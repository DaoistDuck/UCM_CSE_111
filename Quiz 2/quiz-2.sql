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



