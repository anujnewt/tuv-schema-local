-- PROCEDURE: fecxc.dmap_fecxc_divxperiodo_pkg_fecxc_fill_divxperiodo_disc_pr(character varying, character varying, numeric, numeric, character varying, numeric)

-- DROP PROCEDURE IF EXISTS fecxc.dmap_fecxc_divxperiodo_pkg_fecxc_fill_divxperiodo_disc_pr(character varying, character varying, numeric, numeric, character varying, numeric);

CREATE OR REPLACE PROCEDURE fecxc.dmap_fecxc_divxperiodo_pkg_fecxc_fill_divxperiodo_disc_pr(
	INOUT posterrbuf character varying,
	INOUT postretcode character varying,
	IN piinidagrup numeric,
	IN piinformat numeric,
	IN pistuser character varying,
	IN piinsegment numeric)
LANGUAGE 'plpgsql'
AS $BODY$
declare
o record;
l record;
j record;
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
and    a.subtipo             = 'AÑO ANTERIOR'
) anioant
) b;
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
and    a.subtipo             = 'AÑO ANTERIOR'
and    a.mes                 in (select * from  fecxc_divxperiodo_pkg_in_list(pistmonths))
) anioant
) b;
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
and    a.subtipo             = 'AÑO ANTERIOR'
) anioant
) b;
begin
delete from fecxc_divxperiodo_tab;
raise notice '%', concat('piinSegment: ', piinsegment);
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
and     a.subtipo             in ('REAL','PRESUPUESTO','AÑO ANTERIOR')
and     a.mes                 = i;
raise notice '%', concat('linTotalMonth: ', lintotalmonth);
if (lintotalmonth != 0) then
linfinalmonth := i;
end if;
end loop;
raise notice '%', concat('piinIdAgrup: ', piinidagrup);
if (piinidagrup = 1)then
linmonthbegin := 1;
else
liniterations := trunc(linfinalmonth/piinidagrup);
linmodule     := mod(linfinalmonth,piinidagrup);
linmonthbegin := (piinidagrup * liniterations) + 1;
end if;
raise notice '%', concat('linFinalMonth:', linfinalmonth);
raise notice '%', concat('linIterations:', liniterations);
raise notice '%', concat('linModule:', linmodule);
raise notice '%', concat('linMonthBegin:', linmonthbegin);
for i in curcanalesdesc
loop
for j in select * from curtotalperiodo(i.descanal)
loop
raise notice '%', concat(j.order_id, '|', j.canal, '|', j.periodo, '|', j.cobranza, '|', j.ppto, '|', j.anioant, '|', j.varppto, '|', j.varant, '|', j.porvarppto, '|', j.porvarant);
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
end loop;
for k in 1..liniterations
loop
raise notice '%', concat('piinOrder: ', k);
raise notice '%', concat('piinCanal: ', i.descanal);
raise notice '%', concat('pistUserL: ', pistuser);
raise notice '%', concat('pistIter: ', fecxc_divxperiodo_pkg_fecxc_get_cardinal_fn(k));
raise notice '%', concat('pistAgrup: ', fecxc_divxperiodo_pkg_fecxc_get_groupname_fn(piinidagrup));
raise notice '%', concat('pistMonths: ', fecxc_divxperiodo_pkg_fecxc_get_months_fn(piinidagrup,k));
for j in select * from curperiodo(k+1, i.descanal, pistuser,
fecxc_divxperiodo_pkg_fecxc_get_cardinal_fn(k),
fecxc_divxperiodo_pkg_fecxc_get_groupname_fn(piinidagrup),
fecxc_divxperiodo_pkg_fecxc_get_months_fn(piinidagrup,k))
loop
raise notice '%', concat(j.order_id, '|', j.canal, '|', j.periodo, '|', j.cobranza, '|', j.ppto, '|', j.anioant, '|', j.varppto, '|', j.varant, '|', j.porvarppto, '|', j.porvarant);
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
end loop;
end loop;
if (linmodule != 0) then
for j in select * from curperiodo(liniterations+2, i.descanal, pistuser,
fecxc_divxperiodo_pkg_fecxc_get_cardinal_fn(liniterations+1),
fecxc_divxperiodo_pkg_fecxc_get_groupname_fn(piinidagrup),
fecxc_divxperiodo_pkg_fecxc_get_months_fn_mod(linmonthbegin,linfinalmonth))
loop
raise notice '%', concat(j.order_id, '|', j.canal, '|', j.periodo, '|', j.cobranza, '|', j.ppto, '|', j.anioant, '|', j.varppto, '|', j.varant, '|', j.porvarppto, '|', j.porvarant);
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
end loop;
end if;
end loop;
for j in curtotalgeneral
loop
raise notice '%', concat(j.order_id, '|', j.canal, '|', j.periodo, '|', j.cobranza, '|', j.ppto, '|', j.anioant, '|', j.varppto, '|', j.varant, '|', j.porvarppto, '|', j.porvarant);
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
end loop;
postretcode := 'S';
exception
when others then
postretcode := 'E';
posterrbuf := sqlerrm;
end;
$BODY$;
ALTER PROCEDURE fecxc.dmap_fecxc_divxperiodo_pkg_fecxc_fill_divxperiodo_disc_pr(character varying, character varying, numeric, numeric, character varying, numeric)
    OWNER TO postgres;

