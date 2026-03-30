class Library:
    def __init__(self):
        self.books = {}
        self.members = {}
        self.borrowed_books = {}

    def add_book(self, title, author, isbn, quantity=1):
        if isbn in self.books:
            self.books[isbn]['quantity'] += quantity
            self.books[isbn]['available'] += quantity
            print(f"Added {quantity} more copies of '{title}'. Total: {self.books[isbn]['quantity']}")
        else:
            self.books[isbn] = {
                'title': title,
                'author': author,
                'isbn': isbn,
                'quantity': quantity,
                'available': quantity
            }
            print(f"Book '{title}' by {author} (ISBN: {isbn}) added to the library.")

    def add_member(self, name, member_id):
        if member_id in self.members:
            print(f"Member with ID '{member_id}' already exists.")
        else:
            self.members[member_id] = {'name': name, 'member_id': member_id, 'borrowed_count': 0}
            print(f"Member '{name}' (ID: {member_id}) added to the library.")

    def borrow_book(self, member_id, isbn):
        if member_id not in self.members:
            print(f"Error: Member with ID '{member_id}' not found.")
            return
        if isbn not in self.books:
            print(f"Error: Book with ISBN '{isbn}' not found.")
            return

        book = self.books[isbn]
        if book['available'] > 0:
            book['available'] -= 1
            if member_id not in self.borrowed_books:
                self.borrowed_books[member_id] = []
            self.borrowed_books[member_id].append(isbn)
            self.members[member_id]['borrowed_count'] += 1
            print(f"'{book['title']}' borrowed by '{self.members[member_id]['name']}'.")
        else:
            print(f"Sorry, '{book['title']}' is currently not available.")

    def return_book(self, member_id, isbn):
        if member_id not in self.members:
            print(f"Error: Member with ID '{member_id}' not found.")
            return
        if isbn not in self.books:
            print(f"Error: Book with ISBN '{isbn}' not found.")
            return

        if member_id in self.borrowed_books and isbn in self.borrowed_books[member_id]:
            book = self.books[isbn]
            book['available'] += 1
            self.borrowed_books[member_id].remove(isbn)
            self.members[member_id]['borrowed_count'] -= 1
            print(f"'{book['title']}' returned by '{self.members[member_id]['name']}'.")
        else:
            print(f"Error: Member '{self.members[member_id]['name']}' did not borrow book '{self.books[isbn]['title']}'.")

    def list_books(self):
        if not self.books:
            print("No books in the library.")
            return
        print("\n--- Current Books in Library ---")
        for isbn, book in self.books.items():
            print(f"Title: {book['title']}, Author: {book['author']}, ISBN: {isbn}, Total: {book['quantity']}, Available: {book['available']}")
        print("------------------------------")

    def list_members(self):
        if not self.members:
            print("No members registered.")
            return
        print("\n--- Registered Members ---")
        for member_id, member in self.members.items():
            print(f"Name: {member['name']}, ID: {member_id}, Books Borrowed: {member['borrowed_count']}")
        print("------------------------")

    def search_book(self, query):
        found_books = []
        for isbn, book in self.books.items():
            if query.lower() in book['title'].lower() or query.lower() in book['author'].lower():
                found_books.append(book)

        if not found_books:
            print(f"No books found matching '{query}'.")
        else:
            print(f"\n--- Search Results for '{query}' ---")
            for book in found_books:
                print(f"Title: {book['title']}, Author: {book['author']}, ISBN: {book['isbn']}, Available: {book['available']}/{book['quantity']}")
            print("------------------------------------")

# Main interaction loop
def main():
    library = Library()

    while True:
        print("\n--- Library Management System ---")
        print("1. Add Book")
        print("2. Add Member")
        print("3. Borrow Book")
        print("4. Return Book")
        print("5. List All Books")
        print("6. List All Members")
        print("7. Search Book")
        print("8. Exit")
        choice = input("Enter your choice: ")

        if choice == '1':
            title = input("Enter book title: ")
            author = input("Enter book author: ")
            isbn = input("Enter book ISBN: ")
            try:
                quantity = int(input("Enter quantity (default 1): ") or 1)
            except ValueError:
                print("Invalid quantity. Defaulting to 1.")
                quantity = 1
            library.add_book(title, author, isbn, quantity)
        elif choice == '2':
            name = input("Enter member name: ")
            member_id = input("Enter member ID: ")
            library.add_member(name, member_id)
        elif choice == '3':
            member_id = input("Enter member ID: ")
            isbn = input("Enter book ISBN: ")
            library.borrow_book(member_id, isbn)
        elif choice == '4':
            member_id = input("Enter member ID: ")
            isbn = input("Enter book ISBN: ")
            library.return_book(member_id, isbn)
        elif choice == '5':
            library.list_books()
        elif choice == '6':
            library.list_members()
        elif choice == '7':
            query = input("Enter title or author to search: ")
            library.search_book(query)
        elif choice == '8':
            print("Exiting Library Management System. Goodbye!")
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == '__main__':
    main() 