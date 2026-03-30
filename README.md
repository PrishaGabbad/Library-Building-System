Library Management System (Python CLI)

A simple command-line based Library Management System built using Python. This project allows users to manage books, members, and borrowing operations efficiently.

Features
Add new books with title, author, ISBN, and quantity
Register library members
Borrow books (if available)
Return borrowed books
View all books in the library
View all registered members
Search books by title or author
Error handling for invalid operations

Tech Stack
Language: Python 3
Type: Command Line Interface (CLI)
Data Storage: In-memory (Dictionaries)

📂 Project Structure
library.py     # Main file containing the entire system

How to Run
1. Clone the repository:
   git clone https://github.com/your-username/library-management-system.git
2. Navigate to the project folder:
   cd library-management-system
3. Run the program:
   python library.py

How It Works
Books are stored using ISBN as a unique identifier
Members are tracked using a unique member ID
Borrowed books are mapped to members
Availability is updated automatically when borrowing/returning

Sample Menu
--- Library Management System ---
1. Add Book
2. Add Member
3. Borrow Book
4. Return Book
5. List All Books
6. List All Members
7. Search Book
8. Exit

Example Usage
Add a book → Enter title, author, ISBN
Add a member → Enter name and ID
Borrow → Provide member ID + ISBN
Return → Provide member ID + ISBN

