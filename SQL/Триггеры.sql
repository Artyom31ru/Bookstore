-- Триггеры --

create or replace function reduce_sample()
returns trigger as $$
declare
    p_branch_id integer;
begin
    p_branch_id = (
        select branch_id from orders
        join sellers on seller_id = id_seller
        where orders.id_order = new.order_id
    );

    if (
        select total - new.quantity
        from samples 
        where book_id = new.book_id and branch_id = p_branch_id
    ) < 0 then
        raise exception 'Невозможно купить книгу. На складе не хватает книг.';
    end if;

    update samples set total = total - new.quantity
    where book_id = new.book_id and branch_id = p_branch_id;

    return new;
end;
$$ language plpgsql;

create or replace trigger suborder_create_trigger
before insert on suborders
for each row
execute function reduce_sample();




create or replace function increase_sample()
returns trigger as $$
begin
	update samples set total = total + old.quantity
	where samples.book_id = old.book_id and samples.branch_id = (
		select branch_id from orders
		join sellers on seller_id = id_seller
		where orders.id_order = old.order_id
	);
	return old;
end;
$$ language plpgsql;

create or replace trigger suborder_delete_trigger
after delete on suborders
for each row
execute function increase_sample();



create or replace function change_sample()
returns trigger as $$
declare
    p_branch_id integer;
begin
    p_branch_id = (
        select branch_id from orders
        join sellers on seller_id = id_seller
        where orders.id_order = new.order_id
    );
    
    if (
        select total + old.quantity - new.quantity
        from samples 
        where book_id = new.book_id and branch_id = p_branch_id
    ) < 0 then
        raise exception 'Невозможно обновить книги. Общее количество менее, чем заказанное.';
    end if;

    update samples set total = total + old.quantity - new.quantity
    where book_id = new.book_id and branch_id = p_branch_id;

    return new;
end;
$$ language plpgsql;

create or replace trigger suborder_update_trigger
after update of quantity on suborders 
for each row when (old.quantity is distinct from new.quantity)
execute function change_sample();




create or replace function delete_order_with_suborders()
returns trigger as $$
begin
	delete from suborders where order_id = old.id_order;
	return old;
end;
$$ language plpgsql;

create or replace trigger delete_order
before delete on orders
for each row
execute function delete_order_with_suborders();

