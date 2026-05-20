create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_set_db2_ids_pr ( p_id_solicitud integer, p_ordlnid integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_ordlnid              integer := -1;
v_suma                 integer;
lst_id_enc             varchar(15);
lst_desc_error         varchar(4000);
lin_ordid              integer := 0;
lin_val_max_ordlnid    numeric;
lin_val_max_ordid      numeric;
lineas_bien_cur cursor for
select id_solicitud, linea
from   xxmor_solicitudes_det_tab d
where  id_solicitud = p_id_solicitud
and    exists (--que todavia no han sido numeradas
select 1
from   xxmor_solicitudes_est_rep_tab r
where  r.id_solicitud = p_id_solicitud
and    r.id_solicitud = d.id_solicitud
and    r.linea        = d.linea
and    nullif(r.aux2::text, '') is null
)
and    not exists (--que el encabezado este bien
select 1
from   xxmor_concom_rpta_tab cr
where  cr.estatus_orduni     = '10'
and    cr.id_solicitud       = d.id_solicitud
and    nullif(trim(both from numlinea_concom::text), '') is null
)
and    not exists ( --lineas que esten bien
select 1
from   xxmor_concom_rpta_tab cr
where  cr.estatus_orduni             = '10'
and    cr.id_solicitud               = d.id_solicitud
and    (cr.numlinea_concom)::numeric  = d.linea
)
and    exists (--lineas que no hayan entrado a paradigm
select 1
from   xxmor_solicitudes_est_rep_tab er
where  er.id_solicitud     = d.id_solicitud
and    er.linea            = d.linea
and    nullif(er.estat_id_foraneo::text, '') is null )
order by id_solicitud, linea;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
-- se lleva a cabo la obtencion del id para el encabezado, siempre y cuando este listo para insercion.
lin_val_max_ordid := 0;
begin
select valor_parametro
into strict   lin_val_max_ordid
from   xxmor_conf_params_grls_tab
where  nombre_parametro = 'VALOR_MAX_ORDID';
exception
when no_data_found then
lin_val_max_ordid := 0;
end;
lst_id_enc := null;
begin
select coalesce(aux2,'-1')
into strict   lst_id_enc
from   xxmor_solicitudes_est_rep_tab
where  linea        = 0
and    id_solicitud = p_id_solicitud;
exception
when others then
lst_id_enc := 'ERROR';
end;
if lst_id_enc = '-1' then
-- se obtiene el siguiente valor de la secuencia
select nextval('xxmor.xxmor_ordid_sq')
into strict   lin_ordid
;
if lin_ordid >= lin_val_max_ordid then
lin_ordid      := -1;/* dmap converted statement start */
lst_desc_error :=  concat('ID Solicitud: ', p_id_solicitud, ' - El Valor de la Secuencia de Oracle para el manejo del ID del Encabezado ha llegado a su Maximo Definido') ;/* dmap converted statement end */
end if;
elsif lst_id_enc = 'ERROR' then
lin_ordid      := -1;/* dmap converted statement start */
lst_desc_error :=  concat('ID Solicitud: ', p_id_solicitud, ' - No Fue Posible Verificar si la Solicitud Ya Tiene Asignado el ID de Paradigm') ;/* dmap converted statement end */
else
lin_ordid      := 0;
end if; -- sin valor
if lin_ordid > 0 then
-- se actualiza el la tabla
-- con el id del encabezado
update xxmor_solicitudes_est_rep_tab
set    aux2         = to_char(lin_ordid)
where  linea        = 0
and    id_solicitud = p_id_solicitud;
elsif lin_ordid = -1 then
-- se insterta el error en la tabla de log
insert into xxmor_log_errores_tab(   id_error,
desc_error,
archivo_error,
metodo_error
)
values (   nextval('xxmor_log_error_sq'),
lst_desc_error,
'XXMOR_SET_DB2_IDS_PR',
'Procedimiento xxmor_funcional_pkg_xxmor_set_db2_ids_pr()'
);
end if;
-- se lleva a cabo la obtencion de los ids de las lineas que estan listas para insertarse.
lin_val_max_ordlnid := 0;
begin
select valor_parametro
into strict   lin_val_max_ordlnid
from   xxmor_conf_params_grls_tab
where  nombre_parametro = 'VALOR_MAX_ORDLNID';
exception
when no_data_found then
lin_val_max_ordlnid := 0;
end;
for c_linea_bien in lineas_bien_cur loop
perform dbms_output.put_line(c_linea_bien.linea);
select nextval('xxmor.xxmor_ordlnid_sq')
into strict   v_ordlnid
;
if v_ordlnid >= lin_val_max_ordlnid then
v_ordlnid := -1;
end if;
update xxmor_solicitudes_est_rep_tab
set    aux2 = to_char(v_ordlnid)
where  id_solicitud = c_linea_bien.id_solicitud
and    linea        = c_linea_bien.linea;
end loop;end;
$body$
language plpgsql
;
