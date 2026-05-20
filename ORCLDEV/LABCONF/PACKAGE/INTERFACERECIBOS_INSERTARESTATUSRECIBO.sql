create or replace procedure labconf.interfacerecibos_insertarestatusrecibo (idcomprobanteemp numeric, status numeric, errorstr varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
merge into labconf.cfdi2estatusrecibos
using(select insertarestatusrecibo.idcomprobanteemp idcomprobanteemp,
clock_timestamp() est_feclec,
insertarestatusrecibo.status est_status,
errorstr est_error  ) cfdi
on (labconf.cfdi2estatusrecibos.idcomprobanteemp = insertarestatusrecibo.idcomprobanteemp)
when matched then
update set est_feclec = cfdi.est_feclec, est_status = cfdi.est_status, est_error = cfdi.est_error
when not matched then
insert(
idcomprobanteemp,
est_feclec,
est_status,
est_error
)
values (
cfdi.idcomprobanteemp,
cfdi.est_feclec,
cfdi.est_status,
cfdi.est_error
);end;
$body$
language plpgsql
;
