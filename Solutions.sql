SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM return_status;
SELECT * FROM members;


-- Project Task

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;


-- Task 2: Update an Existing Member's Address

UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';
SELECT * FROM members;


-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

SELECT * FROM issued_status
WHERE issued_id = 'IS121';

DELETE FROM issued_status
WHERE issued_id = 'IS121'



-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';


-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.



SELECT 
    ist.issued_emp_id,
     e.emp_name
    -- COUNT(*)
FROM issued_status as ist
JOIN
employees as e
ON e.emp_id = ist.issued_emp_id
GROUP BY 1, 2
HAVING COUNT(ist.issued_id) > 1

-- ### 3. CTAS (Create Table As Select)

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt

CREATE TABLE book_counts
AS
SELECT 
b.isbn,
b.book_title ,
COUNT(ist.issued_id) AS no_issued
FROM books as b 
JOIN 
issued_status as ist 
ON ist.issued_book_isbn = b.isbn
GROUP BY 1,2 ;

SELECT * FROM book_counts ;

-- ### 4. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:

SELECT * FROM books 
WHERE category = 'fiction' ;

-- Task 8: Find Total Rental Income by Category:

SELECT 
b.category,
SUM(b.rental_price),
COUNT(*)
FROM books as b 
JOIN 
issued_status as ist 
ON ist.issued_book_isbn = b.isbn
GROUP BY 1 ;

-- Task 9. **List Members Who Registered in the Last 180 Days**:

INSERT INTO issued_status(
    issued_id, 
    issued_member_id, 
    issued_book_name, 
    issued_date, 
    issued_book_isbn, 
    issued_emp_id
)
VALUES
('IS151', 'C118', 'The Catcher in the Rye', DATE_SUB(CURRENT_DATE, INTERVAL 24 DAY), '978-0-553-29698-2', 'E108'),
('IS152', 'C119', 'The Catcher in the Rye', DATE_SUB(CURRENT_DATE, INTERVAL 13 DAY), '978-0-553-29698-2', 'E109'),
('IS153', 'C106', 'Pride and Prejudice', DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY),  '978-0-14-143951-8', 'E107'),
('IS154', 'C105', 'The Road', DATE_SUB(CURRENT_DATE, INTERVAL 32 DAY),  '978-0-375-50167-0', 'E101');


SELECT * 
FROM members 
WHERE reg_date >= DATE_SUB(CURRENT_DATE, INTERVAL 180 DAY);

