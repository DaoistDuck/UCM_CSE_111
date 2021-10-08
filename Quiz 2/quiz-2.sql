--SQLite
.headers on

-- Product(maker, model, type)
-- PC(model, speed, ram, hd, price)
-- Laptop(model, speed, ram, hd, screen, price)
-- Printer(model, color, type, price)

select distinct maker
    from product, laptop
    where product.model = laptop.model AND laptop.screen > 16 AND laptop.price < 2000;


select maker
    from Product
    where type = 'pc'
EXCEPT
    select maker
    from Product
    where type = 'laptop';

select maker
from product
where type = 'pc';
select maker 
from product
where type = 'laptop';


select P1.maker, P1.model, P2.model,max(pc.price+printer.price)
from Product P1 join Product P2
    on P1.maker = P2.maker,
    pc,printer
where
    P1.type = 'pc' and
    P2.type = 'printer'
    AND P1.model = pc.model
    AND P2.model = printer.model
group by p1.maker;

select percomp.maker, pc.model, printer.model, max(pc.price + printer.price)
    from product percomp, product lap, pc, printer
    where percomp.maker = lap.maker
    and percomp.model = pc.model
    and lap.model = printer.model
    group by percomp.maker;


select hd
from laptop
group by hd
having count(hd) > 1;

select pc.model, pc.price
from pc,laptop
group by pc.model
having pc.price < min(laptop.price);



select pc.model, pc.price
from pc,
(

select min(laptop.price) as minprice
from laptop

) as minlapprice
where pc.price < minlapprice.minprice
group by pc.model;






select maker
from product, laptop
where product.model = laptop.model 
intersect
select maker
from product, printer
where product.model = printer.model
group by maker
having count(printer.model) > 1;



