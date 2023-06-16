create or replace view orders_view as
	select 
	buyers.surname as b_surname, buyers.firstname as b_firstname,
	sellers.surname as s_surname, sellers.firstname as s_firstname,
	date_order, city, street, home, coalesce(sum(price * quantity), 0.00) as sum_order
	from orders
	left join suborders on order_id = id_order
	left join books on book_id = id_book
	join buyers on buyer_id = id_buyer
	join sellers on seller_id = id_seller
	join branches on branch_id = id_branch
	group by b_surname, b_firstname, s_surname, s_firstname, date_order, city, street, home;


create or replace view books_view as
	select title, author, genre, price
	from books
	join genres on genre_id = id_genre;


create or replace view branches_city as
	select city from branches;


create or replace view buyers_view as
	select surname, firstname, phone from buyers;