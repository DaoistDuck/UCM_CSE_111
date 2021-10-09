--SQLite
.headers on

-- Product(maker, model, type)
-- PC(model, speed, ram, hd, price)
-- Laptop(model, speed, ram, hd, screen, price)
-- Printer(model, color, type, price)

select distinct maker
    from product, laptop
    where product.model = laptop.model AND laptop.price < 2000 AND laptop.screen > 16 ;


select maker
    from Product
    where type = 'pc'
EXCEPT
    select maker
    from Product
    where type = 'laptop';


select PCMaker.maker, pc.model, printer.model, max(pc.price + printer.price)
    from Product PCMaker, Product PrinterMaker, pc, printer
    where PCMaker.maker = PrinterMaker.maker
    and PCMaker.model = pc.model
    and PrinterMaker.model = printer.model
    group by PCMaker.maker;




select hd
from laptop
group by hd
having count(hd) > 1;


select pc.model, pc.price
from pc,
(

select min(laptop.price) as minprice
from laptop

) as minlaptopprice
where pc.price < minlaptopprice.minprice
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



