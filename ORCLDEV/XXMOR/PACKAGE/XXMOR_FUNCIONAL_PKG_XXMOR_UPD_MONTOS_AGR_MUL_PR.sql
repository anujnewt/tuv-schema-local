create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_upd_montos_agr_mul_pr ( p_id_solicitud numeric, p_linea integer, p_monto numeric, p_id_sol_ref integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_tot_spots              numeric;
v_lineas_con_get_rate    integer;
v_ordenes_hermanas       integer;
v_id_request             integer;
v_suma_get_rate          numeric;
v_getrate_sin_ajuste     numeric;
v_rt_original            numeric;
v_monto_updated          integer :=0;
v_get_rate_from          varchar(4);
v_monto_orig             numeric;
v_suma_lineas            numeric;
v_ca_rtcrd               integer;
v_monto                  numeric;
v_aut_tm                 integer;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');/* dmap converted statement start */
--dmap conversion comment: gtt declaration added
if p_monto = 0 then
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom,
resultadogeneral, trackingid, desc_concom,
posicion_concom, id_concom, numlinea_concom,
estatus_concom, campo_concom, detalle_concom,
accion_concom, tiporegla_concom, estatus_orduni,
created_date, created_by
)
select e.id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'),
null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null, linea,
'ERROR', 'TARIFA_MANUAL',  concat('RECHAZO - La tarifa para la linea de la orden ', p_id_solicitud, ' es igual a ', p_monto)  ,
'RECHAZO', null, '10',
clock_timestamp(), 'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud in (select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = (select id_request
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
)
)
and    e.id_solicitud = d.id_solicitud
and    d.linea        = p_linea
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud             = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is not null
and    accion_concom              = 'RECHAZO'
and    (numlinea_concom)::numeric  = d.linea
);/* dmap converted statement end */
end if;
--verificamos si proviene de ca_ratecards
select xxmor_funcional_pkg_xxmor_rtcrd_ca_fun(p_id_solicitud)
into strict   v_ca_rtcrd
;
--verificamos si se genero tarifa manual
select count(1)
into strict   v_aut_tm
from   xxmor_concom_rpta_tab
where  id_solicitud               = p_id_solicitud
and    nullif(numlinea_concom::text, '') is not null
and    campo_concom               = 'TARIFA_MANUAL'
and    (numlinea_concom)::numeric  = p_linea;
if v_ca_rtcrd = 1 then
v_monto := p_monto;
else
v_monto := p_monto/100;
end if;
--obtenemos la fuente de donde provienen las cotizaciones (ws o sp)
select get_rate
into strict   v_get_rate_from
from   xxmor_fzas_vtas_tab
where  id_fza_ventas  = (select id_fza_ventas
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
);
--obtenemos la tarifa original de la orden de referencia (debe ser igual al getrate la 1a vez)
--el getrate_sin_ajuste es el valor original del valor del precio por spot sin descuento
select getrate_sin_ajuste,
tarifasp_sin_desc
into strict   v_getrate_sin_ajuste,
v_rt_original
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
and    linea        = p_linea;
--obtenemos el monto original de la linea
select trunc(coalesce(tarifasp_sin_desc,0))
into strict   v_monto_orig
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
and    linea        = p_linea;
--obtenemos el monto de la suma de las lineas
select round(sum( tarifasp_sin_desc ))
into strict   v_suma_lineas
from   xxmor_solicitudes_det_tab
where  id_solicitud in ( select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = (select id_request
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
)
)
and    linea        = p_linea;
--revisamos si el monto ya fue actualizado, si si, entonces evitar volver a actualizar
select (case when nullif(getrate_con_ajuste::text, '') is not null then 1 else 0 end)
into strict   v_monto_updated
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
and    linea        = p_linea;/* dmap converted statement start */
perform dbms_output.put_line( concat(' V_SUMA_LINEAS:  ', v_suma_lineas)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat(' V_MONTO_ORIG:  ', v_monto_orig)) ;/* dmap converted statement end */
update xxmor_solicitudes_det_tab
set    getrate_con_ajuste = v_monto
where  id_solicitud    = p_id_solicitud
and    linea           = p_linea
and    nullif(division_montos::text, '') is null;
-- if v_suma_lineas != v_monto_orig then
--actualizamos el campo getrate_con_ajuste (dado que para este tipo de ordenes debe venir vacio)
--            update xxmor_solicitudes_det_tab
--            set getrate_con_ajuste = v_monto
--            where id_solicitud = p_id_solicitud
--            and linea = p_linea;
--obtenemos el identificador de  las ordenes hermanas
select id_request
into strict   v_id_request
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud;
--contamos las lineas hermanas
select count(1)
into strict   v_ordenes_hermanas
from   xxmor_solicitudes_enc_tab
where  id_request = v_id_request;
--contamos todas las lineas hermanas que ya tienen ese campo calculado
select count(1)
into strict   v_lineas_con_get_rate
from   xxmor_solicitudes_enc_tab e,
xxmor_solicitudes_det_tab d
where  e.id_request         = v_id_request
and    e.id_solicitud       = d.id_solicitud
and    d.linea              = p_linea
and    nullif(d.getrate_con_ajuste::text, '') is not null;
--si todas las lineas/ordenes hermanas ya tienen ese campo != de null entonces aplicamos la formula
if v_ordenes_hermanas = v_lineas_con_get_rate then
--sacamos la suma de las parciales o getrates con ratecard especifico
select sum(getrate_con_ajuste)
into strict   v_suma_get_rate
from   xxmor_solicitudes_enc_tab e,
xxmor_solicitudes_det_tab d
where  e.id_request         = v_id_request
and    e.id_solicitud       = d.id_solicitud
and    d.linea              = p_linea
and    nullif(d.getrate_con_ajuste::text, '') is not null;
--total de spots de la linea
v_tot_spots := xxmor_funcional_pkg_xxmor_sol_totales_fun(p_id_solicitud, p_linea, 'SP_X_L');
--if v_get_rate_from = sp and v_suma_get_rate <> 0 then
if v_suma_get_rate <> 0 then
--actualizamos los valores para cuando la orden es de ca
if v_ca_rtcrd = 1 then
perform dbms_output.put_line(' rtcrd de CA  ');
if v_aut_tm > 0 then
perform dbms_output.put_line(' y con TM');
update xxmor_solicitudes_det_tab
set    tarifasp_sin_desc  = round((tarifasp_sin_desc::numeric * getrate_con_ajuste / v_suma_get_rate)::numeric,2),
tarifasp_con_desc  = 777, --round(nvl(tarifasp_con_desc,0) * getrate_con_ajuste / v_suma_get_rate,2),
tot_linea_sin_desc = round(v_tot_spots * (tarifasp_sin_desc::numeric * getrate_con_ajuste / v_suma_get_rate),2),
tot_linea_con_desc = round(v_tot_spots * (coalesce(tarifasp_con_desc,0) * getrate_con_ajuste / v_suma_get_rate),2),
division_montos    = 1
where id_solicitud in (select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = (select id_request
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_sol_ref
)
)
and nullif(division_montos::text, '') is null
and linea           = p_linea;
else
perform dbms_output.put_line(' sin TM  ');
--si la tarifa de la linea = 0 o no traia
if v_monto_orig = 0 then
perform dbms_output.put_line(' y monto = 0 o null ');
update xxmor_solicitudes_det_tab
set    tarifasp_sin_desc = round(getrate_sin_ajuste * getrate_con_ajuste / (select sum(getrate_con_ajuste)
from   xxmor_solicitudes_enc_tab e,
xxmor_solicitudes_det_tab d
where  e.id_request = ((select id_request
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_sol_ref))
and     e.id_solicitud       = d.id_solicitud
and     d.linea              = p_linea
and     nullif(d.getrate_con_ajuste::text, '') is not null
)
,2),
--tarifasp_con_desc = p_monto,
division_montos = 1
where  id_solicitud in (select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = (select id_request
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_sol_ref
)
)
and    nullif(division_montos::text, '') is null
and    linea           = p_linea;
else
perform dbms_output.put_line(' Monto Diferente de 0/null');
-- si el monto de la linea traia una tarifa != 0
update xxmor_solicitudes_det_tab
set    tarifasp_sin_desc  = round((tarifasp_sin_desc::numeric * getrate_con_ajuste / v_suma_get_rate)::numeric,2),
tarifasp_con_desc  = 777, --round(nvl(tarifasp_con_desc,0) * getrate_con_ajuste / v_suma_get_rate,2),
tot_linea_sin_desc = round(v_tot_spots * (tarifasp_sin_desc::numeric * getrate_con_ajuste / v_suma_get_rate),2),
tot_linea_con_desc = round(v_tot_spots * (coalesce(tarifasp_con_desc,0) * getrate_con_ajuste / v_suma_get_rate),2),
division_montos    = 1
where  id_solicitud in (select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = (select id_request
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_sol_ref
)
)
and nullif(division_montos::text, '') is null
and linea           = p_linea;
end if;
end if;
else
--si la linea trae tarifa manual
if v_aut_tm > 0 then
update xxmor_solicitudes_det_tab
set    tarifasp_sin_desc  = round((tarifasp_sin_desc::numeric * getrate_con_ajuste / v_suma_get_rate)::numeric,2),
tarifasp_con_desc  = 777, --round(nvl(tarifasp_con_desc,0) * getrate_con_ajuste / v_suma_get_rate,2),
tot_linea_sin_desc = round(v_tot_spots * (tarifasp_sin_desc::numeric * getrate_con_ajuste / v_suma_get_rate),2),
tot_linea_con_desc = round(v_tot_spots * (coalesce(tarifasp_con_desc,0) * getrate_con_ajuste / v_suma_get_rate),2),
division_montos    = 1
where  id_solicitud in (select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = (select id_request
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_sol_ref
)
)
and nullif(division_montos::text, '') is null
--                             and (select count(getrate_sin_ajuste)
--                                    from xxmor_solicitudes_enc_tab e,
--                                             xxmor_solicitudes_det_tab d
--                                    where e.id_solicitud = d.id_solicitud
--                                    and e.id_solicitud in ( select id_solicitud
--                                                                    from  xxmor_solicitudes_enc_tab
--                                                                    where id_request = (select id_request
--                                                                                                       from xxmor_solicitudes_enc_tab
--                                                                                                       where id_solicitud = p_id_sol_ref))
--                                    and linea = p_linea )
--                                    =
--                                    (select count(agrupador_multiple) as agrupadormultiple
--                                    from xxmor_cat_agrupador_mult_tab
--                                    where agrupador_multiple = (select agrupador
--                                                                                     from  xxmor.xxmor_solicitudes_enc_tab
--                                                                                     where id_solicitud = p_id_sol_ref) )
and linea           = p_linea;
else
--si la linea es tarifa normal
update xxmor_solicitudes_det_tab
set    tarifasp_sin_desc  = round((getrate_sin_ajuste  * getrate_con_ajuste / v_suma_get_rate)::numeric,2),
tarifasp_con_desc  = round((coalesce(getrate_sin_ajuste ,0) * getrate_con_ajuste / v_suma_get_rate)::numeric,2),
tot_linea_sin_desc = round(v_tot_spots * (getrate_sin_ajuste  * getrate_con_ajuste / v_suma_get_rate),2),
tot_linea_con_desc = round(v_tot_spots * (coalesce(getrate_sin_ajuste ,0) * getrate_con_ajuste / v_suma_get_rate),2),
division_montos    = 1
where --id_solicitud = p_id_solicitud  --p_id_sol_ref
id_solicitud in (select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = (select id_request
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_sol_ref
)
)
and nullif(division_montos::text, '') is null
and linea           = p_linea;
end if;
end if;
end if;
end if;
-- end if;
/* commit; */
end;
$body$
language plpgsql
;
