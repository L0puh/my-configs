import sys
import re
from datetime import datetime

files = sys.argv[1:]
if not files or not files[1:]:
    print("Converts markdown links to html file.")
    print("USAGE:\nmd_to_html [markdown file] [html file]")
    print("Example of file:\n[name](https://www.example.org) -> <a href='https://www.example.org'>name</a>")
    print("- ! some note                -> <p> some note </p>")
    exit()

md = files[0]
html = files[1]

LINK_PATTERN = re.compile(r'\[(.*?)\]\((.*?)\)')


def parse_line(line):
    line = line.strip()
    if not line:
        return None
    match = LINK_PATTERN.match(line)
    if match:
        return ("link", match.group(1), match.group(2))
    if line.startswith("!"):
        return ("note", line[1:].strip())
    return None


def get_entries():
    entries = []
    with open(md, "r") as f:
        for raw_line in f.readlines():
            entry = parse_line(raw_line)
            if entry:
                entries.append(entry)
    return entries


PAGE_TEMPLATE = """<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>inbox</title>
<style>
:root {{
   --red-color:    #b0716f;
   --yellow-color: #b0a46f;
   --blue-color:   #8aabac;
   --dark-color:   #121212;
   --light-color:  #d4cfd0;
   --dim-color:    #5f5a55;
}}
body{{
   background-color: var(--dark-color);
   text-align: center;
   padding: 4rem 1rem 3rem;
   font-family: "Cascadia Code", Hack, monospace;
   margin: auto;
   font-size: 20px;
   line-height: 1.5;
   max-width: 640px;
}}
h2, h3, h4, b {{
   color: var(--yellow-color);
   font-weight: normal;
}}
a {{
   text-decoration: none;
   color: var(--light-color);
}}
a:hover {{ color: var(--blue-color); }}
.prompt {{
   color: var(--dim-color);
   font-size: 0.85em;
}}
ul.inbox {{
   list-style: none;
   padding: 0;
   margin: 1.6em 0 2.4em;
   text-align: left;
}}
ul.inbox li {{ padding: 0.15em 0; }}
ul.inbox li.link::before {{ content: "· "; color: var(--dim-color); }}
ul.inbox li.note {{ color: var(--light-color); }}
ul.inbox li.note::before {{ content: "// "; color: var(--dim-color); }}
.empty {{ color: var(--dim-color); }}
footer {{
   color: var(--dim-color);
   font-size: 0.75em;
   margin-top: 2em;
}}
</style>
</head>
<body>

<h3><span class="prompt">user@hub:~$</span> cat inbox.txt</h3>

{body}

<footer>// synced {timestamp}</footer>

<h3><a style="color: var(--blue-color);" href="startpage.html">BACK</a></h3>

</body>
</html>
"""


def render_entry(entry):
    if entry[0] == "link":
        _, title, url = entry
        return f'  <li class="link"><a href="{url}">{title}</a></li>'
    else:
        _, note = entry
        return f'  <li class="note">{note}</li>'


def format_html(entries):
    if entries:
        items = "\n".join(render_entry(e) for e in entries)
        body = f'<ul class="inbox">\n{items}\n</ul>'
    else:
        body = '<p class="empty">// nothing here yet</p>'

    page = PAGE_TEMPLATE.format(
        body=body,
        timestamp=datetime.now().strftime("%Y-%m-%d %H:%M"),
    )
    with open(html, "w") as f:
        f.write(page)


def main():
    entries = get_entries()
    format_html(entries)


if __name__ == "__main__":
    main()
