create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_proc_rpta_cc_pr ( p_id_solicitud integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_es_sobrecargo     integer :=0;
v_ver_horario       integer :=0;
v_linea             integer;
v_aux               varchar(20);
v_es_openlog        integer;
v_es_urgente        integer;
v_matloc            varchar(3);
v_version_lin       varchar(30);
v_errores_lin       integer;
lin_max_reenvios    integer := 0;
lin_num_reenvios    integer := 0;
-- inicio omw - cambio rechazo de lineas por canal-tipo servicio, 18-sep-2019
lstrechazocantserv  varchar(5);
linnumregs          numeric := 0;
-- fin omw - cambio rechazo de lineas por canal-tipo servicio, 18-sep-2019
lineas_concom_cur cursor for
select id_solicitud,
id_rpta_concom,
resultadogeneral,
trackingid,
desc_concom,
posicion_concom,
id_concom,
numlinea_concom,
estatus_concom,
campo_concom,
detalle_concom,
accion_concom,
tiporegla_concom,
estatus_orduni,
id_seg_neg
from   xxmor_concom_rpta_tab
where  id_solicitud = p_id_solicitud;
-- inicio omw - cambio rechazo de lineas por canal-tipo servicio, 18-sep-2019
-- se le agrearon los campos de canal y tipo de servicio al cursor.
lineas_orden_cur cursor for
select linea,
stnid,
tipo_servicio
from   xxmor_solicitudes_det_tab
where  id_solicitud =  p_id_solicitud;
-- fin omw - cambio rechazo de lineas por canal-tipo servicio, 18-sep-2019
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select coalesce(matloc,'0')
into strict   v_matloc
from   xxmor_fzas_vtas_tab
where  id_fza_ventas = (select id_fza_ventas
from   xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud
)
and id_seg_neg       = 1;
--revisamos si la orden tiene lineas  urgentes
call xxmor_funcional_pkg_xxmor_aut_urgente_fun(p_id_solicitud, 1);
--revisamos si la orden tiene lineas open log
call xxmor_funcional_pkg_xxmor_aut_openlog_fun(p_id_solicitud, 1, v_aux);
--si hubiese lineas con reenvio aqui se podria meter el enviar a concom y actualizar el estatus orduni a conveniencia
--se actualiza el estatus de las lineas de rtpa_concom de la orden si es que tuvo reenvio
/*update xxmor_concom_rpta_tab cr
set    cr.estatus_orduni = 20,
cr.updated_by     = orduni,
cr.updated_date   = sysdate
where  upper(cr.accion_concom) = reenvio
and    cr.estatus_orduni       = 10
and    cr.id_solicitud         = p_id_solicitud;*/
--omitimos todos los errores de version de la orden provenientes de concom para las lineas que contienen ver pauta
--conforme al correo del 13-dic-2012
update xxmor_concom_rpta_tab cr
set    cr.estatus_orduni = '20',
cr.updated_by     = 'ORDUNI',
cr.updated_date   = clock_timestamp()
where  cr.id_solicitud   = p_id_solicitud
and    cr.estatus_orduni = '10'
and    exists (select 1
from   xxmor_solicitudes_det_tab
where  upper(version)                = 'VER PAUTA'
and    id_solicitud                  = p_id_solicitud
and    (cr.numlinea_concom)::numeric  = linea
)
and position('VERSION' in upper(desc_concom)) = 1;
-- 06-09-2013 manejo reenvios de la respuesta de concom
-- codigo para validar que si se ha alacanzado el nunmero maximo de reenvios a concom se rechace el encabezado
-- primero se obtiene el numero maximo de reenvios configurado en los parametros generales
lin_max_reenvios := 0;
begin
select (valor_parametro)::numeric  num_reenvios
into strict   lin_max_reenvios
from   xxmor_conf_params_grls_tab
where  nombre_parametro  = 'NUM_REENVIOS_CONCOM';
exception
when no_data_found then
lin_max_reenvios := 0;
when others then
lin_max_reenvios := 0;
end;
-- se obtiene el numero de reenvios que ya se generaron a nivel encabezado
lin_num_reenvios := 0;
select count(1)
into strict   lin_num_reenvios
from   xxmor_concom_rpta_tab
where  nullif(numlinea_concom::text, '') is null
and    upper(resultadogeneral) = 'REENVIO'
and    id_solicitud            = p_id_solicitud;
if lin_max_reenvios > 0 then
if lin_num_reenvios > 0 then
if lin_num_reenvios = lin_max_reenvios then
--se actualiza el estatus de las lineas de rtpa_concom de la orden si es que tuvo reenvio el encabezado
update xxmor_concom_rpta_tab cr
set    cr.estatus_orduni   = '20',
cr.updated_by       = 'ORDUNI2',
cr.updated_date     = clock_timestamp()
where  nullif(cr.numlinea_concom::text, '') is null
and    upper(cr.accion_concom)   = 'REENVIO'
and    cr.estatus_orduni         = '10'
and    cr.id_solicitud           = p_id_solicitud;
-- se inserta el registro de rechazo para el encabezado
insert into xxmor_concom_rpta_tab(
id_solicitud,     id_rpta_concom,
resultadogeneral, trackingid,
desc_concom,      posicion_concom,
id_concom,        estatus_concom,
campo_concom,     detalle_concom,
accion_concom,    tiporegla_concom,
estatus_orduni,   created_date,
created_by,       id_seg_neg
)
values (
p_id_solicitud, nextval('xxmor_id_rpta_concom_sq'),
'Sin Reenvio', nextval('xxmor_id_rpta_concom_sq'),
'La orden no pudo ser procesada por ConCom', 'Encabezado',
null, 'Error',
'Encabezado', 'Rechazo por reenvios',
'Rechazo', null,
'10', clock_timestamp(),
'ORDUNI2', 1
);
elsif lin_num_reenvios < lin_max_reenvios then
update xxmor_concom_rpta_tab cr
set    cr.estatus_orduni = '20',
cr.updated_by     = 'ORDUNI',
cr.updated_date   = clock_timestamp()
where  nullif(cr.numlinea_concom::text, '') is null
and    upper(cr.accion_concom)   = 'REENVIO'
and    cr.estatus_orduni         = '10'
and    cr.id_solicitud           = p_id_solicitud;
end if;
end if;
else
-- se inserta en la tabla de errores que no existe el parametro de reenvios configurado.
insert into xxmor_log_errores_tab(
id_error,
desc_error,
archivo_error,
metodo_error,
hora_error
)
values (       nextval('xxmor.xxmor_log_error_sq'),
'No existe configurado el Valor Maximo de Renvios, en la Tabla XXMOR_CONF_PARAMS_GRLS_TAB o su Valor es 0',
'XXMOR_FUNCIONAL_PKG',
'XXMOR_PROC_RPTA_CC_PR',
clock_timestamp()
);
if lin_num_reenvios > 0 then
--si hubiese lineas con reenvio aqui se podria meter el enviar a concom y actualizar el estatus orduni a conveniencia
--se actualiza el estatus de las lineas de rtpa_concom de la orden si es que tuvo reenvio
update xxmor_concom_rpta_tab cr
set    cr.estatus_orduni = '20',
cr.updated_by     = 'ORDUNI',
cr.updated_date   = clock_timestamp()
where  upper(cr.accion_concom) = 'REENVIO'
and    cr.estatus_orduni       = '10'
and    cr.id_solicitud         = p_id_solicitud;
end if;
end if;
-- para resolver el conflicto del las versiones en ordenes urgentes
-- si esta respuesta contiene la cadena ?|versionhorario? en el campo detalle, entonces decides si la mostraras como error o no
for rpta_concom in lineas_concom_cur loop
if rpta_concom.campo_concom = 'Request/Orden/Encabezado/CPSMasterContract' and rpta_concom.accion_concom = 'Autorizacion' then
update xxmor_concom_rpta_tab
set    estatus_orduni = '20',
updated_by     = 'ORDUNI',
updated_date   = clock_timestamp()
where  id_solicitud           = p_id_solicitud
and    accion_concom          = 'Autorizacion'
and    nullif(updated_by::text, '') is null
and    upper(posicion_concom) = 'ENCABEZADO'
and    campo_concom           = 'Request/Orden/Encabezado/CPSMasterContract'
and    estatus_orduni         = '10'
and (select count(1)
from   xxmor_concom_rpta_tab
where  id_solicitud           = p_id_solicitud
and    accion_concom          = 'Autorizacion'
and    nullif(updated_by::text, '') is not null
and    upper(posicion_concom) = 'ENCABEZADO'
and    campo_concom           = 'Request/Orden/Encabezado/CPSMasterContract'
and    estatus_orduni         = '20'
)                      > 0;
end if;
--revisamos la parte de matloc
if v_matloc <> '0' then
--tiene que ser un error relacionado a una linea
if nullif(rpta_concom.numlinea_concom::text, '') is not null then
--traemos la version de la linea
select version
into strict   v_version_lin
from   xxmor_solicitudes_det_tab
where  id_solicitud = rpta_concom.id_solicitud
and    linea        = rpta_concom.numlinea_concom;
/*  31-oct-2012 -lugar de tavo
se decidio quitar las reglas de version vacia de concom
y comentar estos updates
*/
--si no trae version -> se deja pasar
if nullif(v_version_lin::text, '') is null then
update xxmor_concom_rpta_tab
set    estatus_orduni = '20',
updated_by     = 'ORDUNI',
updated_date   = clock_timestamp()
where  id_solicitud   = p_id_solicitud
and    id_rpta_concom = rpta_concom.id_rpta_concom
and    position('La duracion' in detalle_concom) > 0
and    position('no existe en paradigm' in detalle_concom) > 0;
update xxmor_concom_rpta_tab
set    estatus_orduni = '20',
updated_by = 'ORDUNI',
updated_date = clock_timestamp()
where  id_solicitud   = p_id_solicitud
and    id_rpta_concom = rpta_concom.id_rpta_concom
and    position('La version  no contiene ningun caracter.' in detalle_concom) >0
and    upper(accion_concom)  != 'RECHAZO';
update xxmor_concom_rpta_tab
set    estatus_orduni = '20'
where  id_solicitud = (select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
and    nullif(advid::text, '') is not null
)
and id_rpta_concom  = rpta_concom.id_rpta_concom
and position('La version  o el cliente' in detalle_concom) >0
and position('viene vacio.' in detalle_concom) >0;
end if;
end if;
end if;
select count(1)
into strict   v_ver_horario
where  position('VersionHorario' in rpta_concom.detalle_concom) > 0;/* dmap converted statement start */
perform dbms_output.put_line( concat('RPTA_CONCOM.DETALLE_CONCOM: ', rpta_concom.detalle_concom)) ;/* dmap converted statement end */
if v_ver_horario = 1 then
select count(1)
into strict   v_es_openlog
from   xxmor_concom_rpta_tab
where  campo_concom    = 'OPENLOG'
and    id_solicitud    = p_id_solicitud
and    numlinea_concom = rpta_concom.numlinea_concom;
select count(1)
into strict   v_es_urgente
from   xxmor_concom_rpta_tab
where  campo_concom    = 'URGENTE'
and    id_solicitud    = p_id_solicitud
and    numlinea_concom = rpta_concom.numlinea_concom;
if v_es_urgente > 0 or v_es_openlog > 0 then
--si la linea es urgente u open log, muestras el error que haya sido reportado con esta leyenda.
null;/* dmap converted statement start */
else
perform dbms_output.put_line( concat('NO ES URGENTE NI OPENLOG: ', rpta_concom.numlinea_concom)) ;/* dmap converted statement end */
-- si la linea no es urgente ni open log, no muestras el error, ni lo tomas en cuenta, y no escribes copys
-- no generar copys se encuentra en la vista xxmor_para_copy_vw
-- 11/enero/2013 se agrega el comentario en la linea de la version
update xxmor_solicitudes_det_tab d
set    observaciones = version
where  d.id_solicitud = p_id_solicitud
and    exists (select 1
from   xxmor_concom_rpta_tab rc
where  rc.id_solicitud               = p_id_solicitud
and    rc.estatus_orduni             = '10'
and    rc.numlinea_concom            = rpta_concom.numlinea_concom
and    position('VersionHorario' in rc.detalle_concom) > 0
and    rc.accion_concom             != 'AUTORIZACION'
and    rc.id_solicitud               = d.id_solicitud
and    (rc.numlinea_concom)::numeric  = d.linea
);
-- se cambio el valor con el que se actualiza estatus_orduni por 30 esto
-- para poder manejar cuando se generan copys y cuando no por versionhorario
-- omw 09-may-2016
update xxmor_concom_rpta_tab
set    estatus_orduni = '30',
updated_by     = 'ORDUNI',
updated_date   = clock_timestamp()
where  id_solicitud    = p_id_solicitud
and    estatus_orduni  = '10'
and    numlinea_concom = rpta_concom.numlinea_concom
and    position('VersionHorario' in detalle_concom) > 0
and    accion_concom  != 'AUTORIZACION';
end if;
end if;
--se ignoran las respuestas de concom cuyas lineas ya fueron insertadas en paradigm
update xxmor_concom_rpta_tab cr
set    cr.estatus_orduni = '20',
cr.updated_by     = 'ORDUNI',
cr.updated_date   = clock_timestamp()
where  cr.id_solicitud   = p_id_solicitud
and    cr.id_rpta_concom = rpta_concom.id_rpta_concom
and    cr.estatus_orduni = '10'
and    exists (select 1
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud  = cr.id_solicitud
and    er.linea         = (cr.numlinea_concom)::numeric
and    nullif(estat_id_foraneo::text, '') is not null
);
-- 06-09-2013 manejo reenvios de la respuesta de concom
-- se obtiene el numero de reenvios que ya se generaron a nivel linea
lin_num_reenvios := 0;
select count(1)
into strict   lin_num_reenvios
from   xxmor_concom_rpta_tab
where  upper(posicion_concom)  = 'LINEA'
and    upper(resultadogeneral) = 'REENVIO'
and    upper(accion_concom)    = 'REENVIO'
and    id_solicitud            = p_id_solicitud
and    numlinea_concom         = rpta_concom.numlinea_concom;
if lin_max_reenvios > 0 then
if lin_num_reenvios > 0 then
if lin_num_reenvios = lin_max_reenvios then
-- se actualiza el estatus de las lineas de rtpa_concom de la orden
-- si es que tuvo reenvio la linea que se esta procesando.
update xxmor_concom_rpta_tab cr
set    cr.estatus_orduni   = '20',
cr.updated_by       = 'ORDUNI2',
cr.updated_date     = clock_timestamp()
where  upper(cr.posicion_concom)  = 'LINEA'
and    upper(cr.resultadogeneral) = 'REENVIO'
and    upper(cr.accion_concom)    = 'REENVIO'
and    cr.id_solicitud            = p_id_solicitud
and    cr.numlinea_concom         = rpta_concom.numlinea_concom;
-- se inserta el registro de rechazo para la linea
insert into xxmor_concom_rpta_tab(
id_solicitud,     id_rpta_concom,
resultadogeneral, trackingid,
desc_concom,      posicion_concom,
id_concom,        numlinea_concom,
estatus_concom,   campo_concom,
detalle_concom,   accion_concom,
tiporegla_concom, estatus_orduni,
created_date,     created_by,
id_seg_neg
)
values (
p_id_solicitud, nextval('xxmor_id_rpta_concom_sq'),
'Sin Reenvio', nextval('xxmor_id_rpta_concom_sq'),
'La Linea no pudo ser procesada por ConCom', 'Linea',
null, rpta_concom.numlinea_concom,
'Error', 'Linea',
'Rechazo por reenvios', 'Rechazo',
null, '10',
clock_timestamp(), 'ORDUNI2', 1
);
elsif lin_num_reenvios < lin_max_reenvios then
update xxmor_concom_rpta_tab cr
set    cr.estatus_orduni = '20',
cr.updated_by     = 'ORDUNI',
cr.updated_date   = clock_timestamp()
where  upper(cr.posicion_concom)  = 'LINEA'
and    upper(cr.resultadogeneral) = 'REENVIO'
and    upper(cr.accion_concom)    = 'REENVIO'
and    cr.estatus_orduni          = '10'
and    cr.id_solicitud            = p_id_solicitud
and    cr.numlinea_concom         = rpta_concom.numlinea_concom;
end if;
end if;
else
-- se inserta en la tabla de errores que no existe el parametro de reenvios configurado.
insert into xxmor_log_errores_tab(
id_error,
desc_error,
archivo_error,
metodo_error,
hora_error
)
values (       nextval('xxmor.xxmor_log_error_sq'),
'No existe configurado el Valor Maximo de Renvios, en la Tabla XXMOR_CONF_PARAMS_GRLS_TAB o su Valor es 0',
'XXMOR_FUNCIONAL_PKG',
'XXMOR_PROC_RPTA_CC_PR',
clock_timestamp()
);
end if;
end loop;
--se elimina la informacion de las autorizaciones de open log y orden urgente
--        delete from xxmor_concom_rpta_tab cr
--        where cr.campo_concom in ( urgente)
--        and id_solicitud = p_id_solicitud
--        and resultadogeneral = 1
--        and trackingid =(select max(trackingid)
--                                     from xxmor_concom_rpta_tab
--                                     where cr.campo_concom in ( urgente)
--                                     and resultadogeneral = 1
--                                     and   id_solicitud = p_id_solicitud);
--
--        delete from xxmor_concom_rpta_tab cr
--        where cr.campo_concom in ( openlog)
--        and id_solicitud = p_id_solicitud
--        and resultadogeneral = 1
--        and trackingid =(select max(trackingid)
--                                     from xxmor_concom_rpta_tab
--                                     where cr.campo_concom in ( openlog)
--                                     and resultadogeneral = 1
--                                     and   id_solicitud = p_id_solicitud);
--        and numlinea_concom not in (select distinct numlinea_concom
--                                                   from xxmor_concom_rpta_tab
--                                                   where id_solicitud = p_id_solicitud
--                                                   and estatus_orduni = 20
--                                                   and instr(detalle_concom,versionhorario) > 0);
/*
select count(1)
into   v_es_sobrecargo
from   xxmor_concom_rpta_tab
where  id_solicitud = p_id_solicitud
and    campo_concom = sobrecargo;
update xxmor_concom_rpta_tab
set estatus_orduni = 20
where id_solicitud = p_id_solicitud
and     numlinea_concom in (select linea
from xxmor_solicitudes_det_tab
where version = ver pauta
and id_solicitud = p_id_solicitud )
and     instr(desc_concom,version -) > 0;
if v_es_sobrecargo = 0 then
update xxmor_concom_rpta_tab
set estatus_orduni = 20
where id_solicitud = p_id_solicitud
and     instr(upper(detalle_concom),horario)>0;
--and 1=2; --este update esta incompleto revisar
end if;
*/
-- se definio el 31 oct 12 que se meteria una linea de rpta concom que diga explicitamente que la linea esta bien en caso de que
-- cuando entren lineas mal y se omitan quede un registro que diga que existe una linea que diga que ya esta bien.
for linea_orden in lineas_orden_cur loop
select count(1)
into strict   v_errores_lin
from   xxmor_concom_rpta_tab
where  id_solicitud    = p_id_solicitud
and    numlinea_concom = to_char(linea_orden.linea)
and    estatus_orduni  = '10';
if v_errores_lin = 0 then
insert into xxmor_concom_rpta_tab(
id_solicitud,     id_rpta_concom,
resultadogeneral, trackingid,
numlinea_concom,  accion_concom,
estatus_orduni,   created_date,
created_by,       id_seg_neg
)
values (
p_id_solicitud, nextval('xxmor_id_rpta_concom_sq'),
'Bien', nextval('xxmor_id_rpta_concom_sq'),
to_char(linea_orden.linea), 'LineaBien',
'20', clock_timestamp(),
'ConComWsResponseSP', 1
);
end if;
v_errores_lin := 0;
select count(1)
into strict   v_errores_lin
from   xxmor_concom_rpta_tab
where  id_solicitud             = p_id_solicitud
and    coalesce(numlinea_concom,'0') = to_char(linea_orden.linea)
and    upper(accion_concom)     = 'RECHAZO'
and    estatus_orduni           = '10';
if v_errores_lin > 0 then
--para actualizar a estatus 20 las lineas que concom rechaza y que
--por reprocesos anteriores (o de la ultima respuesta de concom( tienen autorizaciones o reprocesos (que ya no tienen caso)
update xxmor_concom_rpta_tab cr
set    cr.estatus_orduni = '20',
cr.updated_by     = 'ORDUNI',
cr.updated_date   = clock_timestamp()
where  cr.id_solicitud   = p_id_solicitud
and    upper(cr.accion_concom) in ('REPROCESO','AUTORIZACION')
and    cr.numlinea_concom      = to_char(linea_orden.linea)
and    cr.estatus_orduni       = '10';
-- inicio omw - cambio rechazo de lineas por canal-tipo servicio, 18-sep-2019
elsif v_errores_lin = 0 then
-- se verifica si se deben rechazar lineas por canal-tipo servicio configurados en la tabla xxmor_map_canal_tserv_rech_tab
begin
lstrechazocantserv := 'N';
select coalesce(valor_parametro,'N') rechazo_canal_tserv
into strict   lstrechazocantserv
from   xxmor_conf_params_grls_tab
where  upper(nombre_parametro) = 'RECHAZO_CANAL_TIPO_SERVICIO';
exception
when others then
lstrechazocantserv := 'N';
end;
if lstrechazocantserv = 'S' then
-- se valida si el canal y tipo de servicio de la linea, existe actuvo en la tabla
-- xxmor_map_canal_tserv_rech_tab.
linnumregs := 0;
begin
select count(1)
into strict   linnumregs
from   xxmor_map_canal_tserv_rech_tab
where  activo        = '1'
and    canal         = linea_orden.stnid
and    tipo_servicio = linea_orden.tipo_servicio;
exception
when others then
linnumregs := 0;
end;/* dmap converted statement start */
-- si la combinacion de canal y tipo de servicio existe, se rechaza la linea.
if linnumregs > 0 then
insert into xxmor_concom_rpta_tab( id_solicitud, id_seg_neg, id_rpta_concom, resultadogeneral, trackingid,   desc_concom,
posicion_concom, id_concom, numlinea_concom, estatus_concom, campo_concom,
detalle_concom, accion_concom, tiporegla_concom, estatus_orduni, created_date,
created_by
)
select e.id_solicitud, id_seg_neg, nextval('xxmor_id_rpta_concom_sq'), null, nextval('xxmor_id_rpta_concom_sq'), null,
'LINEA', null,d.linea, 'ERROR','RECHAZO CANAL-TIPO SERVICIO',
concat('RECHAZO - El Canal ', linea_orden.stnid, ' y Tipo de Servicio: ', linea_orden.tipo_servicio, ' estan configurados para Rechazo') , 'RECHAZO', null,'10', clock_timestamp(),
'ORDUNI2'
from   xxmor_solicitudes_det_tab d,
xxmor_solicitudes_enc_tab e
where  e.id_solicitud = p_id_solicitud
and    e.id_solicitud = d.id_solicitud
and    d.linea        = linea_orden.linea
and    not exists (select 1
from   xxmor_concom_rpta_tab c
where  c.id_solicitud         = d.id_solicitud
and    c.numlinea_concom      = d.linea
and    nullif(c.numlinea_concom::text, '') is not null
and    c.campo_concom         = 'RECHAZO CANAL-TIPO SERVICIO'
and    upper(c.accion_concom) = 'RECHAZO'
and    (d.linea)::numeric      = (c.numlinea_concom)::numeric
);/* dmap converted statement end */
end if;
end if;
-- fin omw - cambio rechazo de lineas por canal-tipo servicio, 18-sep-2019
end if;
end loop;
--para revisar lo de los copys del copy job list
call xxmor_funcional_pkg_xxmor_copy_update_pr(p_id_solicitud);end;
$body$
language plpgsql
;
