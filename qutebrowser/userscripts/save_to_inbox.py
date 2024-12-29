#!/usr/bin/env python3

import re, os

title=os.environ['QUTE_TITLE']
url=os.environ['QUTE_URL']
HOME = os.environ['HOME']
PATH= f"{HOME}/storage/notes/inbox.md"
PAGE_TO= f"{HOME}/.config/qutebrowser/startpage.html"
entry=f"- [] [{title}]({url})"
os.system(f"echo '{entry}' >> {PATH}")

file = []
with open(PAGE_TO, "r") as f:
    for line in f.readlines(): file.append(line)

with open(PAGE_TO, "w") as f:
    for i in file[:-2]:
        f.write(i)
    f.write(f"\t<p><a href='{url}'> {title} </a></p>\n")
    f.write("\t</body>\n</html>")

