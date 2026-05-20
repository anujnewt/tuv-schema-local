create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_generaordenes_pr ( p_id_request_aux numeric ) as $body$
declare
rec_pref record;
-- pgv moved types start
-- pgv moved types end
v_mcontid             varchar(30);
v_mcontid_ci          varchar(30);
v_mul_fzas            numeric(2);
v_cutin               numeric(2);
v_facturable          varchar(12);
v_agrupador           varchar(30);
v_region              varchar(2);
v_sufijo              varchar(2);
v_segneg              numeric(2);
v_request_aux         integer;
p_id_request          integer;
v_id_solicitud_temp   integer;
v_temp                numeric(30);
v_agrupa              integer;
v_existe              integer;
v_usrchr              varchar(5);
v_sptchr              varchar(5);
v_desc_t_serv         varchar(50);
v_tipo_servicio       varchar(100);
v_aux                 varchar(100);
v_mc_ing_cutin        varchar(30);      --<-- el mastercontract de la derecha
v_spt_5               integer:=0;
v_spt_1               integer:=0;
v_prefijo_stnid       varchar(5);       --<hasta aca con mcontid de la derecha
v_rtcrd               varchar(50);      --> para gen aut tarifa manual sin rtcrd
--v_ord_mkt               pls_integer;
v_solicitud_enc       xxmor_funcional_pkg_xxmor_funcional_pkg_mor_enc_rec_type;
v_id_solicitud_nal    numeric;
v_id_solicitud_prov   numeric;
lst_nom_archivo       varchar(150);
lst_inserta           varchar(1);
lst_orden_mcing       varchar(1);
lst_orden_mc          varchar(1);
lin_numregs_orig      numeric := 0;
lin_numregs_det       numeric := 0;
ordenes cursor for
select id_request
from   xxmor_solicitudes_orig_enc_tab
where  aux1 = p_id_request_aux;
cur_prefijos cursor(p_i_id_request integer) for
select prefijo_canal,
agrupador_multiple
from   xxmor_cat_agrupador_mult_tab
where  agrupador_multiple = (select trim(both plataforma_canal)
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_i_id_request
);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
open ordenes;
loop
fetch ordenes into p_id_request;
exit when not found; /* apply on ordenes */
select trim(both oe.mcontid),
trim(both oe.mcontid_cutin),
trim(both oe.plataforma_canal),
trim(both oe.id_seg_neg),
(select sa.nom_archivo_sol
from   xxmor_solicitudes_arch_tab sa
where  sa.id_seg_neg     = 1
and    sa.id_archivo_sol = oe.id_archivo_sol
)
into strict   v_mcontid,
v_mcontid_ci,
v_agrupador,
v_segneg,
lst_nom_archivo
from   xxmor_solicitudes_orig_enc_tab oe
where  oe.id_request = p_id_request;
lst_inserta := null;/* dmap converted statement start */
begin
--para identificar la fza de ventas, solo se utiliza el tipo de servicio de la primera orden
select rtrim(tipo_servicio::text)
into strict   v_tipo_servicio
from   xxmor.xxmor_solicitudes_orig_det_tab
where  id_request    = p_id_request
and    linea_request = 1;/* dmap converted statement end */
exception
when no_data_found then
lst_inserta := 'N';
v_tipo_servicio := null;
when others then
v_tipo_servicio := 'NA';
end;
if length(v_tipo_servicio) = 2 then
lst_inserta := 'Y';
begin
select usr_chr,
spt_chr,
desc_tipo_servicio
into strict   v_usrchr,
v_sptchr,
v_tipo_servicio
from   xxmor.xxmor_cat_tipo_serv_tab
where  coalesce(usr_chr,' ') = oracle.substr(v_tipo_servicio,1,1)
and    spt_chr          = oracle.substr(v_tipo_servicio,2,1);
exception
when others then
v_usrchr := 'XX';
v_sptchr := 'XX';/* dmap converted statement start */
-- se inserta en la tabla de errores el error encontrado
insert into xxmor_log_errores_tab(
id_error,
desc_error,
archivo_error,
metodo_error,
hora_error
)
values (       nextval('xxmor.xxmor_log_error_sq'),
concat('Error al procesar el archivo: ', lst_nom_archivo, ', El Valor del Campo Tipo de Servicio ', v_tipo_servicio, ' No es Valido') ,
'XXMOR_FUNCIONAL_PKG',
'XXMOR_GENERAORDENES_PR',
clock_timestamp()
);/* dmap converted statement end */
end;/* dmap converted statement start */
perform dbms_output.put_line( concat(' -> USR_CHR', ' ->', v_usrchr, '<-')  );/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat(' -> V_SPTCHR ', ' ->', v_sptchr, '<-')  );/* dmap converted statement end */
if v_usrchr != 'XX' and v_sptchr != 'XX' then
--ponemos la descripcion del servicio que representan spot-usr chr
select desc_tipo_servicio
into strict   v_desc_t_serv
from   xxmor_cat_tipo_serv_tab
where  coalesce(usr_chr,' ') = coalesce(v_usrchr,' ')
and    coalesce(spt_chr,' ') = v_sptchr;
end if;
elsif length(v_tipo_servicio) > 0 then
lst_inserta := 'Y';
begin
select spt_chr,
usr_chr
into strict   v_sptchr,
v_usrchr
from   xxmor.xxmor_cat_tipo_serv_tab
where  upper(desc_tipo_servicio) = upper(v_tipo_servicio);
exception
when others then
v_usrchr := 'XX';
v_sptchr := 'XX';/* dmap converted statement start */
-- se inserta en la tabla de errores el error encontrado
insert into xxmor_log_errores_tab(
id_error,
desc_error,
archivo_error,
metodo_error,
hora_error
)
values (       nextval('xxmor.xxmor_log_error_sq'),
concat('Error al procesar el archivo: ', lst_nom_archivo, ', El Valor del Campo Tipo de Servicio ', v_tipo_servicio, ' No es Valido') ,
'XXMOR_FUNCIONAL_PKG',
'XXMOR_GENERAORDENES_PR',
clock_timestamp()
);/* dmap converted statement end */
end;
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat(' -> ', p_id_request , ' -> ', v_agrupador)  );/* dmap converted statement end */
if lst_inserta = 'Y' then
-- si las ordenes ingresadas no son de television insertar como vienen
if v_segneg != 1 then
perform dbms_output.put_line('La orden no es de television [entonces no la tomamos en cuenta]');
insert into xxmor_solicitudes_enc_tab( id_solicitud, id_request, id_seg_neg,
proc_por_linea, garantizado, advid,
mcontid, mcontid_cutin, email,
agyestnum, accthdrid, rtcrddscr,
rtcrddscr_cutin, comentarios, plataforma_canal,
prdid_desc, total_spots, total_sin_desc,
total_con_desc, tipo_facturacion, descuento,
target, created_by
)
select nextval('xxmor_id_solicitud_sq'), id_request, id_seg_neg,
proc_por_linea, garantizado, advid,
mcontid, mcontid_cutin, email,
agyestnum, accthdrid, rtcrddscr,
rtcrddscr_cutin, comentarios, plataforma_canal,
prdid_desc, total_spots, total_sin_desc,
total_con_desc, tipo_facturacion, descuento,
target, created_by
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request;
insert into xxmor_solicitudes_det_tab( id_solicitud, linea, stnid,
fecha_inicio, fecha_fin, duracion,
buyuntid, hora_inicio, hora_fin,
spots, lunes, martes, miercoles,
jueves, viernes, sabado, domingo,
spots_x_semana, tipo_servicio, bn,
p, marca, version, tarifasp_sin_desc,
tarifasp_con_desc, tot_linea_sin_desc,
tot_linea_con_desc, sobrecargo,
observaciones, des_plataforma, created_by
)
select currval('xxmor_id_solicitud_sq'), coalesce(linea_request,nextval('xxmor_linea_solicitud_sq')), stnid,
fecha_inicio, fecha_fin, duracion,
buyuntid, hora_inicio, hora_fin,
spots, lunes, martes, miercoles,
jueves, viernes, sabado, domingo,
spots_x_semana, tipo_servicio, bn,
p, marca, version, tarifasp_sin_desc,
tarifasp_con_desc, tot_linea_sin_desc,
tot_linea_con_desc, initcap(sobrecargo),
observaciones, des_plataforma,
(select created_by
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request
)
from   xxmor_solicitudes_orig_det_tab
where  id_request = p_id_request;
else -- v_segneg != 1
--revisamos q el agrupador no genere mas de una orden
select count(1)
into strict   v_existe
from   xxmor_cat_agrupador_mult_tab
where  agrupador_multiple = (select trim(both plataforma_canal)
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request
);
if v_sptchr = '5' or v_sptchr = '1' then
lst_orden_mc     := 'N';
lst_orden_mcing  := 'N';
lin_numregs_orig := 0;
lin_numregs_det  := 0;
begin
select trim(both mcontid_cutin)
into strict   v_mc_ing_cutin
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request;
--para el prefijo que tenemos que concatenar al canal
select prefijo_canal
into strict   v_prefijo_stnid
from   xxmor_cat_agrupador_mult_tab
where  agrupador_multiple = (select trim(both plataforma_canal)
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request
);
exception when others then
v_prefijo_stnid:= null;
end;
--revisamos que traiga lineas el spot characteristic = 1
select count(1)
into strict   v_spt_1
from   xxmor_solicitudes_orig_det_tab d
where  id_request = p_id_request
and    case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,2,1)
else (select spt_chr
from xxmor.xxmor_cat_tipo_serv_tab
where desc_tipo_servicio = d.tipo_servicio
)
end = 1;/* dmap converted statement start */
--para generar la orden del mastercontract de ingresos/cutin (el de la derecha)
perform dbms_output.put_line( concat('V_MC_ING_CUTIN: ', v_mc_ing_cutin)  );/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('V_SPT_1: ', v_spt_1)  );/* dmap converted statement end */
if (nullif(v_mc_ing_cutin::text, '') is not null) and (v_spt_1 > 0) then
insert into xxmor_solicitudes_enc_tab( id_solicitud, id_request, id_seg_neg,
proc_por_linea, garantizado, advid,
mcontid, mcontid_cutin, email,
agyestnum, accthdrid, rtcrddscr,
rtcrddscr_cutin, comentarios, plataforma_canal,
prdid_desc, total_spots, total_sin_desc,
total_con_desc, tipo_facturacion, descuento,
target, created_by,id_fza_ventas, orden_estatus
)
select nextval('xxmor_id_solicitud_sq'), id_request, id_seg_neg,
trim(both proc_por_linea), trim(both case when coalesce(garantizado,'0')='0' then '0'  else '1' end ), trim(both advid),
trim(both mcontid_cutin), null, trim(both email),
trim(both agyestnum), trim(both accthdrid), trim(both rtcrddscr),
trim(both rtcrddscr_cutin), oracle.substr(trim(both comentarios),1,132), trim(both plataforma_canal),
trim(both prdid_desc), trim(both total_spots), trim(both total_sin_desc),
trim(both total_con_desc), trim(both tipo_facturacion), trim(both descuento),
trim(both target), created_by, null, 10
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request;/* dmap converted statement start */
insert into xxmor_solicitudes_det_tab( id_solicitud, linea, stnid,
fecha_inicio, fecha_fin, duracion,
buyuntid, hora_inicio, hora_fin,
spots, lunes, martes, miercoles,
jueves, viernes, sabado, domingo,
spots_x_semana, tipo_servicio, usr_chr,
spot_chr, bn, p, marca, version,
tarifasp_sin_desc, tarifasp_con_desc,
tot_linea_sin_desc, tot_linea_con_desc,
sobrecargo, observaciones, des_plataforma,
linea_estatus, created_by
)
select currval('xxmor_id_solicitud_sq'), row_number() over ( order by  linea_request) num_linea,  concat(v_prefijo_stnid, coalesce(trim(both stnid),v_agrupador)) ,
trim(both fecha_inicio), trim(both fecha_fin), trim(both duracion),
trim(both buyuntid), trim(both hora_inicio), trim(both hora_fin),
trim(both spots), trim(both lunes), trim(both martes), trim(both miercoles),
trim(both jueves), trim(both viernes), trim(both sabado), trim(both domingo),
coalesce(spots_x_semana,(coalesce(trim(both lunes),0))::numeric +(coalesce(trim(both martes),0))::numeric +(coalesce(trim(both miercoles),0))::numeric +(coalesce(trim(both jueves),0))::numeric +(coalesce(trim(both viernes),0))::numeric +(coalesce(trim(both sabado),0))::numeric +(coalesce(trim(both domingo),0))::numeric ),
case when length(tipo_servicio) = 2 then (select desc_tipo_servicio
from   xxmor_cat_tipo_serv_tab
where  spt_chr           = oracle.substr(tipo_servicio,2,1)
and    coalesce(usr_chr, ' ') = oracle.substr(tipo_servicio,1,1)
)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then
upper(tipo_servicio)
else
'NO APLICA'
end
end as tipo_servicio,
case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,1,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = tipo_servicio
) > 0 then (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
)
else (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end usrchr,
case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,2,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
)
else (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end sptchr,
trim(both bn), trim(both p), trim(both marca), trim(both version), --nvl(trim(version),ver pauta),se quito para las ordenes de merca version virtual
trim(both tarifasp_sin_desc), trim(both tarifasp_con_desc),
trim(both tot_linea_sin_desc), trim(both tot_linea_con_desc),
trim(both initcap(sobrecargo)), trim(both observaciones),
trim(both des_plataforma), 10,
(select trim(both created_by)
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request
)
from   xxmor_solicitudes_orig_det_tab
where  id_request = p_id_request
and    case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,2,1)
else (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = tipo_servicio
)
end = 1;/* dmap converted statement end */
lst_orden_mcing := 'Y';
else -- no se genera la orden del mastercontract de ingresos/cutin
lst_orden_mcing := 'N';
-- se envia la notificacion de que no se pudo generar la orden
call xxmor_funcional_pkg_xxmor_notifica_fvtas_merca_pr(
'MERCA',
0,
p_id_request
);
end if;
--para ver si se genera la orden del master contract (de la izquierda)
select count(1)
into strict   v_spt_5
from   xxmor_solicitudes_orig_det_tab d
where  id_request = p_id_request
and    case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,2,1)
else (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(d.tipo_servicio)
)
end = 5;/* dmap converted statement start */
perform dbms_output.put_line( concat('v_MCONTID: ', v_mcontid)  );/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('V_SPT_5: ', v_spt_5)  );/* dmap converted statement end */
if (nullif(v_mcontid::text, '') is not null) and (v_spt_5 > 0) then
insert into xxmor_solicitudes_enc_tab( id_solicitud, id_request, id_seg_neg,
proc_por_linea, garantizado, advid,
mcontid, mcontid_cutin, email,
agyestnum, accthdrid, rtcrddscr,
rtcrddscr_cutin, comentarios, plataforma_canal,
prdid_desc, total_spots, total_sin_desc,
total_con_desc, tipo_facturacion, descuento,
target, created_by, id_fza_ventas, orden_estatus
)
select nextval('xxmor_id_solicitud_sq'), id_request, id_seg_neg,
trim(both proc_por_linea), trim(both case when coalesce(garantizado,'0')='0' then '0'  else '1' end ), trim(both advid),
trim(both mcontid), null, trim(both email),
trim(both agyestnum), trim(both accthdrid), trim(both rtcrddscr),
trim(both rtcrddscr_cutin), oracle.substr(trim(both comentarios),1,132), trim(both plataforma_canal),
trim(both prdid_desc), trim(both total_spots), trim(both total_sin_desc),
trim(both total_con_desc), trim(both tipo_facturacion), trim(both descuento),
trim(both target), created_by, null, 10
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request;/* dmap converted statement start */
insert into xxmor_solicitudes_det_tab( id_solicitud, linea, stnid,
fecha_inicio, fecha_fin, duracion,
buyuntid, hora_inicio, hora_fin,
spots, lunes, martes, miercoles,
jueves, viernes, sabado, domingo,
spots_x_semana, tipo_servicio, usr_chr,
spot_chr, bn, p, marca, version,
tarifasp_sin_desc, tarifasp_con_desc,
tot_linea_sin_desc, tot_linea_con_desc,
sobrecargo, observaciones, des_plataforma,
linea_estatus, created_by
)
select currval('xxmor_id_solicitud_sq'), row_number() over ( order by  linea_request) num_linea,  concat(v_prefijo_stnid, coalesce(trim(both stnid),v_agrupador)) ,
trim(both fecha_inicio), trim(both fecha_fin), trim(both duracion),
trim(both buyuntid), trim(both hora_inicio), trim(both hora_fin),
trim(both spots), trim(both lunes), trim(both martes), trim(both miercoles),
trim(both jueves), trim(both viernes), trim(both sabado), trim(both domingo),
coalesce(spots_x_semana,(coalesce(trim(both lunes),0))::numeric +(coalesce(trim(both martes),0))::numeric +(coalesce(trim(both miercoles),0))::numeric +(coalesce(trim(both jueves),0))::numeric +(coalesce(trim(both viernes),0))::numeric +(coalesce(trim(both sabado),0))::numeric +(coalesce(trim(both domingo),0))::numeric ),
case when length(tipo_servicio) = 2 then (select desc_tipo_servicio
from   xxmor_cat_tipo_serv_tab
where  spt_chr           = oracle.substr(tipo_servicio,2,1)
and    coalesce(usr_chr, ' ') = oracle.substr(tipo_servicio,1,1)
)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then
upper(tipo_servicio)
else
'NO APLICA'
end
end as tipo_servicio,
case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,1,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
)
else (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end usrchr,
case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,2,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
)
else (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end sptchr,
trim(both bn), trim(both p), trim(both marca), trim(both version), --nvl(trim(version),ver pauta),se quito para las ordenes de merca version virtual
trim(both tarifasp_sin_desc), trim(both tarifasp_con_desc),
trim(both tot_linea_sin_desc), trim(both tot_linea_con_desc),
trim(both initcap(sobrecargo)), trim(both observaciones),
trim(both des_plataforma), 10,
(select trim(both created_by)
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request
)
from   xxmor_solicitudes_orig_det_tab
where  id_request = p_id_request
and    case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,2,1)
else (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
)
end = 5;/* dmap converted statement end */
lst_orden_mc := 'Y';
else -- no se genera la orden la orden del master contract (de la izquierda)
lst_orden_mc := 'N';
-- se envia la notificacion de que no se pudo generar la orden
call xxmor_funcional_pkg_xxmor_notifica_fvtas_merca_pr(
'MERCA',
1,
p_id_request
);
end if;
-- se valida si es que se generaron las 2 ordenes y el numero de registros
-- es el mismo que los que venian en el archivo.
if lst_orden_mc = 'Y' and lst_orden_mcing = 'Y' then
select count(1)
into strict   lin_numregs_orig
from   xxmor_solicitudes_orig_det_tab
where  id_request = p_id_request;
select count(1)
into strict   lin_numregs_det
from   xxmor_solicitudes_det_tab sd
where  exists (select 1
from   xxmor_solicitudes_enc_tab se
where  se.id_solicitud = sd.id_solicitud
and    se.id_request   = p_id_request
);
if lin_numregs_orig > 0 and lin_numregs_det > 0 then
if lin_numregs_orig != lin_numregs_det then
-- se envia la notificacion de que las ordenes estan incompletas
call xxmor_funcional_pkg_xxmor_notifica_fvtas_merca_pr(
'MERCA',
2,
p_id_request
);
end if;
end if;
end if;
else -- v_sptchr = 5 or v_sptchr = 1
if v_existe = 0 then
if v_agrupador != 'CUTIN' then
perform dbms_output.put_line('La orden no es de multiOrden ni CUTIN');
--generamos el id_solicitud
select nextval('xxmor_id_solicitud_sq')
into strict   v_id_solicitud_temp
;
insert into xxmor_solicitudes_enc_tab( id_solicitud, id_request, id_seg_neg,
proc_por_linea, garantizado, advid,
mcontid, mcontid_cutin, email,
agyestnum, accthdrid, rtcrddscr,
rtcrddscr_cutin, comentarios, plataforma_canal,
prdid_desc, total_spots, total_sin_desc,
total_con_desc, tipo_facturacion, descuento,
target, created_by, id_fza_ventas, orden_estatus
)
select v_id_solicitud_temp, id_request, id_seg_neg,
trim(both proc_por_linea), trim(both case when coalesce(garantizado,'0')='0' then '0'  else '1' end ), trim(both advid),
trim(both mcontid), trim(both mcontid_cutin), trim(both email),
trim(both agyestnum), trim(both accthdrid), trim(both rtcrddscr),
trim(both rtcrddscr_cutin), oracle.substr(trim(both comentarios),1,132), trim(both plataforma_canal)||case when v_sptchr='XX' then '-ERTS' end ,
trim(both prdid_desc), trim(both total_spots), trim(both total_sin_desc),
trim(both total_con_desc), trim(both tipo_facturacion), trim(both descuento),
trim(both target), created_by, null, 10
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request;
insert into xxmor_solicitudes_det_tab( id_solicitud, linea, stnid,
fecha_inicio, fecha_fin, duracion,
buyuntid, hora_inicio, hora_fin,
spots, lunes, martes, miercoles,
jueves, viernes, sabado, domingo,
spots_x_semana, tipo_servicio, usr_chr,
spot_chr, bn, p, marca, version,
tarifasp_sin_desc, tarifasp_con_desc,
tot_linea_sin_desc, tot_linea_con_desc,
sobrecargo, observaciones, des_plataforma,
linea_estatus, created_by
)
select currval('xxmor_id_solicitud_sq'), row_number() over ( order by  linea_request) num_linea, coalesce(trim(both stnid),v_agrupador),
trim(both fecha_inicio), trim(both fecha_fin), trim(both duracion),
trim(both buyuntid), trim(both hora_inicio), trim(both hora_fin),
trim(both spots), trim(both lunes), trim(both martes), trim(both miercoles),
trim(both jueves), trim(both viernes), trim(both sabado), trim(both domingo),
coalesce(spots_x_semana,(coalesce(trim(both lunes),0))::numeric +(coalesce(trim(both martes),0))::numeric +(coalesce(trim(both miercoles),0))::numeric +(coalesce(trim(both jueves),0))::numeric +(coalesce(trim(both viernes),0))::numeric +(coalesce(trim(both sabado),0))::numeric +(coalesce(trim(both domingo),0))::numeric ),
case when length(tipo_servicio) = 2 then (select desc_tipo_servicio
from   xxmor_cat_tipo_serv_tab
where  spt_chr           = oracle.substr(tipo_servicio,2,1)
and    coalesce(usr_chr, ' ') = oracle.substr(tipo_servicio,1,1)
)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then
upper(tipo_servicio)
else
'NO APLICA'
end
end as tipo_servicio,
case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,1,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
)
else (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end usrchr,
case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,2,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
)
else (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end sptchr,
trim(both bn), trim(both p), trim(both marca), coalesce(trim(both version),'VER PAUTA'),
trim(both tarifasp_sin_desc), trim(both tarifasp_con_desc),
trim(both tot_linea_sin_desc), trim(both tot_linea_con_desc),
trim(both initcap(sobrecargo)), trim(both observaciones),
trim(both des_plataforma), 10,
(select trim(both created_by)
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request
)
from   xxmor_solicitudes_orig_det_tab
where  id_request = p_id_request;
else -- v_agrupador != cutin
perform dbms_output.put_line('La orden es de CUTIN');
-- se inserta la orden nacional
-- se obtiene el id de la solicitud el cual se usara para guardar como
-- el la solicitud hermana en la orden de provincia.
select nextval('xxmor_id_solicitud_sq')
into strict   v_id_solicitud_nal
;
insert into xxmor_solicitudes_enc_tab( id_solicitud, id_request, id_seg_neg,
proc_por_linea, garantizado, advid,
mcontid, mcontid_cutin, email,
agyestnum, accthdrid, rtcrddscr,
rtcrddscr_cutin, comentarios, plataforma_canal,
prdid_desc, total_spots, total_sin_desc,
total_con_desc, tipo_facturacion, descuento,
target, created_by, id_fza_ventas, orden_estatus
)
select v_id_solicitud_nal, id_request, id_seg_neg,
trim(both proc_por_linea), trim(both case when coalesce(garantizado,'0')='0' then '0'  else '1' end ), trim(both advid),
trim(both mcontid), null as mcontid_cutin, trim(both email),
trim(both agyestnum), trim(both accthdrid), trim(both rtcrddscr),
trim(both rtcrddscr_cutin), oracle.substr(trim(both comentarios),1,132), 'TVSA'||case when v_sptchr='XX' then '-ERTS' end ,
trim(both prdid_desc), trim(both total_spots), trim(both total_sin_desc),
trim(both total_con_desc), trim(both tipo_facturacion), trim(both descuento),
trim(both target), created_by, null, 10
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request;
insert into xxmor_solicitudes_det_tab( id_solicitud, linea, stnid,
fecha_inicio, fecha_fin, duracion,
buyuntid, hora_inicio, hora_fin,
spots, lunes, martes, miercoles,
jueves, viernes, sabado, domingo,
spots_x_semana, tipo_servicio, usr_chr,
spot_chr, bn, p, marca, version,
tarifasp_sin_desc, tarifasp_con_desc,
tot_linea_sin_desc, tot_linea_con_desc,
sobrecargo, observaciones, des_plataforma,
linea_estatus, created_by
)
select currval('xxmor_id_solicitud_sq'), row_number() over ( order by  linea_request) num_linea, coalesce(trim(both stnid),v_agrupador),
trim(both fecha_inicio), trim(both fecha_fin), trim(both duracion),
trim(both buyuntid), trim(both hora_inicio), trim(both hora_fin),
trim(both spots), trim(both lunes), trim(both martes), trim(both miercoles),
trim(both jueves), trim(both viernes), trim(both sabado), trim(both domingo),
trim(both spots_x_semana),
case when length(tipo_servicio) = 2 then (select desc_tipo_servicio
from   xxmor_cat_tipo_serv_tab
where  spt_chr           = oracle.substr(tipo_servicio,2,1)
and    coalesce(usr_chr, ' ') = oracle.substr(tipo_servicio,1,1)
)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then
upper(tipo_servicio)
else
'NO APLICA'
end
end as tipo_servicio,
case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,1,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
)
else (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end usrchr,
case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,2,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
)
else (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end sptchr,
trim(both bn), trim(both p), trim(both marca), coalesce(trim(both version),'VER PAUTA'),
trim(both tarifasp_sin_desc), trim(both tarifasp_con_desc),
trim(both tot_linea_sin_desc), trim(both tot_linea_con_desc),
trim(both initcap(sobrecargo)), trim(both observaciones),
trim(both des_plataforma), 10,
(select trim(both created_by)
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request
)
from   xxmor_solicitudes_orig_det_tab
where  id_request = p_id_request
and    stnid      in (select canal
from   xxmor_canales_nac_vw
);
-- se inserta la orden provincia
-- se obtiene el id de la solicitud el cual se usara para guardar como
-- el la solicitud hermana en la orden de provincia.
select nextval('xxmor_id_solicitud_sq')
into strict   v_id_solicitud_prov
;
--el master contract cuttin se pone como mconid en el caso de la orden de provincia
insert into xxmor_solicitudes_enc_tab( id_solicitud, id_request, id_seg_neg,
proc_por_linea, garantizado, advid,
mcontid, mcontid_cutin, email,
agyestnum, accthdrid, rtcrddscr,
rtcrddscr_cutin, comentarios, plataforma_canal,
prdid_desc, total_spots, total_sin_desc,
total_con_desc, tipo_facturacion, descuento,
target, created_by, id_fza_ventas,
orden_estatus, id_solicitud_hna
)
select v_id_solicitud_prov, id_request, id_seg_neg,
trim(both proc_por_linea), trim(both case when coalesce(garantizado,'0')='0' then '0'  else '1' end ), trim(both advid),
trim(both mcontid_cutin), null, trim(both email),
trim(both agyestnum), trim(both accthdrid), trim(both rtcrddscr_cutin),
null, oracle.substr(trim(both comentarios),1,132), 'PROVIN'||case when v_sptchr='XX' then '-ERTS' end ,
trim(both prdid_desc), trim(both total_spots), trim(both total_sin_desc),
trim(both total_con_desc), trim(both tipo_facturacion), trim(both descuento),
trim(both target), created_by, null,
10, v_id_solicitud_nal
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request;
-- se actualiza la orden de nacional con el id de la orden de provincia
-- para el campo id_solicitud_hna.
update xxmor_solicitudes_enc_tab
set    id_solicitud_hna = v_id_solicitud_prov
where  id_solicitud = v_id_solicitud_nal;
insert into xxmor_solicitudes_det_tab( id_solicitud, linea, stnid,
fecha_inicio, fecha_fin, duracion,
buyuntid, hora_inicio, hora_fin,
spots, lunes, martes, miercoles,
jueves, viernes, sabado, domingo,
spots_x_semana, tipo_servicio, usr_chr,
spot_chr, bn, p, marca, version,
tarifasp_sin_desc, tarifasp_con_desc,
tot_linea_sin_desc, tot_linea_con_desc,
sobrecargo, observaciones, des_plataforma,
linea_estatus, created_by
)
select currval('xxmor_id_solicitud_sq'), row_number() over ( order by  linea_request) num_linea, coalesce(trim(both stnid),v_agrupador),
trim(both fecha_inicio), trim(both fecha_fin), trim(both duracion),
trim(both buyuntid), trim(both hora_inicio), trim(both hora_fin),
trim(both spots), trim(both lunes), trim(both martes), trim(both miercoles),
trim(both jueves), trim(both viernes), trim(both sabado), trim(both domingo),
trim(both spots_x_semana),
case when length(tipo_servicio) = 2 then (select desc_tipo_servicio
from   xxmor_cat_tipo_serv_tab
where  spt_chr           = oracle.substr(tipo_servicio,2,1)
and    coalesce(usr_chr, ' ') = oracle.substr(tipo_servicio,1,1)
)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then
upper(tipo_servicio)
else
'NO APLICA'
end
end as tipo_servicio,
case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,1,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
)
else (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end usrchr,
case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,2,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
)
else (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end sptchr,
trim(both bn), trim(both p), trim(both marca), coalesce(trim(both version),'VER PAUTA'),
trim(both tarifasp_sin_desc), trim(both tarifasp_con_desc),
trim(both tot_linea_sin_desc), trim(both tot_linea_con_desc),
trim(both initcap(sobrecargo)), trim(both observaciones),
trim(both des_plataforma), 10,
(select trim(both created_by)
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request
)
from   xxmor_solicitudes_orig_det_tab
where  id_request = p_id_request
and    stnid not in (select canal
from xxmor_canales_nac_vw
);
end if; -- v_agrupador != cutin
else -- v_existe = 0
--la solicitud genera mas de una orden
select nextval('xxmor_id_solicitud_sq')
into strict   v_agrupa
;
for rec_pref in select * from cur_prefijos(p_id_request) loop
insert into xxmor_solicitudes_enc_tab( id_solicitud, id_request, id_seg_neg,
proc_por_linea, garantizado, advid,
mcontid, mcontid_cutin, email,
agyestnum, accthdrid, rtcrddscr,
rtcrddscr_cutin, comentarios, plataforma_canal,
prdid_desc, total_spots, total_sin_desc,
total_con_desc, tipo_facturacion, descuento,
target, created_by, id_fza_ventas,
orden_estatus, id_solicitud_hna
)
select nextval('xxmor_id_solicitud_sq'), id_request, id_seg_neg,
trim(both proc_por_linea), trim(both case when coalesce(garantizado,'0')='0' then '0'  else '1' end ), trim(both advid),
trim(both mcontid), trim(both mcontid_cutin), trim(both email),
trim(both agyestnum), trim(both accthdrid), trim(both rtcrddscr),
trim(both rtcrddscr_cutin), oracle.substr(trim(both comentarios),1,132), trim(both plataforma_canal)||case when v_sptchr='XX' then '-ERTS' end ,
trim(both prdid_desc), trim(both total_spots), trim(both total_sin_desc),
trim(both total_con_desc), trim(both tipo_facturacion), trim(both descuento),
trim(both target), created_by, null,
10, v_temp
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request;/* dmap converted statement start */
insert into xxmor_solicitudes_det_tab( id_solicitud, linea, stnid,
fecha_inicio, fecha_fin, duracion,
buyuntid, hora_inicio, hora_fin,
spots, lunes, martes, miercoles,
jueves, viernes, sabado, domingo,
spots_x_semana, tipo_servicio, usr_chr,
spot_chr, bn, p, marca, version,
tarifasp_sin_desc, tarifasp_con_desc,
tot_linea_sin_desc, tot_linea_con_desc,
sobrecargo, observaciones, des_plataforma,
linea_estatus, created_by
)
select currval('xxmor_id_solicitud_sq'), row_number() over ( order by  linea_request) num_linea,  concat(rec_pref.prefijo_canal, trim(both stnid)) ,
trim(both fecha_inicio), trim(both fecha_fin), trim(both duracion),
trim(both buyuntid), trim(both hora_inicio), trim(both hora_fin),
trim(both spots), trim(both lunes), trim(both martes), trim(both miercoles),
trim(both jueves), trim(both viernes), trim(both sabado), trim(both domingo),
trim(both spots_x_semana),
case when length(tipo_servicio) = 2 then (select desc_tipo_servicio
from   xxmor_cat_tipo_serv_tab
where  spt_chr           = oracle.substr(tipo_servicio,2,1)
and    coalesce(usr_chr, ' ') = oracle.substr(tipo_servicio,1,1)
)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then
upper(tipo_servicio)
else
'NO APLICA'
end
end as tipo_servicio,
case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,1,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
)
else (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end usrchr,
case when length(tipo_servicio) = 2 then
oracle.substr(tipo_servicio,2,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
) > 0 then (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = upper(tipo_servicio)
)
else (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end sptchr,
trim(both bn), trim(both p), trim(both marca), coalesce(trim(both version),'VER PAUTA'),
trim(both tarifasp_sin_desc), trim(both tarifasp_con_desc),
trim(both tot_linea_sin_desc), trim(both tot_linea_con_desc),
trim(both initcap(sobrecargo)), trim(both observaciones),
trim(both des_plataforma), 10,
(select trim(both created_by)
from   xxmor_solicitudes_orig_enc_tab
where  id_request = p_id_request
)
from   xxmor_solicitudes_orig_det_tab
where  id_request = p_id_request;/* dmap converted statement end */
end loop;
end if; -- v_existe = 0
end if; -- v_sptchr = 5 or v_sptchr = 1
end if; -- v_segneg != 1
/* dmap converted statement start */
perform dbms_output.put_line( concat('Antes de entrar a revisar', p_id_request)) ;/* dmap converted statement end */
begin
insert into xxmor_solicitudes_est_rep_tab( id_solicitud,  linea, id_sist, created_date)
select id_solicitud, 0, 1, clock_timestamp()
from   xxmor_solicitudes_enc_tab
where  id_request  = p_id_request;
insert into xxmor_solicitudes_est_rep_tab( id_solicitud,  linea, id_sist, created_date)
select id_solicitud, linea, 1, clock_timestamp()
from   xxmor_solicitudes_det_tab
where  id_solicitud in (select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = p_id_request
);
-- para rechazar las ordenes que no tienen un master contract valido con . (punto)
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom,
resultadogeneral, trackingid, desc_concom,
posicion_concom, id_concom, numlinea_concom,
estatus_concom, campo_concom, detalle_concom,
accion_concom, tiporegla_concom, estatus_orduni,
created_date, created_by
)
select id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'),
null, nextval('xxmor_id_rpta_concom_sq'), null,
'ENCABEZADO', null, null,
'ERROR','Request/Orden/Encabezado/CPSMasterContract', 'RECHAZO - La orden no tiene un master contract valido',
'RECHAZO', null, '10',
clock_timestamp(), 'ORDUNI2'
from   xxmor_solicitudes_enc_tab
where  id_request         = p_id_request
and    position('.' in mcontid) = 0;/* dmap converted statement start */
--xxmor_funcional_pkg_xxmor_env_mail_or_mc_pr(p_id_request, 5000);
perform dbms_output.put_line( concat('el dbms del momento en que se generan las ordenes', p_id_request)) ;/* dmap converted statement end */
exception
when unique_violation then
null;
end;/* dmap converted statement start */
elsif lst_inserta = 'N' then
-- se inserta en la tabla de errores el error encontrado
insert into xxmor_log_errores_tab(
id_error,
desc_error,
archivo_error,
metodo_error,
hora_error
)
values (       nextval('xxmor.xxmor_log_error_sq'),
concat('Error al procesar el archivo: ', lst_nom_archivo, ', No Existe Informacion de Lineas') ,
'XXMOR_FUNCIONAL_PKG',
'XXMOR_GENERAORDENES_PR',
clock_timestamp()
);/* dmap converted statement end */
end if;
end loop;
close ordenes;end;
$body$
language plpgsql
;
