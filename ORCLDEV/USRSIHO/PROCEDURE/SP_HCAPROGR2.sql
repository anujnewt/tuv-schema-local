create or replace procedure usrsiho."sp_hcaprogr2"  (vs_ide_pcc varchar,  -- identif. pc
vn_key_usu numeric,   -- clave de usuario
vs_log_usu varchar,  -- login del usuario
vs_key_men varchar,  -- nombre del menu
vn_ran_ini numeric,   -- rango inicial
vn_ran_fin numeric,   -- rango final
vs_key_dep varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- clave de departamento
-- estandares y desarrollo
--
-- sistema  : rh-2000  c/s
-- modulo   : nomina de honorarios(ho)
-- programa : sp_hcaprogr2
--            eliminacion de capitulos por rangos
-- autor    : emilio pulido rangel
-- fecha    : 10 de diciembre de 2001
vn_con_001    numeric(5);
-- contador de registros
vn_capitulos  numeric(5);
-- contador de capitulos para la primer validaci??   define vn_rescapi    smallint;
-- resta de capitulos
vn_rescapi    numeric(5);
vs_cadena     varchar(15);                  -- variable para la bitacora
vpre_status   varchar(1);
vn_key_plz    holocont.con_keyplz%type;  -- clave de plaza
vs_keydep     holocont.con_keydep%type;  -- clave de departamento
vn_cos_uni    holocont.con_cosuni%type;  -- costo unitario del capitulo
vs_key_pue    holocont.con_keypue%type;  -- clave de puesto o actividad
vs_sts_pag    holococa.coc_stspag%type;  -- status capitulo
vn_pre_ano    holocont.con_preano%type;
rec record;
begin
-- a??el ejercicio
-- insert into borra values ('EMILIO','paso1');
-- busca que ninguno de los capitulos a cancelar ya esten pagados o en proceso
select count(distinct con_keyplz)
into strict vn_capitulos
from usrsiho.holocont,usrsiho.holococa
where con_keydep = vs_key_dep
and con_keyplz = coc_keyplz
and coc_keycap between vn_ran_ini and vn_ran_fin
and coc_stspag in ('V','E')
and nullif(coc_keyrph::text, '') is not null;
-- insert into borra values ('EMILIO','paso2');
if vn_capitulos = 0 then   -- si existen capitulos pagados o en proceso
-- return vn_capitulos;
--else                       -- si no existen capitulos pagados o en proceso dentro del rango
-- lectura de datos
for rec in (select con_keyplz,con_keydep,con_cosuni,con_keypue,coc_stspag,con_preano
from usrsiho.holocont,usrsiho.holococa
where con_keyplz=coc_keyplz
and con_keydep = vs_key_dep
and con_keytva = 1
and coc_keycap between vn_ran_ini and vn_ran_fin) loop
-- insert into borra values ('EMILIO',vn_cos_uni);
vn_key_plz := rec.con_keyplz;
vs_keydep := rec.con_keydep;
vn_cos_uni := rec.con_cosuni;
vs_key_pue := rec.con_keypue;
vs_sts_pag := rec.coc_stspag;
vn_pre_ano := rec.con_preano;
vn_rescapi := 0;
vn_rescapi := (vn_ran_fin - vn_ran_ini) + 1;
-- por cada uno resta el numero de capitulos en holocont
update usrsiho.holocont
set con_numcdi = con_numcdi - vn_rescapi
where con_keyplz = vn_key_plz
and con_keydep = vs_keydep
and con_keytva = 1;
-- insert into borra values ('EMILIO','paso4');
-- actualiza en holococa para poner status de pago = cancelado
update usrsiho.holococa
set coc_stspag = 'C'
where coc_keyplz = vn_key_plz
and coc_keycap between vn_ran_ini and vn_ran_fin
and nullif(coc_keyrph::text, '') is null
and coc_stspag = 'V';
-- insert into borra values ('EMILIO','paso5');
-- por cada uno resta al costo unitario en el presupuesto
if vs_sts_pag <> 'C' then
begin
select pre_status
into strict vpre_status
from usrsiho.holopres
where pre_keydep = vs_keydep
and pre_keypue = vs_key_pue
and pre_anio = vn_pre_ano;
exception when no_data_found then vpre_status:= null;
end;
if vpre_status = 'A' then
update usrsiho.holopres
set pre_ejerci = pre_ejerci - (vn_cos_uni * vn_rescapi)
where pre_keydep = vs_keydep
and pre_keypue = vs_key_pue
and pre_anio = vn_pre_ano
and pre_status = 'A';
else
begin
select max(pre_anio)
into strict vn_pre_ano
from usrsiho.holopres
where pre_keydep = vs_keydep
and pre_keypue = vs_key_pue;
exception when no_data_found then vn_pre_ano := 0;
end;
update usrsiho.holopres
set pre_ejerci = pre_ejerci - (vn_cos_uni * vn_rescapi)
where pre_keydep = vs_keydep
and pre_keypue = vs_key_pue
and pre_anio = vn_pre_ano;
end if;
-- insert into borra values ('EMILIO','paso6');
end if;
end loop;
-- actualiza en holocapi el rango de capitulos para poner
-- el status de pago = cancelado utilizando para esto un auxiliar (cap_ca1aux = 'C')
update usrsiho.holocapi
set cap_ca1aux = 'C'
where cap_keydep = vs_key_dep
and cap_keycap between vn_ran_ini and vn_ran_fin;/* dmap converted statement start */
-- insert into borra values ('EMILIO','paso7');
-- llena la bitacora
vs_cadena :=  concat(vn_ran_ini, ' AL ' , vn_ran_fin) ;/* dmap converted statement end */
-- insert into borra values ('EMILIO',vs_cadena);
call usrsiho.sp_bitacora ( vn_key_usu,
vs_log_usu,
vs_ide_pcc,
'EL',
'cap_keydep',
'cap_keycap',
' ',
vs_key_dep,
vs_cadena,
' ',
'hcaprogr');
-- insert into borra values ('EMILIO','FIN');
end if;end;
$body$
language plpgsql
;
