import sys
import os 
from datetime import datetime
files = sys.argv[1:]
if not files or not files[1:]: 
    print("Convert markdown links to html file. Links have '- []'")
    print("Usage: md_to_html [markdown file] [html file]")
    exit()
md = files[0]
html = files[1]

def get_url():
    urls=[]
    with open(md, "r") as f:
        for i in f.readlines():
            if i[0:4] == "- []":
                title=""
                url  =""
                index = 0
                for n, k in enumerate(i[5:]):
                    if k == "]":
                        index = 5+n
                        break
                    title+=k
                for l in i[index+1:]:
                    if l == ")":
                        break
                    url+=l
                urls.append([title.replace("[", ""), url.replace("(", "")])
    return urls


def format_html(urls, title):
    with open(html, "w") as f:
        header =  """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MAIN</title>
</head>
        """
        style="""
<style>
body{
    margin: 0;
    text-align: center;
    font-family: Hack;
    background-color: #121212;
    font-size: 19px;

}
h1{
    color: #b0716f
}
</style>
        """
        f.write(header+style+"\n<body>\n")
        f.write(f"<h1>{title}</h1>\n")
        for i in urls:
            f.write(f'<p><a href="{i[1]}">{i[0]}</a></p>\n')
        f.write("</body>\n</html>")

def main():
    urls = get_url()
    format_html(urls, datetime.now().strftime("%d %b"))


if __name__ == "__main__":
    main()
