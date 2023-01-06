--1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.
select
	e.employee_name,
	s.monthly_salary
from employees as e
join employee_salary as es
	on e.id = es.employee_id
join salary as s
	on es.salary_id = s.id;

--2. Вывести всех работников у которых ЗП меньше 2000.
select
	e.employee_name,
	s.monthly_salary
from employees as e
join employee_salary as es
	on e.id = es.employee_id
join salary as s
	on es.salary_id = s.id
where monthly_salary < 2000;

--3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select 
	es.salary_id,
	s.monthly_salary,
	e.employee_name
from employee_salary as es
join salary as s
	on es.salary_id = s.id
left join employees as e
	on e.id = es.employee_id
where e.employee_name is null;

--4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен.(ЗП есть, но не понятно кто её получает.)
select 
	es.salary_id,
	s.monthly_salary,
	e.employee_name
from employee_salary as es
join salary as s
	on es.salary_id = s.id
left join employees as e
	on e.id = es.employee_id
where e.employee_name is null
	and s.monthly_salary < 2000;

--5. Найти всех работников кому не начислена ЗП.
select
	e.employee_name,
	es.salary_id
from employees as e
left join employee_salary as es
	on e.id = es.employee_id
where es.salary_id is null;

--6. Вывести всех работников с названиями их должности.
select
	e.employee_name,
	r.role_name
from employees as e
join roles_employee as re 
	on e.id = re.employee_id
join roles as r 
	on re.role_id = r.id;
	
--7. Вывести имена и должность только Java разработчиков.
select
	e.employee_name,
	r.role_name
from employees as e
join roles_employee as re 
	on e.id = re.employee_id
join roles as r 
	on re.role_id = r.id
where r.role_name like '%Java developer%';

--8. Вывести имена и должность только Python разработчиков.
select
	e.employee_name,
	r.role_name
from employees as e
join roles_employee as re 
	on e.id = re.employee_id
join roles as r 
	on re.role_id = r.id
where r.role_name like '%Python developer%';

--9. Вывести имена и должность всех QA инженеров.
select
	e.employee_name,
	r.role_name
from employees as e
join roles_employee as re 
	on e.id = re.employee_id
join roles as r 
	on re.role_id = r.id
where r.role_name like '%QA%';

--10. Вывести имена и должность ручных QA инженеров.
select
	e.employee_name,
	r.role_name
from employees as e
join roles_employee as re 
	on e.id = re.employee_id
join roles as r 
	on re.role_id = r.id
where r.role_name like '%Manual QA%';

--11. Вывести имена и должность автоматизаторов QA
select
	e.employee_name,
	r.role_name
from employees as e
join roles_employee as re 
	on e.id = re.employee_id
join roles as r 
	on re.role_id = r.id
where r.role_name like '%Automation QA%';

--12. Вывести имена и зарплаты Junior специалистов
select
	e.employee_name,
	r.role_name,
	s.monthly_salary
from employees as e
join employee_salary as es 
	on e.id = es.employee_id
join roles_employee as re 
	on re.employee_id = e.id
join roles as r
	on r.id = re.role_id 
join salary as s 
	on s.id = es.salary_id
where r.role_name like '%Junior%';


--13. Вывести имена и зарплаты Middle специалистов
select
	e.employee_name,
	r.role_name,
	s.monthly_salary
from employees as e
join employee_salary as es 
	on e.id = es.employee_id
join roles_employee as re 
	on re.employee_id = e.id
join roles as r
	on r.id = re.role_id 
join salary as s 
	on s.id = es.salary_id
where r.role_name like '%Middle%';

--14. Вывести имена и зарплаты Senior специалистов
select
	e.employee_name,
	r.role_name,
	s.monthly_salary
from employees as e
join employee_salary as es 
	on e.id = es.employee_id
join roles_employee as re 
	on re.employee_id = e.id
join roles as r
	on r.id = re.role_id 
join salary as s 
	on s.id = es.salary_id
where r.role_name like '%Senior%';

--15. Вывести зарплаты Java разработчиков
select
	e.employee_name,
	r.role_name,
	s.monthly_salary
from employees as e
join employee_salary as es 
	on e.id = es.employee_id
join roles_employee as re 
	on re.employee_id = e.id
join roles as r
	on r.id = re.role_id 
join salary as s 
	on s.id = es.salary_id
where r.role_name like '%Java developer%';

--16. Вывести зарплаты Python разработчиков
select
	e.employee_name,
	r.role_name,
	s.monthly_salary
from employees as e
join employee_salary as es 
	on e.id = es.employee_id
join roles_employee as re 
	on re.employee_id = e.id
join roles as r
	on r.id = re.role_id 
join salary as s 
	on s.id = es.salary_id
where r.role_name like '%Python developer%';

--17. Вывести имена и зарплаты Junior Python разработчиков
select
	e.employee_name,
	r.role_name,
	s.monthly_salary
from employees as e
join employee_salary as es 
	on e.id = es.employee_id
join roles_employee as re 
	on re.employee_id = e.id
join roles as r
	on r.id = re.role_id 
join salary as s 
	on s.id = es.salary_id
where r.role_name = 'Junior Python developer';

--18. Вывести имена и зарплаты Middle JS разработчиков
select
	e.employee_name,
	r.role_name,
	s.monthly_salary
from employees as e
join employee_salary as es 
	on e.id = es.employee_id
join roles_employee as re 
	on re.employee_id = e.id
join roles as r
	on r.id = re.role_id 
join salary as s 
	on s.id = es.salary_id
where r.role_name = 'Middle JavaScript developer';

--19. Вывести имена и зарплаты Senior Java разработчиков
select
	e.employee_name,
	r.role_name,
	s.monthly_salary
from employees as e
join employee_salary as es 
	on e.id = es.employee_id
join roles_employee as re 
	on re.employee_id = e.id
join roles as r
	on r.id = re.role_id 
join salary as s 
	on s.id = es.salary_id
where r.role_name = 'Senior Java developer';

--20. Вывести зарплаты Junior QA инженеров
select
	e.employee_name,
	r.role_name,
	s.monthly_salary
from employees as e
join employee_salary as es 
	on e.id = es.employee_id
join roles_employee as re 
	on re.employee_id = e.id
join roles as r
	on r.id = re.role_id 
join salary as s 
	on s.id = es.salary_id
where r.role_name like 'Junior%QA engineer';

--21. Вывести среднюю зарплату всех Junior специалистов.
select
	round(avg(s.monthly_salary), 0) as avg_junior_salary
from salary as s
join employee_salary as es 
	on s.id = es.salary_id
join roles_employee as re
	on re.employee_id = es.employee_id
join roles as r
	on r.id = re.role_id
where r.role_name like '%Junior%';

--22. Вывести сумму зарплат JS разработчиков
select
	sum(s.monthly_salary) as sum_jsdevelopers_salary
from salary as s
join employee_salary as es 
	on s.id = es.salary_id
join roles_employee as re
	on re.employee_id = es.employee_id
join roles as r
	on r.id = re.role_id
where r.role_name like '%JavaScript%';

--23. Вывести минимальную ЗП QA инженеров
select
	min(s.monthly_salary) as min_qa_salary
from salary as s
join employee_salary as es 
	on s.id = es.salary_id
join roles_employee as re
	on re.employee_id = es.employee_id
join roles as r
	on r.id = re.role_id
where r.role_name like '%QA%';

--24. Вывести максимальную ЗП QA инженеров
select
	max(s.monthly_salary) as max_qa_salary
from salary as s
join employee_salary as es 
	on s.id = es.salary_id
join roles_employee as re
	on re.employee_id = es.employee_id
join roles as r
	on r.id = re.role_id
where r.role_name like '%QA%';

--25. Вывести количество QA инженеров
select
	count(*) as qa_count
from employees as e
join roles_employee as re 
	on e.id = re.employee_id
join roles as r 
	on re.role_id = r.id
where r.role_name like '%QA%';

--26. Вывести количество Middle специалистов.
select
	count(*) as middle_count
from employees as e
join roles_employee as re 
	on e.id = re.employee_id
join roles as r 
	on re.role_id = r.id
where r.role_name like 'Middle%';

--27. Вывести количество разработчиков
select
	count(*) as developers_count
from employees as e
join roles_employee as re 
	on e.id = re.employee_id
join roles as r 
	on re.role_id = r.id
where r.role_name like '%developer%';

--28. Вывести фонд (сумму) зарплаты разработчиков.
select
	sum(s.monthly_salary) as developers_salary_fund
from salary as s
join employee_salary as es 
	on s.id = es.salary_id
join roles_employee as re
	on re.employee_id = es.employee_id
join roles as r
	on r.id = re.role_id
where r.role_name like '%developer%';

--29. Вывести имена, должности и ЗП всех специалистов по возрастанию
select
	e.employee_name,
	r.role_name,
	s.monthly_salary
from employees as e
join employee_salary as es 
	on e.id = es.employee_id
join roles_employee as re 
	on re.employee_id = e.id
join roles as r
	on r.id = re.role_id 
join salary as s 
	on s.id = es.salary_id
order by 3;

--30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300
select
	e.employee_name,
	r.role_name,
	s.monthly_salary
from employees as e
join employee_salary as es 
	on e.id = es.employee_id
join roles_employee as re 
	on re.employee_id = e.id
join roles as r
	on r.id = re.role_id 
join salary as s 
	on s.id = es.salary_id
where s.monthly_salary between 1700 and 2300
order by 3;

--31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300
select
	e.employee_name,
	r.role_name,
	s.monthly_salary
from employees as e
join employee_salary as es 
	on e.id = es.employee_id
join roles_employee as re 
	on re.employee_id = e.id
join roles as r
	on r.id = re.role_id 
join salary as s 
	on s.id = es.salary_id
where s.monthly_salary < 2300
order by 3;

--32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000
select
	e.employee_name,
	r.role_name,
	s.monthly_salary
from employees as e
join employee_salary as es 
	on e.id = es.employee_id
join roles_employee as re 
	on re.employee_id = e.id
join roles as r
	on r.id = re.role_id 
join salary as s 
	on s.id = es.salary_id
where s.monthly_salary in (1100, 1500, 2000)
order by 3;