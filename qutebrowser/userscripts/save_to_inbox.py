#!/usr/bin/env python3

import os
import argparse

HOME = os.environ['HOME']
PATH= f"{HOME}/storage/notes/inbox.md"
PAGE_TO= f"{HOME}/.config/qutebrowser/inbox.html"
parser = argparse.ArgumentParser()
parser.add_argument("--update", action="store_true")
parser.add_argument("--delete", action="store_true")
args = parser.parse_args()

if args.update:
    os.system(f"python ~/.config/my-configs/scripts/md_to_html.py {PATH} {PAGE_TO}")
    os.system(f"echo 'message-info \"List is updated!\"' >> $QUTE_FIFO")
    exit(0)
elif args.delete:
    os.system(f"echo '' > {PATH}")
    os.system(f"python ~/.config/my-configs/scripts/md_to_html.py {PATH} {PAGE_TO}")
    os.system(f"echo 'message-info \"List is cleared!\"' >> $QUTE_FIFO")
    exit(0)
else:
    title=os.environ['QUTE_TITLE']
    url=os.environ['QUTE_URL']
    entry=f"[{title}]({url})"
    os.system(f"echo '{entry}' >> {PATH}")
    os.system(f"python ~/.config/my-configs/scripts/md_to_html.py {PATH} {PAGE_TO}")
    os.system(f"echo 'message-info \"{title} is added!\"' >> $QUTE_FIFO")

