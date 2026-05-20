create or replace  function  xxmor."xxmor_insert_conf_notif_fn"  ( id_seg_neg numeric, id_fza_vtas numeric, id_notificacion array_tvch2, u_interno array_tvch2, u_agencia array_tvch2, u_factur array_tvch2, top_config numeric, id_user varchar ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
resultado   numeric;
flagaction  numeric;
idnot       numeric;
usrinterno  numeric;
usragencia  numeric;
usrfactur  numeric;
begin
resultado := 1;
if (top_config > 0) then
for i in 1..top_config loop
-- primero ver si es update or insert
-- busca con llave:
idnot := (id_notificacion(i))::numeric;
usrinterno := (u_interno(i))::numeric;
usragencia := (u_agencia(i))::numeric;
usrfactur := (u_factur(i))::numeric;
select count(1)
into strict   flagaction
from   xxmor_conf_notific_tab
where  id_seg_neg      = id_seg_neg
and    id_fza_ventas   = id_fza_vtas
and    id_notificacion = idnot;
if (flagaction > 0) then
--update
update xxmor_conf_notific_tab
set    usuario_interno = usrinterno,
usuario_agencia = usragencia,
usuario_factur  = usrfactur,
updated_date    = clock_timestamp(),
updated_by      = id_user
where  id_seg_neg      = id_seg_neg
and    id_fza_ventas   = id_fza_vtas
and    id_notificacion = idnot;
/* commit; */
else
--insert
insert into xxmor_conf_notific_tab
values ( id_seg_neg,
id_fza_vtas,
idnot,
usrinterno,
usragencia,
id_user,
clock_timestamp(),
null,
null,
usrfactur
);
/* commit; */
end if;
end loop;
-- /* commit; */
end if;
return resultado;
exception
when others then
return 0;end;
--dmap converted function completed
$body$
language plpgsql
;
