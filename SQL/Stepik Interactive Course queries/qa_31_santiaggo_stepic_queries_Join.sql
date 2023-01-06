
-- Table book
+---------+-----------------------+-----------+----------+--------+--------+
| book_id | title                 | author_id | genre_id | price  | amount |
+---------+-----------------------+-----------+----------+--------+--------+
| 1       | Мастер и Маргарита    | 1         | 1        | 670.99 | 3      |
| 2       | Белая гвардия         | 1         | 1        | 540.50 | 5      |
| 3       | Идиот                 | 2         | 1        | 460.00 | 10     |
| 4       | Братья Карамазовы     | 2         | 1        | 799.01 | 3      |
| 5       | Игрок                 | 2         | 1        | 480.50 | 10     |
| 6       | Стихотворения и поэмы | 3         | 2        | 650.00 | 15     |
| 7       | Черный человек        | 3         | 2        | 570.20 | 6      |
| 8       | Лирика                | 4         | 2        | 518.99 | 2      |
+---------+-----------------------+-----------+----------+--------+--------+

-- Table author
+-----------+------------------+
| author_id | name_author      |
+-----------+------------------+
| 1         | Булгаков М.А.    |
| 2         | Достоевский Ф.М. |
| 3         | Есенин С.А.      |
| 4         | Пастернак Б.Л.   |
| 5         | Лермонтов М.Ю.   |
+-----------+------------------+

-- Table genre
+----------+-------------+
| genre_id | name_genre  |
+----------+-------------+
| 1        | Роман       |
| 2        | Поэзия      |
| 3        | Приключения |
+----------+-------------+

-- Table city
+---------+-----------------+
| city_id | name_city       |
+---------+-----------------+
| 1       | Москва          |
| 2       | Санкт-Петербург |
| 3       | Владивосток     |
+---------+-----------------+

-- Table supply
+-----------+----------------+------------------+--------+--------+
| supply_id | title          | author           | price  | amount |
+-----------+----------------+------------------+--------+--------+
| 1         | Доктор Живаго  | Пастернак Б.Л.   | 618.99 | 3      |
| 2         | Черный человек | Есенин С.А.      | 570.20 | 6      |
| 3         | Евгений Онегин | Пушкин А.С.      | 440.80 | 5      |
| 4         | Идиот          | Достоевский Ф.М. | 360.80 | 3      |
+-----------+----------------+------------------+--------+--------+

-- Вывести название, жанр и цену тех книг, количество которых больше 8. Отсортировать по убыванию цены.
select
    b.title,
    g.name_genre,
    b.price
from book as b
join genre as g
    on b.genre_id = g.genre_id
where b.amount > 8
order by b.price desc;

-- Вывести все жанры, которые не представлены в книгах на складе.
select
    g.name_genre
from genre as g
left join book as b
    on g.genre_id = b.genre_id
where b.title is null;

-- Необходимо в каждом городе (таблица City) провести выставку книг каждого автора в течение 2020 года. 
-- Дату проведения выставки выбрать случайным образом. Создать запрос, который выведет город, автора и дату проведения выставки.
-- Отсортировать сначала в алфавитном порядке по названиям городов, а потом по убыванию дат проведения выставок.
select
    name_city,
    name_author,
    date_add('2020-01-01', interval (floor(rand()*365)) DAY) as date
from city
cross join author
order by name_city, date desc;

-- Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру, включающему слово «роман». Отсортировать по названиям книг.
select
    g.name_genre,
    b.title,
    a.name_author
from genre as g
join book as b
    on g.genre_id = b.genre_id
join author as a
    on b.author_id = a.author_id
where g.name_genre like '%роман%'
order by b.title;

-- Посчитать количество экземпляров  книг каждого автора из таблицы author.  
-- Вывести тех авторов, количество книг которых меньше 10. Отсортировать по возрастанию количества.
select
    a.name_author,
    sum(b.amount) as book_amount
from author as a
left join book as b
    on a.author_id = b.author_id
group by a.name_author
having book_amount < 10 or book_amount is null
order by book_amount;

-- Вывести в алфавитном порядке всех авторов, которые пишут только в одном жанре.
select name_author
from author as a
join book as b
    on a.author_id = b.author_id
group by name_author
having count(distinct b.genre_id) = 1;

-- Если в таблицах supply и book есть одинаковые книги, которые имеют равную цену,  
-- вывести их название и автора, а также посчитать общее количество экземпляров книг в таблицах supply и book.
select
    title, 
    author, 
    (supply.amount + book.amount) as total_amount
from
    book
join author 
    using(author_id)
join supply 
    using(title)
where supply.price = book.price;

-- Для книг, которые уже есть на складе (в таблице book), но по другой цене, чем в поставке (supply),  
-- необходимо в таблице book увеличить количество на значение, указанное в поставке, и пересчитать цену (установить среднюю). 
update book as b
join author as a
    on a.author_id = b.author_id
join supply as s
    on b.title = s.title 
       and s.author = a.name_author
set b.amount = b.amount + s.amount,
    s.amount = 0,
    b.price = (b.price * b.amount + s.price * s.amount) / (b.amount + s.amount)
where b.price <> s.price;


-- Table client
+-----------+-----------------+---------+----------------+
| client_id | name_client     | city_id | email          |
+-----------+-----------------+---------+----------------+
| 1         | Баранов Павел   | 3       | baranov@test   |
| 2         | Абрамова Катя   | 1       | abramova@test  |
| 3         | Семенонов Иван  | 2       | semenov@test   |
| 4         | Яковлева Галина | 1       | yakovleva@test |
+-----------+-----------------+---------+----------------+

-- Table step
+---------+-----------------+
| step_id | name_step       |
+---------+-----------------+
| 1       | Оплата          |
| 2       | Упаковка        |
| 3       | Транспортировка |
| 4       | Доставка        |
+---------+-----------------+

-- Table buy
+--------+---------------------------------------+-----------+
| buy_id | buy_description                       | client_id |
+--------+---------------------------------------+-----------+
| 1      | Доставка только вечером               | 1         |
| 2      | NULL                                  | 3         |
| 3      | Упаковать каждую книгу по отдельности | 2         |
| 4      | NULL                                  | 1         |
+--------+---------------------------------------+-----------+

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

-- Вывести все заказы Баранова Павла (id заказа, какие книги, по какой цене и в каком количестве он заказал).
select
    buy.buy_id,
    b.title,
    b.price,
    bb.amount
from buy
join client as c
    on buy.client_id = c.client_id
join buy_book as bb
    on buy.buy_id = bb.buy_id
join book as b
    on bb.book_id = b.book_id
where c.name_client = 'Баранов Павел'
order by buy.buy_id, b.title;

-- Посчитать, сколько раз была заказана каждая книга (посчитать, в каком количестве заказов фигурирует каждая книга).  
-- Вывести автора, название книги.
select
    a.name_author,
    b.title,
    count(bb.amount) as order_amount
from author as a
join book as b
    on a.author_id = b.author_id
left join buy_book as bb
    on b.book_id = bb.book_id
group by b.title, a.name_author
order by a.name_author, b.title;

-- Вывести города, в которых живут клиенты, оформлявшие заказы в интернет-магазине. Указать количество заказов в каждый город.
select
    city.name_city,
    count(buy.client_id) as order_amount
from city
join client
    on city.city_id = client.city_id
join buy
    on client.client_id = buy.client_id
group by city.name_city
order by Количество desc, city.name_city;

-- Вывести информацию о каждом заказе: его номер, кто его сформировал (фамилия пользователя) 
-- и его стоимость (сумма произведений количества заказанных книг и их цены)
select
    buy.buy_id,
    c.name_client,
    sum(bb.amount * b.price) as sum_price
from buy
join client as c
    on buy.client_id = c.client_id
join buy_book as bb
    on buy.buy_id = bb.buy_id
join book as b
    on bb.book_id = b.book_id
group by buy.buy_id
order by buy.buy_id;

-- Вывести номера заказов (buy_id) и названия этапов, на которых они в данный момент находятся. Если заказ доставлен – информацию о нем не выводить. 
select 
    bs.buy_id,
    s.name_step
from buy_step as bs
join step as s
    on bs.step_id = s.step_id
where bs.date_step_beg is not null
    and bs.date_step_end is null
order by bs.buy_id;

-- В таблице city для каждого города указано количество дней, за которые заказ может быть доставлен в этот город (рассматривается только этап "Транспортировка"). 
-- Для тех заказов, которые прошли этап транспортировки, вывести количество дней за которое заказ реально доставлен в город. 
-- А также, если заказ доставлен с опозданием, указать количество дней задержки, в противном случае вывести 0. 
-- В результат включить номер заказа (buy_id)

select 
    bs.buy_id,
    datediff(bs.date_step_end, bs.date_step_beg) as count_days,
    if(datediff(bs.date_step_end, bs.date_step_beg) > city.days_delivery, 
       datediff(bs.date_step_end, bs.date_step_beg) - city.days_delivery, 
       0) as late
from buy_step as bs
join step
    on bs.step_id = step.step_id
join buy as b
    on bs.buy_id = b.buy_id
join client as c
    on b.client_id = c.client_id
join city
    on c.city_id = city.city_id
where bs.step_id = 3 and bs.date_step_end is not null;

-- Выбрать всех клиентов, которые заказывали книги Достоевского
select distinct c.name_client
from client as c
join buy
    on c.client_id = buy.client_id
join buy_book as bb
    on buy.buy_id = bb.buy_id
join book as b
    on bb.book_id = b.book_id
join author as a
    on b.author_id = a.author_id
where a.name_author = 'Достоевский Ф.М.'
order by c.name_client;

-- Вывести жанр (или жанры), в котором было заказано больше всего экземпляров книг, указать это количество.
select
    g.name_genre,
    sum(bb.amount) as book_amount
from genre as g
join book as b
    on g.genre_id = b.genre_id
join buy_book as bb
    on b.book_id = bb.book_id
group by g.name_genre
having sum(bb.amount) = 
    (select max(sum_amount)
     from 
         (select
            sum(bb.amount) as sum_amount
          from genre as g
          join book as b
            on g.genre_id = b.genre_id
          join buy_book as bb
            on b.book_id = bb.book_id
          group by g.name_genre
         ) queri_in);


-- Table buy_archive
+----------------+--------+-----------+---------+--------------+--------+--------+
| buy_archive_id | buy_id | client_id | book_id | date_payment | price  | amount |
+----------------+--------+-----------+---------+--------------+--------+--------+
| 1              | 2      | 1         | 1       | 2019-02-21   | 670.60 | 2      |
| 2              | 2      | 1         | 3       | 2019-02-21   | 450.90 | 1      |
| 3              | 1      | 2         | 2       | 2019-02-10   | 520.30 | 2      |
| 4              | 1      | 2         | 4       | 2019-02-10   | 780.90 | 3      |
| 5              | 1      | 2         | 3       | 2019-02-10   | 450.90 | 1      |
| 6              | 3      | 4         | 4       | 2019-03-05   | 780.90 | 4      |
| 7              | 3      | 4         | 5       | 2019-03-05   | 480.90 | 2      |
| 8              | 4      | 1         | 6       | 2019-03-12   | 650.00 | 1      |
| 9              | 5      | 2         | 1       | 2019-03-18   | 670.60 | 2      |
| 10             | 5      | 2         | 4       | 2019-03-18   | 780.90 | 1      |
+----------------+--------+-----------+---------+--------------+--------+--------+

-- Сравнить ежемесячную выручку от продажи книг за текущий и предыдущий годы. Для этого вывести год, месяц, сумму выручки.
-- Информация о продажах предыдущего года хранится в архивной таблице buy_archive, которая создается в конце года на основе информации из таблиц базы данных.
select
    year(bs.date_step_end) as year,
    monthname(bs.date_step_end) as month,
    sum(bb.amount * b.price) as sun_price
from buy_step as bs
join buy_book as bb
    on bs.buy_id = bb.buy_id
join book as b
    on bb.book_id = b.book_id
where year(bs.date_step_end) is not null
    and bs.step_id = 1
group by year, month
union 
select 
    year(date_payment) as year,
    monthname(date_payment) as month,
    sum(amount * price) as sun_price
from buy_archive
group by year, month
order by month, year;

-- Для каждой отдельной книги необходимо вывести информацию о количестве проданных экземпляров и их стоимости за 2020 и 2019 год.
select
    query_in.title,
    sum(query_in.book_amount) as book_total,
    sum(query_in.sum_price) as sum_total
from
    (select
        b.title,
        sum(bb.amount) as book_amount,
        sum(bb.amount * b.price) as sum_price
    from book as b
    join buy_book as bb
        on b.book_id = bb.book_id
    join buy_step as bs
        on bb.buy_id = bs.buy_id
    where bs.step_id = 1 
        and bs.date_step_end is not null
    group by b.title

    union all

    select
        b.title,
        ba.amount as book_amount,
        sum(ba.amount * ba.price) as sum_price
    from buy_archive as ba
    join book as b
        on ba.book_id = b.book_id
    group by 1, 2) as query_in
group by query_in.title
order by sum_total desc;