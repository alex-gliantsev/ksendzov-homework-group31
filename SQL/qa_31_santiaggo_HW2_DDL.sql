-- 1. Создать таблицу employees
-- - id. serial,  primary key,
-- - employee_name. Varchar(50), not null

CREATE TABLE employees(
    id serial primary key, 
    employee_name VARCHAR(50) not null
);

-- 2. Наполнить таблицу employee 70 строками

insert into employees (employee_name)
values 
		('John'),
		('Boris'),
		('Genry'),
		('Ivan'),
		('Omar'),
		('Lee'),
		('Ruslan'),
		('Alex'),
		('Andrei'),
		('Azamat'),
		('Jack'),
		('Steven'),
		('Nadia'),
		('Elena'),
		('Renat'),
		('Sveta'),
		('Avanti'),
		('Darshit'),
		('Zohan'),
		('Alisha'),
		('Eva'),
		('Monica'),
		('Rachel'),
		('Rodrigo'),
		('Diego'),
		('Cristiano'),
		('Lionel'),
		('Tony'),
		('Karim'),
		('Andre'),
		('Silvestre'),
		('Niko'),
		('Diego'),
		('Marcos'),
		('Gonsalo'),
		('Pablo'),
		('Oliver'),
		('Thomas'),
		('Eric'),
		('Alfonso'),
		('Daniel'),
		('Giovani'),
		('Manuel'),
		('Nikolas'),
		('Joe'),
		('Samuel'),
		('Francis'),
		('Santiago'),
		('Jennifer'),
		('Ingrid'),
		('Kate'),
		('Naomi'),
		('Natalie'),
		('Gustaf'),
		('Peter'),
		('Travis'),
		('Ragnar'),
		('Bjorn'),
		('Helga'),
		('Philipp'),
		('Maria'),
		('Olga'),
		('Marina'),
		('Natasha'),
		('William'),
		('Gabriel'),
		('Bradly'),
		('Martin'),
		('Eric'),
		('Luke');

-- 3. Создать таблицу salary
-- - id. Serial  primary key,
-- - monthly_salary. Int, not null

CREATE TABLE salary(
    id serial primary key, 
    monthly_salary int not null
);

-- 4. Наполнить таблицу salary 15 строками

insert into salary (monthly_salary)
values 
		(1000),
		(1100),
		(1200),
		(1300),
		(1400),
		(1500),
		(1600),
		(1700),
		(1800),
		(1900),
		(2000),
		(2100),
		(2200),
		(2300),
		(2400);

-- 5. Создать таблицу employee_salary
-- - id. Serial  primary key,
-- - employee_id. Int, not null, unique
-- - salary_id. Int, not null

CREATE TABLE employee_salary(
    id serial primary key, 
    employee_id int not null unique,
    salary_id int not null
);

-- 6. Наполнить таблицу employee_salary 40 строками
-- - в 10 строк из 40 вставить несуществующие employee_id

insert into employee_salary (employee_id, salary_id)
values 
		(5, 6),
		(1, 10),
		(3, 9),
		(10, 15),
		(2, 14),
		(4, 8),
		(6, 7),
		(7, 13),
		(9, 1),
		(8, 5),
		(45, 2),
		(30, 3),
		(12, 4),
		(11, 12),
		(17, 11),
		(50, 4),
		(47, 7),
		(15, 14),
		(32, 8),
		(33, 13),
		(18, 9),
		(20, 5),
		(22, 1),
		(28, 3),
		(14, 6),
		(19, 13),
		(29, 2),
		(49, 4),
		(21, 10),
		(43, 12),
		(90, 1),
		(91, 3),
		(92, 9),
		(93, 8),
		(94, 14),
		(95, 7),
		(96, 4),
		(97, 13),
		(98, 2),
		(99, 2);

-- 7. Создать таблицу roles
-- - id. Serial  primary key,
-- - role_name. int, not null, unique

CREATE TABLE roles(
    id serial primary key, 
    role_name int not null
);

-- 8. Поменять тип столба role_name с int на varchar(30)

alter table roles
alter column role_name type varchar(30);

-- 9. Наполнить таблицу roles 20 строками

insert into roles (role_name)
values
		('Junior Python developer'),
		('Middle Python developer'),
		('Senior Python developer'),
		('Junior Java developer'),
		('Middle Java developer'),
		('Senior Java developer'),
		('Junior JavaScript developer'),
		('Middle JavaScript developer'),
		('Senior JavaScript developer'),
		('Junior Manual QA engineer'),
		('Middle Manual QA engineer'),
		('Senior Manual QA engineer'),
		('Project Manager'),
		('Designer'),
		('HR'),
		('CEO'),
		('Sales manager'),
		('Junior Automation QA engineer'),
		('Middle Automation QA engineer'),
		('Senior Automation QA engineer');

-- 10. Создать таблицу roles_employee
-- - id. Serial  primary key,
-- - employee_id. Int, not null, unique (внешний ключ для таблицы employees, поле id)
-- - role_id. Int, not null (внешний ключ для таблицы roles, поле id)

CREATE TABLE roles_employee (
    id serial primary key, 
    employee_id int not null unique,
    role_id int not null,
    foreign key (employee_id) references employees (id),
    foreign key (role_id) references roles (id)
);

-- 11. Наполнить таблицу roles_employee 40 строками

insert into roles_employee (employee_id, role_id)
values 
		(3, 10),
		(5, 6),
		(1, 15),
		(4, 9),
		(10, 8),
		(2, 4),
		(9, 13),
		(6, 7),
		(7, 5),
		(30, 1),
		(8, 3),
		(45, 2),
		(17, 16),
		(12, 11),
		(11, 12),
		(15, 17),
		(50, 18),
		(47, 14),
		(18, 19),
		(32, 20),
		(33, 16),
		(28, 11),
		(20, 1),
		(22, 9),
		(29, 8),
		(14, 20),
		(19, 8),
		(43, 5),
		(49, 7),
		(21, 16),
		(51, 19),
		(46, 14),
		(48, 4),
		(52, 15),
		(44, 18),
		(53, 14),
		(31, 7),
		(37, 10),
		(36, 10),
		(23, 2);