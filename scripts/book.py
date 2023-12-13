"""
dependencies:
pacman -S zathura
pacman -S python-colorama

script for quick access to the local
library (located in "Documents/books")

- tags are folders 
- files should have .pdf format 
- navigation via typing title or number

"""

import os
from colorama import Fore, init
from colorama import Style

init()

def get_dir(path):
    try:
        directory = os.path.join(os.environ["BOOKS_DIR"], path)
    except:
        directory = os.path.join(os.environ["HOME"], "Documents/books", path)
    print("found directory: ", directory)
    return directory

def get_name(book):
    name = book.replace(".pdf", "").replace("_", " ").replace("-", " ").lower()
    return name 

def get_books(dirc):
    books=[]
    tags=[]
    for num, el in enumerate(os.listdir(dirc), 1):
        if el[len(el)-3:] == "pdf":
            books.append(el)
        else: tags.append(el)
    return books, tags

def get_choice(books, tags) -> str:
    cnt = 0
    if books:
        print(Fore.YELLOW + "\n--------------")
        print(Fore.BLUE + "BOOKS:" + Style.RESET_ALL)
        for i, b in enumerate(books, 1):
            print(i, ": ", get_name(b))
            cnt = i
    else: print(Fore.RED + "there are no books" + Style.RESET_ALL)
    
    if tags:
        print(Fore.YELLOW + "\n--------------")
        print(Fore.BLUE + "TAGS:" + Style.RESET_ALL)
        for i, t in enumerate(tags, cnt+1):
            print(i, ": ", t.lower())
    else: print(Fore.RED + "there are no tags" + Style.RESET_ALL)
    choice = (input("> "))
    return choice, cnt


def find_book(choice, books, tags, dirc):
    for book in books:
        name = get_name(book)
        if name.find(choice) != -1:
            os.system(f"zathura {dirc}/{book}")
            return
    for tag in tags:
        if tag.lower().find(choice.lower()) != -1:
            books, tags = get_books(get_dir(tag))
            choice, cnt = get_choice(books, tags)
            return choice, tag, cnt
    return 

def digit_choice(choice, books, tags, cnt, dirc):
    ch = int(choice)
    if ch <= len(books):
        os.system(f"zathura {dirc}/{books[ch-1]}")
        return
    elif ch-cnt <= len(tags):
        i = tags[ch-cnt-1]
        books, tags = get_books(get_dir(i))
        choice, cnt = get_choice(books, tags)
        os.system(f"zathura {dirc}/{i}/{books[int(choice)-1]}")
        return

def main():
    dirc = get_dir("")
    books, tags = get_books(dirc) 

    choice, cnt = get_choice(books, tags)
    if choice.isdigit():
        digit_choice(choice, books, tags, cnt, dirc)
    else: 
        choice, tag, cnt = find_book(choice, books, tags, dirc)
        books, tags = get_books(get_dir(tag))
        if choice.isdigit():
            digit_choice(choice, books, tags, cnt, get_dir(tag))
        else:
            find_book(choice, books, tags, get_dir(tag))


if "__main__" == __name__:
    main()
