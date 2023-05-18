select * from clientes
select * from ventas
select * from marcas
select * from vehiculos

insert into clientes(run, nombre, correo, direccion, telefono, alta)
 values ('10111222-8', 'Diego', 'juan@mail.com', 'Calle 4', '244445555', 'A'),
 ('10111222-9', 'Carlos', 'juan@mail.com', 'Calle 4', '244445555', 'A'),
 ('12111222-0', 'Ozvaldo', 'juan@mail.com', 'Calle 4', '244445555', 'A');

-- 1. Listar los clientes sin ventas por medio de una subconsulta.
select nombre from clientes where run not in (select id_cliente from ventas)

-- 2. Listar todas ventas con las siguientes columnas: 
--    Folio, Fecha, Monto, NombreCliente, RutCliente. 


select folio, fecha, monto, id_cliente as rut_cliente, 
(select nombre from clientes 
 	where run = ventas.id_cliente) as nombre  from ventas


-- 3. Clasificar los clientes según la siguiente tabla:
-- venta anuales - clasificacion
-- 0 y 1mm - Standar
-- 1mm y 3mm - Gold
-- 3mm o mas - Premium
select * from clientes;
select * from ventas;
select * from vehiculos

-- insertamos venta con un año diferente para el trabajo --
insert into ventas values(6, '2020-05-01', 4500000, 101, '10333222-8');

select c.nombre, extract(year from v.fecha) as fecha, sum(monto) as cantidad,

case
when sum(monto) between 0 and 10000000 then 'Standar'
when sum(monto) between 11000000 and 15000000 then 'Gold'
when sum(monto) > 15000001 then 'Premium'
else 'sin clasificacion' 
end as clasificacion

from clientes c
right join ventas v 
on v.id_cliente = c.run
group by c.run, extract(year from v.fecha)

-- 4. Por medio de una subconsulta, listar las ventas con la marca del vehículo 
-- más vendido.
select * from ventas
select * from vehiculos
select * from marcas

SELECT fecha, monto, id_vehiculo, (select marca from vehiculos order by marca limit 1) as marca FROM Ventas
WHERE id_vehiculo IN 
(SELECT id FROM vehiculos vh WHERE marca IN 
(SELECT vh.marca AS marca FROM vehiculos vh
JOIN ventas v ON vh.id = v.id_vehiculo 
GROUP BY marca ORDER BY count(vh.marca) DESC LIMIT 1))




		


