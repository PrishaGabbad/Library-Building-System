PROJECT OVERVIEW – Library Management System

This project is a Command-Line Based Library Management System built using Python. It simulates real-world library operations such as managing books, registering members, and handling borrowing/returning of books.

The system uses efficient data structures like dictionaries to store and manage records dynamically during runtime. It provides a complete prototype of a basic library system suitable for learning object-oriented programming and system design concepts.

🔹 Project Features

Data Management
Add new books with title, author, ISBN, and quantity
Store and update book availability
Maintain structured records using dictionaries

Member Management
Register new members with unique IDs
Track number of books borrowed by each member

Borrowing System
Borrow books if available
Automatically update availability count
Maintain mapping of borrowed books per member

Return System
Return borrowed books
Update availability and member records
Validate incorrect return attempts

Search Functionality
Search books by title or author
Display matching results with availability

System Interface
Interactive CLI menu
Simple and user-friendly navigation
Input validation and error handling

How It Works
Books are stored using ISBN as a unique identifier
Members are tracked using a unique member ID
Borrowed books are mapped to members
Availability is updated automatically when borrowing/returning

🛠️ Technology / Tools Used
Programming Language
Python 3
Libraries / Frameworks
Category	Tools
Core Programming	Python Standard Library
Data Structures	Dictionaries, Lists
Interface	Command Line (CLI)

💻 Software Used
Python 3.x
Terminal / Command Prompt / VS Code

📂 Project Structure
library.py   # Main program file containing all functionalities

System Menu
--- Library Management System ---
1. Add Book
2. Add Member
3. Borrow Book
4. Return Book
5. List All Books
6. List All Members
7. Search Book
8. Exit

Instructions for Testing the Project-
Test 1: Add Books
Add multiple books with same ISBN → check quantity update
Test 2: Add Members
Add members with unique IDs
Try duplicate ID → should show error
Test 3: Borrow Books
Borrow available book → should decrease availability
Borrow unavailable book → should show message
Test 4: Return Books
Return borrowed book → availability increases
Return non-borrowed book → error message
Test 5: Search Function
Search by title or author
Verify correct matching results
Test 6: View Data
List all books → verify counts
List members → verify borrowed count

Example Usage
Add a book → Enter title, author, ISBN
Add a member → Enter name and ID
Borrow → Provide member ID + ISBN
Return → Provide member ID + ISBN

