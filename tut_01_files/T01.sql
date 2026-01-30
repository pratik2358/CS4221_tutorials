CREATE TABLE books (
  b_title VARCHAR(256) NOT NULL,
  b_published VARCHAR(64) NOT NULL,
  b_year DATE NOT NULL,
  b_language VARCHAR(32) NOT NULL,
  b_format CHAR(9)
    CONSTRAINT format
    CHECK(format = 'paperback' OR format='hardcover')
  b_isbn10 CHAR(10) UNIQUE NOT NULL,
  b_isbn13 CHAR(14) PRIMARY KEY
);

CREATE TABLE departments (
  d_name VARCHAR(32) PRIMARY KEY,
  d_faculty VARCHAR(62) NOT NULL
);

CREATE TABLE students (
  s_name VARCHAR(32) NOT NULL,
  s_email VARCHAR(256) PRIMARY KEY,
  s_join DATE NOT NULL,
  d_name VARCHAR(32) NOT NULL
    REFERENCES departments(d_name),
  g_date DATE CHECK(g_date >= year) -- simplification
);

CREATE TABLE authors (
  a_name VARCHAR(64) PRIMARY KEY
);

CREATE TABLE write (
  b_isbn13 CHAR(14)
    REFERENCES books(b_isbn13),
  a_name VARCHAR(64)
    REFERENCES authors(a_name),
  PRIMARY KEY (b_isbn13, a_name)
);

CREATE TABLE own (
  s_owner VARCHAR(256)
    REFERENCES students(s_email),
  b_isbn13 CHAR(14)
    REFERENCES books(b_isbn13),
  c_number INT CHECK(c_number > 0),
  PRIMARY KEY(s_owner, b_isbn13, c_number)
);

CREATE TABLE loan (
  s_owner VARCHAR(256),
  b_isbn13 CHAR(14),
  c_number INT CHECK(c_number > 0),
  s_borrower VARCHAR(256),
    REFERENCES students(s_email),
  bd_date DATE,
  rd_date DATE CHECK(rd_date >= bd_date) -- simplification
  FOREIGN KEY (s_owner, b_isbn13, c_number)
    REFERENCES own(s_owner, b_isbn13, c_number)
  PRIMARY KEY (s_owner, b_isbn13, c_number, s_borrower, bd_date)
);