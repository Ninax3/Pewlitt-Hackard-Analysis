--create retirement titles table per criteria
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM titles as ti
LEFT JOIN employees as e
ON (ti.emp_no = e.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

SELECT * FROM retirment_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_retirement_titles
FROM retirement_titles as rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

-- count the number of unique retirement titles
SELECT COUNT (title)
FROM unique_retirement_titles;

--create retiring titles descending count
SELECT COUNT (title),
	urt.title
INTO retiring_titles
FROM unique_retirement_titles as urt
GROUP BY title
ORDER BY count DESC;

--create mentorship eligibility per criteria
SELECT DISTINCT ON (ti.emp_no)
	ti.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no ASC;

--RECOMMENDED additional query for silver tsunami hr event
SELECT DISTINCT ON (ti.emp_no)
	ti.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility_enhanced
FROM employees as e
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1956-01-01' AND '1965-12-31')
ORDER BY emp_no ASC;

SELECT * FROM mentorship_eligibility_enhanced

-- RECOMMENDED count titles in mentorship_eligibility_enhanced
SELECT COUNT (title),
	mee.title
INTO mee_titles
FROM mentorship_eligibility_enhanced as mee
GROUP BY title
ORDER BY count DESC;

SELECT * FROM mee_titles



