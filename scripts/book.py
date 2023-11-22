#pacman -S zathura
import os


def get_dir():
    try:
        directory = os.environ["BOOKS_DIR"]
    except:
        directory = os.environ["HOME"] + "/Documents/books"
    print("found directory: ", directory)
    return directory
def get_name(book):
    name = book.replace(".pdf", "").replace("_", " ").replace("-", " ").lower()
    return name 

def main():
    books=[]
    dirc = get_dir()
    print("BOOKS:")
    for num, book in enumerate(os.listdir(dirc), 1):
        books.append(book)
        print(num, ": ", get_name(book))
    choice = (input("> "))
    if choice.isdigit():
        if int(choice) <= len(books):
            os.system(f"zathura {dirc}/{books[int(choice)-1]}")
    else: 
        for book in books:
            name = get_name(book).split(" ")
            for i in name:
                if i == choice:
                    os.system(f"zathura {dirc}/{book}")
                    return


    
     

if "__main__" == __name__:
    main()
