create table genres (
	id_genre serial primary key,
	genre varchar(40) check(genre != '') not null unique
);

create table books (
	id_book serial primary key,
	title varchar(40) check(title != '') not null,
	author varchar(40) check(author != '') not null,
	genre_id integer references genres(id_genre),
	price numeric(9,2) check(price > 0) not null
);

create table branches (
	id_branch serial primary key,
	city varchar(40) check(city != '') not null,
	street varchar(40) check(street != '') not null,
	home varchar(20) check(home != '') not null
);

create table samples (
	id_sample serial primary key,
	branch_id integer references branches(id_branch),
	book_id integer references books(id_book),
	total integer check(total >= 0) not null
);

create table sellers (
	id_seller serial primary key,
	surname varchar(30) check(surname != '') not null,
	firstname varchar(30) check(firstname != '') not null,
	patronymic varchar(30),
	branch_id integer references branches(id_branch),
	salary numeric(9,2) default 20000 check(salary >= 10000) not null
);

create table buyers (
	id_buyer serial primary key,
	surname varchar(30) check(surname != '') not null,
	firstname varchar(30) check(firstname != '') not null,
	phone varchar(12) check(phone != '') not null unique
);

create table orders (
	id_order serial primary key,
	buyer_id integer references buyers(id_buyer),
	seller_id integer references sellers(id_seller),
	date_order timestamp default current_timestamp not null
);

create table suborders (
	id_suborder serial primary key,
	order_id integer references orders(id_order),
	book_id integer references books(id_book),
	quantity integer default 1 check(quantity > 0) not null
);