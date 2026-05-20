create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_sol_hna_am_pr ( p_id_solicitud integer, o_id_sol_hna inout integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_valido        integer;
v_copys         integer;
v_lineas        integer;
v_enc           integer;
v_intentos      integer;
v_id_sol_hna    integer;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
begin
select id_solicitud
into strict v_id_sol_hna
from  xxmor_solicitudes_enc_tab
where id_request = (select id_request
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
)
and id_solicitud != p_id_solicitud
and (select count(1)
from   xxmor_solicitudes_est_rep_tab
where  estat_reintento <= 5
and    id_solicitud    =  p_id_solicitud
and    linea           =  0
)      > 0 limit 1;
exception
when no_data_found then
o_id_sol_hna := 0;
end;
--        select estat_reintento
--        into v_intentos
--        from xxmor_solicitudes_est_rep_tab
--        where id_solicitud = v_id_sol_hna
--        and linea = 0;
if nullif(v_id_sol_hna::text, '') is not null then
update xxmor_solicitudes_est_rep_tab
set estat_reintento =  estat_reintento + 1
where id_solicitud = v_id_sol_hna
and linea = 0;
select count(1)
into strict v_copys
from xxmor_para_copy_vw
where id_solicitud = v_id_sol_hna;
select count(1)
into strict v_lineas
from xxmor_para_lin_vw
where id_solicitud = v_id_sol_hna;
select count(1)
into strict v_enc
from xxmor_para_enc_vw
where id_solicitud = v_id_sol_hna;
--dbms_output.put_line(v_lineas: ||v_lineas);
--dbms_output.put_line(v_copys: ||v_copys);
if v_enc > 0 or v_copys > 0 or v_lineas > 0 then
o_id_sol_hna := v_id_sol_hna;
else
o_id_sol_hna := 0;
end if;
else
o_id_sol_hna := 0;
end if;end;
$body$
language plpgsql
;
