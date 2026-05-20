create or replace procedure usrsiho."sp_hcaprogr"  (vs_ide_pcc varchar,  -- identif. pc
vn_key_usu numeric,   -- clave de usuario
vs_log_usu varchar,  -- login del usuario
vs_key_men varchar,  -- nombre del menu
vn_ran_ini numeric,   -- rango inicial
vn_ran_fin numeric,   -- rango final
vs_key_dep varchar) as $body$
declare
ora2pg_rowcount int;
-- pgv moved types start
-- pgv moved types end
-- clave de departamento
-- sipros, s. a. de c. v.
--
-- sistema  : rh-2000  c/s
-- modulo   : nomina de honorarios(ho)
-- programa : sp_hcaprogr
--            insercion de capitulos  por rangos
-- autor    : veronica vazquez rodriguez
-- fecha    : 09 de septiembre de 1999
vn_con_001    numeric(5);
begin
-- contador de registros
-- cliclo de insecion de capitulos
for vn_con_001 in vn_ran_ini .. vn_ran_fin loop
update usrsiho.holocapi set cap_keydep =  vs_key_dep
where cap_keydep = vs_key_dep
and cap_keycap = vn_con_001;
-- valida si existe el capitulo
get diagnostics ora2pg_rowcount = row_count;
if ora2pg_rowcount  = 0 then
insert into usrsiho.holocapi(cap_keydep,cap_keycap,cap_ca1aux)
values (vs_key_dep,vn_con_001,'V');
call usrsiho.sp_bitacora ( vn_key_usu,
vs_log_usu,
vs_ide_pcc,
'IN',
'cap_keydep',
'cap_keycap',
' ',
vs_key_dep,
vn_con_001,
' ','hcaprogr');
end if;
end loop;end;
$body$
language plpgsql
;
