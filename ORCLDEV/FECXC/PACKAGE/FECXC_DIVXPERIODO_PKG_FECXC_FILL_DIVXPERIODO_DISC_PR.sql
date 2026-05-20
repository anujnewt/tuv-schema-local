create or replace procedure fecxc.dmap_fecxc_divxperiodo_pkg_fecxc_fill_divxperiodo_disc_pr ( posterrbuf inout varchar, postretcode inout varchar, piinidagrup numeric, piinformat numeric, pistuser varchar, piinsegment numeric ) as $body$
declare
o record;
l record;
j record;
-- pgv moved types start
-- pgv moved types end
-- pragma autonomous_transaction;
linfinalmonth            numeric := 0;
lintotalmonth            numeric;
liniterations            numeric := 0;
linmodule                numeric := 0;
linmonthbegin            numeric := 0;
curcanalesdesc cursor for
select distinct
descanal,
canal
from
fecxc_divxperiodo_vw
where
segmento =  piinsegment
order by canal;
curtotalperiodo cursor(piincanal  varchar)
for
select
1 order_id,
piincanal canal,
'Total' periodo,
coalesce(b.cobranza,0) cobranza,
coalesce(b.ppto,0) ppto,
coalesce(b.anioant,0) anioant,
coalesce(b.cobranza-b.ppto,0) varppto,
coalesce(b.cobranza-b.anioant,0) varant,
coalesce(100*case when b.ppto=0 then 1  else (b.cobranza-b.ppto)/b.ppto end ,0)as porvarppto,
coalesce(100*case when b.anioant=0 then 1  else (b.cobranza-b.anioant)/b.anioant end ,0)as porvarant
from
(select (select
sum(a.importe)
from   fecxc_divxperiodo_vw    a
where  a.segmento            = piinsegment
and    a.descanal            = piincanal
and    a.subtipo             = 'REAL'
) cobranza,
(select
sum(a.importe)
from   fecxc_divxperiodo_vw    a
where  a.segmento            = piinsegment
and    a.descanal            = piincanal
and    a.subtipo             = 'PRESUPUESTO'
) ppto,
(select
sum(a.importe)
from   fecxc_divxperiodo_vw    a
where  a.segmento            = piinsegment
and    a.descanal            = piincanal
and    a.subtipo             = 'A?O ANTERIOR'
) anioant
a)b;
curperiodo cursor(piinorder numeric,piincanal varchar, pistuserl varchar,
pistiter varchar, pistagrup varchar, pistmonths varchar )
for
select
piinorder order_id,
piincanal canal,
pistiter||' '||pistagrup periodo,
coalesce(b.cobranza,0) cobranza,
coalesce(b.ppto,0) ppto,
coalesce(b.anioant,0) anioant,
coalesce(b.cobranza-b.ppto,0) varppto,
coalesce(b.cobranza-b.anioant,0) varant,
coalesce(100*case when b.ppto=0 then 1  else (b.cobranza-b.ppto)/b.ppto end ,0)as porvarppto,
coalesce(100*case when b.anioant=0 then 1  else (b.cobranza-b.anioant)/b.anioant end ,0)as porvarant
from
(select (select
sum(a.importe)
from   fecxc_divxperiodo_vw    a
where  a.segmento            = piinsegment
and    a.descanal            = piincanal
and    a.subtipo             = 'REAL'
and    a.mes                 in (select * from  fecxc_divxperiodo_pkg_in_list(pistmonths))
) cobranza,
(select
sum(a.importe)
from   fecxc_divxperiodo_vw    a
where  a.segmento            = piinsegment
and    a.descanal            = piincanal
and    a.subtipo             = 'PRESUPUESTO'
and    a.mes                 in (select * from  fecxc_divxperiodo_pkg_in_list(pistmonths))
) ppto,
(select
sum(a.importe)
from   fecxc_divxperiodo_vw    a
where  a.segmento            = piinsegment
and    a.descanal            = piincanal
and    a.subtipo             = 'A?O ANTERIOR'
and    a.mes                 in (select * from  fecxc_divxperiodo_pkg_in_list(pistmonths))
) anioant
a)b;
curtotalgeneral cursor for
select
100 order_id,
'Total' canal,
'Total General' periodo,
coalesce(b.cobranza,0) cobranza,
coalesce(b.ppto,0) ppto,
coalesce(b.anioant,0) anioant,
coalesce(b.cobranza-b.ppto,0) varppto,
coalesce(b.cobranza-b.anioant,0) varant,
coalesce(100*case when b.ppto=0 then 1  else (b.cobranza-b.ppto)/b.ppto end ,0)as porvarppto,
coalesce(100*case when b.anioant=0 then 1  else (b.cobranza-b.anioant)/b.anioant end ,0)as porvarant
from
(select (select
sum(a.importe)
from   fecxc_divxperiodo_vw    a
where  a.segmento            = piinsegment
and    a.descanal            in (select distinct
descanal
from
fecxc_divxperiodo_vw
where
segmento =  piinsegment)
and    a.subtipo             = 'REAL'
) cobranza,
(select
sum(a.importe)
from   fecxc_divxperiodo_vw    a
where  a.segmento            = piinsegment
and    a.descanal            in (select distinct
descanal
from
fecxc_divxperiodo_vw
where
segmento =  piinsegment)
and    a.subtipo             = 'PRESUPUESTO'
) ppto,
(select
sum(a.importe)
from   fecxc_divxperiodo_vw    a
where  a.segmento            = piinsegment
and    a.descanal            in (select distinct
descanal
from
fecxc_divxperiodo_vw
where
segmento =  piinsegment)
and    a.subtipo             = 'A?O ANTERIOR'
) anioant
a)b;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from fecxc_divxperiodo_tab;/* dmap converted statement start */
/* commit; */
perform dbms_output.put_line( concat('piinSegment: ', piinsegment)) ;/* dmap converted statement end */
--posterrbuf  :=  error en linea 593;
for i in 1..12
loop
select
coalesce(sum(a.importe),0) into strict lintotalmonth
from    fecxc_divxperiodo_vw    a
where  a.segmento            = piinsegment
and    a.descanal            in (select distinct
descanal
from
fecxc_divxperiodo_vw
where
segmento =  piinsegment)
and     a.subtipo             in ('REAL','PRESUPUESTO','A?O ANTERIOR')
and     a.mes                 = i;/* dmap converted statement start */
perform dbms_output.put_line( concat('linTotalMonth: ', lintotalmonth)) ;/* dmap converted statement end */
if (lintotalmonth != 0) then
linfinalmonth := i;
end if;
end loop;/* dmap converted statement start */
perform dbms_output.put_line( concat('piinIdAgrup: ', piinidagrup)) ;/* dmap converted statement end */
--posterrbuf  :=  error en linea 618;
if (piinidagrup = 1)then
linmonthbegin := 1;
else
liniterations := trunc(linfinalmonth/piinidagrup);
linmodule     := mod(linfinalmonth,piinidagrup);
linmonthbegin := (piinidagrup * liniterations) + 1;
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('linFinalMonth:', linfinalmonth)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('linIterations:', liniterations)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('linModule:', linmodule)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('linMonthBegin:', linmonthbegin)) ;/* dmap converted statement end *//* dmap converted statement start */
--posterrbuf  :=  error en linea 633;
for i in curcanalesdesc
loop
--posterrbuf  :=  error en linea 637;
for j in select * from curtotalperiodo(i.descanal)
loop
perform dbms_output.put_line( concat(j.order_id, '|', j.canal, '|', j.periodo, '|', j.cobranza, '|', j.ppto, '|', j.anioant, '|', j.varppto, '|', j.varant, '|', j.porvarppto, '|', j.porvarant)) ;/* dmap converted statement end */
insert into fecxc_divxperiodo_tab(
id_order,
des_canal,
des_periodo,
num_real,
num_ppto,
num_anio_ant,
num_var_ppto,
num_var_anio_ant,
por_var_ppto,
por_var_anio_ant
)
values (
j.order_id,
j.canal,
j.periodo,
j.cobranza,
j.ppto,
j.anioant,
j.varppto,
j.varant,
j.porvarppto,
j.porvarant
);
end loop;/* dmap converted statement start */
for k in 1..liniterations
loop
--posterrbuf  :=  error en linea 671;
perform dbms_output.put_line( concat('piinOrder: ', k)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('piinCanal: ', i.descanal)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('pistUserL: ', pistuser)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('pistIter: ', fecxc_divxperiodo_pkg_fecxc_get_cardinal_fn(k))) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('pistAgrup: ', fecxc_divxperiodo_pkg_fecxc_get_groupname_fn(piinidagrup))) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('pistMonths: ', fecxc_divxperiodo_pkg_fecxc_get_months_fn(piinidagrup,k))) ;/* dmap converted statement end *//* dmap converted statement start */
for l in select * from curperiodo(k,i.descanal,pistuser,fecxc_divxperiodo_pkg_fecxc_get_cardinal_fn(k),fecxc_divxperiodo_pkg_fecxc_get_groupname_fn(piinidagrup),
fecxc_divxperiodo_pkg_fecxc_get_months_fn(piinidagrup,k))
loop
perform dbms_output.put_line( concat(l.order_id, '|', l.canal, '|', l.periodo, '|', l.cobranza, '|', l.ppto, '|', l.anioant, '|', l.varppto, '|', l.varant, '|', l.porvarppto, '|', l.porvarant)) ;/* dmap converted statement end */
insert into fecxc_divxperiodo_tab(
id_order,
des_canal,
des_periodo,
num_real,
num_ppto,
num_anio_ant,
num_var_ppto,
num_var_anio_ant,
por_var_ppto,
por_var_anio_ant
)
values (
l.order_id,
l.canal,
l.periodo,
l.cobranza,
l.ppto,
l.anioant,
l.varppto,
l.varant,
l.porvarppto,
l.porvarant
);
end loop;
end loop;/* dmap converted statement start */
--posterrbuf  :=  error en linea 712;
for m in linmonthbegin..linfinalmonth
loop
perform dbms_output.put_line( concat('m:', m)) ;/* dmap converted statement end *//* dmap converted statement start */
for o in select * from curperiodo(m,i.descanal,pistuser,fecxc_divxperiodo_pkg_fecxc_get_cardinal_fn('0'),fecxc_divxperiodo_pkg_fecxc_get_monthname_fn(m),m)
loop
perform dbms_output.put_line( concat(o.order_id, '|', o.canal, '|', o.periodo, '|', o.cobranza, '|', o.ppto, '|', o.anioant, '|', o.varppto, '|', o.varant, '|', o.porvarppto, '|', o.porvarant)) ;/* dmap converted statement end */
insert into fecxc_divxperiodo_tab(
id_order,
des_canal,
des_periodo,
num_real,
num_ppto,
num_anio_ant,
num_var_ppto,
num_var_anio_ant,
por_var_ppto,
por_var_anio_ant
)
values (
o.order_id,
o.canal,
o.periodo,
o.cobranza,
o.ppto,
o.anioant,
o.varppto,
o.varant,
o.porvarppto,
o.porvarant
);
end loop;
end loop;
end loop;/* dmap converted statement start */
for n in curtotalgeneral
loop
perform dbms_output.put_line( concat(n.order_id, '|', n.canal, '|', n.periodo, '|', n.cobranza, '|', n.ppto, '|', n.anioant, '|', n.varppto, '|', n.varant, '|', n.porvarppto, '|', n.porvarant)) ;/* dmap converted statement end */
--posterrbuf  :=  error en linea 756;
insert into fecxc_divxperiodo_tab(
id_order,
des_canal,
des_periodo,
num_real,
num_ppto,
num_anio_ant,
num_var_ppto,
num_var_anio_ant,
por_var_ppto,
por_var_anio_ant
)
values (
n.order_id,
n.canal,
n.periodo,
n.cobranza,
n.ppto,
n.anioant,
n.varppto,
n.varant,
n.porvarppto,
n.porvarant
);
end loop;
/* commit; */
postretcode := '0';/* dmap converted statement start */
exception
when others
then
posterrbuf  :=   concat('No se produjo informaci?n.', sqlerrm) ;/* dmap converted statement end */
postretcode :=  sqlstate;/* dmap converted statement start */
perform dbms_output.put_line( concat('Error:', to_char(postretcode))) ;/* dmap converted statement end */
perform dbms_output.put_line(posterrbuf);
rollback;end;
$body$
language plpgsql
;
