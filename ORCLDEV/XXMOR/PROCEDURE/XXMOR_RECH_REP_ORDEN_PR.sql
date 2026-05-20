create or replace procedure xxmor."xxmor_rech_rep_orden_pr"  ( id_sol numeric, lns array_tvch2, ln_size numeric, est varchar, usuario varchar, motivo varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
tot_lineas         numeric;
v_distinct_status  numeric;
v_ln_status_46     varchar(2);
begin
if (est = '46') then
/*
select count(linea)
into   tot_lineas
from   xxmor_solicitudes_det_tab
where  id_solicitud = id_sol;
if (tot_lineas = ln_size) then
insert into xxmor_concom_rpta_tab (
id_solicitud,
id_seg_neg,
id_rpta_concom,
resultadogeneral,
trackingid,
desc_concom,
posicion_concom,
id_concom,
numlinea_concom,
estatus_concom,
campo_concom,
detalle_concom,
accion_concom,
tiporegla_concom,
estatus_orduni,
created_date,
created_by
)
values
(
id_sol,
1,
xxmor_id_rpta_concom_sq.nextval,
null,
xxmor_id_rpta_concom_sq.nextval,
null,
'LINEA',
null,
null,
'ERROR',
motivo,
'RECHAZO - La l?a fue rechazada manualmente',
'RECHAZO',
null,
10,
sysdate,
usuario
);
/* commit; */
end if;
*/
for tln in 1..ln_size loop
insert into xxmor_concom_rpta_tab(
id_solicitud,
id_seg_neg,
id_rpta_concom,
resultadogeneral,
trackingid,
desc_concom,
posicion_concom,
id_concom,
numlinea_concom,
estatus_concom,
campo_concom,
detalle_concom,
accion_concom,
tiporegla_concom,
estatus_orduni,
created_date,
created_by
)
values (
id_sol,
1,
nextval('xxmor_id_rpta_concom_sq'),
null,
nextval('xxmor_id_rpta_concom_sq'),
null,
'LINEA',
null,
lns(tln),
'ERROR',
motivo,
'RECHAZO - La l?a fue rechazada manualmente',
'RECHAZO',
null,
10,
clock_timestamp(),
usuario
);
if found then
-- se actualiza el estatus de los registros para la misma linea
-- rechazada que se hayan generado por autorizaci? reproceso
update xxmor_concom_rpta_tab
set    estatus_orduni = '20',
updated_by     = 'ORDUNI',
updated_date   = clock_timestamp()
where  id_solicitud           = id_sol
and    numlinea_concom        = lns(tln)
and    estatus_orduni         = '10'
and    upper(posicion_concom) = 'LINEA'
and    upper(accion_concom)   in ('AUTORIZACION','REPROCESO');
/* commit; */
end if;
end loop;
-- verificar si todas las lineas estan rechazadas
select count(*)
into strict   v_distinct_status
from (select distinct linea_estatus
from   xxmor_solicitudes_det_tab
where  id_solicitud = id_sol
) alias1;
if (v_distinct_status = 1) then
select distinct linea_estatus
into strict   v_ln_status_46
from   xxmor_solicitudes_det_tab
where  id_solicitud = id_sol;
if (v_ln_status_46 = '46') then
update xxmor_solicitudes_enc_tab
set    orden_estatus = 45   --,updated_date = sysdate, updated_by = 'SOL_ESTATUS_PR'
where  id_solicitud  = id_sol
and    orden_estatus not in (36);
-- /* commit; */
update xxmor_solicitudes_est_rep_tab
set    estat_rep    = '0'
where  id_solicitud = id_sol
and    estat_rep    = '2';
-- /* commit; */
update  xxmor_concom_rpta_tab
set     estatus_orduni   = '10',
accion_concom    = 'RECHAZO'
where   id_solicitud     = id_sol
and     nullif(numlinea_concom::text, '') is null;
/* commit; */
-- select orden_estatus from xxmor_solicitudes_enc_tab
-- where  id_solicitud  = :id_sol
end if;
end if;
else -- est != '46'
if (ln_size = 0) then
update xxmor_concom_rpta_tab
set    estatus_orduni = '20',
updated_by     = usuario,
updated_date   = clock_timestamp()
where  id_solicitud         = id_sol
and    estatus_orduni       = '10'
and    upper(accion_concom) in ('REENVIO','REPROCESO');
-- and    upper(accion_concom) = 'REPROCESO'; -- se cambio para que los reenvios tambien funcionen
update xxmor_solicitudes_enc_tab
set    orden_estatus = est
where  id_solicitud  = id_sol;
/* commit; */
else
for tln in 1..ln_size loop
update xxmor_concom_rpta_tab
set    estatus_orduni = '20',
updated_by     = usuario,
updated_date   = clock_timestamp()
where  id_solicitud         = id_sol
and    numlinea_concom      = lns(tln)
and    estatus_orduni       = '10'
and    upper(accion_concom) in ('REENVIO','REPROCESO');
-- and    upper(accion_concom) = 'REPROCESO'; -- se cambio para que los reenvios tambien funcionen
update xxmor_solicitudes_det_tab
set    linea_estatus = est
where  id_solicitud  = id_sol
and    linea         = lns(tln);
/* commit; */
end loop;
update xxmor_concom_rpta_tab
set    estatus_orduni = '20',
updated_by     = usuario,
updated_date   = clock_timestamp()
where  id_solicitud         = id_sol
and    nullif(numlinea_concom::text, '') is null
and    estatus_orduni       = '10'
and    upper(accion_concom) in ('REENVIO','REPROCESO');
-- and    upper(accion_concom) = 'REPROCESO'; -- se cambio para que los reenvios tambien funcionen
/* commit; */
end if;
end if;
-- /* commit; */
end;
$body$
language plpgsql
;
