create or replace procedure usrdrc.dmap_dercorp_report_tencasc_pkg_insert_row_pr (prginrow dercorp_reporte_tencasc_tmp) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- pragma autonomous_transaction;
--dmap conversion comment: global temp variables moved as local temp variables
gincountarr_temp numeric;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('USRDRC', 'DERCORP_REPORT_TENCASC_PKG');
--dmap conversion comment: gtt declaration added
insert into usrdrc.dercorp_reporte_tencasc_tmp(
des_dato1,
des_dato2,
des_dato3,
des_dato4,
des_dato5,
des_dato6,
des_dato7,
des_dato8,
des_dato9,
des_dato10
)
values (
prginrow.des_dato1,
prginrow.des_dato2,
prginrow.des_dato3,
prginrow.des_dato4,
prginrow.des_dato5,
prginrow.des_dato6,
prginrow.des_dato7,
prginrow.des_dato8,
prginrow.des_dato9,
prginrow.des_dato10
);
/* commit; */
end;
$body$
language plpgsql
;
