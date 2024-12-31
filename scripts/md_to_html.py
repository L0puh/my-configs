import sys
import os, re
from datetime import datetime

files = sys.argv[1:]

if not files or not files[1:]: 
    print("Converts markdown links to html file.")
    print("USAGE:\nmd_to_html [markdown file] [html file]")
    print("Exmaple of file:\n[name](www.example.org) -> <a href='www.example.org'>name</a>")
    print("- ! some note                -> <p> some note </p>")
    exit()

md = files[0]
html = files[1]
def get_url(line):
    pattern = r'\[(.*?)\]\((.*?)\)'
    match = re.match(pattern, line)
    if match:
        return match.group(1), match.group(2)
    return None, None

def get_urls():
    urls = []
    with open(md, "r") as f:
        for i in f.readlines():
            title, url = get_url(i.strip())
            if title and url:
                urls.append([title, url])
    return urls


def format_html(urls):
    with open(html, "w") as f:
        header =  f"""
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MAIN</title>
</head>
        """
        style="""
<style>
:root {
   --red-color: #b0716f;
   --blue-color: #8aabac;
   --dark-color: #121212;
   --light-color: #d4cfd0;
}
body{
   background-color: var(--dark-color);
   text-align: center;
   padding: 10% 0;
   font-family: "Cascadia Code", Hack, monospace;
   margin:auto;
   font-size: 24px;
}
h1 {
   color: var(--red-color);
}
h2, h3, h4, b {
   color: var(--blue-color);
}
a {
   text-decoration: none;
   color: var(--light-color);
}
</style>
</body>
    <h3><a style="color: var(--blue-color);" href='startpage.html'>BACK</a></h3>
        """
        f.write(header)
        f.write(style)
        for url in urls:
            f.write(f'\t\t<p><a href="{url[1]}">{url[0]}</a></p>\n')
        f.write("\t</body>\n</html>")

def main():
    urls = get_urls()
    format_html(urls)

if __name__ == "__main__":
    main()
