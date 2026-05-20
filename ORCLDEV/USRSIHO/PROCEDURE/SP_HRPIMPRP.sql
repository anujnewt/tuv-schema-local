create or replace procedure usrsiho."sp_hrpimprp"  (vs_des_rep varchar, vs_pro_yec varchar, vn_key_usu numeric, vs_rut_arp inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- sipros, s. a. de c. v.
-- sistema  : rh-2000  c/s
-- modulo   : nomina de honorarios
-- programa : sp_htpimprp
--            generacion de nombre de reporte
-- autor    : veronica vazquez rodriguez
-- fecha    : 13 de septiembre de 1999
vn_key_rep numeric;
begin
-- inicializa variables
vn_key_rep := 0;
-- selecciona ruta de generacion
begin
select pam_nompar
into strict vs_rut_arp
from usrsiho.glcopams
where pam_keypar = 'H001'
and pam_cvesec = 'OPCI09';
exception
when no_data_found then
vs_rut_arp:= null;
end;
-- obtiene numero de reporte asignado
-- vn_key_rep := sp_lee_serial();
select max(rep_keyrep)+1
into strict   vn_key_rep
from   usrsiho.holorepo;/* dmap converted statement start */
-- arma nombre de archivo y ruta de impresion
vs_rut_arp := concat( trim(both vs_rut_arp), to_char(vn_key_rep)) ;/* dmap converted statement end */
-- inserta valores a tabla de reportes
insert into usrsiho.holorepo(rep_keyrep,rep_desrep,rep_proyec,rep_keyusu,rep_fechag,rep_rutarp)
values (vn_key_rep,
vs_des_rep,
vs_pro_yec,
vn_key_usu,
trunc(clock_timestamp()),
vs_rut_arp);
--  actualiza nombre de archivo
--   update usrsiho.holorepo
--      set rep_rutarp = vs_rut_arp
--    where rep_keyrep = vn_key_rep;
end;
$body$
language plpgsql
;
