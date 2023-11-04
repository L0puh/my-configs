#pacman -S zathura
import os


def get_dir():
    try:
        directory = os.environ["BOOKS_DIR"]
    except:
        directory = os.environ["HOME"] + "/Documents/books"
    print("found directory: ", directory)
    return directory

def main():
    books=[]
    dirc = get_dir()
    print("BOOKS:")
    for num, book in enumerate(os.listdir(dirc), 1):
        books.append(book)
        print(num, ": ", book)
    choice = int(input("> "))
    if choice <= len(books):
        os.system(f"zathura {dirc}/{books[choice-1]}")
    
     
    


if "__main__" == __name__:
    main()
