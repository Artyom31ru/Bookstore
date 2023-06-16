-- https://chatgptbot.me/index.html#/questionDetail?code=mFXPsYwrTUBwgWBeUsk5GRJqSoJfOGqJqQzNKY8AbscSzPTOzPv7-rTEfl9Mp8xv

CREATE OR REPLACE PROCEDURE insert_genre(
    p_genre VARCHAR(40)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (SELECT id_genre FROM genres WHERE genre = p_genre) THEN
        RAISE EXCEPTION 'Жанр с таким названием уже существует';
    END IF;

    IF p_genre = '' THEN
        RAISE EXCEPTION 'Название жанра не может быть пустым';
    END IF;

    INSERT INTO genres (genre)
    VALUES (p_genre);
END;
$$;

CREATE OR REPLACE PROCEDURE update_genre(
    p_id_genre INTEGER,
    p_genre    VARCHAR(40)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_genre FROM genres WHERE id_genre = p_id_genre) THEN
        RAISE EXCEPTION 'Жанр с заданным идентификатором не найден';
    END IF;

    IF EXISTS (SELECT id_genre FROM genres WHERE genre = p_genre AND id_genre <> p_id_genre) THEN
        RAISE EXCEPTION 'Жанр с таким названием уже существует';
    END IF;

    IF p_genre = '' THEN
        RAISE EXCEPTION 'Название жанра не может быть пустым';
    END IF;

    UPDATE genres SET
        genre = p_genre
    WHERE id_genre = p_id_genre;
END;
$$;

CREATE OR REPLACE PROCEDURE delete_genre(
    p_id_genre INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_genre FROM genres WHERE id_genre = p_id_genre) THEN
        RAISE EXCEPTION 'Жанр с заданным идентификатором не найден';
    END IF;

    DELETE FROM genres WHERE id_genre = p_id_genre;
END;
$$;




CREATE OR REPLACE PROCEDURE insert_book(
    p_title   VARCHAR(40),
    p_author  VARCHAR(40),
    p_genre   INTEGER,
    p_price    NUMERIC(9, 2)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_title = '' THEN
        RAISE EXCEPTION 'Заголовок должен быть задан';
    END IF;
    IF p_author = '' THEN
        RAISE EXCEPTION 'Автор должен быть задан';
    END IF;
    IF p_genre IS NULL OR p_genre < 1 THEN
        RAISE EXCEPTION 'Жанр не выбран';
    END IF;
    IF p_price <= 0 THEN
        RAISE EXCEPTION 'Цена должна быть больше 0';
    END IF;
    
    INSERT INTO books(title, author, genre_id, price)
    VALUES(p_title, p_author, p_genre, p_price);
END;
$$;


CREATE OR REPLACE PROCEDURE update_book(
    p_id_book INTEGER,
    p_title   VARCHAR(40),
    p_author  VARCHAR(40),
    p_genre   INTEGER,
    p_price    NUMERIC(9, 2)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_book FROM books WHERE id_book = p_id_book) THEN
        RAISE EXCEPTION 'Книга с заданным идентификатором не найдена';
    END IF;
    
    IF p_title = '' THEN
        RAISE EXCEPTION 'Заголовок должен быть задан';
    END IF;
    
    IF p_author = '' THEN
        RAISE EXCEPTION 'Автор должен быть задан';
    END IF;
    
    IF p_genre IS NULL OR p_genre < 1 THEN
       RAISE EXCEPTION 'Жанр не выбран';
    END IF;
    
    IF p_price <= 0 THEN
       RAISE EXCEPTION 'Цена должна быть больше 0';
    END IF;
    
    UPDATE books SET title=p_title, author=p_author, genre_id=p_genre, price=p_price
    WHERE id_book = p_id_book;
END;
$$;

CREATE OR REPLACE PROCEDURE delete_book(
    p_id_book INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_book FROM books WHERE id_book = p_id_book) THEN
        RAISE EXCEPTION 'Книга с заданным идентификатором не найдена';
    END IF;

    DELETE FROM books WHERE id_book = p_id_book;
END;
$$;





CREATE OR REPLACE PROCEDURE insert_branch(
    p_city   VARCHAR(40),
    p_street VARCHAR(40),
    p_home   VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_city = '' THEN
        RAISE EXCEPTION 'Город должен быть задан';
    END IF;
    
    IF p_street = '' THEN
        RAISE EXCEPTION 'Улица должна быть задана';
    END IF;
    
    IF p_home = '' THEN
        RAISE EXCEPTION 'Дом должен быть задан';
    END IF;
    
    INSERT INTO branches(city, street, home)
    VALUES(p_city, p_street, p_home);
END;
$$;

CREATE OR REPLACE PROCEDURE update_branch(
    p_id_branch INTEGER,
    p_city   VARCHAR(40),
    p_street VARCHAR(40),
    p_home   VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_branch FROM branches WHERE id_branch = p_id_branch) THEN
        RAISE EXCEPTION 'Отделение с заданным идентификатором не найдено';
    END IF;
    
    IF p_city = '' THEN
        RAISE EXCEPTION 'Город должен быть задан';
    END IF;
    
    IF p_street = '' THEN
        RAISE EXCEPTION 'Улица должна быть задана';
    END IF;
    
    IF p_home = '' THEN
        RAISE EXCEPTION 'Дом должен быть задан';
    END IF;
    
    UPDATE branches SET city=p_city, street=p_street, home=p_home
    WHERE id_branch = p_id_branch;
END;
$$;


CREATE OR REPLACE PROCEDURE delete_branch(
    p_id_branch INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_branch FROM branches WHERE id_branch = p_id_branch) THEN
        RAISE EXCEPTION 'Отделение с заданным идентификатором не найдено';
    END IF;

    DELETE FROM branches WHERE id_branch = p_id_branch;
END;
$$;









CREATE OR REPLACE PROCEDURE insert_sample(
    p_branch_id INTEGER,
    p_book_id   INTEGER,
    p_total     INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_branch FROM branches WHERE id_branch = p_branch_id) THEN
        RAISE EXCEPTION 'Отделение с заданным идентификатором не найдено';
    END IF;
    
    IF NOT EXISTS (SELECT id_book FROM books WHERE id_book = p_book_id) THEN
        RAISE EXCEPTION 'Книга с заданным идентификатором не найдена';
    END IF;
    
    IF p_total < 0 THEN
        RAISE EXCEPTION 'Количество должно быть неотрицательным числом';
    END IF;
    
    INSERT INTO samples(branch_id, book_id, total)
    VALUES(p_branch_id, p_book_id, p_total);
END;
$$;

CREATE OR REPLACE PROCEDURE update_sample(
    p_id_sample INTEGER,
    p_total     INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_sample FROM samples WHERE id_sample = p_id_sample) THEN
        RAISE EXCEPTION 'Образец с заданным идентификатором не найден';
    END IF;
    
    IF p_total < 0 THEN
        RAISE EXCEPTION 'Количество должно быть неотрицательным числом';
    END IF;
    
    UPDATE samples SET total = p_total
    WHERE id_sample = p_id_sample;
END;
$$;

CREATE OR REPLACE PROCEDURE delete_sample(
    p_id_sample INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_sample FROM samples WHERE id_sample = p_id_sample) THEN
        RAISE EXCEPTION 'Образец с заданным идентификатором не найден';
    END IF;

    DELETE FROM samples WHERE id_sample = p_id_sample;
END;
$$;










CREATE OR REPLACE PROCEDURE insert_seller(
    p_surname    VARCHAR(30),
    p_firstname  VARCHAR(30),
    p_patronymic VARCHAR(30),
    p_branch_id  INTEGER,
    p_salary     NUMERIC(9,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_branch FROM branches WHERE id_branch = p_branch_id) THEN
        RAISE EXCEPTION 'Отделение с заданным идентификатором не найдено';
    END IF;

    IF p_surname = '' THEN
        RAISE EXCEPTION 'Фамилия не может быть пустым';
    END IF;

    IF p_firstname = '' THEN
        RAISE EXCEPTION 'Имя не может быть пустым';
    END IF;
    
    IF p_salary < 10000 THEN
        RAISE EXCEPTION 'Заработная плата должна быть не менее 10000';
    END IF;
    
    INSERT INTO sellers(surname, firstname, patronymic, branch_id, salary)
    VALUES(p_surname, p_firstname, p_patronymic, p_branch_id, p_salary);
END;
$$;


CREATE OR REPLACE PROCEDURE update_seller(
    p_id_seller   INTEGER,
    p_surname     VARCHAR(30),
    p_firstname   VARCHAR(30),
    p_patronymic  VARCHAR(30),
    p_branch_id   INTEGER,
    p_salary      NUMERIC(9,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_seller FROM sellers WHERE id_seller = p_id_seller) THEN
        RAISE EXCEPTION 'Продавец с заданным идентификатором не найден';
    END IF;
    
    IF NOT EXISTS (SELECT id_branch FROM branches WHERE id_branch = p_branch_id) THEN
        RAISE EXCEPTION 'Отделение с заданным идентификатором не найдено';
    END IF;
    
    IF p_surname = '' THEN
        RAISE EXCEPTION 'Фамилия не может быть пустым';
    END IF;

    IF p_firstname = '' THEN
        RAISE EXCEPTION 'Имя не может быть пустым';
    END IF;

    IF p_salary < 10000 THEN
        RAISE EXCEPTION 'Заработная плата должна быть не менее 10000';
    END IF;
    
    UPDATE sellers SET
        surname = p_surname,
        firstname = p_firstname,
        patronymic = p_patronymic,
        branch_id = p_branch_id,
        salary = p_salary
    WHERE id_seller = p_id_seller;
END;
$$;

CREATE OR REPLACE PROCEDURE delete_seller(
    p_id_seller INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_seller FROM sellers WHERE id_seller = p_id_seller) THEN
        RAISE EXCEPTION 'Продавец с заданным идентификатором не найден';
    END IF;

    DELETE FROM sellers WHERE id_seller = p_id_seller;
END;
$$;




CREATE OR REPLACE PROCEDURE insert_buyer(
    p_surname    VARCHAR(30),
    p_firstname  VARCHAR(30),
    p_phone      VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
DECLARE
    phone_regex TEXT := '^\+[0-9]{11}$';
BEGIN
    IF EXISTS (SELECT id_buyer FROM buyers WHERE phone = p_phone) THEN
        RAISE EXCEPTION 'Покупатель с заданным номером телефона уже существует';
    END IF;

    IF p_surname = '' THEN
        RAISE EXCEPTION 'Фамилия не может быть пустым';
    END IF;

    IF p_firstname = '' THEN
        RAISE EXCEPTION 'Имя не может быть пустым';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM regexp_matches(p_phone, phone_regex)) THEN
        RAISE EXCEPTION 'Некорректный номер телефона';
    END IF;
    
    INSERT INTO buyers(surname, firstname, phone)
    VALUES(p_surname, p_firstname, p_phone);
END;
$$;


CREATE OR REPLACE PROCEDURE update_buyer(
    p_id_buyer    INTEGER,
    p_surname     VARCHAR(30),
    p_firstname   VARCHAR(30),
    p_phone       VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
DECLARE
    phone_regex TEXT := '^\+[0-9]{11}$';
BEGIN
    IF NOT EXISTS (SELECT id_buyer FROM buyers WHERE id_buyer = p_id_buyer) THEN
        RAISE EXCEPTION 'Покупатель с заданным идентификатором не найден';
    END IF;
    
    IF p_surname = '' THEN
        RAISE EXCEPTION 'Фамилия не может быть пустым';
    END IF;

    IF p_firstname = '' THEN
        RAISE EXCEPTION 'Имя не может быть пустым';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM regexp_matches(p_phone, phone_regex)) THEN
        RAISE EXCEPTION 'Некорректный номер телефона';
    END IF;

    IF EXISTS (SELECT id_buyer FROM buyers WHERE phone = p_phone AND id_buyer != p_id_buyer) THEN
        RAISE EXCEPTION 'Покупатель с заданным номером телефона уже существует';
    END IF;
    
    UPDATE buyers SET
        surname = p_surname,
        firstname = p_firstname,
        phone = p_phone
    WHERE id_buyer = p_id_buyer;
END;
$$;

CREATE OR REPLACE PROCEDURE delete_buyer(
    p_id_buyer INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_buyer FROM buyers WHERE id_buyer = p_id_buyer) THEN
        RAISE EXCEPTION 'Покупатель с заданным идентификатором не найден';
    END IF;

    DELETE FROM buyers WHERE id_buyer = p_id_buyer;
END;
$$;






CREATE OR REPLACE PROCEDURE insert_order(
    p_buyer_id    INTEGER,
    p_seller_id   INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_buyer FROM buyers WHERE id_buyer = p_buyer_id) THEN
        RAISE EXCEPTION 'Покупатель с заданным идентификатором не найден';
    END IF;

    IF NOT EXISTS (SELECT id_seller FROM sellers WHERE id_seller = p_seller_id) THEN
        RAISE EXCEPTION 'Продавец с заданным идентификатором не найден';
    END IF;
    
    INSERT INTO orders (buyer_id, seller_id)
    VALUES (p_buyer_id, p_seller_id);
END;
$$;


CREATE OR REPLACE PROCEDURE update_order(
    p_id_order    INTEGER,
    p_buyer_id    INTEGER,
    p_seller_id   INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_order FROM orders WHERE id_order = p_id_order) THEN
        RAISE EXCEPTION 'Заказ с заданным идентификатором не найден';
    END IF;
    
    IF NOT EXISTS (SELECT id_buyer FROM buyers WHERE id_buyer = p_buyer_id) THEN
        RAISE EXCEPTION 'Покупатель с заданным идентификатором не найден';
    END IF;

    IF NOT EXISTS (SELECT id_seller FROM sellers WHERE id_seller = p_seller_id) THEN
        RAISE EXCEPTION 'Продавец с заданным идентификатором не найден';
    END IF;
    
    UPDATE orders SET
        buyer_id = p_buyer_id,
        seller_id = p_seller_id
    WHERE id_order = p_id_order;
END;
$$;


CREATE OR REPLACE PROCEDURE delete_order(
    p_id_order INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_order FROM orders WHERE id_order = p_id_order) THEN
        RAISE EXCEPTION 'Заказ с заданным идентификатором не найден';
    END IF;

    DELETE FROM orders WHERE id_order = p_id_order;
END;
$$;









CREATE OR REPLACE PROCEDURE insert_suborder(
    p_order_id    INTEGER,
    p_book_id     INTEGER,
    p_quantity    INTEGER DEFAULT 1
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_order FROM orders WHERE id_order = p_order_id) THEN
        RAISE EXCEPTION 'Заказ с заданным идентификатором не найден';
    END IF;

    IF NOT EXISTS (SELECT id_book FROM books WHERE id_book = p_book_id) THEN
        RAISE EXCEPTION 'Книга с заданным идентификатором не найдена';
    END IF;

    IF p_quantity <= 0 THEN
        RAISE EXCEPTION 'Количество товара должно быть больше нуля';
    END IF;
    
    INSERT INTO suborders (order_id, book_id, quantity)
    VALUES (p_order_id, p_book_id, p_quantity);
END;
$$;


CREATE OR REPLACE PROCEDURE update_suborder(
    p_id_suborder INTEGER,
    p_quantity    INTEGER DEFAULT 1
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_suborder FROM suborders WHERE id_suborder = p_id_suborder) THEN
        RAISE EXCEPTION 'Подзаказ с заданным идентификатором не найден';
    END IF;
    
    IF p_quantity <= 0 THEN
        RAISE EXCEPTION 'Количество товара должно быть больше нуля';
    END IF;

    UPDATE suborders SET
        quantity = p_quantity
    WHERE id_suborder = p_id_suborder;
END;
$$;



CREATE OR REPLACE PROCEDURE delete_suborder(
    p_id_suborder INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_suborder FROM suborders WHERE id_suborder = p_id_suborder) THEN
        RAISE EXCEPTION 'Подзаказ с заданным идентификатором не найден';
    END IF;

    DELETE FROM suborders WHERE id_suborder = p_id_suborder;
END;
$$;
