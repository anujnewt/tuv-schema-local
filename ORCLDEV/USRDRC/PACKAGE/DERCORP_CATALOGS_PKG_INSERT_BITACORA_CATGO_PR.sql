create or replace procedure usrdrc.dercorp_catalogs_pkg_insert_bitacora_catgo_pr ( piinidcatalogo numeric, pistusuario varchar, pistaccion varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linidconsecutivo  numeric; --id consecutivo hasta 3 registros
linidbitacora     numeric; --id de la tabla
linregistroborrar numeric; --id a borrar cuando sea mayor a 3
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select count(id_bitacora_mod)into linidconsecutivo
from dercorp_bita_mod_cat_tab
where id_catalogo = piinidcatalogo;
if linidconsecutivo = 20 --porque solo se requiere los ultimos 3 modificaciones
then
begin
select min(id_bitacora_mod) into strict linregistroborrar
from dercorp_bita_mod_cat_tab
where id_catalogo = piinidcatalogo;
delete from dercorp_bita_mod_cat_tab
where id_catalogo     = piinidcatalogo
and   id_bitacora_mod = linregistroborrar;/* dmap converted statement start */
exception
when others then
perform dbms_output.put_line( concat('Error en la transaccion:', sqlerrm)) ;/* dmap converted statement end */
perform dbms_output.put_line('Se deshacen las modificaciones');
rollback;
end;
end if;
select  coalesce(max(id_bitacora_mod) + 1,1) into strict linidbitacora
from dercorp_bita_mod_cat_tab;
if pistaccion = 'NUEVO'
then
insert into dercorp_bita_mod_cat_tab( id_bitacora_mod,
id_catalogo,
num_created_by,
fec_creation_date)
values ( linidbitacora,
piinidcatalogo,
pistusuario,
clock_timestamp());
else if pistaccion = 'MODIFICACION'
then
insert into dercorp_bita_mod_cat_tab( id_bitacora_mod,
id_catalogo,
num_last_updated_by,
fec_last_update_date)
values ( linidbitacora,
piinidcatalogo,
pistusuario,
clock_timestamp());
end if;
end if;end;
$body$
language plpgsql
;
