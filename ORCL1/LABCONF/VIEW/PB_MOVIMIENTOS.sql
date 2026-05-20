-- dmap_object_gen_tag : type : view name : pb_movimientos
set search_path = labconf,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pb_movimientos"  ("fecha_captura", "emp_keyemp", "nombre", "fecha_movimiento", "tipo_movimiento", "plz_act", "plz_ant", "dpto_act", "dpto_ant", "pto_act", "pto_ant") as select tra_fecmod fecha_captura,
tra_keyemp emp_keyemp,
emp_nomemp nombre,
tra_fecmov fecha_movimiento,
case
when tra_tipmov = '8' then 'DEPARTAMENTO'
when tra_tipmov = '9' then 'PUESTO'
when tra_tipmov = '10' then 'PLAZA'
else ''
end
tipo_movimiento,
case
when tra_tipmov = '8' then null
when tra_tipmov = '9' then null
when tra_tipmov = '10' then tra_keypla
else null
end
plz_act,
case
when tra_tipmov = '8' then null
when tra_tipmov = '9' then null
when tra_tipmov = '10' then tra_ca2aux
else null
end
plz_ant,
case
when tra_tipmov = '8' then tra_keydep
when tra_tipmov = '9' then null
when tra_tipmov = '10' then null
else null
end
dpto_act,
case
when tra_tipmov = '8' then tra_ca2aux
when tra_tipmov = '9' then null
when tra_tipmov = '10' then null
else null
end
dpto_ant,
case
when tra_tipmov = '8' then null
when tra_tipmov = '9' then tra_keypue
when tra_tipmov = '10' then null
else null
end
pto_act,
case
when tra_tipmov = '8' then null
when tra_tipmov = '9' then tra_ca2aux
when tra_tipmov = '10' then null
else null
end
pto_ant
from labconf.nmlotray
inner join labconf.nmcoempl on tra_keyemp = emp_keyemp
where     tra_tipmov in ('8', '9', '10')
and tra_fecmov >= statement_timestamp() - interval '2 days'
and tra_fecmov < statement_timestamp();/* dmap converted statement end */
-- estimed cost of view [ pb_movimientos ]: 1.00;
