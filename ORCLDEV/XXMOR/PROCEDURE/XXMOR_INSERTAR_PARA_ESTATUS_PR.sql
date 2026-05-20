create or replace procedure xxmor."xxmor_insertar_para_estatus_pr"  ( id_sol numeric, lns numeric, est varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
if (lns = 0) then
update xxmor_solicitudes_enc_tab
set    orden_estatus = est
where  id_solicitud  = id_sol;
else
update xxmor_solicitudes_det_tab
set    linea_estatus = est
where  id_solicitud = id_sol
and    linea        = lns;
end if;
/* commit; */
end;
$body$
language plpgsql
;
