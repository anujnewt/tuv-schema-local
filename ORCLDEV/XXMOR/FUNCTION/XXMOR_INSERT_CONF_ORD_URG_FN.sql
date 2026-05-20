create or replace  function  xxmor."xxmor_insert_conf_ord_urg_fn"  ( id_seg_neg numeric, id_fza_vtas numeric, a_dia array_tvch2, a_dia_cierre array_tvch2, a_hora_cierre array_tvch2, top_config numeric, id_user varchar ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
resultado   numeric;
dia         numeric;
diacierre   numeric;
horacierre  timestamp(0);
begin
resultado := 1;
-- insertar usuarios --------
delete from xxmor_conf_ords_urgentes_tab where id_fza_ventas = id_fza_vtas;
/* commit; */
if (top_config>0) then
for i in 1..top_config loop
dia := (a_dia(i))::numeric;
diacierre := (a_dia_cierre(i))::numeric;
horacierre := to_date(oracle.substr(a_hora_cierre(i),0,19),'YYYY-MM-DD HH24:mi:ss');
insert into xxmor_conf_ords_urgentes_tab values (id_seg_neg,id_fza_vtas, dia, diacierre, horacierre, id_user, clock_timestamp(),null,null);
end loop;
/* commit; */
end if;
return resultado;
exception
when others then
return 0;end;
--dmap converted function completed
$body$
language plpgsql
;
