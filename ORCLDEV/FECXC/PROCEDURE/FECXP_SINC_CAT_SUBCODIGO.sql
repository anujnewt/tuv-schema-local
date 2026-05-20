create or replace procedure fecxc."fecxp_sinc_cat_subcodigo"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_secuencia_cod_sub_bit integer;
v_ins_no_empresa smallint;
v_ins_id_codigo varchar(2);
v_ins_id_subcodigo varchar(3);
v_ins_desc_subcodigo varchar(40);
v_del_no_empresa smallint;
v_del_id_codigo varchar(2);
v_del_id_subcodigo varchar(3);
v_del_desc_subcodigo varchar(40);
v_accion varchar(40);
v_ins_existe integer;
v_del_existe integer;
v_fec_ejecucion timestamp(0):= clock_timestamp();
rs_fecxp_cod_sub_bitacora record;
begin 

for rs_fecxp_cod_sub_bitacora in (
select	a.secuencia_cod_sub_bit,
a.ins_no_empresa, a.ins_id_codigo, a.ins_id_subcodigo, a.ins_desc_subcodigo,
a.del_no_empresa, a.del_id_codigo, a.del_id_subcodigo, a.del_desc_subcodigo,
a.accion
from	fecxp_cod_sub_bitacora a
where	a.sincronizado_fe = upper('NO')
order by  secuencia_cod_sub_bit
)
loop
v_secuencia_cod_sub_bit:= rs_fecxp_cod_sub_bitacora.secuencia_cod_sub_bit;
v_ins_no_empresa:= rs_fecxp_cod_sub_bitacora.ins_no_empresa;
v_ins_id_codigo:= rs_fecxp_cod_sub_bitacora.ins_id_codigo;
v_ins_id_subcodigo:= rs_fecxp_cod_sub_bitacora.ins_id_subcodigo;
v_ins_desc_subcodigo:= rs_fecxp_cod_sub_bitacora.ins_desc_subcodigo;
v_del_no_empresa:= rs_fecxp_cod_sub_bitacora.del_no_empresa;
v_del_id_codigo:= rs_fecxp_cod_sub_bitacora.del_id_codigo;
v_del_id_subcodigo:= rs_fecxp_cod_sub_bitacora.del_id_subcodigo;
v_del_desc_subcodigo:= rs_fecxp_cod_sub_bitacora.del_desc_subcodigo;
v_accion:= rs_fecxp_cod_sub_bitacora.accion;
--=== determina la existencia del insertado ===--
select	case count(1) when 0 then 0 else 1 end
into strict	v_ins_existe
from	fecxp_cat_subcodigo
where	no_empresa = v_ins_no_empresa
and		id_codigo = v_ins_id_codigo
and		id_subcodigo = v_ins_id_subcodigo;
--=== determina la existencia del borrado ===--
select	case count(1) when 0 then 0 else 1 end
into strict	v_del_existe
from	fecxp_cat_subcodigo
where	no_empresa = v_del_no_empresa
and		id_codigo = v_del_id_codigo
and		id_subcodigo = v_del_id_subcodigo;
-- dbms_output.put_line('* V_NO_EMPRESA: ' || v_no_empresa || '* V_ID_CODIGO: ' || v_id_codigo || '* V_ID_SUBCODIGO: ' || v_id_subcodigo || '* V_DESC_SUBCODIGO: ' || v_desc_subcodigo || '* V_ACCION: ' || v_accion);
if v_accion = 'ALTA' then
if v_ins_existe = 1 then
update	fecxp_cat_subcodigo
set		desc_subcodigo = v_ins_desc_subcodigo,
fecha_modificacion = v_fec_ejecucion,
estatus = 'ACTIVO'
where	no_empresa = v_ins_no_empresa
and		id_codigo = v_ins_id_codigo
and		id_subcodigo = v_ins_id_subcodigo;
else
insert	into fecxp_cat_subcodigo(secuencia_cod_sub, no_empresa, id_codigo, id_subcodigo, desc_subcodigo, cla_fe_id, fecha_modificacion)
values (nextval('secuencia_cod_sub'), v_ins_no_empresa, v_ins_id_codigo, v_ins_id_subcodigo, v_ins_desc_subcodigo, '', v_fec_ejecucion);
end if;
update	fecxp_cod_sub_bitacora
set		fecha_modificacion = v_fec_ejecucion,
sincronizado_fe = 'SI',
comentario_sincronizado_fe = case v_ins_existe when 1 then '[ALTA]: EL REGISTRO YA EXISTIA. SE ACTUALIZO EN SU DESCRIPCION' else '[ALTA]: EL REGISTRO FUE INSERTADO' end
where	secuencia_cod_sub_bit = v_secuencia_cod_sub_bit;
end if;
if v_accion = 'CAMBIO' then
if v_ins_existe = 1 then
if v_ins_no_empresa = v_del_no_empresa and v_ins_id_codigo = v_del_id_codigo and v_ins_id_subcodigo = v_del_id_subcodigo then
update	fecxp_cat_subcodigo
set		desc_subcodigo = v_ins_desc_subcodigo,
fecha_modificacion = v_fec_ejecucion,
estatus = 'ACTIVO'
where	no_empresa = v_del_no_empresa
and		id_codigo = v_del_id_codigo
and		id_subcodigo = v_del_id_subcodigo;
else
update	fecxp_cat_subcodigo
set		desc_subcodigo = v_ins_desc_subcodigo,
fecha_modificacion = v_fec_ejecucion,
estatus = 'INACTIVO'
where	no_empresa = v_del_no_empresa
and		id_codigo = v_del_id_codigo
and		id_subcodigo = v_del_id_subcodigo;
update	fecxp_cat_subcodigo
set		desc_subcodigo = v_ins_desc_subcodigo,
fecha_modificacion = v_fec_ejecucion,
estatus = 'ACTIVO'
where	no_empresa = v_ins_no_empresa
and		id_codigo = v_ins_id_codigo
and		id_subcodigo = v_ins_id_subcodigo;
end if;
else
insert	into fecxp_cat_subcodigo(secuencia_cod_sub, no_empresa, id_codigo, id_subcodigo, desc_subcodigo, cla_fe_id, fecha_modificacion)
values (nextval('secuencia_cod_sub'), v_ins_no_empresa, v_ins_id_codigo, v_ins_id_subcodigo, v_ins_desc_subcodigo, '', v_fec_ejecucion);
end if;
update	fecxp_cod_sub_bitacora
set		fecha_modificacion = v_fec_ejecucion,
sincronizado_fe = 'SI',
comentario_sincronizado_fe =
case v_ins_existe
when 1 then
case when v_ins_no_empresa = v_del_no_empresa and v_ins_id_codigo = v_del_id_codigo and v_ins_id_subcodigo = v_del_id_subcodigo then
'[CAMBIO]: EL REGISTRO FUE MODIFICADO'
else
'[CAMBIO]: LA LLAVE DEL REGISTRO CAMBIO. FUE INHABILITADO Y SE ACTUALIZO EL REGISTRO CON LA NUEVA LLAVE'
end
else
'[CAMBIO]: EL REGISTRO NO EXISTIA. FUE INSERTADO'
end
where	secuencia_cod_sub_bit = v_secuencia_cod_sub_bit;
end if;
if v_accion = 'BAJA' then
update	fecxp_cat_subcodigo
set		desc_subcodigo = v_ins_desc_subcodigo,
fecha_modificacion = v_fec_ejecucion,
estatus = 'INACTIVO'
where	no_empresa = v_del_no_empresa
and		id_codigo = v_del_id_codigo
and		id_subcodigo = v_del_id_subcodigo;
update	fecxp_cod_sub_bitacora
set		fecha_modificacion = v_fec_ejecucion,
sincronizado_fe = 'SI',
comentario_sincronizado_fe = case v_del_existe when 1 then '[BAJA]: EL REGISTRO FUE INACTIVADO' else '[BAJA]: EL REGISTRO NO EXISTIA. NO HUBO ACCION' end
where	secuencia_cod_sub_bit = v_secuencia_cod_sub_bit;
end if;
end loop; -- implicit close occurs
/* commit; */
-- end;
exception
when no_data_found then
raise exception '%', 'No hay datos nuevos.' using errcode = '45000';end;
$body$
language plpgsql
;
