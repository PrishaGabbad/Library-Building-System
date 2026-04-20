import sqlite3

def create_tables():
    conn = sqlite3.connect("library.db")
    cursor = conn.cursor()

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS Books (
        isbn TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        author TEXT NOT NULL,
        quantity INTEGER CHECK (quantity >= 0),
        available INTEGER CHECK (available >= 0)
    )
    """)

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS Members (
        member_id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        borrowed_count INTEGER DEFAULT 0 CHECK (borrowed_count >= 0)
    )
    """)

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS BorrowedBooks (
        borrow_id INTEGER PRIMARY KEY AUTOINCREMENT,
        member_id INTEGER,
        isbn TEXT,
        borrow_date TEXT,
        return_date TEXT,
        FOREIGN KEY(member_id) REFERENCES Members(member_id),
        FOREIGN KEY(isbn) REFERENCES Books(isbn)
    )
    """)

    conn.commit()
    conn.close()

create_tables()

import sqlite3
from datetime import date

class Library:

    def __init__(self):
        self.conn = sqlite3.connect("library.db")
        self.cursor = self.conn.cursor()
        
    def add_book(self, title, author, isbn, quantity):
        self.cursor.execute("SELECT quantity, available FROM Books WHERE isbn = ?", (isbn,))
        result = self.cursor.fetchone()

        if result:
            self.cursor.execute("""
                UPDATE Books
                SET quantity = quantity + ?, available = available + ?
                WHERE isbn = ?
            """, (quantity, quantity, isbn))
        else:
            self.cursor.execute("""
                INSERT INTO Books (isbn, title, author, quantity, available)
                VALUES (?, ?, ?, ?, ?)
            """, (isbn, title, author, quantity, quantity))

        self.conn.commit()
        
    def add_member(self, name, member_id):
        self.cursor.execute("SELECT member_id FROM Members WHERE member_id = ?", (member_id,))
        
        if not self.cursor.fetchone():
            self.cursor.execute("""
                INSERT INTO Members (member_id, name, borrowed_count)
                VALUES (?, ?, 0)
            """, (member_id, name))
            self.conn.commit()
            
    def borrow_book(self, member_id, isbn):
        # Check member
        self.cursor.execute("SELECT borrowed_count FROM Members WHERE member_id = ?", (member_id,))
        member = self.cursor.fetchone()

        # Check book
        self.cursor.execute("SELECT available FROM Books WHERE isbn = ?", (isbn,))
        book = self.cursor.fetchone()

        if not member or not book:
            print("Member or Book not found")
            return

        if book[0] <= 0:
            print("Book not available")
            return

        if member[0] >= 5:
            print("Borrow limit reached")
            return

        try:
            self.conn.execute("BEGIN")

            self.cursor.execute("""
                UPDATE Books SET available = available - 1 WHERE isbn = ?
            """, (isbn,))

            self.cursor.execute("""
                UPDATE Members SET borrowed_count = borrowed_count + 1 WHERE member_id = ?
            """, (member_id,))

            self.cursor.execute("""
                INSERT INTO BorrowedBooks (member_id, isbn, borrow_date)
                VALUES (?, ?, ?)
            """, (member_id, isbn, date.today()))

            self.conn.commit()
            print("Book borrowed successfully")

        except:
            self.conn.rollback()
            print("Error during borrowing")
            
    def return_book(self, member_id, isbn):
        self.cursor.execute("""
            SELECT borrow_id FROM BorrowedBooks
            WHERE member_id = ? AND isbn = ? AND return_date IS NULL
            LIMIT 1
        """, (member_id, isbn))

        record = self.cursor.fetchone()

        if not record:
            print("No active borrow found")
            return

        borrow_id = record[0]

        try:
            self.conn.execute("BEGIN")

            self.cursor.execute("""
                UPDATE BorrowedBooks
                SET return_date = ?
                WHERE borrow_id = ?
            """, (date.today(), borrow_id))

            self.cursor.execute("""
                UPDATE Books SET available = available + 1 WHERE isbn = ?
            """, (isbn,))

            self.cursor.execute("""
                UPDATE Members SET borrowed_count = borrowed_count - 1 WHERE member_id = ?
            """, (member_id,))

            self.conn.commit()
            print("Book returned successfully")

        except:
            self.conn.rollback()
            print("Error during return")
            
    def list_books(self):
        self.cursor.execute("SELECT * FROM Books")
        for row in self.cursor.fetchall():
            print(row)
            
    def list_members(self):
        self.cursor.execute("SELECT * FROM Members")
        for row in self.cursor.fetchall():
            print(row)
            
    def search_book(self, query):
        self.cursor.execute("""
            SELECT * FROM Books
            WHERE title LIKE ? OR author LIKE ?
        """, ('%' + query + '%', '%' + query + '%'))

        for row in self.cursor.fetchall():
            print(row)
            
lib = Library()

lib.add_book("Harry Potter", "J.K. Rowling", "111", 5)
lib.add_member("Alice", 1)

lib.borrow_book(1, "111")
lib.list_books()

lib.return_book(1, "111")
lib.list_books()

