-- SQLite
.headers on

-- Product(maker, model, type)
-- PC(model, speed, ram, hd, price)
-- Laptop(model, speed, ram, hd, screen, price)
-- Printer(model, color, type, price)

--1 DONE
    select distinct maker
    from product, printer
    where product.model = printer.model AND printer.color = 1 AND printer.price < 120;
    -- 1 is true 0 is false

--2 DONE
    select distinct maker
    from product
    where type = 'pc' and maker not in
    (select maker from product where type = 'laptop') 
    and maker not in (select maker from product where type = 'printer');

--3 FIX IT SOMEHOW
    select percomp.maker, pc.model, laptop.model, (pc.price + laptop.price)
    from product percomp, product lap, pc, laptop
    where percomp.maker = lap.maker
    and percomp.model = pc.model
    and lap.model = laptop.model
    group by percomp.maker;
  

    select maker,model, type
    from product;
    select model, price 
    from pc;
    select model, price
    from laptop;

 
--4 DONE
    select screen
    from laptop
    group by screen
    having count(screen) > 1;

--5 DONE
    select laptop.model, laptop.price
    from laptop, pc
    group by laptop.model
    having laptop.price > max(pc.price);

--6 DONE
    select maker
    from product, pc
    where product.model = pc.model 
    union 
    select maker
    from product, laptop
    where product.model = laptop.model 
    intersect
    select maker
    from product, printer
    where product.model = printer.model
    group by maker
    having count(printer.model) > 1;

