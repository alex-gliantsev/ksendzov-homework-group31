--Сформулируйте запрос для создания таблицы book.
create table book (
    book_id int primary key auto_increment,
    title varchar(50),
    author varchar(30),
    price decimal(8, 2),
    amount int
    );

--Занесите новую строку в таблицу book 
insert into book (title, author, price, amount)
values ('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3);

--Занесите три последние записи в таблицу book
insert into book (title, author, price, amount)
values 
    ('Белая гвардия', 'Булгаков М.А.', 540.50, 5),
    ('Идиот', 'Достоевский Ф.М.', 460.00, 10),
    ('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2);

-- Создание таблицы с внешними ключами
create table book (
    book_id int primary key auto_increment, 
    title varchar(50), 
    author_id int not null, 
    genre_id int,
    price decimal(8,2), 
    amount int, 
    foreign key (author_id)  references author (author_id),
    foreign key (genre_id) references genre (genre_id)
);

-- Создание таблицы с внешними ключами
-- При удалении автора из таблицы author, должны удаляться все записи о книгах из таблицы book, написанные этим автором. 
-- При удалении жанра из таблицы genre для соответствующей записи book установить значение Null в столбце genre_id.
create table book (
    book_id int primary key auto_increment, 
    title varchar(50), 
    author_id int not null, 
    genre_id int,
    price decimal(8,2), 
    amount int, 
    foreign key (author_id) references author (author_id) on delete cascade,
    foreign key (genre_id) references genre (genre_id) on delete set null
);


-- Table book
+---------+--------------------+------------------+--------+--------+
| book_id | title              | author           | price  | amount |
+---------+--------------------+------------------+--------+--------+
| 1       | Мастер и Маргарита | Булгаков М.А.    | 670.99 | 3      |
| 2       | Белая гвардия      | Булгаков М.А.    | 540.50 | 5      |
| 3       | Идиот              | Достоевский Ф.М. | 460.00 | 10     |
| 4       | Братья Карамазовы  | Достоевский Ф.М. | 799.01 | 2      |
+---------+--------------------+------------------+--------+--------+

-- Table supply
+-----------+----------------+------------------+--------+--------+
| supply_id | title          | author           | price  | amount |
+-----------+----------------+------------------+--------+--------+
| 1         | Лирика         | Пастернак Б.Л.   | 518.99 | 2      |
| 2         | Черный человек | Есенин С.А.      | 570.20 | 6      |
| 3         | Белая гвардия  | Булгаков М.А.    | 540.50 | 7      |
| 4         | Идиот          | Достоевский Ф.М. | 360.80 | 3      |
+-----------+----------------+------------------+--------+--------+

-- Table genre
+----------+-------------+
| genre_id | name_genre  |
+----------+-------------+
| 1        | Роман       |
| 2        | Поэзия      |
| 3        | Приключения |
+----------+-------------+

-- Добавить из таблицы supply в таблицу book, все книги, кроме книг, написанных Булгаковым М.А. и Достоевским Ф.М.
insert into book (title, author, price, amount) 
select title, author, price, amount 
from supply
where author not in ('Булгаков М.А.', 'Достоевский Ф.М.');

-- Занести из таблицы supply в таблицу book только те книги, авторов которых нет в book.
insert into book (title, author, price, amount) 
select title, author, price, amount 
from supply
where author not in (
        select author 
        from book
      );

-- Уменьшить на 10% цену тех книг в таблице book, количество которых принадлежит интервалу от 5 до 10, включая границы.
update book
set price = 0.9 * price
where amount between 5 and 10;

-- Для реализации оптовой продажи включим дополнительный столбец buy в таблицу book.
-- В таблице book необходимо скорректировать значение для покупателя в столбце buy таким образом, 
-- чтобы оно не превышало количество экземпляров книг, указанных в столбце amount.
-- А цену тех книг, которые покупатель не заказывал, снизить на 10%.
update book
set buy = if(buy >= amount, amount, buy),
    price = if(buy = 0, price * 0.9, price);

-- Для тех книг в таблице book, которые есть в таблице supply, увеличить их количество в таблице book (на значение столбца amount таблицы supply),
-- пересчитать их цену (для каждой книги найти сумму цен из таблиц book и supply и разделить на 2).
update book, supply 
set book.amount = book.amount + supply.amount,
    book.price = (book.price + supply.price)/2
WHERE book.title = supply.title AND book.author = supply.author;

-- Удалить из таблицы supply книги тех авторов, общее количество экземпляров книг которых в таблице book превышает 10.
delete from supply
where author in (
    select author
    from book
    group by author
    having sum(amount) > 10);

-- Создать таблицу заказ (ordering), куда включить авторов и названия тех книг, 
-- количество экземпляров которых в таблице book меньше среднего количества экземпляров книг в таблице book. 
-- В таблицу включить столбец amount, в котором для всех книг указать одинаковое значение - среднее количество экземпляров книг в таблице book.
create table ordering as
select author, title, (
    select round(avg(amount))
    from book
    ) as amount
from book
where amount < (
    select round(avg(amount))
    from book);

-- Включить новых авторов в таблицу author с помощью запроса на добавление.  
-- Новыми считаются авторы, которые есть в таблице supply, но нет в таблице author.
insert into author (name_author)
select s.author
from author as a
right join supply as s
    on a.name_author = s.author
where a.name_author is null;

-- Добавить новые записи о книгах, которые есть в таблице supply и нет в таблице book.
insert into book (title, author_id, price, amount)
select 
    s.title, 
    a.author_id, 
    s.price, 
    s.amount
from author as a
join supply as s
    on a.name_author = s.author
where amount <> 0;

-- Занести для книги «Стихотворения и поэмы» Лермонтова жанр «Поэзия»
update book
set genre_id = 
    (select genre_id
     from genre
     where name_genre = 'Поэзия')
where title = 'Стихотворения и поэмы';

-- Удалить всех авторов и все их книги, общее количество книг которых меньше 20.
delete from author
where author_id in 
    (select 
        author_id
    from book
    group by author_id
    having sum(amount) < 20);

-- Удалить все жанры, к которым относится меньше 4-х книг.
delete from genre
where genre_id in
    (select genre_id
     from book
     group by genre_id
     having count(title) < 4);

-- Удалить всех авторов, которые пишут в жанре "Поэзия".
delete from author
using author
join book as b
    on author.author_id = b.author_id
join genre as g
    on b.genre_id = g.genre_id
where name_genre = 'Поэзия';

-- Table client
+-----------+-----------------+---------+----------------+
| client_id | name_client     | city_id | email          |
+-----------+-----------------+---------+----------------+
| 1         | Баранов Павел   | 3       | baranov@test   |
| 2         | Абрамова Катя   | 1       | abramova@test  |
| 3         | Семенонов Иван  | 2       | semenov@test   |
| 4         | Яковлева Галина | 1       | yakovleva@test |
+-----------+-----------------+---------+----------------+

-- Table buy
+--------+---------------------------------------+-----------+
| buy_id | buy_description                       | client_id |
+--------+---------------------------------------+-----------+
| 1      | Доставка только вечером               | 1         |
| 2      | NULL                                  | 3         |
| 3      | Упаковать каждую книгу по отдельности | 2         |
| 4      | NULL                                  | 1         |
+--------+---------------------------------------+-----------+

-- Table buy_book
+-------------+--------+---------+--------+
| buy_book_id | buy_id | book_id | amount |
+-------------+--------+---------+--------+
| 1           | 1      | 1       | 1      |
| 2           | 1      | 7       | 2      |
| 3           | 1      | 3       | 1      |
| 4           | 2      | 8       | 2      |
| 5           | 3      | 3       | 2      |
| 6           | 3      | 2       | 1      |
| 7           | 3      | 1       | 1      |
| 8           | 4      | 5       | 1      |
+-------------+--------+---------+--------+

-- Table buy_step
+-------------+--------+---------+---------------+---------------+
| buy_step_id | buy_id | step_id | date_step_beg | date_step_end |
+-------------+--------+---------+---------------+---------------+
| 1           | 1      | 1       | 2020-02-20    | 2020-02-20    |
| 2           | 1      | 2       | 2020-02-20    | 2020-02-21    |
| 3           | 1      | 3       | 2020-02-22    | 2020-03-07    |
| 4           | 1      | 4       | 2020-03-08    | 2020-03-08    |
| 5           | 2      | 1       | 2020-02-28    | 2020-02-28    |
| 6           | 2      | 2       | 2020-02-29    | 2020-03-01    |
| 7           | 2      | 3       | 2020-03-02    | NULL          |
| 8           | 2      | 4       | NULL          | NULL          |
| 9           | 3      | 1       | 2020-03-05    | 2020-03-05    |
| 10          | 3      | 2       | 2020-03-05    | 2020-03-06    |
| 11          | 3      | 3       | 2020-03-06    | 2020-03-11    |
| 12          | 3      | 4       | 2020-03-12    | NULL          |
| 13          | 4      | 1       | 2020-03-20    | NULL          |
| 14          | 4      | 2       | NULL          | NULL          |
| 15          | 4      | 3       | NULL          | NULL          |
| 16          | 4      | 4       | NULL          | NULL          |
+-------------+--------+---------+---------------+---------------+

-- Включить нового человека в таблицу с клиентами. Его имя Попов Илья, его email popov@test, проживает в Москве.
insert into client (name_client, city_id, email)
select
    'Попов Илья',
    city_id,
    'popov@test'
from city
where name_city = 'Москва';

-- Создать новый заказ для Попова Ильи. Его комментарий для заказа: «Связаться со мной по вопросу доставки».
insert into buy (buy_description, client_id)
select 
    'Связаться со мной по вопросу доставки',
    client_id
from client
where name_client = 'Попов Илья';

-- В таблицу buy_book добавить заказ с номером 5. Этот заказ должен содержать книгу Пастернака «Лирика» в количестве двух экземпляров.
insert into buy_book (buy_id, book_id, amount)
select
    5,
    book_id,
    2
from book as b
join author as a
    on b.author_id = a.author_id
where b.title = 'Лирика'
    and a.name_author = 'Пастернак Б.Л.';

-- Уменьшить количество тех книг на складе, которые были включены в заказ с номером 5.
update book, buy_book
set book.amount = book.amount - buy_book.amount
where book.book_id = buy_book.book_id
    and buy_book.buy_id = 5;

-- Создать счет (таблицу buy_pay) на оплату заказа с номером 5, в который включить название книг, их автора, цену, количество заказанных книг и  стоимость. 
create table buy_pay as
select
    b.title,
    a.name_author,
    b.price,
    bb.amount,
    bb.amount * b.price as sum_price
from author as a
join book as b
    on a.author_id = b.author_id
join buy_book as bb
    on b.book_id = bb.book_id
where bb.buy_id = 5
order by b.title;

-- Создать общий счет (таблицу buy_pay) на оплату заказа с номером 5. 
-- Куда включить номер заказа, количество книг в заказе и его общую стоимость.
create table buy_pay as
select
    bb.buy_id,
    sum(bb.amount) as book_amount,
    sum(bb.amount * b.price) as price_total
from book as b
join buy_book as bb
    on b.book_id = bb.book_id
where bb.buy_id = 5
group by bb.buy_id;

-- В таблицу buy_step для заказа с номером 5 включить все этапы из таблицы step, которые должен пройти этот заказ. 
-- В столбцы date_step_beg и date_step_end всех записей занести Null.
insert into buy_step (buy_id, step_id, date_step_beg, date_step_end)
select 
    b.buy_id,
    s.step_id,
    null,
    null
from step as s
cross join buy as b
where b.buy_id = 5;

-- В таблицу buy_step занести дату 12.04.2020 выставления счета на оплату заказа с номером 5.
update buy_step as bs
join step as s
   on bs.step_id = s.step_id
set date_step_beg = '2020-04-12'
where buy_id = 5 
    and s.name_step = 'Оплата' ;


-- Table fine
+---------------+--------+------------------------------+----------+----------------+--------------+
| name          | number | violation                    | sum_fine | date_violation | date_payment | 
|               | _plate |                              |          |                |              | 
+---------------+--------+------------------------------+----------+----------------+--------------+
| Баранов П.Е.  | Р523ВТ | Превышение скорости(от 40... | 500.00   | 2020-01-12     | 2020-01-17   |
| Абрамова К.А. | О111АВ | Проезд на запрещающий сигнал | 1000.00  | 2020-01-14     | 2020-02-27   |
| Яковлев Г.Р.  | Т330ТТ | Превышение скорости(от 20... | 500.00   | 2020-01-23     | 2020-02-23   |
| Яковлев Г.Р.  | М701АА | Превышение скорости(от 20... | NULL     | 2020-01-12     | NULL         |
| Колесов С.П.  | К892АХ | Превышение скорости(от 20... | NULL     | 2020-02-01     | NULL         |
| Баранов П.Е.  | Р523ВТ | Превышение скорости(от 40... | NULL     | 2020-02-14     | NULL         |
| Абрамова К.А. | О111АВ | Проезд на запрещающий сигн...| NULL     | 2020-02-23     | NULL         |
| Яковлев Г.Р.  | Т330ТТ | Проезд на запрещающий сигн...| NULL     | 2020-03-03     | NULL         |
+---------------+--------+------------------------------+----------+----------------+--------------+

-- Занести в таблицу fine суммы штрафов, которые должен оплатить водитель, в соответствии с данными из таблицы traffic_violation. 
-- При этом суммы заносить только в пустые поля столбца  sum_fine.
update fine f, traffic_violation tv
set f.sum_fine = tv.sum_fine 
where f.sum_fine is null 
   and f.violation = tv.violation;

-- В таблице fine увеличить в два раза сумму неоплаченных штрафов для тех водителей, которые на одной машине нарушили одно и то же правило два и более раз. 
update 
    fine,
    (select name, number_plate, violation
    from fine
    group by  1, 2, 3
    having count(3) >= 2) as new
set sum_fine = IF(date_payment is null, sum_fine * 2, sum_fine)
where fine.name = new.name;


-- Table payment
+------------+--------------+--------------+----------------------------------+----------------+--------------+
| payment_id | name         | number_plate | violation                        | date_violation | date_payment |
+------------+--------------+--------------+----------------------------------+----------------+--------------+
| 1          | Яковлев Г.Р. | М701АА       | Превышение скорости(от 20 до 40) | 2020-01-12     | 2020-01-22   |
| 2          | Баранов П.Е. | Р523ВТ       | Превышение скорости(от 40 до 60) | 2020-02-14     | 2020-03-06   |
| 3          | Яковлев Г.Р. | Т330ТТ       | Проезд на запрещающий сигнал     | 2020-03-03     | 2020-03-23   |
+------------+--------------+--------------+----------------------------------+----------------+--------------+

-- В таблице payment занесены даты оплаты штрафов. 
-- Необходимо в таблицу fine занести дату оплаты соответствующего штрафа из таблицы payment.
-- Уменьшить начисленный штраф в таблице fine в два раза (только для тех штрафов, информация о которых занесена в таблицу payment), 
-- если оплата произведена не позднее 20 дней со дня нарушения.
update 
    fine f, 
    payment p
set 
    f.date_payment = p.date_payment,
    f.sum_fine = if(datediff(p.date_payment, p.date_violation) < 21, f.sum_fine/2, f.sum_fine)
where 
    f.name = p.name and
    f.number_plate = p.number_plate and
    f.violation = p.violation and
    f.date_violation = p.date_violation and
    f.date_payment is null;

-- Создать новую таблицу back_payment, куда внести информацию о неоплаченных штрафах 
-- (Фамилию и инициалы водителя, номер машины, нарушение, сумму штрафа  и  дату нарушения) из таблицы fine.
create table back_payment as
select
    name,
    number_plate,
    violation,
    sum_fine,
    date_violation
from fine
where date_payment is null;

-- Удалить из таблицы fine информацию о нарушениях, совершенных раньше 1 февраля 2020 года. 
delete from fine
where date_violation < '2020-02-01';