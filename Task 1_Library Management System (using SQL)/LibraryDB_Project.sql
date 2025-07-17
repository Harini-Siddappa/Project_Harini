DROP TABLE IF EXISTS BorrowingRecords;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Books;

CREATE TABLE Books (
    BOOK_ID INT PRIMARY KEY,
    TITLE VARCHAR(200),
    AUTHOR VARCHAR(100),
    GENRE VARCHAR(50),
    YEAR_PUBLISHED YEAR,
    AVAILABLE_COPIES INT
);
CREATE TABLE Members (
    MEMBER_ID INT PRIMARY KEY,
    NAME VARCHAR(100),
    EMAIL VARCHAR(100),
    PHONE_NO VARCHAR(20),
    ADDRESS VARCHAR(200),
    MEMBERSHIP_DATE DATE
);
CREATE TABLE BorrowingRecords (
    BORROW_ID INT PRIMARY KEY,
    MEMBER_ID INT,
    BOOK_ID INT,
    BORROW_DATE DATE,
    RETURN_DATE DATE,
    FOREIGN KEY (MEMBER_ID) REFERENCES Members(MEMBER_ID),
    FOREIGN KEY (BOOK_ID) REFERENCES Books(BOOK_ID)
);
--  value for books
INSERT INTO Books VALUES
(1, 'Wings of Fire', 'A.P.J. Abdul Kalam', 'Biography', 1999, 4),
(2, 'Wise and Otherwise', 'Sudha Murty', 'Inspirational', 2002, 3),
(3, 'The Monk Who Sold His Ferrari', 'Robin Sharma', 'Motivational Fiction', 1997, 5),
(4, 'Life’s Amazing Secrets', 'Gaur Gopal Das', 'Life Philosophy', 2018, 4),
(5, 'What the Buddha Taught', 'Walpola Rahula', 'Spiritual', 1959, 2);

-- Values for Members
INSERT INTO Members VALUES
(101, 'Ravi Kumar', 'ravi.kumar@example.com', '9876543210', 'Bangalore', '2024-01-10'),
(102, 'Neha Sharma', 'neha.sharma@example.com', '9123456780', 'Hyderabad', '2024-03-05'),
(103, 'Amit Jain', 'amit.jain@example.com', '9999999999', 'Delhi', '2024-04-15'),
(104, 'Priya Reddy', 'priya.reddy@example.com', '9871234567', 'Mysuru', '2024-06-01'),
(105, 'Manoj Mehta', 'manoj.mehta@example.com', '9112233445', 'Mumbai', '2024-07-05'),
(106, 'Kavya Desai', 'kavya.desai@example.com', '9988776655', 'Ahmedabad', '2024-07-12');

-- Values Borrowing Records
INSERT INTO BorrowingRecords VALUES
(1, 101, 1, '2024-04-10', NULL),             
(2, 102, 2, '2024-05-15', '2024-06-01'),     
(3, 103, 3, '2024-05-20', NULL),             
(4, 101, 4, '2024-06-05', '2024-06-25'),     
(5, 102, 5, '2024-06-10', NULL),             
(6, 103, 1, '2024-07-01', NULL),             
(7, 104, 1, '2024-07-02', NULL),             
(8, 105, 2, '2024-07-05', '2024-07-15'),    
(9, 105, 5, '2024-07-06', NULL),             
(10, 104, 4, '2024-06-01', '2024-06-20'), 
(11, 101, 3, '2024-07-10', NULL),
(12, 101, 1, '2024-07-11', NULL),
(13, 102, 1, '2024-07-12', NULL),
(14, 103, 1, '2024-07-13', NULL),
(15, 104, 1, '2024-07-14', NULL),
(16, 105, 1, '2024-07-15', NULL),
(17, 101, 1, '2024-07-16', NULL),
(18, 102, 1, '2024-07-16', NULL),
(19, 103, 1, '2024-07-16', NULL);

SELECT * FROM Books;

SELECT B.TITLE
FROM BorrowingRecords BR
JOIN Books B ON BR.BOOK_ID = B.BOOK_ID
WHERE BR.MEMBER_ID = 101 AND BR.RETURN_DATE IS NULL;

SELECT M.NAME, BR.BORROW_DATE
FROM BorrowingRecords BR
JOIN Members M ON BR.MEMBER_ID = M.MEMBER_ID
WHERE BR.RETURN_DATE IS NULL
  AND BR.BORROW_DATE < CURDATE() - INTERVAL 30 DAY;
  
  SELECT GENRE, SUM(AVAILABLE_COPIES) AS TOTAL_COPIES
FROM Books
GROUP BY GENRE;

SELECT B.TITLE, COUNT(*) AS TIMES_BORROWED
FROM BorrowingRecords BR
JOIN Books B ON BR.BOOK_ID = B.BOOK_ID
GROUP BY B.TITLE
HAVING COUNT(*) = (
    SELECT MAX(BorrowCount) FROM (
        SELECT COUNT(*) AS BorrowCount
        FROM BorrowingRecords
        GROUP BY BOOK_ID
    ) AS BorrowStats
);

SELECT M.MEMBER_ID, M.NAME
FROM Members M
JOIN BorrowingRecords BR ON M.MEMBER_ID = BR.MEMBER_ID
JOIN Books B ON BR.BOOK_ID = B.BOOK_ID
GROUP BY M.MEMBER_ID, M.NAME
HAVING COUNT(DISTINCT B.GENRE) >= 3;

SELECT DATE_FORMAT(BORROW_DATE, '%Y-%m') AS MONTH, COUNT(*) AS TOTAL_BORROWED
FROM BorrowingRecords
GROUP BY MONTH
ORDER BY MONTH;

SELECT M.MEMBER_ID, M.NAME, COUNT(*) AS TOTAL_BORROWED
FROM Members M
JOIN BorrowingRecords BR ON M.MEMBER_ID = BR.MEMBER_ID
GROUP BY M.MEMBER_ID, M.NAME
ORDER BY TOTAL_BORROWED DESC
LIMIT 3;

SELECT B.AUTHOR, COUNT(*) AS TIMES_BORROWED
FROM BorrowingRecords BR
JOIN Books B ON BR.BOOK_ID = B.BOOK_ID
GROUP BY B.AUTHOR
HAVING COUNT(*) >= 10;

SELECT M.NAME
FROM Members M
LEFT JOIN BorrowingRecords BR ON M.MEMBER_ID = BR.MEMBER_ID
WHERE BR.BORROW_ID IS NULL;
