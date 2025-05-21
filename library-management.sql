-- Simple Library Management System

-- CREATE DATABASE simple_library;
-- USE simple_library;

-- 1. MEMBERS TABLE - Stores library members
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    join_date DATE DEFAULT (CURRENT_DATE)
) COMMENT 'Library members information';

-- 2. BOOKS TABLE - Stores book information
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    year_published INT,
    available CHAR(1) DEFAULT 'Y' CHECK (available IN ('Y', 'N'))
) COMMENT 'Book inventory information';

-- 3. LOANS TABLE - Tracks book loans
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE DEFAULT (CURRENT_DATE),
    due_date DATE DEFAULT (DATE_ADD(CURRENT_DATE, INTERVAL 14 DAY)),
    returned CHAR(1) DEFAULT 'N' CHECK (returned IN ('Y', 'N')),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
) COMMENT 'Book checkout records';

-- 4. GENRES TABLE - Book categories
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
) COMMENT 'Book genre categories';

-- 5. BOOK_GENRES TABLE - Links books to genres (many-to-many)
CREATE TABLE book_genres (
    book_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE
) COMMENT 'Connects books to genres';
