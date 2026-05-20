create or replace procedure fecxc."xxchk_carga_masiva_cheques"  ( --parameters
pdtfecha_emision timestamp(0), pdtfecha_cobro timestamp(0), pdtaccounting_date timestamp(0), pdeimporte decimal, pine_codigo integer, pinid_banco integer, pinid_banco_rep integer, pinno_cheque integer, pinprocesado integer, pinvencido integer, pstcreated_by varchar, pstdesc_cliente varchar, pstentregado_por varchar, pstexpide varchar, pstmoneda varchar, pstreferencia_cliente varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--global variables
gingroup_id                 xxchk_cheq_all_hist.group_id%type;            --it contains the "group_id"
ginid_sec_cheque            xxchk_captura_cheques.id_sec_cheque%type;     --it contains the "id check"
ginorg_id                   integer;
ginset_of_books_id          xxchk_gl_interface_chk.set_of_books_id%type;  --it contains the "set of books"
gstid_cliente               xxchk_captura_cheques.id_cliente%type;        --it contains the "id customer"
gstdesc_cliente             xxchk_captura_cheques.desc_cliente%type;        --it contains the "desc customer"
ginedo_cheque               integer;
gint_dias_diferencia        integer;
gint_antiguedad             xxchk_parametros_generales.antiguedad%type;
gstr_usuario_autoriza       xxchk_parametros_generales.usuario_autoriza%type;
gstr_errores                varchar(500):= null;
cont                        integer;
hay_error                   integer:=0;
--dmap conversion comment: global temp variables moved as local temp variables
cinid_estado_cheque_temp numeric;
cstimagen_temp varchar;
--dmap conversion comment: declaration boundary ends
begin 

-- principal
-- verifica datos correctos
-- validar empresa
select count(1) into strict cont
from fecxc_empresas
where e_codigo = pine_codigo;/* dmap converted statement start */
perform dbms_output.put_line( concat('Empresa', to_char(cont))) ;/* dmap converted statement end */
if cont<1 then
select concat(gstr_errores,'LA EMPRESA ES INCORRECTA, ')
into strict gstr_errores
;
select 1 into strict hay_error;
end if;
--para validar banco
select count(1) into strict cont
from xxchk_catalogo_bancos
where id_banco = pinid_banco;/* dmap converted statement start */
perform dbms_output.put_line( concat('Banco', to_char(cont))) ;/* dmap converted statement end */
if cont<1 then
select concat(gstr_errores,'EL ID BANCO ES INCORRECTO, ')
into strict gstr_errores
;
select 1 into strict hay_error;
end if;
--para validar la referencia del cliente
select count(1) into strict cont
from ra_customers__erp_prod
where orig_system_reference = to_char(pstreferencia_cliente);
if cont<1 then
select concat(gstr_errores,'LA REFERENCIA DEL CLIENTE ES INCORRECTA, ')
into strict gstr_errores
;
select 1 into strict hay_error;
end if;
--para validar moneda
select count(1) into strict cont
from fecxp_monedas
where mon_set = pstmoneda;
if cont<1 then
select concat(gstr_errores,'EL ID MONEDA ES INCORRECTO, ')
into strict gstr_errores
;
select 1 into strict hay_error;
end if;
begin
--valido per?odo contable
call fecxc.xxchk_ver_per_contable (pdtaccounting_date, pine_codigo);
exception
when others then
begin
select concat(gstr_errores,'FECHA DE CREACION FUERA DEL PERIODO CONTABLE (AR), ')
into strict gstr_errores
;
select 1 into strict hay_error;
end;
end;
--valido antig?edad
begin
select dmap_interval_to_days(to_timestamp(pdtfecha_cobro,'DD/MM/YYYY') - to_timestamp(pdtfecha_emision,'DD/MM/YYYY'))
into strict gint_dias_diferencia
;
select antiguedad, usuario_autoriza
into strict gint_antiguedad, gstr_usuario_autoriza
from xxchk_parametros_generales
where e_codigo = pine_codigo;
if pstcreated_by<>gstr_usuario_autoriza then
perform dbms_output.put_line('CREATED BY <> USARIO AUTORIZA');
if gint_dias_diferencia<0 then
perform dbms_output.put_line('Fecha emison > fecha de cobro');
select concat(gstr_errores,'LA FECHA DE EMISION NO PUEDE SER MAYOR QUE LA FECHA DE COBRO. ')
into strict gstr_errores
;
select 1 into strict hay_error;
else
if gint_dias_diferencia>gint_antiguedad then
perform dbms_output.put_line('GDIAS_DIFERENCIA>GINT_ANTIGUEDAD');
select concat(gstr_errores,'EL USUARIO NO TIENE PERMISOS PARA DAR DE ALTA CHEQUES ANTIGUOS. ')
into strict gstr_errores
;
select 1 into strict hay_error;
end if;
end if;
end if;
end;
begin
perform dbms_output.put_line('INICIO');
-- verifica si ek registro ya est? procesado
perform dbms_output.put_line('busco cheque existente');
select count(id_sec_cheque)
into strict ginedo_cheque
from xxchk_captura_cheques
where e_codigo = pine_codigo
and id_banco = pinid_banco
and no_cheque = pinno_cheque
and moneda = pstmoneda
and referencia_cliente = to_char(pstreferencia_cliente);
if ginedo_cheque>0 then
perform dbms_output.put_line('existe cheque');
raise exception 'eno_cheque_found' using errcode = '50001';
else
begin
perform dbms_output.put_line('no existe cheque');/* dmap converted statement start */
perform dbms_output.put_line( concat('Errrores', to_char(gstr_errores))) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Hay error', hay_error)) ;/* dmap converted statement end */
if hay_error=1 then
raise exception 'eno_errores' using errcode = '50007';
else
begin
begin
--it gets the "customer_id"
select customer_id,customer_name
into strict gstid_cliente,gstdesc_cliente --variable global
from ra_customers__erp_prod
where orig_system_reference = to_char(pstreferencia_cliente);
exception
when no_data_found then
raise exception 'eno_customer_found' using errcode = '50002';
end;/* dmap converted statement start */
perform dbms_output.put_line(  concat('ID CLIENTE ', to_char(gstid_cliente))) ;/* dmap converted statement end */
--it gets the "id check"
select nextval('xxchk_sec_id_cheque')
into strict ginid_sec_cheque
;/* dmap converted statement start */
perform dbms_output.put_line(  concat('ID_SEC_CHEQUE ', to_char(ginid_sec_cheque))) ;/* dmap converted statement end */
cstimagen_temp := dmap_extension.f_dmap_get_pkg_var('FECXC' , 'CHK_CARG_MASI_CHK_PKG', 'CSTIMAGEN', 'VARCHAR2', 'N')::varchar;
cinid_estado_cheque_temp := dmap_extension.f_dmap_get_pkg_var('FECXC' , 'CHK_CARG_MASI_CHK_PKG', 'CINID_ESTADO_CHEQUE', 'NUMBER', 'N')::numeric;
--it creates the check' head of the check
insert into xxchk_captura_cheques(
id_sec_cheque,
e_codigo,
id_banco,
id_estado_cheque,
no_cheque,
referencia_cliente,
id_cliente,
fecha_emision,
fecha_cobro,
date_created,
created_by,
modified_by,
importe,
moneda,
entregado_por,
expide,
imagen,
vencido,
desc_cliente,
procesado,
id_banco_rep
)
values (ginid_sec_cheque, pine_codigo, pinid_banco, cinid_estado_cheque_temp, pinno_cheque, pstreferencia_cliente, gstid_cliente, pdtfecha_emision, pdtfecha_cobro, pdtaccounting_date, pstcreated_by, chk_carg_masi_chk_pkg.cstmodified_by, pdeimporte, pstmoneda, pstentregado_por, pstexpide, cstimagen_temp, pinvencido, gstdesc_cliente, pinprocesado, pinid_banco_rep);
call dmap_extension.p_dmap_set_pkg_var('FECXC' , 'CHK_CARG_MASI_CHK_PKG', 'CINID_ESTADO_CHEQUE', 'NUMBER',(cinid_estado_cheque_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('FECXC' , 'CHK_CARG_MASI_CHK_PKG', 'CSTIMAGEN', 'VARCHAR2',(cstimagen_temp)::text, 'N');
perform dbms_output.put_line('INSERTO CABECERO');
begin
select estado_inicial_chk
into strict ginedo_cheque
from xxchk_parametros_generales
where e_codigo = pine_codigo;
exception
when no_data_found then
raise exception 'eno_ginedo_cheque_found' using errcode = '50005';
end;
begin
call fecxc.xxchk_envia_chks_manual (ginid_sec_cheque,chk_carg_masi_chk_pkg.cstmodified_by,ginedo_cheque);
perform dbms_output.put_line('PASO ENVIA CHEQUE MANUAL');
end;
end;
end if;
end;
end if;
exception
when sqlstate '50006' then
raise exception '%', 'FECHA DE CREACION FUERA DEL PERIODO CONTABLE (AR). ' using errcode = '45000';
when sqlstate '50001' then
raise exception '%', 'CHEQUE YA PROCESADO.' using errcode = '45000';
when sqlstate '50007' then
raise exception '%', gstr_errores using errcode = '45000';
when sqlstate '50002' then
select concat(gstr_errores,'NO SE ENCOTRO EL CLIENTE.')
into strict gstr_errores
;
raise exception '%', gstr_errores using errcode = '45000';
when sqlstate '50003' then
select concat(gstr_errores,'NO SE ENCONTRO EL ID DE LA ORGANIZACION.')
into strict gstr_errores
;
raise exception '%', gstr_errores using errcode = '45000';
when sqlstate '50004' then
select concat(gstr_errores,'NO SE ENCONTRO EL LIBRO CONTABLE.')
into strict gstr_errores
;
raise exception '%', gstr_errores using errcode = '45000';
when sqlstate '50005' then
select concat(gstr_errores,'NO SE ENCONTRO EL ESTADO INICIAL DEL CHEQUE.')
into strict gstr_errores
;
raise exception '%', gstr_errores using errcode = '45000';
when others then
raise exception '%', 'ERROR: FAVOR DE VERIFICAR LAYOUT Y CONEXION A BASE' using errcode = '45000';
end;end;
$body$
language plpgsql
;
