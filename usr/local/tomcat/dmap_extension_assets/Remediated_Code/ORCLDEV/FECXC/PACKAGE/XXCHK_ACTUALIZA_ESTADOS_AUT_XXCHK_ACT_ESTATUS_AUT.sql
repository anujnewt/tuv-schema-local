create or replace procedure fecxc.xxchk_actualiza_estados_aut_xxchk_act_estatus_aut () as $body$
declare
flg3 text;
flg0 text;
flg4 text;
flg5 text;
flg2 text;
flg1 text;
-- pgv moved types start
-- pgv moved types end
v_e_codigo 					 xxchk_cheques_all.e_codigo%type;
v_referencia_cliente			 xxchk_cheques_all.referencia_cliente%type;
v_importe					 	 xxchk_cheques_all.importe%type;
v_moneda						 xxchk_cheques_all.moneda%type;
v_id_estado_cheque			 xxchk_captura_cheques.id_estado_cheque%type;
v_id_tipo_operacion_set 		 xxchk_cheques_all.id_tipo_operacion_set%type;
v_cuenta_sbc_cap_chk			 integer;
v_cuenta_sbc_chk_all			 integer;
v_cuenta_sbc					 integer;
--------selecciona todos los registros repetidos en xxchk_cheques_all, basados en captura cheques para actualizar los sbc
reg_repetidos_sbc cursor for
select c.e_codigo, c.referencia_cliente, c.importe, c.moneda
from  xxchk_cheques_all a, (
select 	  e_codigo, referencia_cliente, importe, moneda
from   	  xxchk_cheques_all a, xxchk_mapeo_de_estados c, xxchk_cat_edos d
where     nullif(procesado::text, '') is null
and       c.id_estado_cheque = d.id_estado_cheque
and 	  a.id_tipo_operacion_set = c.id_tipo_operacion_set
and    	  d.tipo_operacion('SBC')
group by  e_codigo, referencia_cliente, importe, moneda
) b,
xxchk_captura_cheques c
where  a.e_codigo=b.e_codigo
and	 a.referencia_cliente=b.referencia_cliente
and    a.importe=b.importe
and	 a.moneda=b.moneda
and    a.e_codigo=c.e_codigo
and	 a.referencia_cliente=c.referencia_cliente
and    a.importe=c.importe
and	 a.moneda=c.moneda
and    nullif(a.procesado::text, '') is null
and    nullif(c.procesado::text, '') is null   				                        ---solo toma si son nuevos o si ya se registraron como 200 de sbc
and 	 c.id_estado_cheque in ( select distinct id_estado_cheque    ---solo se pueden cambiar de estado los reg. en dichos estados
from xxchk_cat_cambios_estado
where id_estado_b in (7))
group by c.e_codigo, c.referencia_cliente, c.importe, c.moneda;
act_reg_repetidos cursor for
select distinct c.e_codigo, c.referencia_cliente, c.importe, c.moneda
from 	 xxchk_cheques_all c
where  procesado=100;
-----selecciona todos los registros repetidos en xxchk_cheques_all, basados en captura cheques para actualizar los en firme y rechazados
reg_firme cursor for
select c.e_codigo, c.referencia_cliente, c.importe, c.moneda
from  xxchk_cheques_all a, (
select e_codigo, referencia_cliente, importe, moneda
from   	  xxchk_cheques_all a, xxchk_mapeo_de_estados c, xxchk_cat_edos d
where     nullif(procesado::text, '') is null
and       c.id_estado_cheque = d.id_estado_cheque
and 	  a.id_tipo_operacion_set = c.id_tipo_operacion_set
and    	  d.tipo_operacion('ENFIRME','RECHAZADO')
group by  e_codigo, referencia_cliente, importe, moneda
) b,
xxchk_captura_cheques c
where  a.e_codigo=b.e_codigo
and	 a.referencia_cliente=b.referencia_cliente
and    a.importe=b.importe
and	 a.moneda=b.moneda
and    a.e_codigo=c.e_codigo
and	 a.referencia_cliente=c.referencia_cliente
and    a.importe=c.importe
and	 a.moneda=c.moneda
and    nullif(a.procesado::text, '') is null
and    nullif(c.procesado::text, '') is null
and 	 c.id_estado_cheque in ( select distinct id_estado_cheque    ---solo se pueden cambiar de estado los reg. en dichos estados
from xxchk_cat_cambios_estado
where id_estado_b in (8,9))
group by c.e_codigo, c.referencia_cliente, c.importe, c.moneda;
reg_repetidos_firme cursor for
select c.e_codigo, c.referencia_cliente, c.importe, c.moneda
from  xxchk_cheques_all a, (
select e_codigo, referencia_cliente, importe, moneda
from   	  xxchk_cheques_all a, xxchk_mapeo_de_estados c, xxchk_cat_edos d
where     nullif(procesado::text, '') is null
and       c.id_estado_cheque = d.id_estado_cheque
and 	  a.id_tipo_operacion_set = c.id_tipo_operacion_set
and    	  d.tipo_operacion('ENFIRME','RECHAZADO')
group by  e_codigo, referencia_cliente, importe, moneda
) b,
xxchk_captura_cheques c
where  a.e_codigo=b.e_codigo
and	 a.referencia_cliente=b.referencia_cliente
and    a.importe=b.importe
and	 a.moneda=b.moneda
and    a.e_codigo=c.e_codigo
and	 a.referencia_cliente=c.referencia_cliente
and    a.importe=c.importe
and	 a.moneda=c.moneda
and    nullif(a.procesado::text, '') is null
and    c.procesado=200
and 	 c.id_estado_cheque in ( select distinct id_estado_cheque    ---solo se pueden cambiar de estado los reg. en dichos estados
from xxchk_cat_cambios_estado
where id_estado_b in (8,9))
group by c.e_codigo, c.referencia_cliente, c.importe, c.moneda;
act_reg_firme cursor for
select distinct c.e_codigo, c.referencia_cliente, c.importe, c.moneda
from 	 xxchk_cheques_all c
where  procesado=100;
-----------
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
---------------------------------------------proceso que llevara a cabo la actualizacion de cheques repetidos-------------------
----procesado = 100 identifica que es un registro repetido y que se debe procesar uno por uno
----procesado = 200 identifica que se actualizo un registro repetido  a sbc
-----es necesario revisar cuantas veces tiene que llevar a cabo registro por registro y tiene que ser el menor registro de ambas tablas
select max(count(*))
into strict   v_cuenta_sbc_cap_chk
from   xxchk_captura_cheques a, (
select b.e_codigo, b.referencia_cliente, b.importe, b.moneda
from xxchk_cheques_all b
where nullif(procesado::text, '') is null
group by  b.e_codigo, b.referencia_cliente, b.importe, b.moneda
having count(*) > 1) c
where  a.e_codigo=c.e_codigo
and	   a.referencia_cliente=c.referencia_cliente
and    a.importe=c.importe
and	   a.moneda=c.moneda
and    nullif(a.procesado::text, '') is null
group by  a.e_codigo, a.referencia_cliente, a.importe, a.moneda;
select max(count(*))
into strict v_cuenta_sbc_chk_all
from   xxchk_cheques_all a, (
select b.e_codigo, b.referencia_cliente, b.importe, b.moneda, count(*)
from xxchk_captura_cheques  b
where nullif(procesado::text, '') is null
group by  b.e_codigo, b.referencia_cliente, b.importe, b.moneda
having count(*) > 1
) c
where  a.e_codigo=c.e_codigo
and	   a.referencia_cliente=c.referencia_cliente
and    a.importe=c.importe
and	   a.moneda=c.moneda
and    nullif(a.procesado::text, '') is null
group by  a.e_codigo, a.referencia_cliente, a.importe, a.moneda;
if v_cuenta_sbc_cap_chk < v_cuenta_sbc_chk_all then
v_cuenta_sbc:=v_cuenta_sbc_cap_chk;
else
v_cuenta_sbc:=v_cuenta_sbc_chk_all;
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_CUENTA_SBC_CAP_CHK VALE LA 1RA VEZ: ', v_cuenta_sbc_cap_chk)) ; --ojo ooc
/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('V_CUENTA_SBC_CHK_ALL VALE LA 1RA VEZ: ', v_cuenta_sbc_chk_all)) ;  --ojo ooc
/* dmap converted statement end *//* dmap converted statement start */
while(v_cuenta_sbc <> 0)
loop
-----------------actualiza los registros unicos seleccionados para ser procesados----------------
perform dbms_output.put_line( concat('en el loop de sbc: ', v_cuenta_sbc)) ; --ojo ooc
/* dmap converted statement end */
open reg_repetidos_sbc;
loop
fetch reg_repetidos_sbc
into  v_e_codigo, v_referencia_cliente, v_importe, v_moneda;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;
flg4 := found;
flg5 := found;
exit when (not flg0)or(not flg1)or(not flg2)or(not flg3)or(not flg4)or(not flg5);/* apply on reg_repetidos_sbc */
update xxchk_cheques_all a
set 	 procesado=100
where    e_codigo=v_e_codigo
and 	 referencia_cliente=v_referencia_cliente
and 	 importe=v_importe
and 	 moneda=v_moneda
and 	 nullif(procesado::text, '') is null
and 	 id_tipo_operacion_set in (select id_tipo_operacion_set
from   xxchk_mapeo_de_estados
where  id_estado_cheque=7 limit 1);
perform dbms_output.put_line('PASO EL PRIMER UPDATE'); --ojo ooc
update xxchk_captura_cheques b
set	   procesado=100
where  e_codigo=v_e_codigo
and    referencia_cliente=v_referencia_cliente
and    importe=v_importe
and    moneda=v_moneda
and    nullif(procesado::text, '') is null
and    b.id_estado_cheque in (select distinct id_estado_cheque    ---solo se pueden cambiar de estado los reg. en dichos estados
from xxchk_cat_cambios_estado
where id_estado_b =7 limit 1);  		      ----ojo aqui esta el error;
perform dbms_output.put_line('PASO EL SEGUNDO UPDATE'); --ojo ooc
end loop;
close reg_repetidos_sbc;
--------------inserta los registros modificados en la bitacora------------------------------
insert into xxchk_cheq_all_hist(
e_codigo,
no_cheque,
id_sec_cheque,
modified_by,
tipo_cheq,
referencia_cliente,
id_tipo_operacion_set,
procesado,
id_estado_cheque
)
select   	distinct x1.e_codigo, x1.no_cheque, x1.id_sec_cheque, 'Automatico', 'Automatico',
x1.referencia_cliente, a.id_tipo_operacion_set, null, d.id_estado_cheque
from 	    xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d,
xxchk_captura_cheques x1
where 		a.e_codigo = x1.e_codigo
and 		a.importe = x1.importe
and 		a.referencia_cliente = x1.referencia_cliente
and 		a.moneda = x1.moneda
and 		a.id_tipo_operacion_set = c.id_tipo_operacion_set
and 		c.id_estado_cheque = d.id_estado_cheque
and 		d.tipo_operacion in ('SBC')
and 		a.procesado=100
and 		x1.procesado=100;
------------actualiza el estado del cheque y el procesado a 200 que es el final para sbc y no sera seleccionado en un futuro
update  xxchk_captura_cheques b
set  	id_estado_cheque =    (   select d.id_estado_cheque
from 	xxchk_cheques_all x1,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where exists (
select   1
from 	xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where 	a.e_codigo = x1.e_codigo
and 		a.importe = x1.importe
and 		a.referencia_cliente = x1.referencia_cliente
and 		a.moneda = x1.moneda
and 		a.id_tipo_operacion_set = c.id_tipo_operacion_set
and 		c.id_estado_cheque = d.id_estado_cheque
and 		d.tipo_operacion in ('SBC')
and 		a.procesado=100
and 		b.procesado=100
)
and x1.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('SBC')
and x1.e_codigo = b.e_codigo
and x1.importe = b.importe
and x1.referencia_cliente = b.referencia_cliente
and x1.moneda = b.moneda
and x1.procesado = 100
and b.procesado =  100
),
procesado = 200
where exists (
select 1
from xxchk_cheques_all x1,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where exists (
select   1
from 	  xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where 	  a.e_codigo = x1.e_codigo
and 	  a.importe = x1.importe
and 	  a.referencia_cliente = x1.referencia_cliente
and 	  a.moneda = x1.moneda
and 	  a.id_tipo_operacion_set = c.id_tipo_operacion_set
and 	  c.id_estado_cheque = d.id_estado_cheque
and 	  d.tipo_operacion in ('SBC')
and 	  a.procesado=100
and 	  b.procesado=100
)
and x1.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('SBC')
and x1.e_codigo = b.e_codigo
and x1.importe = b.importe
and x1.referencia_cliente = b.referencia_cliente
and x1.moneda = b.moneda
and x1.procesado=100
and b.procesado=100
and b.id_estado_cheque in ( select distinct id_estado_cheque   ---solo se pueden cambiar de estado validando la regla de cambio de estados
from xxchk_cat_cambios_estado
where id_estado_b in (7)));
------------- ya que se actualizaron los estados correctamente se procede a cambiar el estado en cheques all para que no sean tomados en cuenta
open act_reg_repetidos;
loop
fetch act_reg_repetidos
into  v_e_codigo, v_referencia_cliente, v_importe, v_moneda;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;
flg4 := found;
flg5 := found;
exit when (not flg0)or(not flg1)or(not flg2)or(not flg3)or(not flg4)or(not flg5);/* apply on act_reg_repetidos */
update xxchk_cheques_all a
set procesado = 300
where ctid in
(
    select ctid
    from xxchk_cheques_all
    where e_codigo = v_e_codigo
      and referencia_cliente = v_referencia_cliente
      and importe = v_importe
      and moneda = v_moneda
      and procesado = 100
    limit 1
);
end loop;
close act_reg_repetidos;
v_cuenta_sbc:= v_cuenta_sbc - 1;
end loop;/* dmap converted statement start */
------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------para los registros rechazados y liberados----------------------------------------------------------
---------------------------------------------proceso que llevara a cabo la actualizacion de cheques repetidos-------------------
----procesado = 100 identifica que es un registro repetido y que se debe procesar uno por uno
----procesado = 200 identifica que se actualizo un registro repetido  a sbc
-----------------actualiza los registros unicos seleccionados para ser procesados----------------
perform dbms_output.put_line( concat('V_CUENTA_SBC_CAP_CHK VALE LA 2da VEZ: ', v_cuenta_sbc_cap_chk)) ;  ---ojo ooc
/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('V_CUENTA_SBC_CHK_ALL VALE LA 2da VEZ: ', v_cuenta_sbc_chk_all)) ;	---ojo ooc
/* dmap converted statement end */
if v_cuenta_sbc_cap_chk < v_cuenta_sbc_chk_all then
v_cuenta_sbc:=v_cuenta_sbc_cap_chk;
else
v_cuenta_sbc:=v_cuenta_sbc_chk_all;
end if;/* dmap converted statement start */
while(v_cuenta_sbc <> 0)
loop
perform dbms_output.put_line( concat('en el loop DE FIRME valgo: ', v_cuenta_sbc)) ; --ojo ooc
/* dmap converted statement end */
open reg_firme;
loop
fetch reg_firme
into  v_e_codigo, v_referencia_cliente, v_importe, v_moneda;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;
flg4 := found;
flg5 := found;
exit when (not flg0)or(not flg1)or(not flg2)or(not flg3)or(not flg4)or(not flg5);/* apply on reg_firme */
update   xxchk_cheques_all a
set 	 procesado=100
where    e_codigo=v_e_codigo
and 	 referencia_cliente=v_referencia_cliente
and 	 importe=v_importe
and 	 moneda=v_moneda
and 	 nullif(procesado::text, '') is null
and 	 id_tipo_operacion_set in (
select id_tipo_operacion_set
from xxchk_mapeo_de_estados
where id_estado_cheque in (8,9) limit 1); ---solo para los registros en nuill
update xxchk_captura_cheques b
set	   procesado=100
where  e_codigo=v_e_codigo
and    referencia_cliente=v_referencia_cliente
and    importe=v_importe
and    moneda=v_moneda
and    nullif(procesado::text, '') is null
and    b.id_estado_cheque in (select distinct id_estado_cheque   ---solo se pueden cambiar de estado los reg. en dichos estados
from xxchk_cat_cambios_estado
where id_estado_b in (8,9) limit 1);  		 		 ----ojo aqui esta el error
end loop;
close reg_firme;
--------------inserta los registros modificados en la bitacora------------------------------
insert into xxchk_cheq_all_hist(
e_codigo,
no_cheque,
id_sec_cheque,
modified_by,
tipo_cheq,
referencia_cliente,
id_tipo_operacion_set,
procesado,
id_estado_cheque
)
select   	distinct x1.e_codigo, x1.no_cheque, x1.id_sec_cheque, 'Automatico', 'Automatico',
x1.referencia_cliente, a.id_tipo_operacion_set, null, d.id_estado_cheque
from 	    xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d,
xxchk_captura_cheques x1
where 		a.e_codigo = x1.e_codigo
and 		a.importe = x1.importe
and 		a.referencia_cliente = x1.referencia_cliente
and 		a.moneda = x1.moneda
and 		a.id_tipo_operacion_set = c.id_tipo_operacion_set
and 		c.id_estado_cheque = d.id_estado_cheque
and 		d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and 		a.procesado=100
and 		x1.procesado=100;
------------actualiza el estado del cheque y el procesado a 200 que es el final para sbc y no sera seleccionado en un futuro
update  xxchk_captura_cheques b
set  id_estado_cheque =    (   select d.id_estado_cheque
from 	xxchk_cheques_all x1,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where exists (
select   1
from 	xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where 	a.e_codigo = x1.e_codigo
and 		a.importe = x1.importe
and 		a.referencia_cliente = x1.referencia_cliente
and 		a.moneda = x1.moneda
and 		a.id_tipo_operacion_set = c.id_tipo_operacion_set
and 		c.id_estado_cheque = d.id_estado_cheque
and 		d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and 		a.procesado=100
and 		b.procesado=100
)
and x1.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and x1.e_codigo = b.e_codigo
and x1.importe = b.importe
and x1.referencia_cliente = b.referencia_cliente
and x1.moneda = b.moneda
and x1.procesado = 100
and b.procesado =  100
),
procesado = 300
where exists (
select 1
from xxchk_cheques_all x1,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where exists (
select   1
from 	  xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where 	  a.e_codigo = x1.e_codigo
and 	  a.importe = x1.importe
and 	  a.referencia_cliente = x1.referencia_cliente
and 	  a.moneda = x1.moneda
and 	  a.id_tipo_operacion_set = c.id_tipo_operacion_set
and 	  c.id_estado_cheque = d.id_estado_cheque
and 	  d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and 	  a.procesado=100
and 	  b.procesado=100
)
and x1.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and x1.e_codigo = b.e_codigo
and x1.importe = b.importe
and x1.referencia_cliente = b.referencia_cliente
and x1.moneda = b.moneda
and x1.procesado=100
and b.procesado=100
and b.id_estado_cheque in ( select distinct id_estado_cheque   ---solo se pueden cambiar de estado validando la regla de cambio de estados
from xxchk_cat_cambios_estado
where id_estado_b in (8,9)));
------------- ya que se actualizaron los estados correctamente se procede a cambiar el estado en cheques all para que no sean tomados en cuenta
open act_reg_repetidos;
loop
fetch act_reg_repetidos
into  v_e_codigo, v_referencia_cliente, v_importe, v_moneda;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;
flg4 := found;
flg5 := found;
exit when (not flg0)or(not flg1)or(not flg2)or(not flg3)or(not flg4)or(not flg5);/* apply on act_reg_repetidos */
perform dbms_output.put_line('si entro al cursor');
update xxchk_cheques_all a
set procesado = 300
where ctid = (
    select ctid
    from xxchk_cheques_all
    where e_codigo = v_e_codigo
      and referencia_cliente = v_referencia_cliente
      and importe = v_importe
      and moneda = v_moneda
      and procesado = 100
    limit 1
);
end loop;
close act_reg_repetidos;
v_cuenta_sbc:= v_cuenta_sbc - 1;
end loop;
--/* commit; */
--****-------------------------------------------------------------------------------------------------------------------------------------
if v_cuenta_sbc_cap_chk < v_cuenta_sbc_chk_all then
v_cuenta_sbc:=v_cuenta_sbc_cap_chk;
else
v_cuenta_sbc:=v_cuenta_sbc_chk_all;
end if;/* dmap converted statement start */
while(v_cuenta_sbc <> 0)
loop
perform dbms_output.put_line( concat('en el loop DE FIRME valgo: ', v_cuenta_sbc)) ; --ojo ooc
/* dmap converted statement end */
open reg_repetidos_firme;
loop
fetch reg_repetidos_firme
into  v_e_codigo, v_referencia_cliente, v_importe, v_moneda;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;
flg4 := found;
flg5 := found;
exit when (not flg0)or(not flg1)or(not flg2)or(not flg3)or(not flg4)or(not flg5);/* apply on reg_repetidos_firme */
update   xxchk_cheques_all a
set 	 procesado=100
where    e_codigo=v_e_codigo
and 	 referencia_cliente=v_referencia_cliente
and 	 importe=v_importe
and 	 moneda=v_moneda
and 	 nullif(procesado::text, '') is null
and 	 id_tipo_operacion_set in (
select id_tipo_operacion_set
from xxchk_mapeo_de_estados
where id_estado_cheque in (8,9) limit 1); ---solo para los registros en nuill
update xxchk_captura_cheques b
set procesado = 100
where ctid = (
    select ctid
    from xxchk_captura_cheques
    where e_codigo = v_e_codigo
      and referencia_cliente = v_referencia_cliente
      and importe = v_importe
      and moneda = v_moneda
      and procesado = 200
    limit 1
);
end loop;
close reg_repetidos_firme;
--------------inserta los registros modificados en la bitacora------------------------------
insert into xxchk_cheq_all_hist(
e_codigo,
no_cheque,
id_sec_cheque,
modified_by,
tipo_cheq,
referencia_cliente,
id_tipo_operacion_set,
procesado,
id_estado_cheque
)
select   	distinct x1.e_codigo, x1.no_cheque, x1.id_sec_cheque, 'Automatico', 'Automatico',
x1.referencia_cliente, a.id_tipo_operacion_set, null, d.id_estado_cheque
from 	    xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d,
xxchk_captura_cheques x1
where 		a.e_codigo = x1.e_codigo
and 		a.importe = x1.importe
and 		a.referencia_cliente = x1.referencia_cliente
and 		a.moneda = x1.moneda
and 		a.id_tipo_operacion_set = c.id_tipo_operacion_set
and 		c.id_estado_cheque = d.id_estado_cheque
and 		d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and 		a.procesado=100
and 		x1.procesado=100;
------------actualiza el estado del cheque y el procesado a 200 que es el final para sbc y no sera seleccionado en un futuro
update  xxchk_captura_cheques b
set  id_estado_cheque =    (   select d.id_estado_cheque
from 	xxchk_cheques_all x1,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where exists (
select   1
from 	xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where 	a.e_codigo = x1.e_codigo
and 		a.importe = x1.importe
and 		a.referencia_cliente = x1.referencia_cliente
and 		a.moneda = x1.moneda
and 		a.id_tipo_operacion_set = c.id_tipo_operacion_set
and 		c.id_estado_cheque = d.id_estado_cheque
and 		d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and 		a.procesado=100
and 		b.procesado=100
)
and x1.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and x1.e_codigo = b.e_codigo
and x1.importe = b.importe
and x1.referencia_cliente = b.referencia_cliente
and x1.moneda = b.moneda
and x1.procesado = 100
and b.procesado =  100
),
procesado = 300
where exists (
select 1
from xxchk_cheques_all x1,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where exists (
select   1
from 	  xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where 	  a.e_codigo = x1.e_codigo
and 	  a.importe = x1.importe
and 	  a.referencia_cliente = x1.referencia_cliente
and 	  a.moneda = x1.moneda
and 	  a.id_tipo_operacion_set = c.id_tipo_operacion_set
and 	  c.id_estado_cheque = d.id_estado_cheque
and 	  d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and 	  a.procesado=100
and 	  b.procesado=100
)
and x1.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and x1.e_codigo = b.e_codigo
and x1.importe = b.importe
and x1.referencia_cliente = b.referencia_cliente
and x1.moneda = b.moneda
and x1.procesado=100
and b.procesado=100
and b.id_estado_cheque in ( select distinct id_estado_cheque   ---solo se pueden cambiar de estado validando la regla de cambio de estados
from xxchk_cat_cambios_estado
where id_estado_b in (8,9)));
------------- ya que se actualizaron los estados correctamente se procede a cambiar el estado en cheques all para que no sean tomados en cuenta
open act_reg_repetidos;
loop
fetch act_reg_repetidos
into  v_e_codigo, v_referencia_cliente, v_importe, v_moneda;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;
flg4 := found;
flg5 := found;
exit when (not flg0)or(not flg1)or(not flg2)or(not flg3)or(not flg4)or(not flg5);/* apply on act_reg_repetidos */
perform dbms_output.put_line('si entro al cursor final ooc');
update xxchk_cheques_all a
set procesado = 300
where ctid = (
    select ctid
    from xxchk_cheques_all
    where e_codigo = v_e_codigo
      and referencia_cliente = v_referencia_cliente
      and importe = v_importe
      and moneda = v_moneda
      and procesado = 100
    limit 1
);
end loop;
close act_reg_repetidos;
v_cuenta_sbc:= v_cuenta_sbc - 1;
end loop;
--****-------------------------------------------------------------------------------------------------------------------------------------
end;
$body$
language plpgsql
;
