create or replace procedure xxmor."xxmor_autorizar_orden_pr"  ( id_sol numeric, lns array_tvch2, ln_size numeric, tipo_aut varchar, est varchar, p_usuario varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
auts    numeric;
errs    numeric;
reten   numeric;
begin
if (tipo_aut = 'REQUEST/ORDEN/ENCABEZADO/CPSMASTERCONTRACT' or tipo_aut = 'CPS') then
update xxmor_concom_rpta_tab
set    estatus_orduni = est,
updated_date   = clock_timestamp(),
updated_by     = p_usuario
where  id_solicitud           = id_sol
and    upper(accion_concom)   = 'AUTORIZACION'
and    upper(campo_concom)    = tipo_aut
and    upper(posicion_concom) = 'ENCABEZADO';
else
for tln in 1..ln_size loop
update xxmor_concom_rpta_tab
set    estatus_orduni = est,
updated_date   = clock_timestamp(),
updated_by     = p_usuario
where  id_solicitud         = id_sol
and    upper(accion_concom) = 'AUTORIZACION'
and    upper(campo_concom)  = tipo_aut
and    numlinea_concom      = lns(tln);
end loop;
end if;
/* commit; */
end;
$body$
language plpgsql
;
