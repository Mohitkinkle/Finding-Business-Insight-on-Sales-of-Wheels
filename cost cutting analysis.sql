-- 1)	SCENARIO - 1

SELECT 
    e.first_name, e.last_name, s.salary
FROM
    employees AS e
        JOIN
    newsalaries AS s ON e.emp_no = s.emp_no
ORDER BY s.salary DESC
LIMIT 10;

-- Tokuyasu	Pesch	158220.0
-- Honesty	Mukaidono	156286.0
-- Xiahua	Whitcomb	155709.0
-- Sanjai	Luders	155513.0
-- Tsutomu	Alameldin	155190.0
-- Willard	Baca	154459.0
-- Lidong	Meriste	154376.0
-- Charmane	Griswold	153715.0
-- Weijing	Chenoweth	152710.0
-- Weicheng	Hatcliff	152687.0


SELECT 
    d.dept_name, e.first_name, e.last_name, s.salary
FROM
    employees e
        INNER JOIN
    newsalaries s ON e.emp_no = s.emp_no
        INNER JOIN
    new_dept_emp de ON e.emp_no = de.emp_no
        INNER JOIN
    departments d ON de.dept_no = d.dept_no
ORDER BY s.salary DESC
LIMIT 10;

-- Production	Tokuyasu	Pesch	158220.0
-- Development	Honesty	Mukaidono	156286.0
-- Development	Xiahua	Whitcomb	155709.0
-- Customer Service	Sanjai	Luders	155513.0
-- Sales	Tsutomu	Alameldin	155190.0
-- Quality Management	Willard	Baca	154459.0
-- Production	Lidong	Meriste	154376.0
-- Research	Charmane	Griswold	153715.0
-- Production	Weijing	Chenoweth	152710.0
-- Customer Service	Weicheng	Hatcliff	152687.0

-- so production been the highest department


-- 3)	SCENARIO - 3

-- Similar to the previous scenario, not just the high salaried departments need to be focused on but also high employed departments analysis can help the company to do workforce management.
-- The company has decided a threshold of the number of employees for each department and to take an action on the departments with the number of employees more than the threshold they first need to find the highly employed departments.

-- Task: Find the top 3 departments having the highest number of employees.

-- Hint: Use group by and order by clauses

select d.dept_name,count(*) as num_employees
from employees as e
join new_dept_emp as de
on e.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no
group by dept_name
order by num_employees desc
limit 3

-- Development	76967
-- Production	66672
-- Sales	46921

-- this are 3 departments having highest number of employees

-- 4)	SCENARIO - 4

-- From the observations and analysis of the excel dataset we can say that the major focus of the company is to reduce the workforce of the sales department. As the number of sales are affected majorly the company finds the need to urgently reduce the workforce of sales departments.
-- This issue can be solved by focusing on those sales employees whose salary is greater than the average salary of the sales department.

-- Task: Find the list of employees from the sales department having a salary more than the average sales department salary.

-- Hint: Use where clause and subquery


select e.first_name, e.last_name, s.salary
from employees e
join newsalaries s ON e.emp_no = s.emp_no
join (
    select dept_no, avg(salary) as avg_salary
    from newsalaries
    join new_dept_emp on newsalaries.emp_no = new_dept_emp.emp_no
    group by dept_no
    ) 
dept_salary on e.emp_no = s.emp_no
join departments d on dept_salary.dept_no = d.dept_no
where  d.dept_name = 'Sales' and s.salary > dept_salary.avg_salary
order by s.salary desc
limit 15;

-- Tokuyasu	Pesch	158220.0
-- Honesty	Mukaidono	156286.0
-- Xiahua	Whitcomb	155709.0
-- Sanjai	Luders	155513.0
-- Tsutomu	Alameldin	155190.0
-- Willard	Baca	154459.0
-- Lidong	Meriste	154376.0
-- Charmane	Griswold	153715.0
-- Weijing	Chenoweth	152710.0
-- Weicheng	Hatcliff	152687.0
-- Shin	Birdsall	152412.0
-- Mitsuyuki	Stanfel	152220.0
-- Mohammed	Moehrke	150740.0
-- Ibibia	Junet	150345.0
-- Lansing	Kambil	150052.0

-- the list of employees from the sales department having a salary more than the average sales department salary.




-- 5)	SCENARIO - 5

-- According to the current situation of the company, they have decided the threshold/ margin of 65,000 monthly average salary of the departments which will help them in cost cutting as well as in workforce management.
-- How can we find the designations or job titles which are having high salaries?
-- If this question is resolved the company can focus on such designations or job titles and will stop their new hiring as well as can focus on the retrenchment of the employees having these designations for cost cutting purposes.

-- Task: Find the titles having an average salary greater than 65,000.

-- Hint: Use group by and having clauses.



select nt.title,avg(ns.salary) as avg_sal
from employees as e
join newsalaries as ns
on e.emp_no = ns.emp_no
join newtitle as nt
on e.emp_no = nt.emp_no
group by nt.title
having avg(ns.salary) > 65000
order by avg_sal desc

-- Senior Staff	79656.84339
-- Senior Engineer	69610.12391
-- Staff	69337.17417
-- Manager	68514.33333
-- Technique Leader	65490.77186


-- this job titles with their corresponding average salary, sorted by the average salary in descending order.












