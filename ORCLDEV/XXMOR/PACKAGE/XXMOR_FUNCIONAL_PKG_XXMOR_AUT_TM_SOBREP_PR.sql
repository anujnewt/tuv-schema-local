create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_aut_tm_sobrep_pr ( p_id_solicitud integer, p_linea integer, p_tipo_aut varchar, p_rate numeric, p_aux varchar, p_det_concom varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_solicitud               xxmor_funcional_pkg_xxmor_funcional_pkg_mor_enc_rec_type;
v_rtcrd                   varchar(50);
v_rtcrd_ca                integer;  --para saber si el rtcrd es de ca
v_res                     varchar(20);
v_tipo_aut                varchar(2);
v_tarifasp_sin_desc       numeric;
v_tarifasp_con_desc       numeric;
v_tolerancia              numeric;
v_lim_sup                 numeric;
v_lim_inf                 numeric;
v_sobrecargo              varchar(50) := null;
v_errores                 integer;
v_rate                    numeric;
v_rate_adj                numeric;
v_en_rango                varchar(5);
v_aut_aut                 integer;
v_created_by              varchar(100);
v_email                   varchar(100);
v_id_fza_ventas           integer;
v_get_rate_from           varchar(5);
v_agrupador_mult          integer;
v_sum_tarifasp_sin_desc   numeric;
v_monto_div               integer:=0; --si una ord es de agr multiple para saber si ya se dividio
v_currva_rc               integer;        --para actualizar rpta concom en caso de agrupador multiple
lin_enc_paradigm          integer;
lst_estatus_orduni        varchar(2) := null;
lin_monto_con_desc        numeric := 0;
lin_spots_linea           numeric := 0;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select coalesce(get_rate,'SP'),
xxmor_funcional_pkg_xxmor_rtcrd_ca_fun(p_id_solicitud)
into strict   v_get_rate_from,
v_rtcrd_ca
from   xxmor_fzas_vtas_tab
where  id_fza_ventas = (select id_fza_ventas
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
);/* dmap converted statement start */
perform dbms_output.put_line(  concat('V_GET_RATE_FROM = ', v_get_rate_from)) ;/* dmap converted statement end */
if nullif(p_linea::text, '') is not null then
---sobrecargo y tarifas
select d.sobrecargo,
d.tarifasp_sin_desc,
d.tarifasp_con_desc
into strict   v_sobrecargo,
v_tarifasp_sin_desc,
v_tarifasp_con_desc
from   xxmor_solicitudes_det_tab d
where  d.id_solicitud = p_id_solicitud
and    d.linea        = p_linea;
end if;
--revisamos que tipo de autorizacion de tarifa manual tiene que generar
if v_get_rate_from = 'WS' and v_rtcrd_ca > 0 then
v_get_rate_from := 'WS';
else
v_get_rate_from := 'SP';
end if;
if p_tipo_aut != 'CPS' then
if v_get_rate_from = 'SP' then
--v_rate := p_rate/100;
--v_rate_adj := trunc(to_number(p_aux)/100::numeric, 2); -- se modifico 30may2013 pues recibe valor con letras
if nullif(v_tarifasp_sin_desc::text, '') is null or v_tarifasp_sin_desc = 0 then
v_rate := p_rate/100;
else
if p_rate = 0 then
v_rate := p_rate;
else
select tarifasp_sin_desc
into strict   v_rate
from   xxmor_solicitudes_det_tab d
where  id_solicitud = p_id_solicitud
and    linea        = p_linea;
end if;
end if;
if nullif(p_aux::text, '') is not null then
select trunc(v_rate*(1+((trim(both replace(replace(upper(coalesce(p_aux,'0')), 'DESC. ', '-'), '%', '')))::numeric /100)),2)
into strict   v_rate_adj
;
end if;
else
if nullif(v_sobrecargo::text, '') is not null then
select trunc(p_rate*(1+((trim(both replace(replace(upper(coalesce(v_sobrecargo,'0')), 'DESC. ', '-'), '%', '')))::numeric /100)),2)
into strict   v_rate_adj
;
--v_rate_adj := trunc(p_rate*(1+(v_sobrecargo/100)),2);
end if;
--el p_rate proviene del ws, si proviene de una orden de agrupador multiple revisar si hay que actualizar el monto
select count(agrupador_multiple)
into strict   v_agrupador_mult
from   xxmor_cat_agrupador_mult_tab
where  agrupador_multiple = (select plataforma_canal
from xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud
);
-- si aparte la orden proviene de un agrupador multiple revisar la suma de las lineas hermanas
if v_agrupador_mult > 1 then
/* select sum(tarifasp_sin_desc)
into v_sum_tarifasp_sin_desc
from xxmor_solicitudes_det_tab d
where id_solicitud in (select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = (select id_request
from xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud));*/
select coalesce(division_montos,0)
into strict   v_monto_div
from   xxmor_solicitudes_det_tab d
where  id_solicitud = p_id_solicitud
and    linea        = p_linea;
-- si la suma de las lineas hermanas es igual a lo que trae el p_rate, es porque ya se actualizaron
--if v_sum_tarifasp_sin_desc = p_rate then
-- si monto_div = 1 , es porque ya se actualizaron
if v_monto_div = 1 then
--se usa el monto de la linea
select tarifasp_sin_desc
into strict v_rate
from xxmor_solicitudes_det_tab d
where id_solicitud = p_id_solicitud
and linea          = p_linea;
else
--si no pues se usa el p_rate que trae como parametro de entrada
if nullif(v_tarifasp_sin_desc::text, '') is null or v_tarifasp_sin_desc = 0 then
v_rate := p_rate;
else
select tarifasp_sin_desc
into strict   v_rate
from   xxmor_solicitudes_det_tab d
where  id_solicitud = p_id_solicitud
and    linea        = p_linea;
end if;
end if;
else
--si no es agrupador multiple tambien se utiliza el parametro de entrada
v_rate := p_rate;
end if;
end if;
else
--se trata de una autorizacion de cps
v_rate := p_rate;
end if;
--este trunc porque a veces el super getrate lanza como mil decimales
v_rate := trunc(v_rate,2);
select count(0)
into strict   v_errores
from   xxmor_concom_rpta_tab
where  estatus_orduni             = '10'
and    upper(resultadogeneral)   != upper('Autorizacion')
and    id_solicitud               = p_id_solicitud
and    (numlinea_concom)::numeric  = p_linea;
-- se verifica si si el campo autorizacion
-- sin ratecard automatica esta seleccionado.
select coalesce(fv.rtcrd_auth_aut,0)
into strict   v_aut_aut
from   xxmor_solicitudes_enc_tab e,
xxmor_fzas_vtas_tab       fv
where  e.id_fza_ventas = fv.id_fza_ventas
and    e.id_seg_neg    = fv.id_seg_neg
and    e.id_solicitud  = p_id_solicitud;/* dmap converted statement start */
if position('TM' in p_tipo_aut) > 0 then
perform dbms_output.put_line(  concat('p_tipo_aut', p_tipo_aut)) ;/* dmap converted statement end */
if nullif(v_rate_adj::text, '') is not null then
update xxmor_solicitudes_det_tab
set    getrate_sin_ajuste = v_rate,
getrate_con_ajuste = v_rate_adj where ctid in (select ctid from xxmor_solicitudes_det_tab where id_solicitud    = p_id_solicitud
and    linea           = p_linea
and    nullif(division_montos::text, '') is null;
else
if v_rtcrd_ca = 1 and v_agrupador_mult > 1 then
update xxmor_solicitudes_det_tab
set    getrate_sin_ajuste = p_rate
where  id_solicitud    = p_id_solicitud
and    linea           =  p_linea
and    nullif(division_montos::text, '') is null;
else
update xxmor_solicitudes_det_tab
set    getrate_sin_ajuste = v_rate
where  id_solicitud    = p_id_solicitud
and    linea           = p_linea
and    nullif(division_montos::text, '') is null;
end if;
end if;
--se calcula la tolerancia
--15-enero-2013 se cambia el capo rtcrd por el rtcrddscr como parametro para saber si se genera axtm
select e.rtcrddscr,
aut_tolerancia,
case when v_rtcrd_ca = 1 and v_agrupador_mult > 1 then
p_rate- (coalesce(aut_tolerancia,0))
else v_rate- (coalesce(aut_tolerancia,0)) end,
case when v_rtcrd_ca = 1 and v_agrupador_mult > 1 then
p_rate+(coalesce(aut_tolerancia,0))
else v_rate+(coalesce(aut_tolerancia,0)) end
into strict   v_rtcrd,
v_tolerancia,
v_lim_inf,
v_lim_sup
from   xxmor_solicitudes_enc_tab e,
xxmor_fzas_vtas_tab       fv
where  e.id_solicitud  = p_id_solicitud
and    e.id_fza_ventas = fv.id_fza_ventas;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_SOBRECARGO', v_sobrecargo, ' V_TARIFASP_SIN_DESC, ' , v_tarifasp_sin_desc, 'V_TARIFASP_CON_DESC ' , v_tarifasp_con_desc)  );/* dmap converted statement end */
perform dbms_output.put_line(v_rtcrd);
if nullif(v_rtcrd::text, '') is not null then  --tiene rate card
perform dbms_output.put_line('con ratecard');
-- se obtienes los valores del monto con descuento y numero de lineas
begin
select (case
when nullif(sobrecargo::text, '') is not null then (v_rate * xxmor_funcional_pkg_xxmor_desc_mcontid_fun(id_solicitud)) *
(case
when abs((trim(both replace(replace(upper(coalesce(sobrecargo,'0')), 'DESC. ', '-'), '%', '')))::numeric ) < 1 then (1 + (trim(both replace(replace(upper(coalesce(sobrecargo,'0')), 'DESC. ', '-'), '%', '')))::numeric )
else
(1 + ((trim(both replace(replace(upper(coalesce(sobrecargo,'0')), 'DESC. ', '-'), '%', '')))::numeric /100))
end)
else (v_rate * xxmor_funcional_pkg_xxmor_desc_mcontid_fun(id_solicitud))
end) monto_desc_sob,
xxmor_funcional_pkg_xxmor_sol_totales_fun(p_id_solicitud, p_linea, 'SP_X_L')
into strict   lin_monto_con_desc,
lin_spots_linea
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
and    linea        = p_linea;
exception
when no_data_found then
lin_monto_con_desc := 0;
lin_spots_linea    := 0;
when others then
lin_monto_con_desc := 0;
lin_spots_linea    := 0;
end;/* dmap converted statement start */
if v_get_rate_from = 'SP' then
if v_lim_inf <= v_tarifasp_sin_desc and v_tarifasp_sin_desc <= v_lim_sup then   --tiene rate card y esta dentro del rango
--tiene ratecard esta en el rango y tiene sobrecargo
if nullif(v_sobrecargo::text, '') is not null then
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid, desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni, created_date,
created_by
)
select e.id_solicitud, id_seg_neg, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null, linea, 'ERROR','SOBRECARGO',
concat('AUTORIZACION - SOBRECARGO.- Verificar Ajuste Variable Contrato (', d.sobrecargo, ') de la linea con tarifa ', to_char(d.getrate_sin_ajuste,'9999999999999.00'), ' quedando en ' , to_char(d.getrate_con_ajuste,'99999999999.99')) , 'AUTORIZACION', null,'10', clock_timestamp(),
'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = p_id_solicitud
and    e.id_solicitud = d.id_solicitud
and    d.linea        = p_linea
and    nullif(e.rtcrddscr::text, '') is not null
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud         = d.id_solicitud
and    c.numlinea_concom      = d.linea
and    nullif(c.numlinea_concom::text, '') is not null
and    upper(c.accion_concom) = 'RECHAZO'
and    (d.linea)::numeric      = (c.numlinea_concom)::numeric
)
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud             = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is not null
and    campo_concom               = 'SOBRECARGO'
and    (numlinea_concom)::numeric  = d.linea
);/* dmap converted statement end */
end if;
perform dbms_output.put_line('tarifa sp sin desc entre lim sup e inf');
else --tiene rate card no esta en el rango
if nullif(v_sobrecargo::text, '') is null then --tiene rate card no esta en el rango y no tiene sobrecargo
perform dbms_output.put_line('CON RATECARD Y FUERA DE LOS LIMITES Y SIN SOBRECARGO');/* dmap converted statement start */
if v_get_rate_from = 'SP' then
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid,   desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni, created_date,
created_by
)
select e.id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null,linea, 'ERROR','TARIFA_MANUAL',
concat('AUTORIZACION - Tarifa Manual.- La tarifa de la linea ', to_char(d.tarifasp_sin_desc,'9999999999999.00'), ' no corresponde con la tarifa de sistema ' , to_char(d.getrate_sin_ajuste,'9999999999999.00')) , 'AUTORIZACION', null,'10', clock_timestamp(),
'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = p_id_solicitud
and    e.id_solicitud = d.id_solicitud
and    d.linea        = p_linea
and    nullif(e.rtcrddscr::text, '') is not null
and    nullif(d.division_montos::text, '') is null
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud         = d.id_solicitud
and    c.numlinea_concom      = d.linea
and    nullif(c.numlinea_concom::text, '') is not null
and    upper(c.accion_concom) = 'RECHAZO'
and    (d.linea)::numeric      = (c.numlinea_concom)::numeric
)
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud             = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is not null
and    campo_concom               = 'TARIFA_MANUAL'
and    (numlinea_concom)::numeric  = d.linea
);/* dmap converted statement end */
else
update xxmor_solicitudes_det_tab
set    tarifasp_sin_desc  = v_rate,
tarifasp_con_desc  = trunc(lin_monto_con_desc,2),
tot_linea_sin_desc = trunc((v_rate * lin_spots_linea),2),
tot_linea_con_desc = trunc((lin_monto_con_desc * lin_spots_linea),2)
where  id_solicitud    = p_id_solicitud
and    linea           = p_linea
and    nullif(division_montos::text, '') is null;
end if;
else --tiene rate card no esta en el rango y tiene sobrecargo
perform dbms_output.put_line('-CON RATECARD Y FUERA DE LOS LIMITES Y CON SOBRECARGO');
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid,   desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni, created_date,
created_by
)
select e.id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null, linea, 'ERROR','SOBRECARGO',
'RECHAZO - La linea contiene Tarifa Manual y Sobrecargo lo cual no esta permitido' , 'RECHAZO', null,'10', clock_timestamp(),
'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = p_id_solicitud
and    e.id_solicitud = d.id_solicitud
and    d.linea        = p_linea
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud             = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is not null
and    campo_concom               = 'SOBRECARGO'
and    (numlinea_concom)::numeric  = d.linea
);
end if;
end if;/* dmap converted statement start */
elsif v_get_rate_from = 'WS' then
--tiene ratecard y tiene sobrecargo se rechaza --verificar con tavo 16-04-2013
if nullif(v_sobrecargo::text, '') is not null then
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid,   desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni, created_date,
created_by
)
select e.id_solicitud, id_seg_neg, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null, linea, 'ERROR','SOBRECARGO',
concat('AUTORIZACION - SOBRECARGO.- Verificar Ajuste Variable Contrato (', d.sobrecargo, ') de la linea con tarifa ', to_char(d.getrate_sin_ajuste,'9999999999999.00'), ' quedando en ' , to_char(d.getrate_con_ajuste,'99999999999.99')) , 'AUTORIZACION', null,'10', clock_timestamp(),
'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = p_id_solicitud
and    e.id_solicitud = d.id_solicitud
and    d.linea        = p_linea
and    nullif(e.rtcrddscr::text, '') is not null
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud         = d.id_solicitud
and    c.numlinea_concom      = d.linea
and    nullif(c.numlinea_concom::text, '') is not null
and    upper(c.accion_concom) = 'RECHAZO'
and    (d.linea)::numeric      = (c.numlinea_concom)::numeric
)
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud             = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is not null
and    campo_concom               = 'SOBRECARGO'
and    (numlinea_concom)::numeric  = d.linea
);/* dmap converted statement end */
-- se actualizan montos
update xxmor_solicitudes_det_tab
set    tarifasp_sin_desc  = v_rate,
tarifasp_con_desc  = trunc(lin_monto_con_desc,2),
tot_linea_sin_desc = trunc((v_rate * lin_spots_linea),2),
tot_linea_con_desc = trunc((lin_monto_con_desc * lin_spots_linea),2)
where  id_solicitud    = p_id_solicitud
and    linea           = p_linea
and    nullif(division_montos::text, '') is null;
else
--la orden es de agrupador multiple
if v_agrupador_mult > 1 then
perform dbms_output.put_line('la orden es de agrupador multiple');
-- si es de ca, agrupador multiple y la tarifa linea = 0 o null
if nullif(v_tarifasp_sin_desc::text, '') is null or v_tarifasp_sin_desc = 0 then
update xxmor_solicitudes_det_tab
set    tarifasp_sin_desc  = v_rate,
tarifasp_con_desc  = trunc(lin_monto_con_desc,2),
tot_linea_sin_desc = trunc((v_rate * lin_spots_linea),2),
tot_linea_con_desc = trunc((lin_monto_con_desc * lin_spots_linea),2)
where  id_solicitud    = p_id_solicitud
and    linea           = p_linea
and    nullif(division_montos::text, '') is null;/* dmap converted statement start */
else
--tiene rate card y tarifa de la linea != 0 verificar que este dentro del rango
if v_lim_inf <= v_tarifasp_sin_desc and v_tarifasp_sin_desc <= v_lim_sup then
perform dbms_output.put_line( concat(' la tarifa esta dentro de los limites V_LIM_INF:', v_lim_inf, '  V_LIM_SUP:', v_lim_sup, ' V_TARIFASP_SIN_DESC: ', v_tarifasp_sin_desc)  );/* dmap converted statement end */
update xxmor_solicitudes_det_tab
set    tarifasp_sin_desc  = v_rate,
tarifasp_con_desc  = trunc(lin_monto_con_desc,2),
tot_linea_sin_desc = trunc((v_rate * lin_spots_linea),2),
tot_linea_con_desc = trunc((lin_monto_con_desc * lin_spots_linea),2)
where  id_solicitud    = p_id_solicitud
and    linea           = p_linea
and    nullif(division_montos::text, '') is null;
else
perform dbms_output.put_line('tarifa sp sobrepasa la tolerancia');/* dmap converted statement start */
--si no esta dentro del rango entonces se manda a generar una autorizacion de tm
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid,   desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni, created_date,
created_by
)
select e.id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null,linea, 'ERROR','TARIFA_MANUAL',
concat('AUTORIZACION - Tarifa Manual.- La tarifa de la linea ', to_char(d.tarifasp_sin_desc,'9999999999999.00'), ' no corresponde con la tarifa de sistema ' , to_char(d.getrate_sin_ajuste,'9999999999999.00')) , 'AUTORIZACION', null,'10', clock_timestamp(),
'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud    = p_id_solicitud
and    e.id_solicitud    = d.id_solicitud
and    d.linea           = p_linea
and    nullif(d.division_montos::text, '') is null
and    nullif(e.rtcrddscr::text, '') is not null
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud         = d.id_solicitud
and    c.numlinea_concom      = d.linea
and    nullif(c.numlinea_concom::text, '') is not null
and    upper(c.accion_concom) = 'RECHAZO'
and    (d.linea)::numeric      = (c.numlinea_concom)::numeric
)
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud             = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is not null
and    campo_concom               = 'TARIFA_MANUAL'
and    (numlinea_concom)::numeric  = d.linea
);/* dmap converted statement end */
if found then
select currval('xxmor_id_rpta_concom_sq')
into strict   v_currva_rc
;
---si alguna hermana ya fue autorizada cambiar el estatus a autorizada
update xxmor_concom_rpta_tab
set    estatus_orduni = '20'
where  id_rpta_concom = v_currva_rc
and    (select count(1)
from   xxmor_concom_rpta_tab c
where  c.id_solicitud in (select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = (select id_request
from   xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud
)
)
and    nullif(c.numlinea_concom::text, '') is not null
and    campo_concom               = 'TARIFA_MANUAL'
and    (numlinea_concom)::numeric  = p_linea
and    estatus_orduni             = '20'
)              > 0;
end if;
end if;
end if;
else
-- la orden no es de agrupador multiple
perform dbms_output.put_line('como V_GET_RATE_FROM = WS entonces solo se actualiza el valor de los totales y tarifa');
update xxmor_solicitudes_det_tab
set    tarifasp_sin_desc  = v_rate,
tarifasp_con_desc  = trunc(lin_monto_con_desc,2),
tot_linea_sin_desc = trunc((v_rate * lin_spots_linea),2),
tot_linea_con_desc = trunc((lin_monto_con_desc * lin_spots_linea),2)
where  id_solicitud    = p_id_solicitud
and    linea           = p_linea
and    nullif(division_montos::text, '') is null;
end if;
end if;
end if;
else  --no tiene rate card
if v_get_rate_from = 'WS' then
perform dbms_output.put_line('el rtcrd es de CA/Plan comercial');
if nullif(v_sobrecargo::text, '') is not null then  -- la orden es de plan comercial (se tarifica con el ws) no tiene ratecard y con sobrecargo, se rechaza!!!
--si la linea no tiene ratecard pero si sobrecargo entonces se rechaza
perform dbms_output.put_line('LA ORDEN ES DE PLAN COMERCIAL NO TIENE RATECARD  ');
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid,   desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni, created_date,
created_by
)
select e.id_solicitud, id_seg_neg, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null,linea, 'ERROR','SOBRECARGO',
'RECHAZO - La linea contiene Tarifa Manual y Sobrecargo lo cual no esta permitido', 'RECHAZO', null,'10', clock_timestamp(),
'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = p_id_solicitud
and    e.id_solicitud = d.id_solicitud
and    d.linea        = p_linea
and    nullif(e.rtcrddscr::text, '') is null;
else
perform dbms_output.put_line('tarifa sp sin desc entre lim sup e inf y no es nulo');/* dmap converted statement start */
--la orden es de plan comercial (se tarifica con el ws) no tiene ratecard y no tiene sobrecargo
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid,   desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni, created_date,
created_by
)
select e.id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null,linea, 'ERROR','TARIFA_MANUAL',
concat('AUTORIZACION - Tarifa Manual.- La tarifa de la linea ', to_char(d.tarifasp_sin_desc,'9999999999999.00'), ' no corresponde con la tarifa de sistema ' , to_char(d.getrate_sin_ajuste,'9999999999999.00')) , 'AUTORIZACION', null,'10', clock_timestamp(),
'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud    = p_id_solicitud
and    e.id_solicitud    = d.id_solicitud
and    d.linea           = p_linea
and    nullif(d.division_montos::text, '') is null
and    nullif(e.rtcrddscr::text, '') is not null
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud         = d.id_solicitud
and    c.numlinea_concom      = d.linea
and    nullif(c.numlinea_concom::text, '') is not null
and    upper(c.accion_concom) = 'RECHAZO'
and    (d.linea)::numeric      = (c.numlinea_concom)::numeric
)
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud             = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is not null
and    campo_concom               = 'TARIFA_MANUAL'
and    (numlinea_concom)::numeric  = d.linea
);/* dmap converted statement end */
end if;
elsif  v_get_rate_from = 'SP' then
if nullif(v_sobrecargo::text, '') is not null then  --sin ratecard y fuera de los limites y con sobrecargo
--si la linea no tiene ratecard pero si sobrecargo entonces se rechaza
perform dbms_output.put_line('LA ORDEN ES DE PLAN COMERCIAL NO TIENE RATECARD  ');
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid,   desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni, created_date,
created_by
)
select e.id_solicitud, id_seg_neg, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null,linea, 'ERROR','SOBRECARGO',
'RECHAZO - La linea contiene Tarifa Manual y Sobrecargo lo cual no esta permitido', 'RECHAZO', null,'10', clock_timestamp(),
'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = p_id_solicitud
and    e.id_solicitud = d.id_solicitud
and    d.linea        = p_linea
and    nullif(e.rtcrddscr::text, '') is null;
--elsif v_lim_inf <= v_tarifasp_sin_desc and v_tarifasp_sin_desc <= v_lim_sup then
--    null;
else --sin ratecard y fuera de los limites y sin sobrecargo
perform dbms_output.put_line('SIN RATECARD Y FUERA DE LOS LIMITES Y SIN SOBRECARGO');
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid,   desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni, created_date,
created_by
)
select e.id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null, linea, 'ERROR','TARIFA_MANUAL',
'AUTORIZACION - Tarifa Manual.- La orden no tiene Ratecard', 'AUTORIZACION', null, '10', clock_timestamp(),
'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud    = p_id_solicitud
and    e.id_solicitud    = d.id_solicitud
and    d.linea           = p_linea
and    nullif(e.rtcrddscr::text, '') is null
and    nullif(d.division_montos::text, '') is null
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud         = d.id_solicitud
and    c.numlinea_concom      = d.linea
and    nullif(c.numlinea_concom::text, '') is not null
and    upper(c.accion_concom) = 'RECHAZO'
and    (d.linea)::numeric      = (c.numlinea_concom)::numeric
)
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud             = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is not null
and    campo_concom               = 'TARIFA_MANUAL'
and    (numlinea_concom)::numeric  = d.linea
);
-- se autorizan de manera automatica si el campo autorizacion
-- sin ratecard automatica esta seleccionado.
if v_aut_aut = 1 then
update xxmor_concom_rpta_tab
set    estatus_orduni = '20',
updated_date   = clock_timestamp(),
updated_by     = 'ORDUNI2'
where  id_solicitud               = p_id_solicitud
and    accion_concom              = 'AUTORIZACION'
and    (numlinea_concom)::numeric  = p_linea
and    campo_concom               = 'TARIFA_MANUAL'
and    estatus_orduni             = '10';
end if;
end if;
end if;
end if;
end if;
begin
--revisamos si la orden es urgente
call xxmor_funcional_pkg_xxmor_aut_urgente_fun(p_id_solicitud, null);
--revisamos q si es de mkt cumpla con los requisitos del buyunit y coordinador
call xxmor_funcional_pkg_xxmor_revisar_buyunitmkt_pr(currval('xxmor_id_solicitud_sq'));
exception
when others then
null;
end;
begin
call xxmor_funcional_pkg_xxmor_aut_openlog_fun(p_id_solicitud, null, v_res);
exception
when others then
null;
end;
----------------
-- se revisa si el encabezado ya fue insertado en paradigm, pues de ser asi
-- ya no se generan las autorizaciones de cps ni credito corporativo.
select count(1)
into strict   lin_enc_paradigm
from   xxmor_solicitudes_est_rep_tab
where  linea            = 0
and    nullif(estat_id_foraneo::text, '') is not null
and    id_solicitud     = p_id_solicitud;
if p_tipo_aut = 'CPS' then
select xxmor_funcional_pkg_xxmor_sol_totales_fun(p_id_solicitud, null, 'TCDSC_X_O')
into strict   v_tarifasp_con_desc
;
perform dbms_output.put_line('tipo cps');/* dmap converted statement start */
perform dbms_output.put_line( concat('total_orden:', v_tarifasp_con_desc , ' MONTO_CPS:', p_rate)  );/* dmap converted statement end *//* dmap converted statement start */
if v_tarifasp_con_desc > p_rate  then
if lin_enc_paradigm = 0 then
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid, desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni, created_date,
created_by
)
select e.id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), '',
'ENCABEZADO', null,null, 'ERROR','CPS',
concat('AUTORIZACION - El total del cps es: ', p_rate, ' Total de la orden con descuento: ', v_tarifasp_con_desc) , 'AUTORIZACION', null, '10', clock_timestamp(),
'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = p_id_solicitud
and    e.id_solicitud = d.id_solicitud
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud         = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is null
and    upper(c.accion_concom) = 'RECHAZO'
)
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud    = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is null
and    c.campo_concom    = 'CPS'
) limit 1);/* dmap converted statement end */
/* commit; */
end if;
end if;
-- para generar las autorizaciones de tarifa manual por no traer ratecard
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid, desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni, created_date,
created_by
)
select e.id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null, linea, 'ERROR','TARIFA_MANUAL',
'AUTORIZACION - Tarifa Manual.- La orden no tiene Ratecard', 'AUTORIZACION', null, '10', clock_timestamp(),
'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = p_id_solicitud
and    nullif(e.rtcrddscr::text, '') is null
and    e.id_solicitud = d.id_solicitud
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud         = d.id_solicitud
and    c.numlinea_concom      = d.linea
and    nullif(c.numlinea_concom::text, '') is not null
and    upper(c.accion_concom) = 'RECHAZO'
and    (d.linea)::numeric      = (c.numlinea_concom)::numeric
)
and not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud               = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is not null
and    c.campo_concom               = 'TARIFA_MANUAL'
and    (c.numlinea_concom)::numeric  = d.linea
);
-- se autorizan de manera automatica si el campo autorizacion
-- sin ratecard automatica esta seleccionado.
if v_aut_aut = 1 then
update xxmor_concom_rpta_tab
set    estatus_orduni = '20',
updated_date   = clock_timestamp(),
updated_by     = 'ORDUNI2' where ctid in (select ctid from xxmor_concom_rpta_tab where id_solicitud               = p_id_solicitud
and    accion_concom              = 'AUTORIZACION'
and    campo_concom               = 'TARIFA_MANUAL'
and    estatus_orduni             = '10';
end if;
elsif oracle.substr(p_tipo_aut,1,8) = 'CREDCORP' then
perform dbms_output.put_line('tipo Credito Corp');
select xxmor_funcional_pkg_xxmor_sol_totales_fun(p_id_solicitud, null, 'TCD_X_O')
into strict   v_tarifasp_con_desc
;
if p_tipo_aut = 'CREDCORP10' then
lst_estatus_orduni := '10';
else
lst_estatus_orduni := '20';
end if;
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid,   desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni,
created_date, created_by
)
select e.id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), '',
'ENCABEZADO', null, null, 'ERROR','CRED_CORP',
p_det_concom, 'AUTORIZACION', null, lst_estatus_orduni,
clock_timestamp(), 'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = p_id_solicitud
and    e.id_solicitud = d.id_solicitud
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud         = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is null
and    upper(c.accion_concom) = 'RECHAZO'
)
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud    = e.id_solicitud
and    nullif(c.numlinea_concom::text, '') is null
and    c.campo_concom    = 'CRED_CORP'
) limit 1);
/* commit; */
end if;end;
$body$
language plpgsql
;
