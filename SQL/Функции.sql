CREATE OR REPLACE FUNCTION find_books_by_title_or_author(
  search_value varchar(40)
) RETURNS TABLE(
  title varchar(40),
  author varchar(40),
  genre varchar(40),
  price numeric(9,2)
)
AS $$
BEGIN
  RETURN QUERY SELECT books.title, books.author, genres.genre, books.price
    FROM books
	JOIN genres ON genre_id = id_genre
    WHERE books.title ILIKE '%' || search_value || '%'
      OR books.author ILIKE '%' || search_value || '%';
  IF NOT FOUND THEN
    RAISE NOTICE 'Нет результата для: %', search_value;
  END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_order_suborders(
  orderid integer
) RETURNS TABLE(
  id_suborder integer,
  title varchar(40),
  author varchar(40),
  genre varchar(40),
  quantity integer
)
AS $$
BEGIN
  RETURN QUERY (SELECT suborders.id_suborder, books.title, books.author, genres.genre, suborders.quantity
    FROM suborders
    JOIN books ON book_id = id_book
    JOIN genres ON genre_id = id_genre
    WHERE order_id = orderid
    ORDER BY suborders.id_suborder);
  IF NOT FOUND THEN
    RAISE NOTICE 'Нет результата по ID: %', orderid;
  END IF;
END;
$$ LANGUAGE plpgsql;