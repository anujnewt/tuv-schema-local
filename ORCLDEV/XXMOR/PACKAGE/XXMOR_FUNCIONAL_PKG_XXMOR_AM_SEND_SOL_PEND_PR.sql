create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_am_send_sol_pend_pr ( p_id_solicitud integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_ord_sin_gr_ca_aux      integer;
v_ord_con_gr_ca          integer;
v_conf_agr_mult          integer := 0;
v_sols_bien              integer := 0;
v_return                 integer;
v_aux                    varchar(11);
solicitudes_cur cursor for
select id_solicitud
from xxmor_solicitudes_enc_tab
where id_solicitud in (select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = (select id_request
from xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud
)
);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
--contamos el numero de ordenes/linea generadas por el agrupador multiple
select count(agrupador_multiple)
into strict v_conf_agr_mult
from xxmor_cat_agrupador_mult_tab
where agrupador_multiple in (select agrupador
from   xxmor.xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud
);
if v_conf_agr_mult > 0 then
for c_solicitud in solicitudes_cur loop
select xxmor_funcional_pkg_xxmor_sol_agr_mult_val_fun(c_solicitud.id_solicitud)
into strict v_aux;
if v_aux = 1 then
v_sols_bien := v_sols_bien + 1;
end if;
end loop;/* dmap converted statement start */
--si todas estan bien se reenvian para que se calculen
if v_sols_bien = v_conf_agr_mult then
for c_solicitud in solicitudes_cur loop
if c_solicitud.id_solicitud != p_id_solicitud then
--v_aux := xxmor_funcional_pkg_xxmor_env_sol_concom_fun( c_solicitud.id_solicitud);
perform dbms_output.put_line( concat('V_AUX:', v_aux)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('P_ID_SOLICITUD:', p_id_solicitud)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('C_SOLICITUD.ID_SOLICITUD:', c_solicitud.id_solicitud)) ;/* dmap converted statement end */
end if;
end loop;
end if;
end if;end;
$body$
language plpgsql
;
