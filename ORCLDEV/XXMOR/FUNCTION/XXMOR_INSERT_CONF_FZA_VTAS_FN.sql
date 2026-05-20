create or replace  function  xxmor."xxmor_insert_conf_fza_vtas_fn"  ( id_seg_neg numeric, id_fza_vtas numeric, a_id_user array_tvch2, a_adminitrador array_tvch2, top_ausers numeric, thecanal varchar, a_canales array_tvch2, a_porcentajes array_tvch2, top_acanales numeric, id_user varchar ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
resultado     numeric;
adminyes      varchar(2);
porcentaje    numeric;
banderauser   numeric;
banderaadmon  numeric;
loggeduser    varchar(100);
begin
resultado := 1;
for i in 1..top_ausers loop
adminyes   := to_char(a_adminitrador(i));
loggeduser := id_user;
-- verificar si el idusuario en cuestion ya existe en la bd
banderauser := 0;
select count(1)
into strict   banderauser
from   xxmor_fzas_vtas_usuarios_tab
where  id_seg_neg    = 1
and    id_fza_ventas = id_fza_vtas
and    trim(both id_user) = trim(both a_id_user(i));
if (banderauser > 0) then --update
select distinct administrador
into strict   banderaadmon
from   xxmor_fzas_vtas_usuarios_tab
where  id_seg_neg    = 1
and    id_fza_ventas = id_fza_vtas
and    trim(both id_user) = trim(both a_id_user(i));
if (banderaadmon <> adminyes) then
update xxmor_fzas_vtas_usuarios_tab
set  administrador = adminyes,
updated_by    = loggeduser,
updated_date  = clock_timestamp()
where id_seg_neg    = 1
and id_fza_ventas = id_fza_vtas
and trim(both id_user) = trim(both a_id_user(i));
/* commit; */
end if;
else -- insert
insert into xxmor_fzas_vtas_usuarios_tab
values (id_seg_neg,id_fza_vtas, a_id_user(i),adminyes,loggeduser,clock_timestamp(),null,null);
/* commit; */
end if;
end loop;
/* commit; */
-- insertar canales
/*
delete from xxmor_fzas_vtas_canales_tab where id_fza_ventas = id_fza_vtas;
/* commit; */
if(top_acanales>0) then
for i in 1..top_acanales loop
porcentaje := to_number(a_porcentajes(i));
insert into xxmor_fzas_vtas_canales_tab values (id_seg_neg,id_fza_vtas, thecanal, a_canales(i),porcentaje,id_user,sysdate,null,null);
end loop;
/* commit; */
end if;
*/
return resultado;
exception
when others then
return 0;end;
--dmap converted function completed
$body$
language plpgsql
;
