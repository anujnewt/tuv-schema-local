create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_asigna_fzavtas_pr ( p_id_request_aux integer ) as $body$
declare
pestania record;
-- pgv moved types start
-- pgv moved types end
v_id_fza_ventas     integer;
v_id_solicitud      integer;
v_fza_vtas_mkt      integer;
v_coordina_mkt      integer;
v_count_coord       integer;
v_count_nulls       integer;
v_tot_lineas        integer;
v_gen_ver_vir       integer;
v_aut_x_correo      integer;
v_fza_vtas_ch       integer;
lst_agrupador        varchar(10);
lst_plataforma_canal varchar(70);
lst_usa_buyunit      varchar(1);
ordenes_cur cursor for
select id_request
from   xxmor_solicitudes_orig_enc_tab
where  aux1 = p_id_request_aux;
pestanias_cur cursor(p_id_request integer) for
select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = p_id_request;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
for orden in ordenes_cur loop
for pestania in select * from pestanias_cur(orden.id_request) loop
--selecciona todas las ordenes generadas en un request
v_id_solicitud := pestania.id_solicitud;/* dmap converted statement start */
perform dbms_output.put_line( concat(' V_ID_SOLICITUD: ', v_id_solicitud)) ;/* dmap converted statement end */
-- se obtiene la plataforma-canal a nivel encabezado con el
-- cual se va a obtener el agrupador, para posteriormente
-- actualizar este campo en la tabla de encabezado.
select coalesce(trim(both plataforma_canal),'SIN PLATAFORMA')
into strict   lst_plataforma_canal
from   xxmor_solicitudes_enc_tab
where  id_solicitud = v_id_solicitud;/* dmap converted statement start */
perform dbms_output.put_line( concat('lst_plataforma_canal: ', lst_plataforma_canal)) ;/* dmap converted statement end */
select xxmor_funcional_pkg_xxmor_get_agrupador_fn(
lst_plataforma_canal,
v_id_solicitud
)
into strict   lst_agrupador
;/* dmap converted statement start */
perform dbms_output.put_line( concat('lst_agrupador: ', lst_agrupador)) ;/* dmap converted statement end */
update xxmor_solicitudes_enc_tab
set    agrupador  = lst_agrupador
where id_solicitud = v_id_solicitud;
perform dbms_output.put_line('SE ACTUALIZO AGRUPADOR');
select xxmor_funcional_pkg_xxmor_ident_fza_vtas(
v_id_solicitud,
(select usr_chr
from   xxmor_solicitudes_det_tab
where  id_solicitud = v_id_solicitud
and    linea        = 1
),
(select spot_chr
from   xxmor_solicitudes_det_tab
where  id_solicitud = v_id_solicitud
and    linea        = 1
)
)
into strict v_id_fza_ventas
;
-- inicio omw - cambio notificaciones fvtas, merca, 23-ag0-2016
if v_id_fza_ventas = 0 then
-- se envia la notificacion de que no se obtuvo fuerza de ventas (no fue posible obtenerla)
call xxmor_funcional_pkg_xxmor_notifica_fvtas_merca_pr(
'FVTAS',
0,
v_id_solicitud
);
elsif v_id_fza_ventas = 1 then
v_id_fza_ventas := 0;
-- se envia la notificacion de que no se obtuvo fuerza de ventas (existe mas de una con la misma configuracion)
call xxmor_funcional_pkg_xxmor_notifica_fvtas_merca_pr(
'FVTAS',
1,
v_id_solicitud
);
elsif v_id_fza_ventas < 0 then
v_id_fza_ventas := (v_id_fza_ventas * -1);
-- se envia la notificacion de que no se obtuvo fuerza de ventas (existe pero esta inactiva)
call xxmor_funcional_pkg_xxmor_notifica_fvtas_merca_pr(
'FVTAS',
v_id_fza_ventas,
v_id_solicitud
);
v_id_fza_ventas := 0;
end if;
-- fin omw - cambio notificaciones fvtas, merca, 23-ag0-2016
update xxmor_solicitudes_enc_tab e
set    id_fza_ventas = v_id_fza_ventas
where  id_solicitud = v_id_solicitud;
--where id_request = orden.id_request; -- se modifico para que lo haga por solicitud
select count(1)
into strict   v_fza_vtas_ch
from   xxmor_fzas_vtas_canales_tab
where  id_seg_neg    = 1
and    id_fza_ventas = v_id_fza_ventas;
--se genera la informacion de las lineas hermanas
if v_fza_vtas_ch > 0 then
call xxmor_funcional_pkg_xxmor_genera_inf_rep_pr(v_id_solicitud,v_id_fza_ventas);
end if;
-- revisa si necesita autorizacion de mkt (autorizacion por correo) aut_x_correo
-- si la fuerza de ventas esde mercadotecnia, y la version es nula se generan versiones virtuales
select aut_x_correo,
mercadotecnia,
coalesce(usar_buyunit_mkt,'1') usar_buyunit_mkt
into strict   v_aut_x_correo,
v_gen_ver_vir,
lst_usa_buyunit
from   xxmor_fzas_vtas_tab
where  id_seg_neg    = 1
and    id_fza_ventas = v_id_fza_ventas;/* dmap converted statement start */
if v_gen_ver_vir = '1' then
--generamos las versiones que vienen vacias (para que se generen al momento de usar el ws
update xxmor_solicitudes_det_tab
set    version =  concat('PP', duracion, ' ', marca
) where  nullif(version::text, '') is null
and    id_solicitud = v_id_solicitud;/* dmap converted statement end */
end if;
--si la orden se puede autorizar (en caso de ser necesario) por correo
if v_aut_x_correo = '1' then
if lst_usa_buyunit = '1' then
-- contamos las versiones que si tienen version
/*select count(distinct bm.mkt_coordinador)
into   v_count_coord
from   xxmor_solicitudes_det_tab d
left   outer join xxmor_cat_buyunit_mkt_tab bm
on     d.buyuntid = bm.buyuntid
and    d.id_solicitud = v_id_solicitud;*/
-- se cambia el query anterior por el siguiente para el manejo
-- de byunits nulos en las lineas de la orden.
select count(distinct bm.mkt_coordinador)
into strict   v_count_coord
from   xxmor_solicitudes_det_tab d,
xxmor_cat_buyunit_mkt_tab bm
where  coalesce(trim(both d.buyuntid),'SIN BUYUNIT') = coalesce(trim(both bm.buyuntid),'SIN BUYUNIT')
and    d.id_solicitud   = v_id_solicitud
and    bm.id_fza_ventas = (select e.id_fza_ventas
from   xxmor_solicitudes_enc_tab e
where  e.id_solicitud = d.id_solicitud
);
-- contamos si hay versiones q su coordinador es nulo
/*select count(distinct nvl(bm.mkt_coordinador,1))  --count distinct
into   v_count_nulls
from   xxmor_solicitudes_det_tab d
join   xxmor_cat_buyunit_mkt_tab bm
on     d.buyuntid = bm.buyuntid
and    d.id_solicitud = v_id_solicitud
and    bm.mkt_coordinador is null;*/
-- se cambia el query anterior por el siguiente para el manejo
-- de byunits nulos en las lineas de la orden.
select count(distinct coalesce(bm.mkt_coordinador,1))
into strict   v_count_nulls
from   xxmor_solicitudes_det_tab d,
xxmor_cat_buyunit_mkt_tab bm
where  coalesce(trim(both d.buyuntid),'SIN BUYUNIT') = coalesce(trim(both bm.buyuntid),'SIN BUYUNIT')
and    d.id_solicitud     = v_id_solicitud
and    nullif(bm.mkt_coordinador::text, '') is null
and    bm.id_fza_ventas   = (select e.id_fza_ventas
from   xxmor_solicitudes_enc_tab e
where  e.id_solicitud = d.id_solicitud
);
if v_count_nulls = 0 and v_count_coord = 1 then
null;
else
insert into xxmor_concom_rpta_tab(
id_solicitud,       id_seg_neg,         id_rpta_concom,
resultadogeneral,   trackingid,         desc_concom,
posicion_concom,    id_concom,          numlinea_concom,
estatus_concom,     campo_concom,       detalle_concom,
accion_concom,      tiporegla_concom,   estatus_orduni,
created_date,       created_by
)
select e.id_solicitud, 1, nextval('xxmor_id_rpta_concom_sq'),
null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null, linea,
'ERROR', 'BUYUNIT-COORDINADOR', 'RECHAZO - La orden de mercadotecnia tiene mas de un coordinador',
'RECHAZO', null, '10',
clock_timestamp(), 'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = v_id_solicitud
and    e.id_solicitud = d.id_solicitud;
end if;
end if; -- lst_usa_buyunit = 1
end if; -- v_aut_x_correo = 1
end loop;
end loop;end;
$body$
language plpgsql
;
