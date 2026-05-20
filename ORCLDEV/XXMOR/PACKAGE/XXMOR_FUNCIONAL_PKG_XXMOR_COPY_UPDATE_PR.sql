create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_copy_update_pr ( p_id_solicitud integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_count_copy_vc        integer;
v_copy_x_orden         varchar(1);
v_linea_con_copy       integer;
v_min_linea_vc         integer;
v_id_fza_ventas        integer;
lineas_ord_cur cursor for
select version,stnid,
case when count(version) = 1
then min(linea)
else 0
end
as numline
from xxmor_solicitudes_det_tab
where id_solicitud = p_id_solicitud
having count(version) > 1
group by version, stnid;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
-- se modifico esto por la funcion para saber si la solicitud
-- maneja copys por orden o por linea 27-may-2013
/*select to_number(nvl(copys_x_orden::numeric, 0))
into v_copy_x_orden
from xxmor_fzas_vtas_tab
where id_fza_ventas = (select id_fza_ventas
from   xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud
);
*/
select id_fza_ventas
into strict   v_id_fza_ventas
from   xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud;
v_copy_x_orden := xxmor_funcional_pkg_xxmor_copys_por_orden_fn(v_id_fza_ventas,p_id_solicitud);/* dmap converted statement start */
--if v_copy_x_orden > 0 then
if v_copy_x_orden = 'Y' then
perform dbms_output.put_line( concat(' --COPYS POR ORDEN: ', v_copy_x_orden)  );/* dmap converted statement end */
for c_ver_stn in lineas_ord_cur loop
--contamos si la combinacion version canal ya tiene copys
select count(1)
into strict   v_count_copy_vc
from   xxmor_solicitudes_det_tab     d,
xxmor_solicitudes_est_rep_tab r
where  d.id_solicitud = r.id_solicitud
and    r.linea        = d.linea
and    d.version      = c_ver_stn.version
and    d.stnid        = c_ver_stn.stnid
and    nullif(r.rotid::text, '') is not null;/* dmap converted statement start */
perform dbms_output.put_line( concat(' --YA TIENE COPYS?: ', v_count_copy_vc)  );/* dmap converted statement end */
-- si ya tiene entonces revisamos q la linea a la que se le asigno el copy sea la menor
-- si no entonces borramos
if v_count_copy_vc > 0 then
--sacamos la linea q tiene el copy
select min(r.linea)
into strict   v_linea_con_copy
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_est_rep_tab r
where  r.id_solicitud = p_id_solicitud
and    d.id_solicitud = r.id_solicitud
and    r.linea        = d.linea
and    d.version      = c_ver_stn.version
and    d.stnid        = c_ver_stn.stnid
and    nullif(r.rotid::text, '') is not null;/* dmap converted statement start */
perform dbms_output.put_line( concat(' --LINEA CON COPY: ', v_linea_con_copy)  );/* dmap converted statement end */
--sacamos la menor de las lineas en general
select min(r.linea)
into strict   v_min_linea_vc
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_est_rep_tab r
where  r.id_solicitud = p_id_solicitud
and    d.id_solicitud = r.id_solicitud
and    r.linea        = d.linea
and    d.version      = c_ver_stn.version
and    d.stnid        = c_ver_stn.stnid;/* dmap converted statement start */
perform dbms_output.put_line( concat(' --LINEA MAS PEQUE?A: ', v_min_linea_vc)  );/* dmap converted statement end */
--si la linea q no tiene copy es mayor a la linea que tiene el copy  entonces
--cambiamos los rotids
if v_min_linea_vc = v_linea_con_copy then
update xxmor_solicitudes_est_rep_tab
set rotid = (select rotid
from   xxmor_solicitudes_est_rep_tab
where  id_solicitud = p_id_solicitud
and linea = v_linea_con_copy
),
aux1  = (select aux1
from   xxmor_solicitudes_est_rep_tab
where  id_solicitud = p_id_solicitud
and    linea        = v_linea_con_copy
)
where id_solicitud = p_id_solicitud
and   linea        = (select max(r.linea)
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_est_rep_tab r
where r.id_solicitud = p_id_solicitud
and   d.id_solicitud = r.id_solicitud
and   r.linea        = d.linea
and   d.version      = c_ver_stn.version
and   d.stnid        = c_ver_stn.stnid
);
update xxmor_solicitudes_est_rep_tab
set rotid  = null,
aux1   = null
where id_solicitud = p_id_solicitud
and   linea        = v_linea_con_copy;
end if;
end if;
end loop;
end if;end;
$body$
language plpgsql
;
