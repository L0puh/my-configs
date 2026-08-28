import re
import sys
import json
from pathlib import Path
from datetime import datetime

DEFAULT_ROOT = "/home/lopuh/storage/library"
DEFAULT_OUT = "library.html"

CARDS_FOLDER = "0 book cards"
SKIP_NAMES = {"library.base"}
SKIP_EXTS = {"crdownload"}

CATEGORY_ORDER = ["programming", "fiction", "german", "articles", "tools", "uni", "other"]


# ---------- card parsing (hand-rolled, no yaml dependency needed) ----------

def clean_value(v):
    """Tolerate `key: value` and Obsidian Dataview's `key:: value`, plus
    stray quotes / wiki-link brackets around the value."""
    v = v.strip()
    v = v.lstrip(":").strip()
    v = v.strip("\"'").strip()
    if v.startswith("[[") and v.endswith("]]"):
        v = v[2:-2].strip()
    md_link = re.match(r"^\[(.*?)\]\((.*?)\)$", v)
    if md_link:
        v = md_link.group(2).strip()
    return v


def clean_title(t):
    t = re.sub(r"^#+\s*", "", t).strip()
    return display_name(t)


def display_name(s):
    return re.sub(r"_+", " ", s).strip()


def parse_frontmatter(lines):
    """Parse a simple Obsidian-style YAML frontmatter block into a dict.
    Supports scalar `key: value` and list values written as `key:` followed
    by `- item` lines."""
    data = {}
    key = None
    i = 0
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()
        if stripped.startswith("- ") and key is not None:
            data.setdefault(key, [])
            if isinstance(data[key], list):
                data[key].append(stripped[2:].strip())
            i += 1
            continue
        if ":" in stripped:
            k, _, v = stripped.partition(":")
            k = k.strip()
            v = clean_value(v)
            key = k
            if v == "":
                data[k] = []  # might become a list on the next lines, or stay empty
            elif v.lower() in ("true", "false"):
                data[k] = v.lower() == "true"
            else:
                data[k] = v
        i += 1
    return data


def parse_card(path):
    text = path.read_text(errors="ignore")
    lines = text.splitlines()

    frontmatter = {}
    body_lines = lines

    if lines and lines[0].strip() == "---":
        try:
            end = next(i for i in range(1, len(lines)) if lines[i].strip() == "---")
            frontmatter = parse_frontmatter(lines[1:end])
            body_lines = lines[end + 1:]
        except StopIteration:
            body_lines = lines

    title = path.stem
    link = None
    notes_parts = []
    in_notes = False

    for raw in body_lines:
        stripped = raw.strip()
        if not stripped and not in_notes:
            continue
        if stripped.lower().startswith("link:"):
            link = clean_value(stripped.split(":", 1)[1])
            in_notes = False
            continue
        if stripped.lower().startswith("notes:"):
            rest = clean_value(stripped.split(":", 1)[1])
            if rest:
                notes_parts.append(rest)
            in_notes = True
            continue
        if in_notes:
            if stripped:
                notes_parts.append(stripped)
            continue
        if title == path.stem and link is None:
            title = clean_title(stripped)

    tags = frontmatter.get("tags") or []
    if isinstance(tags, str):
        tags = [tags]

    return {
        "title": display_name(title) if title else path.stem,
        "tags": tags,
        "in_progress": bool(frontmatter.get("in progress", False)),
        "image": frontmatter.get("image") or None,
        "link": link,
        "notes": " ".join(notes_parts).strip(),
        "card_name": path.stem,
    }


# ---------- filesystem scan ----------

def scan_files(root_path):
    """All files in the library, excluding the cards folder itself."""
    files_by_name = {}
    files_by_stem = {}
    all_files = []
    for path in sorted(root_path.rglob("*")):
        if not path.is_file():
            continue
        if path.name in SKIP_NAMES:
            continue
        ext = path.suffix.lstrip(".").lower()
        if ext in SKIP_EXTS:
            continue
        rel = path.relative_to(root_path)
        if rel.parts[0] == CARDS_FOLDER:
            continue
        entry = {
            "name": display_name(path.stem),
            "ext": ext or "file",
            "path": str(rel).replace("\\", "/"),
            "category": rel.parts[0] if len(rel.parts) > 1 else "other",
            "subfolder": rel.parts[1] if len(rel.parts) > 2 else None,
        }
        all_files.append(entry)
        files_by_name.setdefault(path.name, entry)
        files_by_stem.setdefault(path.stem.lower(), entry)
    return all_files, files_by_name, files_by_stem


def resolve_link(link, files_by_name, files_by_stem):
    """Cards often store a relative path (`assembly/foo.pdf`, `../x/foo.pdf`)
    that no longer matches where the file actually lives after a move — so
    search by filename across every subfolder instead of trusting the path."""
    if not link:
        return None
    basename = Path(link).name
    match = files_by_name.get(basename)
    if match:
        return match["path"]
    stem = Path(basename).stem.lower()
    match = files_by_stem.get(stem)
    if match:
        return match["path"]
    return None


def build_cards(root_path, files_by_name, files_by_stem):
    cards_dir = root_path / CARDS_FOLDER
    cards = []
    matched_paths = set()
    if not cards_dir.is_dir():
        return cards, matched_paths

    for card_path in sorted(cards_dir.glob("*.md")):
        card = parse_card(card_path)
        resolved = resolve_link(card["link"], files_by_name, files_by_stem)
        if resolved:
            matched_paths.add(resolved)
        card["resolved_path"] = resolved
        cards.append(card)
    return cards, matched_paths


# ---------- HTML ----------

PAGE_TEMPLATE = """<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>library</title>
<style>
:root {{
   --red-color:    #b0716f;
   --yellow-color: #b0a46f;
   --blue-color:   #8aabac;
   --dark-color:   #121212;
   --light-color:  #d4cfd0;
   --dim-color:    #5f5a55;
}}
* {{ box-sizing: border-box; }}
body {{
   background-color: var(--dark-color);
   color: var(--light-color);
   font-family: "Cascadia Code", Hack, monospace;
   margin: 0;
   font-size: 16px;
   line-height: 1.5;
}}
header {{
   text-align: center;
   padding: 2.2em 1em 1.4em;
   border-bottom: 1px solid #232323;
}}
header h1 {{
   color: var(--red-color);
   font-size: 1.3em;
   font-weight: normal;
   letter-spacing: 0.04em;
   margin: 0 0 0.3em;
}}
header .count {{ color: var(--dim-color); font-size: 0.85em; }}
header a.back {{
   display: inline-block;
   margin-top: 0.8em;
   color: var(--blue-color);
   text-decoration: none;
   font-size: 0.85em;
}}

.search-wrap {{
   max-width: 900px;
   margin: 1.6em auto 0;
   padding: 0 1em;
}}
#search {{
   width: 100%;
   background: #1a1a1a;
   border: 1px solid #2a2a2a;
   color: var(--light-color);
   font-family: inherit;
   font-size: 1em;
   padding: 0.6em 0.8em;
   outline: none;
}}
#search:focus {{ border-color: var(--blue-color); }}
#search::placeholder {{ color: var(--dim-color); }}

main {{ max-width: 900px; margin: 0 auto; padding: 1.6em 1em 4em; }}

h2.section-title {{
   color: var(--yellow-color);
   font-size: 0.95em;
   font-weight: normal;
   letter-spacing: 0.03em;
   border-bottom: 1px solid #232323;
   padding-bottom: 0.4em;
   margin: 2em 0 0.9em;
}}
h2.section-title .n {{ color: var(--dim-color); font-size: 0.85em; }}

/* book cards grid */
.grid {{
   display: grid;
   grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
   gap: 1.1em;
}}
.card {{
   background: #181818;
   border: 1px solid #242424;
   padding: 0.8em;
   display: flex;
   flex-direction: column;
}}
.card .cover {{
   width: 100%;
   height: 150px;
   object-fit: cover;
   background: #101010;
   border: 1px solid #242424;
   margin-bottom: 0.6em;
}}
.card .cover.placeholder {{
   display: flex;
   align-items: center;
   justify-content: center;
   color: var(--dim-color);
   font-size: 0.75em;
}}
.card a.title {{
   color: var(--light-color);
   text-decoration: none;
   font-size: 0.95em;
}}
.card a.title:hover, .card a.title:focus-visible {{ color: var(--blue-color); }}
.card .title.no-link {{ color: var(--dim-color); }}
.card .status {{
   font-size: 0.72em;
   margin: 0.35em 0;
}}
.status.reading {{ color: var(--yellow-color); }}
.status.queued {{ color: var(--dim-color); }}
.card .tags {{ margin: 0.2em 0; }}
.card .tag {{
   display: inline-block;
   color: var(--blue-color);
   font-size: 0.68em;
   margin: 0 0.3em 0.2em 0;
}}
.card .tag::before {{ content: "#"; }}
.card .tag::after {{ content: " "; }}
.card .notes {{
   color: var(--dim-color);
   font-size: 0.75em;
   margin-top: 0.3em;
}}

/* plain file listing */
ul.files {{ list-style: none; margin: 0; padding: 0; }}
ul.files li {{ display: flex; align-items: baseline; gap: 0.6em; padding: 0.25em 0; }}
ul.files a {{ color: var(--light-color); text-decoration: none; flex: 1; }}
ul.files a:hover, ul.files a:focus-visible {{ color: var(--blue-color); }}
.ext {{ color: var(--dim-color); font-size: 0.75em; min-width: 3.2em; }}
.sub {{ color: var(--dim-color); font-size: 0.75em; }}

.no-results {{ color: var(--dim-color); text-align: center; margin-top: 3em; }}
</style>
</head>
<body>

<header>
   <h1>library</h1>
   <div class="count"><span id="visible-count">{total}</span> / {total} items</div>
   <a class="back" href="startpage.html">BACK</a>
</header>

<div class="search-wrap">
   <input id="search" type="text" placeholder="$ search title, tag, folder, or type&hellip;" autofocus>
</div>

<main id="results"></main>

<script>
const ROOT = {root_js};
const CARDS = {cards_json};
const FILES = {files_json};
const CATEGORY_ORDER = {category_order_json};

function encodePath(p) {{
   return p.split("/").map(encodeURIComponent).join("/");
}}

function fileHref(path) {{
   return "file://" + ROOT + "/" + encodePath(path);
}}

function cardMatches(c, q) {{
   const hay = (c.title + " " + c.tags.join(" ") + " " + c.notes + " book").toLowerCase();
   return hay.includes(q);
}}
function fileMatches(e, q) {{
   const hay = (e.name + " " + e.category + " " + (e.subfolder || "") + " " + e.ext).toLowerCase();
   return hay.includes(q);
}}

function renderCard(c) {{
   const div = document.createElement("div");
   div.className = "card";

   if (c.image) {{
      const img = document.createElement("img");
      img.className = "cover";
      img.src = c.image;
      img.alt = "";
      img.loading = "lazy";
      img.referrerPolicy = "no-referrer";
      img.onerror = () => {{ img.replaceWith(Object.assign(document.createElement("div"), {{className: "cover placeholder", textContent: "no cover"}})); }};
      div.appendChild(img);
   }} else {{
      const ph = document.createElement("div");
      ph.className = "cover placeholder";
      ph.textContent = "no cover";
      div.appendChild(ph);
   }}

   const a = document.createElement(c.resolved_path ? "a" : "div");
   a.className = "title" + (c.resolved_path ? "" : " no-link");
   a.textContent = c.title;
   if (c.resolved_path) a.href = fileHref(c.resolved_path);
   div.appendChild(a);

   const status = document.createElement("div");
   status.className = "status " + (c.in_progress ? "reading" : "queued");
   status.textContent = c.in_progress ? "reading" : (c.resolved_path ? "queued" : "missing file");
   div.appendChild(status);

   if (c.tags.length) {{
      const tagsDiv = document.createElement("div");
      tagsDiv.className = "tags";
      for (const t of c.tags) {{
         const span = document.createElement("span");
         span.className = "tag";
         span.textContent = t;
         tagsDiv.appendChild(span);
      }}
      div.appendChild(tagsDiv);
   }}

   return div;
}}

function renderFileRow(e) {{
   const li = document.createElement("li");
   const extSpan = document.createElement("span");
   extSpan.className = "ext";
   extSpan.textContent = e.ext;
   const a = document.createElement("a");
   a.href = fileHref(e.path);
   a.textContent = e.name;
   li.appendChild(extSpan);
   li.appendChild(a);
   if (e.subfolder) {{
      const sub = document.createElement("span");
      sub.className = "sub";
      sub.textContent = e.subfolder;
      li.appendChild(sub);
   }}
   return li;
}}

function render(filterText) {{
   const q = filterText.trim().toLowerCase();
   const cards = CARDS.filter(c => !q || cardMatches(c, q));
   const files = FILES.filter(e => !q || fileMatches(e, q));

   document.getElementById("visible-count").textContent = cards.length + files.length;

   const main = document.getElementById("results");
   main.innerHTML = "";

   if (cards.length === 0 && files.length === 0) {{
      main.innerHTML = '<p class="no-results">// no matches</p>';
      return;
   }}

   if (cards.length) {{
      const h2 = document.createElement("h2");
      h2.className = "section-title";
      h2.innerHTML = 'reading list <span class="n">(' + cards.length + ')</span>';
      main.appendChild(h2);

      const grid = document.createElement("div");
      grid.className = "grid";
      for (const c of cards) grid.appendChild(renderCard(c));
      main.appendChild(grid);
   }}

   const byCategory = {{}};
   for (const e of files) (byCategory[e.category] = byCategory[e.category] || []).push(e);
   const orderedCats = [
      ...CATEGORY_ORDER.filter(c => byCategory[c]),
      ...Object.keys(byCategory).filter(c => !CATEGORY_ORDER.includes(c)).sort(),
   ];

   for (const cat of orderedCats) {{
      const items = byCategory[cat];
      const h2 = document.createElement("h2");
      h2.className = "section-title";
      h2.innerHTML = cat + ' <span class="n">(' + items.length + ')</span>';
      main.appendChild(h2);

      const ul = document.createElement("ul");
      ul.className = "files";
      for (const e of items) ul.appendChild(renderFileRow(e));
      main.appendChild(ul);
   }}
}}

document.getElementById("search").addEventListener("input", (ev) => render(ev.target.value));
render("");
</script>

</body>
</html>
"""


def build(root, out_path):
    root_path = Path(root)
    all_files, files_by_name, files_by_stem = scan_files(root_path)
    cards, matched_paths = build_cards(root_path, files_by_name, files_by_stem)

    leftover_files = [f for f in all_files if f["path"] not in matched_paths]

    total = len(cards) + len(leftover_files)
    html = PAGE_TEMPLATE.format(
        total=total,
        root_js=json.dumps(str(root_path)),
        cards_json=json.dumps(cards),
        files_json=json.dumps(leftover_files),
        category_order_json=json.dumps(CATEGORY_ORDER),
    )
    with open(out_path, "w") as f:
        f.write(html)
    print(f"wrote {out_path}: {len(cards)} cards, {len(leftover_files)} other files "
          f"(generated {datetime.now().isoformat(timespec='seconds')})")


def main():
    args = sys.argv[1:]
    root = args[0] if len(args) > 0 else DEFAULT_ROOT
    out_path = args[1] if len(args) > 1 else DEFAULT_OUT
    build(root, out_path)


if __name__ == "__main__":
    main()
