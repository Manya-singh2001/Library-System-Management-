-- SQL Project - Library System Management 

SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;

/*
Task 13: 
Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue.
*/

-- issued_status == members == books == return_status
-- filter books which is return
-- overdue > 30 

SELECT 
    ist.issued_member_id,
    m.member_name,
    bk.book_title,
    ist.issued_date,
    DATEDIFF(CURRENT_DATE, ist.issued_date) AS overdue_days
FROM issued_status AS ist
JOIN members AS m 
    ON m.member_id = ist.issued_member_id 
JOIN books AS bk 
    ON bk.isbn = ist.issued_book_isbn
LEFT JOIN return_status AS rs
    ON rs.issued_id = ist.issued_id 
WHERE 
    (rs.return_date IS NULL OR rs.return_date > CURRENT_DATE)  -- Ensures overdue books are counted
    AND DATEDIFF(CURRENT_DATE, ist.issued_date) > 30
    ORDER BY 1 ;



-- 
/*    
Task 14: Update Book Status on Return
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
*/
