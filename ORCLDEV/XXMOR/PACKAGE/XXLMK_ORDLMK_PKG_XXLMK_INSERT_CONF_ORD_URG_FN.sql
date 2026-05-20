create or replace  function  xxmor.xxlmk_ordlmk_pkg_xxlmk_insert_conf_ord_urg_fn ( piintipo_orden numeric, a_dia array_tvch2, a_dia_cierre array_tvch2, a_hora_cierre array_tvch2, a_minuto_cierre array_tvch2, piintop_config numeric, pistcreated_by varchar ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
resultado       numeric;
lindia          numeric;
lindiacierre    numeric;
linhoracierre   numeric;
linminutocierre numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
resultado := 1;
-- borrar configuracin
delete from xxlmk_conf_ord_urg_tab where ind_tipo_orden = piintipo_orden;
/* commit; */
if (piintop_config>0) then
for i in 1..piintop_config loop
lindia := (a_dia(i))::numeric;
lindiacierre := (a_dia_cierre(i))::numeric;
linhoracierre := (a_hora_cierre(i))::numeric;
linminutocierre := (a_minuto_cierre(i))::numeric;
insert into xxlmk_conf_ord_urg_tab(id_conf, ind_tipo_orden, num_dia, num_dia_cierre, num_hora_cierre, num_minuto_cierre, fec_creacion, cve_creado_por, fec_actualizacion, cve_actualizado_por)
values (nextval('xxlmk_conf_ord_urg_sq'), piintipo_orden, lindia, lindiacierre, linhoracierre, linminutocierre, clock_timestamp(), pistcreated_by, clock_timestamp(), pistcreated_by);
end loop;
/* commit; */
end if;
return resultado;/* dmap converted statement start */
exception
when others then
raise exception '%',  concat('ERROR: ', sqlerrm)  using errcode = '45000';/* dmap converted statement end */end;
$body$
language plpgsql
;
