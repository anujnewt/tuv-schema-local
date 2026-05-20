create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxlmk_ins_upd_spt_rec_inf_pr (piinid_spot integer, piinnum_spot integer, piinnum_sched_time_orig varchar, piinind_status_lmk_orig varchar, piinind_estatus_mov integer, piinid_razon_cancel integer, piinind_cambio_status integer, pistcve_creado_por varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lincount_spot   integer;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select count(*)
into strict lincount_spot
from xxlmk_recol_spots_ctrl_tab
where id_spot = piinid_spot;
if lincount_spot = 0 then
insert into xxlmk_recol_spots_ctrl_tab(id_spot, num_spot, num_sched_time_orig, ind_status_lmk_orig, ind_estatus_mov, id_razon_cancel,
ind_cambio_status, ind_num_movs, cve_creado_por, fec_creacion)
values (piinid_spot, piinnum_spot, piinnum_sched_time_orig, piinind_status_lmk_orig, piinind_estatus_mov, piinid_razon_cancel,
piinind_cambio_status, 1, pistcve_creado_por, clock_timestamp());
else
update xxlmk_recol_spots_ctrl_tab
set
num_sched_time_orig = piinnum_sched_time_orig,
ind_status_lmk_orig = piinind_status_lmk_orig,
ind_estatus_mov = piinind_estatus_mov,
id_razon_cancel = piinid_razon_cancel,
ind_cambio_status = piinind_cambio_status,
ind_num_movs = ind_num_movs + 1,
cve_actualizado_por = pistcve_creado_por,
fec_actualizacion = clock_timestamp()
where id_spot = piinid_spot;
end if;end;
$body$
language plpgsql
;
