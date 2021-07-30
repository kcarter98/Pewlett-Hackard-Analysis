-- Create retirement titles table
-- Drop Table if necessary
DROP TABLE retirement_titles;
-- run query to get list of employees and titles at retirement age
SELECT e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
JOIN  titles as t ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;
-- View created table
SELECT * FROM retirement_titles;

-- Create unique titles table
-- Drop table if necessary
DROP TABLE unique_titles;
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date
INTO unique_titles
FROM employees as e
JOIN titles as t ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no, t.to_date DESC;
-- View created table
SELECT * FROM unique_titles;

-- Create retiring titles table
-- Drop Table if necessary
DROP TABLE retiring_titles;
-- retrieve number of titles from unique_titles
SELECT count(title) AS count, title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;
-- View created table
SELECT * FROM retiring_titles;

-- Create mentorship eligibility table
-- Drop if exists
DROP TABLE mentorship_eligibility;
-- Create table from data
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
JOIN dept_employees as de ON e.emp_no = de.emp_no
JOIN titles as t ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND de.to_date = '9999-01-01'
ORDER BY e.emp_no;
-- View created table
SELECT * FROM mentorship_eligibility;

-- Create mentorship titles count table
-- Drop if exists
DROP TABLE mentorship_counts;
-- Create counts table
SELECT count(title) AS count, title
INTO mentorship_counts
FROM mentorship_eligibility
GROUP BY title
ORDER BY count DESC;
-- View created table
SELECT * FROM mentorship_counts;