-- LIBRARY_MANAGEMENT_PROJECT_P2 

-- creating branch table 

DROP TABLE IF EXISTS branch ;
CREATE TABLE branch (

        branch_id VARCHAR (10) PRIMARY KEY,
	manager_id	VARCHAR (10),
        branch_address	VARCHAR (55),
        contact_no VARCHAR (10)
    
);

-- creating employees table 

DROP TABLE IF EXISTS employees ;
CREATE TABLE employees (

        emp_id VARCHAR (10) PRIMARY KEY ,
	emp_name VARCHAR (25),
	position VARCHAR (15),
	salary	INT,
        branch_id VARCHAR (25),
	FOREIGN KEY (branch_id) REFERENCES  branch(branch_id)

);

-- creating books table 

DROP TABLE IF EXISTS books;
CREATE TABLE books (

	isbn VARCHAR (50) PRIMARY KEY ,
	book_title VARCHAR (80),
	category VARCHAR (30),
	rental_price DECIMAL (10, 2),
	status	VARCHAR (10),
        author VARCHAR (30),
	publisher VARCHAR (30)

);

-- creating members table 

DROP TABLE IF EXISTS members ;
CREATE TABLE members (

            member_id VARCHAR(10) PRIMARY KEY,
            member_name VARCHAR(30),
            member_address VARCHAR(30),
            reg_date DATE

);

-- creating issued status table 

DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status
(
            issued_id VARCHAR(10) PRIMARY KEY,
            issued_member_id VARCHAR(30),
            issued_book_name VARCHAR(80),
            issued_date DATE,
            issued_book_isbn VARCHAR(50),
            issued_emp_id VARCHAR(10),
            FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
            FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id),
            FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn) 
);

-- creating return status table 

DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status
(
            return_id VARCHAR(10) PRIMARY KEY,
            issued_id VARCHAR(30),
            return_book_name VARCHAR(80),
            return_date DATE,
            return_book_isbn VARCHAR(50),
            FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);
