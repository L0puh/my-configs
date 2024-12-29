import sys
import os 
from datetime import datetime

files = sys.argv[1:]

if not files or not files[1:]: 
    print("Converts markdown links to html file.")
    print("FORMAT:\n- [] link\n- ! info ")
    print("USAGE:\nmd_to_html [markdown file] [html file]")
    print("Exmaple of file:\n- [] [name](www.example.org) -> <a href='www.example.org'>name</a>")
    print("- ! some note                -> <p> some note </p>")
    exit()

md = files[0]
html = files[1]
def get_url(line):
    title=""
    url  =""
    index = 0
    for n, k in enumerate(line[5:]):
        if k == "]":
            index = 5+n
            break
        title+=k
    for l in line[index+1:]:
        if l == ")":
            break
        url+=l
    return title.replace("[", ""), url.replace("(", "");

def get_urls():
    info = []
    cnt = 0
    urls = [[] for _ in range(10)]
    with open(md, "r") as f:
        for i in f.readlines():
            if i[0:3] == "- !":
                info.append(i[3:])
                cnt+=1
                print("new section")
            if i[0:4] == "- []":
                title, url = get_url(i)
                urls[cnt].append([title, url])
                print("new link for section ", info[cnt-1], title, url);


  

    return urls, info


def format_html(urls,title, info):
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
.column {
  float: left;
  width: 50%;
}

.row:after {
  content: "";
  display: table;
  clear: both;
}
</style>
        """
        f.write(header+style+"\n<body>\n")
        f.write(f"<h1>{title}</h1>\n")
        f.write('<div class="row">')
        cnt = 1
        for i in info:
            f.write('<div class="column">')
            f.write(f"<p> {i} </p>\n")
            for url in urls[cnt]:
                f.write(f'<p><a href="{url[1]}">{url[0]}</a></p>\n')
            f.write('</div>')
            cnt+=1
        
        print(f"found {len(info)} sections")

        f.write('</div>')
        f.write("</body>\n</html>")

def main():
    
    urls, info = get_urls()
    format_html(urls, datetime.now().strftime("%d %b"), info)


if __name__ == "__main__":
    main()
