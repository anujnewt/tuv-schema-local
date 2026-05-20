create or replace procedure fecxc.xxmacht_cheques_status_actualiza_chks_status () as $body$
declare
flg0 text;
flg1 text;
-- pgv moved types start
-- pgv moved types end
--*****************************************************************
-- procedimiento  automatico de colsulta de cheques con el set
-- creado por soin soluciones integrales  (omar hernandez)
--*****************************************************************
v_empresa                   xxchk_cheques_all.e_codigo%type;
v_importe          		   xxchk_cheques_all.importe%type;
v_operacion_set    		   xxchk_cheques_all.id_tipo_operacion_set%type;
v_num_cheques      		   integer;
v_fecha            		   xxchk_cheques_all.fec_valor_original%type;
v_from_mail        		   varchar(50);
v_mail_cliente     		   varchar(50);
v_referencia       		   xxchk_captura_cheques.referencia_cliente%type;
v_banco                     varchar(50);
v_moneda                    xxchk_captura_cheques.moneda%type;
v_desc_estado               xxchk_mapeo_de_estados.descripcion%type;
v_grp_id                    integer;
v_usuario          	       integer:= 1;
v_fecha_c          		   timestamp(0);
v_valida           	       numeric;
v_valida2          		   numeric;
v_empresa_val      		   numeric;
v_combinacion      		   numeric;
v_combinacion2     		   numeric;
v_error                     numeric;
v_error2                    numeric;
v_fin_error                 numeric;
v_status                    varchar(50);
v_set_of_books_id           numeric;
v_accounting_date           timestamp(0);
v_currency_code             varchar(3);
v_date_created      timestamp(0);
v_created_by                varchar(30);
v_actual_flag               varchar(1);
v_user_je_category_name     varchar(25);
v_user_je_source_name       varchar(25);
v_currency_convertion_date  timestamp(0);
v_currency_convertion_rate  numeric;
v_segment1                  varchar(25);
v_segment2                  varchar(25);
v_segment3                  varchar(25);
v_segment4                  varchar(25);
v_segment5                  varchar(25);
v_segment6                  varchar(25);
v_segment7                  varchar(25);
v_entered_dr                numeric;
v_entered_cr                numeric;
v_accounted_dr              numeric;
v_accounted_cr              numeric;
v_reference1                varchar(100);
v_reference2                varchar(100);
v_period_name               varchar(2);
v_code_combination_id       numeric;
v_group_id                  numeric;
v_cheque                    numeric;
v_tipo_operacion            numeric;
secuencia1                  integer;
secuencia2                  integer;
incremento                  integer;
fecha_nero                  timestamp(0);
v_moneda_val				   xxchk_captura_cheques.moneda%type;
v_mon                       xxchk_captura_cheques.moneda%type;
-- ***********************************************************************
-- selecciona clientes para mandar los mails de actualizacion de eatados
-- ***********************************************************************
selecciona_clientes cursor for
select c.email_address, a.e_codigo, a.referencia_cliente, a.date_created,
d.descripcion_banco, a.importe, a.moneda
from  xxchk_captura_cheques a,
ra_customers__erp_prod b,
ar_contacts_v__erp_prod c,
xxchk_catalogo_bancos d,
xxchk_cat_edo_cheque e,
fecxc_empresas f,
xxchk_cat_edos g
where  b.customer_id = c.customer_id
and    nullif(c.email_address::text, '') is not null
and    a.referencia_cliente=c.orig_system_reference
and (nullif(a.procesado::text, '') is null
or    a.procesado = 2)
and    a.id_estado_cheque = e.id_estado_cheque
and    e.id_estado_cheque = g.id_estado_cheque
and    g.tipo_operacion in ('ENFIRME','RECHAZADO')
and    e.envia_correo = 1
and    a.id_banco = d.id_banco
and    a.e_codigo = f.e_codigo
and    f.cual_erp = 'O'
group by c.email_address, a.e_codigo, a.referencia_cliente, a.date_created,
d.descripcion_banco, a.importe, a.moneda;
-- *****************************************
-- valida las combinaciones de las cuentas *
-- *****************************************
valida_combinacion cursor for
select c.c_abono_erp, c.c_cargo_erp, a.e_codigo, a.moneda
from   xxchk_captura_cheques a,
xxchk_cheq_all_hist b,
xxchk_cat_edo_cheque c,
apps.gl_code_combinations__erp_prod d,
fecxc_empresas e,
xxchk_mapeo_de_estados f,
xxchk_cat_edos g
where a.e_codigo = b.e_codigo
and   a.referencia_cliente = b.referencia_cliente
and   a.id_sec_cheque = b.id_sec_cheque
and (nullif(a.procesado::text, '') is null
or    a.procesado = 2)
and   b.procesado = 1
and   a.e_codigo = c.e_codigo
and   a.id_estado_cheque = c.id_estado_cheque
and   a.e_codigo = e.e_codigo
and   a.id_estado_cheque = g.id_estado_cheque
and   g.tipo_operacion in ('ENFIRME','SBC','RECHAZADO')
and   c.c_abono_erp = d.code_combination_id
and   c.id_estado_cheque = f.id_estado_cheque
and   c.contabiliza=1
and   e.cual_erp = 'O'
group by c.c_cargo_erp, c.c_abono_erp, a.e_codigo, a.moneda
order by a.e_codigo, a.moneda asc;
-- ********************************************
-- abre la coneccion con el servidor de mails *
-- ********************************************
l_maicon utl_smtp.connection;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--****************************************
---para los registros salvo buen cobro
--****************************************
update  xxchk_captura_cheques b
set  id_estado_cheque =     (select d.id_estado_cheque
from xxchk_cheques_all x1,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where exists (
select   1
from xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where a.e_codigo = x1.e_codigo
and a.importe = x1.importe
and a.referencia_cliente = x1.referencia_cliente
and a.moneda = x1.moneda
and a.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('SBC')
and (nullif(a.procesado::text, '') is null or a.procesado = 2)
group by a.e_codigo,
a.importe,
a.referencia_cliente,
x1.moneda
having count(1) = 1)
and x1.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('SBC')
and (nullif(x1.procesado::text, '') is null or x1.procesado = 2)
and x1.e_codigo = b.e_codigo
and x1.importe = b.importe
and x1.referencia_cliente = b.referencia_cliente
and x1.moneda = b.moneda)
where exists (
select 1
from xxchk_cheques_all x1,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where exists (
select   1
from xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where a.e_codigo = x1.e_codigo
and a.importe = x1.importe
and a.referencia_cliente = x1.referencia_cliente
and a.moneda = x1.moneda
and a.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('SBC')
and (nullif(a.procesado::text, '') is null or a.procesado = 2)
group by a.e_codigo,
a.importe,
a.referencia_cliente,
x1.moneda
having count(1) = 1)
and x1.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('SBC')
and (nullif(x1.procesado::text, '') is null or x1.procesado = 2)
and x1.e_codigo = b.e_codigo
and x1.importe = b.importe
and x1.referencia_cliente = b.referencia_cliente
and x1.moneda = b.moneda);
/* commit; */
--********************************************
--registra los que estan en salvo buen cobro
--********************************************
insert into xxchk_cheq_all_hist(
e_codigo,
no_cheque,
id_sec_cheque,
modified_by,
tipo_cheq,
referencia_cliente,
id_tipo_operacion_set,
procesado,
id_estado_cheque
)
select b.e_codigo, b.no_cheque, b.id_sec_cheque, 'Automatico', 'Automatico',
b.referencia_cliente, x1.id_tipo_operacion_set, null,d.id_estado_cheque
from xxchk_cheques_all x1,
xxchk_mapeo_de_estados c,
xxchk_captura_cheques b,
xxchk_cat_edos d
where exists (select   1
from xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where a.e_codigo = x1.e_codigo
and a.importe = x1.importe
and a.referencia_cliente = x1.referencia_cliente
and a.moneda = x1.moneda
and a.id_tipo_operacion_set =  c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('SBC')
and (nullif(a.procesado::text, '') is null or a.procesado = 2)
group by a.e_codigo,
a.importe,
a.referencia_cliente,
x1.moneda
having count(1) = 1)
and x1.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('SBC')
and (nullif(x1.procesado::text, '') is null or x1.procesado = 2)
and x1.e_codigo = b.e_codigo
and x1.importe = b.importe
and x1.referencia_cliente = b.referencia_cliente
and x1.moneda = b.moneda;
/* commit; */
--****************************************************************
--para poner los registro procesados que son de salvo buen cobro
--****************************************************************
update  xxchk_cheques_all a
set procesado = (
select 1
from   xxchk_captura_cheques b, xxchk_mapeo_de_estados c,  xxchk_cat_edos d
where  a.e_codigo = b.e_codigo
and    a.importe = b.importe
and    a.referencia_cliente=b.referencia_cliente
and    a.moneda = b.moneda
and    a.id_tipo_operacion_set = c.id_tipo_operacion_set
and    c.id_estado_cheque = d.id_estado_cheque
and    d.tipo_operacion = 'SBC'
and    nullif(a.procesado::text, '') is null
group by  a.e_codigo, a.importe, d.tipo_operacion, a.referencia_cliente
having count(1) = 1
)
where exists (
select   1
from  xxchk_captura_cheques b, xxchk_mapeo_de_estados c,  xxchk_cat_edos d
where a.e_codigo = b.e_codigo
and  a.importe = b.importe
and  a.referencia_cliente = b.referencia_cliente
and  a.moneda = b.moneda
and  a.id_tipo_operacion_set = c.id_tipo_operacion_set
and  c.id_estado_cheque = d.id_estado_cheque
and  d.tipo_operacion = 'SBC'
and  nullif(a.procesado::text, '') is null
group by  a.e_codigo,a.importe, d.tipo_operacion, a.referencia_cliente
having   count(1) = 1
);
/* commit; */
--****************************************
--para los registros rechazados o en firme
--****************************************
update xxchk_captura_cheques b
set id_estado_cheque = (select d.id_estado_cheque
from xxchk_cheques_all x1,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where exists (
select   1
from xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where a.e_codigo = x1.e_codigo
and a.importe = x1.importe
and a.referencia_cliente = x1.referencia_cliente
and a.moneda = x1.moneda
and a.id_tipo_operacion_set =
c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and (nullif(a.procesado::text, '') is null or a.procesado = 2)
group by a.e_codigo,
a.importe,
a.referencia_cliente,
x1.moneda
having count(1) = 1)
and x1.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and (nullif(x1.procesado::text, '') is null or x1.procesado = 2)
and x1.e_codigo = b.e_codigo
and x1.importe = b.importe
and x1.referencia_cliente = b.referencia_cliente
and x1.moneda = b.moneda)
where exists (
select 1
from xxchk_cheques_all x1,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where exists (
select   1
from xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where a.e_codigo = x1.e_codigo
and a.importe = x1.importe
and a.referencia_cliente = x1.referencia_cliente
and a.moneda = x1.moneda
and a.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and (nullif(a.procesado::text, '') is null or a.procesado = 2)
group by a.e_codigo,
a.importe,
a.referencia_cliente,
x1.moneda
having count(1) = 1)
and x1.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and (nullif(x1.procesado::text, '') is null or x1.procesado = 2)
and x1.e_codigo = b.e_codigo
and x1.importe = b.importe
and x1.referencia_cliente = b.referencia_cliente
and x1.moneda = b.moneda);
/* commit; */
--************************************************
--registra los que estan en  firme o rechazado
--************************************************
perform dbms_output.put_line('paso historico');
insert into xxchk_cheq_all_hist(
e_codigo,
no_cheque,
id_sec_cheque,
modified_by,
tipo_cheq,
referencia_cliente,
id_tipo_operacion_set,
procesado,
id_estado_cheque
)
select b.e_codigo, b.no_cheque, b.id_sec_cheque, 'Automatico', 'Automatico',
b.referencia_cliente, x1.id_tipo_operacion_set, null,d.id_estado_cheque
from xxchk_cheques_all x1,
xxchk_mapeo_de_estados c,
xxchk_captura_cheques b,
xxchk_cat_edos d
where exists (select   1
from xxchk_cheques_all a,
xxchk_mapeo_de_estados c,
xxchk_cat_edos d
where a.e_codigo = x1.e_codigo
and a.importe = x1.importe
and a.referencia_cliente = x1.referencia_cliente
and a.moneda = x1.moneda
and a.id_tipo_operacion_set =  c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and (nullif(a.procesado::text, '') is null or a.procesado = 2)
group by a.e_codigo,
a.importe,
a.referencia_cliente,
x1.moneda
having count(1) = 1)
and x1.id_tipo_operacion_set = c.id_tipo_operacion_set
and c.id_estado_cheque = d.id_estado_cheque
and d.tipo_operacion in ('ENFIRME', 'RECHAZADO')
and (nullif(x1.procesado::text, '') is null or x1.procesado = 2)
and x1.e_codigo = b.e_codigo
and x1.importe = b.importe
and x1.referencia_cliente = b.referencia_cliente
and x1.moneda = b.moneda;
/* commit; */
--****************************************
--cursor para sacar datos de las personas con correo
--****************************************
open selecciona_clientes;
loop
fetch selecciona_clientes
into v_mail_cliente, v_empresa,
v_referencia, v_fecha,
v_banco, v_importe,
v_moneda;
flg0 := found;
flg1 := found;
exit when (not flg0)or(not flg1);/* apply on selecciona_clientes */
l_maicon :=utl_smtp.open_connection('131.1.13.59',25);
utl_smtp.helo(l_maicon,'Sistemas_automaticos');         ----checar
utl_smtp.mail(l_maicon,'marodriguezg__televisa.com.mx');       ----quien lo manda
utl_smtp.rcpt(l_maicon,v_mail_cliente);/* dmap converted statement start */
utl_smtp.data(l_maicon, concat('From: marodriguezg__televisa.com.mx', utl_tcp.crlf, 'To: ', v_mail_cliente , utl_tcp.crlf , 'Subject: Cambio de Estado en el cheque ' , utl_tcp.crlf , 'DATOS DE LOS CHEQUES ACTUALIZADOS :' , utl_tcp.crlf , ' NO EMPRESA: ' , v_empresa , utl_tcp.crlf , ' REFERENCIA CLIENTE: ' , v_referencia , utl_tcp.crlf , ' FECHA: ' , v_fecha , utl_tcp.crlf , ' BANCO: ' , v_banco , utl_tcp.crlf , ' IMPORTE DEL CHEQUE: ' , v_importe , utl_tcp.crlf , ' TIPO DE CAMBIO: ' , v_moneda)  );/* dmap converted statement end */
end loop;
close selecciona_clientes;
--****************************************************************************
--actualiza el campo de procesado para los registrros que se actualizaron
--****************************************************************************
update xxchk_cheq_all_hist a
set procesado = (select 1
from    xxchk_captura_cheques b, xxchk_mapeo_de_estados c, xxchk_cat_edos d
where   a.e_codigo=b.e_codigo
and     a.referencia_cliente=b.referencia_cliente
and     a.id_tipo_operacion_set=c.id_tipo_operacion_set
and     c.id_estado_cheque = d.id_estado_cheque
and     d.tipo_operacion in ('ENFIRME','RECHAZADO', 'SBC')
and     nullif(a.procesado::text, '') is null
group by  c.id_estado_cheque, a.e_codigo, a.id_tipo_operacion_set, a.referencia_cliente)
where exists (
select 1
from    xxchk_captura_cheques b, xxchk_mapeo_de_estados c, xxchk_cat_edos d
where   a.e_codigo=b.e_codigo
and     a.referencia_cliente=b.referencia_cliente
and     a.id_tipo_operacion_set=c.id_tipo_operacion_set
and     c.id_estado_cheque = d.id_estado_cheque
and     d.tipo_operacion in ('ENFIRME','RECHAZADO','SBC')
and     nullif(a.procesado::text, '') is null
group by  c.id_estado_cheque, a.e_codigo, a.id_tipo_operacion_set, a.referencia_cliente );
/* commit; */
perform dbms_output.put_line('paso historico');
--******************************************************************
--para poner los registro procesados que estan enfirme o rechazados
--******************************************************************
update  xxchk_cheques_all a
set a.procesado = (
select  1
from    xxchk_captura_cheques b, xxchk_cheq_all_hist c, xxchk_mapeo_de_estados d, xxchk_cat_edos e
where   a.e_codigo=b.e_codigo
and     a.importe=b.importe
and     a.referencia_cliente=b.referencia_cliente
and     a.moneda = b.moneda
and     b.e_codigo= c.e_codigo
and     b.referencia_cliente = c.referencia_cliente
and     b.id_sec_cheque = c.id_sec_cheque
and     a.id_tipo_operacion_set = c.id_tipo_operacion_set
and     c.id_tipo_operacion_set = d.id_tipo_operacion_set
and     d.id_estado_cheque      = e.id_estado_cheque
and     e.tipo_operacion   in ('ENFIRME','SBC','RECHAZADO')
group by a.e_codigo, b.referencia_cliente, b.importe, b.moneda, a.id_tipo_operacion_set
)
where exists (
select  1
from    xxchk_captura_cheques b, xxchk_cheq_all_hist c, xxchk_mapeo_de_estados d, xxchk_cat_edos e
where   a.e_codigo=b.e_codigo
and     a.importe=b.importe
and     a.referencia_cliente=b.referencia_cliente
and     a.moneda = b.moneda
and     b.e_codigo= c.e_codigo
and     b.referencia_cliente = c.referencia_cliente
and     b.id_sec_cheque = c.id_sec_cheque
and     a.id_tipo_operacion_set = c.id_tipo_operacion_set
and     c.id_tipo_operacion_set = d.id_tipo_operacion_set
and     d.id_estado_cheque      = e.id_estado_cheque
and     e.tipo_operacion   in ('ENFIRME','SBC','RECHAZADO')
group by a.e_codigo, b.referencia_cliente, b.importe, b.moneda, a.id_tipo_operacion_set
having count(1)=1
);
/* commit; */
--***************************************************************
--para insertar registros en la tabla de gl_interface  de abono *
--***************************************************************
open valida_combinacion;
loop
fetch valida_combinacion
into v_valida,v_valida2,v_empresa_val, v_moneda_val;
flg0 := found;
flg1 := found;
exit when (not flg0)or(not flg1);/* dmap converted statement start *//* apply on valida_combinacion */
perform dbms_output.put_line( concat('ENTRO AL CURSOR VALIDA COMBINACION', to_char(v_valida) , '  ', to_char(v_empresa_val) , '  ', to_char(v_moneda_val))) ;
exit when (not flg0)or(not flg1);
select nextval('xxchk_group_id_abono')
into strict secuencia1
;
select nextval('xxchk_group_id_cargo')
into strict secuencia2
;
if secuencia1>secuencia2 then
select nextval('xxchk_group_id_cargo')
into strict incremento
;
/* commit; */
else if secuencia1<secuencia2 then
select nextval('xxchk_group_id_abono')
into strict incremento
;
/* commit; */
end if;
end if;
end loop;
end;
--***********************************************************
--  valida si existe la code_combination_:id
-- **********************************************************
begin
select  a.code_combination_id
into strict  v_combinacion
from  apps.gl_balances__erp_prod a
where a.code_combination_id = v_valida
group by a.code_combination_id;
select  a.code_combination_id
into strict  v_combinacion2
from  apps.gl_balances__erp_prod a
where a.code_combination_id = v_valida2
group by a.code_combination_id;
if nullif(v_combinacion::text, '') is not null and nullif(v_combinacion2::text, '') is not null then
--*******************************
--validar que tipo de moneda es
--*******************************
perform dbms_output.put_line('ENTRO PRIMER IF');/* dmap converted statement start */
if v_moneda_val <> 'MXP' then
--****************************************************************
--para insertar registros en la tabla de gl_interface  de cargo
--****************************************************************
perform dbms_output.put_line( concat('DIFERENTE MONEDA', to_char(v_valida) , '  ', to_char(v_empresa_val) , '  ', to_char(v_moneda_val))) ;/* dmap converted statement end *//* dmap converted statement start */
insert into xxchk_gl_interface_chk(
id_sec_cheque,
id_estado_cheque,
status,
set_of_books_id,
accounting_date,
currency_code,
currency_conversion_date,
user_currency_conversion_type,
currency_conversion_rate,
actual_flag,
user_je_source_name,
user_je_category_name,
entered_dr,
entered_cr,
accounted_dr,
accounted_cr,
segment1,
segment2,
segment3,
segment4,
segment5,
segment6,
segment7,
group_id,
reference1,
period_name,
date_created,
created_by
)
select
secuencia,
id_estado,
'NEW',
set_of_books_id,
fec1,
moneda,
fecha,
usuario,
conversion,
'A',
'ESTATUS_CHEQUE',
est_2,
dr,
cr,
dr_me,
cr_me,
segment1,
segment2,
segment3,
segment4,
segment5,
segment6,
segment7,
case grupo when 0 then
nextval('xxchk_group_id_cargo') end as grupo_id,
reference1,
period_name,
clock_timestamp(),
'SISTEMA'
from (
select distinct
c.id_sec_cheque as secuencia,
c.id_estado_cheque as id_estado,
'NEW',
d.set_of_books_id,
to_char(clock_timestamp(), 'DD/MON/YY')  as fec1,
c.moneda as moneda, --case c.moneda when mn then mxp end as moneda,
case c.moneda when 'MXP' then null
else clock_timestamp()
end as fecha,
case c.moneda when 'MXP' then null
else 'Corporative'
end as usuario,
case c.moneda when 'MXP' then null
else i.conversion_rate
end as conversion,
clock_timestamp(),
'SISTEMA',
'A',
'ESTATUS_CHEQUE',
'ESTATUS_CHEQUE' as est_2,
c.importe as dr,
0 as cr,
c.importe as dr_me,
0 as cr_me,
a.segment1,
a.segment2,
a.segment3,
a.segment4,
a.segment5,
a.segment6,
a.segment7,
0 as grupo,
concat(a.segment1, '-', 'c.id_sec_cheque')  as reference1,
to_char(clock_timestamp(), 'YY') as period_name    -- now() at time zone current_setting('TIMEZONE') as period_name
from  apps.gl_code_combinations__erp_prod a,
xxchk_cat_edo_cheque b,
xxchk_captura_cheques c,
apps.gl_balances__erp_prod d,
gl_sets_of_books__erp_prod e,
xxchk_cheq_all_hist f,
fecxc_empresas g,
xxchk_cat_edos h,
gl.gl_daily_rates__erp_prod i
where  a.code_combination_id = b.c_cargo_erp
and    b.c_cargo_erp = v_valida2
and    a.code_combination_id = d.code_combination_id
and    d.set_of_books_id = e.set_of_books_id
and    b.id_estado_cheque = c.id_estado_cheque
and    c.e_codigo = f.e_codigo
and    c.e_codigo = g.e_codigo
and    c.id_sec_cheque = f.id_sec_cheque
and    c.referencia_cliente = f.referencia_cliente
and    nullif(c.procesado::text, '') is null
and    c.id_estado_cheque = h.id_estado_cheque
and    h.tipo_operacion in ('ENFIRME','SBC','RECHAZADO')
and    b.e_codigo = c.e_codigo
and    c.e_codigo = v_empresa_val
and    c.moneda = i.from_currency
and    i.from_currency = v_moneda_val
and    i.to_currency = 'MXP'
and    i.conversion_type ='Corporate'
and    i.conversion_date = '31/JAN/2007' --sysdate
and    f.procesado = 1
and    b.contabiliza = 1
and    g.cual_erp= 'O'
)
/* commit; */
--*************************************************************
-- para insertar registros en la tabla de gl_interface  abono
--*************************************************************
insert into xxchk_gl_interface_chk(
id_sec_cheque,
id_estado_cheque,
status,
set_of_books_id,
accounting_date,
currency_code,
currency_conversion_date,
user_currency_conversion_type,
currency_conversion_rate,
actual_flag,
user_je_source_name,
user_je_category_name,
entered_dr,
entered_cr,
accounted_dr,
accounted_cr,
segment1,
segment2,
segment3,
segment4,
segment5,
segment6,
segment7,
group_id,
reference1,
period_name,
date_created,
created_by
)
select  secuencia,
id_estado,
'NEW',
set_of_books_id,
fec1,
moneda,
fecha,
usuario,
conversion,
'A',
'ESTATUS_CHEQUE',
est_2,
dr,
cr,
dr_me,
cr_me,
segment1,
segment2,
segment3,
segment4,
segment5,
segment6,
segment7,
case grupo when 0 then
nextval('xxchk_group_id_abono') end as grupo_id,
reference1,
period_name,
clock_timestamp(),
'SISTEMA'
from (
select distinct
c.id_sec_cheque as secuencia,
c.id_estado_cheque as id_estado,
'NEW',
d.set_of_books_id,
to_char(clock_timestamp(), 'DD/MON/YY')  as fec1,
c.moneda as moneda, --case c.moneda when mn then mxp end as moneda,
case c.moneda when 'MXP' then null
else clock_timestamp()
end as fecha,
case c.moneda when 'MXP' then null
else 'Corporative'
end as usuario,
case c.moneda when 'MXP' then null
else i.conversion_rate
end as conversion,
clock_timestamp(),
'SISTEMA',
'A',
'ESTATUS_CHEQUE',
'ESTATUS_CHEQUE' as est_2,
0 as dr,
c.importe as cr,
0 as dr_me,
c.importe as cr_me,
a.segment1,
a.segment2,
a.segment3,
a.segment4,
a.segment5,
a.segment6,
a.segment7,
0 as grupo,
concat(a.segment1, '-', 'c.id_sec_cheque')  as reference1,
to_char(clock_timestamp(), 'YY') as period_name  --now() at time zone current_setting('TIMEZONE') as period_name
from  apps.gl_code_combinations__erp_prod a,
xxchk_cat_edo_cheque b,
xxchk_captura_cheques c,
apps.gl_balances__erp_prod d,
gl_sets_of_books__erp_prod e,
xxchk_cheq_all_hist f,
fecxc_empresas g,
xxchk_cat_edos h,
gl.gl_daily_rates__erp_prod i
where   a.code_combination_id = b.c_abono_erp
and     b.c_abono_erp = v_valida
and     a.code_combination_id = d.code_combination_id
and     d.set_of_books_id = e.set_of_books_id
and     b.id_estado_cheque = c.id_estado_cheque
and     c.e_codigo = f.e_codigo
and     c.id_sec_cheque = f.id_sec_cheque
and     c.e_codigo = g.e_codigo
and     nullif(c.procesado::text, '') is null
and     c.id_estado_cheque = h.id_estado_cheque
and     h.tipo_operacion in ('ENFIRME','SBC','RECHAZADO')
and     c.e_codigo = v_empresa_val
and     b.e_codigo = c.e_codigo
and     c.referencia_cliente = f.referencia_cliente
and     c.moneda = i.from_currency
and     i.from_currency = v_moneda_val
and     i.to_currency = 'MXP'
and     i.conversion_type = 'Corporate'
and     i.conversion_date = '31/JAN/2007'
and     f.procesado = 1
and     b.contabiliza = 1
and     g.cual_erp= 'O'
)
/* commit; */
end if;/* dmap converted statement end */
if v_moneda_val = 'MXP' then
perform dbms_output.put_line('MISMA MONEDA');/* dmap converted statement start */
--****************************************************************
--para insertar registros en la tabla de gl_interface  de cargo
--****************************************************************
insert into xxchk_gl_interface_chk(
id_sec_cheque,
id_estado_cheque,
status,
set_of_books_id,
accounting_date,
currency_code,
--currency_conversion_date,
--user_currency_conversion_type,
--currency_conversion_rate,
actual_flag,
user_je_source_name,
user_je_category_name,
entered_dr,
entered_cr,
accounted_dr,
accounted_cr,
segment1,
segment2,
segment3,
segment4,
segment5,
segment6,
segment7,
group_id,
reference1,
period_name,
date_created,
created_by
)
select
secuencia,
id_estado,
'NEW',
set_of_books_id,
fec1,
moneda,
'A',
'ESTATUS_CHEQUE',
est_2,
dr,
cr,
dr_me,
cr_me,
segment1,
segment2,
segment3,
segment4,
segment5,
segment6,
segment7,
case grupo when 0 then
nextval('xxchk_group_id_cargo') end as grupo_id,
reference1,
period_name,
clock_timestamp(),
'SISTEMA'
from (
select distinct
c.id_sec_cheque as secuencia,
c.id_estado_cheque as id_estado,
'NEW',
d.set_of_books_id,
to_char(clock_timestamp(), 'DD/MON/YY')  as fec1,
c.moneda as moneda, --case c.moneda when mn then mxp end as moneda,
clock_timestamp(),
'SISTEMA',
'A',
'ESTATUS_CHEQUE',
'ESTATUS_CHEQUE' as est_2,
c.importe as dr,
0 as cr,
c.importe as dr_me,
0 as cr_me,
a.segment1,
a.segment2,
a.segment3,
a.segment4,
a.segment5,
a.segment6,
a.segment7,
0 as grupo,
concat(a.segment1, '-', 'c.id_sec_cheque')  as reference1,
to_char(clock_timestamp(), 'YY') as period_name    -- now() at time zone current_setting('TIMEZONE') as period_name
from  apps.gl_code_combinations__erp_prod a,
xxchk_cat_edo_cheque b,
xxchk_captura_cheques c,
apps.gl_balances__erp_prod d,
gl_sets_of_books__erp_prod e,
xxchk_cheq_all_hist f,
fecxc_empresas g,
xxchk_cat_edos h
where  a.code_combination_id = b.c_cargo_erp
and    b.c_cargo_erp = v_valida2       ---ojo omar
and    a.code_combination_id = d.code_combination_id
and    d.set_of_books_id = e.set_of_books_id
and    b.id_estado_cheque = c.id_estado_cheque
and    c.e_codigo = f.e_codigo
and    c.e_codigo = g.e_codigo
and    c.id_sec_cheque = f.id_sec_cheque
and    c.referencia_cliente = f.referencia_cliente
and    nullif(c.procesado::text, '') is null
and    c.id_estado_cheque = h.id_estado_cheque
and    h.tipo_operacion in ('ENFIRME','SBC','RECHAZADO')
and    b.e_codigo = c.e_codigo
and    c.e_codigo = v_empresa_val
and    c.moneda = v_moneda_val --i.from_currency
and    f.procesado = 1
and    b.contabiliza = 1
and    g.cual_erp= 'O'
)
/* commit; */
--*************************************************************
-- para insertar registros en la tabla de gl_interface  abono
--*************************************************************
insert into xxchk_gl_interface_chk(
id_sec_cheque,
id_estado_cheque,
status,
set_of_books_id,
accounting_date,
currency_code,
--currency_conversion_date,
--user_currency_conversion_type,
--currency_conversion_rate,
actual_flag,
user_je_source_name,
user_je_category_name,
entered_dr,
entered_cr,
accounted_dr,
accounted_cr,
segment1,
segment2,
segment3,
segment4,
segment5,
segment6,
segment7,
group_id,
reference1,
period_name,
date_created,
created_by
)
select  secuencia,
id_estado,
'NEW',
set_of_books_id,
fec1,
moneda,
'A',
'ESTATUS_CHEQUE',
est_2,
dr,
cr,
dr_me,
cr_me,
segment1,
segment2,
segment3,
segment4,
segment5,
segment6,
segment7,
case grupo when 0 then
nextval('xxchk_group_id_abono') end as grupo_id,
reference1,
period_name,
clock_timestamp(),
'SISTEMA'
from (
select distinct
c.id_sec_cheque as secuencia,
c.id_estado_cheque as id_estado,
'NEW',
d.set_of_books_id,
to_char(clock_timestamp(), 'DD/MON/YY')  as fec1,
c.moneda as moneda, --case c.moneda when mn then mxp end as moneda,
clock_timestamp(),
'SISTEMA',
'A',
'ESTATUS_CHEQUE',
'ESTATUS_CHEQUE' as est_2,
0 as dr,
c.importe as cr,
0 as dr_me,
c.importe as cr_me,
a.segment1,
a.segment2,
a.segment3,
a.segment4,
a.segment5,
a.segment6,
a.segment7,
0 as grupo,
concat(a.segment1, '-', 'c.id_sec_cheque')  as reference1,
to_char(clock_timestamp(), 'YY') as period_name  --now() at time zone current_setting('TIMEZONE') as period_name
from  apps.gl_code_combinations__erp_prod a,
xxchk_cat_edo_cheque b,
xxchk_captura_cheques c,
apps.gl_balances__erp_prod d,
gl_sets_of_books__erp_prod e,
xxchk_cheq_all_hist f,
fecxc_empresas g,
xxchk_cat_edos h
where   a.code_combination_id = b.c_abono_erp
and     b.c_abono_erp = v_valida
and     a.code_combination_id = d.code_combination_id
and     d.set_of_books_id = e.set_of_books_id
and     b.id_estado_cheque = c.id_estado_cheque
and     c.e_codigo = f.e_codigo
and     c.id_sec_cheque = f.id_sec_cheque
and     c.e_codigo = g.e_codigo
and     nullif(c.procesado::text, '') is null
and     c.id_estado_cheque = h.id_estado_cheque
and     h.tipo_operacion in ('ENFIRME','SBC','RECHAZADO')
and     c.e_codigo = v_empresa_val
and     b.e_codigo = c.e_codigo
and     c.referencia_cliente = f.referencia_cliente
and     c.moneda = v_moneda_val --i.from_currency
and     f.procesado = 1
and     b.contabiliza = 1
and     g.cual_erp= 'O'
)
/* commit; */
end if;/* dmap converted statement end */
end if;
exception
when no_data_found then perform dbms_output.put_line('NO HAY DATOS');
v_combinacion:= 2;
--v_combinacion2:= 2;
end;
--****************************************************************************
--v_valida = abonno, si abono no es nulo entonces el error esta en  cargo
--****************************************************************************
begin
if v_combinacion = 2  then
select  a.code_combination_id
into strict  v_error
from  apps.gl_balances__erp_prod a
where a.code_combination_id = v_valida
group by a.code_combination_id;/* dmap converted statement start */
/* commit; */
if nullif(v_error::text, '') is not null then
perform dbms_output.put_line( concat('error abono', v_valida , ' ', v_empresa_val)) ;/* dmap converted statement end *//* dmap converted statement start */
insert into xxchk_bit_errores(codigo_error,
desc_error,
id_cheque,
code_combination,
compania,
status_cheque)
select distinct '1','ERROR EN LA CUENTA', a.id_estado_cheque,
concat(d.segment1, d.segment2, d.segment3, d.segment4, d.segment5, d.segment6, d.segment7)  as combinacion,
a.e_codigo, g.descripcion
from  	xxchk_captura_cheques a,
xxchk_cheq_all_hist b,
xxchk_cat_edo_cheque c,
apps.gl_code_combinations__erp_prod d,
fecxc_empresas e,
xxchk_mapeo_de_estados f,
xxchk_cat_edos g
where a.e_codigo = b.e_codigo
and   a.referencia_cliente = b.referencia_cliente
and (nullif(a.procesado::text, '') is null
or    a.procesado = 2)
and   b.procesado =1
and   a.e_codigo = c.e_codigo
and   a.e_codigo = v_empresa_val
and   a.id_estado_cheque = c.id_estado_cheque
and   a.e_codigo = e.e_codigo
and   c.c_cargo_erp = d.code_combination_id
and   c.c_cargo_erp = v_valida2
and   c.id_estado_cheque = f.id_estado_cheque
and   f.id_estado_cheque = g.id_estado_cheque
and   g.tipo_operacion in ('ENFIRME','SBC','RECHAZADO')
and   c.contabiliza=1
and   e.cual_erp= 'O';/* dmap converted statement end */
/* commit; */
end if;
end if;
exception
when no_data_found then perform dbms_output.put_line('NO HAY DATOS');
v_combinacion2:= 2;
end;
--****************************************************************************
--v_valida2 = cargo , si cargo no es nulo entonces el error esta en  abono
--****************************************************************************
begin
if v_combinacion2 = 2 then
select  a.code_combination_id
into strict  v_error2
from  apps.gl_balances__erp_prod a
where a.code_combination_id = v_valida2
group by a.code_combination_id;
/* commit; */
if nullif(v_error2::text, '') is not null then
perform dbms_output.put_line('error cargo' );/* dmap converted statement start */
insert into xxchk_bit_errores(codigo_error,
desc_error,
id_cheque,
code_combination,
compania,
status_cheque)
select distinct '1','ERROR EN LA CUENTA', a.id_estado_cheque,
concat(d.segment1, d.segment2, d.segment3, d.segment4, d.segment5, d.segment6, d.segment7)  as combinacion,
a.e_codigo, g.descripcion
from   xxchk_captura_cheques a,
xxchk_cheq_all_hist b,
xxchk_cat_edo_cheque c,
apps.gl_code_combinations__erp_prod d,
fecxc_empresas e,
xxchk_mapeo_de_estados f,
xxchk_cat_edos g
where a.e_codigo = b.e_codigo
and   a.referencia_cliente = b.referencia_cliente
and (nullif(a.procesado::text, '') is null
or    a.procesado = 2)
and   b.procesado =1
and   a.e_codigo = c.e_codigo
and   a.e_codigo = v_empresa_val
and   a.id_estado_cheque = c.id_estado_cheque
and   a.e_codigo = e.e_codigo
and   c.c_abono_erp = d.code_combination_id
and   c.c_abono_erp = v_valida
and   c.id_estado_cheque = f.id_estado_cheque
and   f.id_estado_cheque = g.id_estado_cheque
and   g.tipo_operacion in ('ENFIRME','SBC','RECHAZADO')
and   c.contabiliza=1
and   e.cual_erp= 'O';/* dmap converted statement end */
/* commit; */
end if;
end if;
exception
when no_data_found then perform dbms_output.put_line('NO HAY DATOS');
v_fin_error:= 1;
end;
begin
if v_fin_error = 1  then
perform dbms_output.put_line('error abono');/* dmap converted statement start */
insert into xxchk_bit_errores(codigo_error,
desc_error,
id_cheque,
code_combination,
compania,
status_cheque)
select distinct '1', 'ERROR EN LA CUENTA', a.id_estado_cheque,
concat(d.segment1, d.segment2, d.segment3, d.segment4, d.segment5, d.segment6, d.segment7)  as combinacion,
a.e_codigo, g.descripcion
from   xxchk_captura_cheques a,
xxchk_cheq_all_hist b,
xxchk_cat_edo_cheque c,
apps.gl_code_combinations__erp_prod d,
xxchk_mapeo_de_estados f,
xxchk_cat_edos g
where a.e_codigo = b.e_codigo
and   a.referencia_cliente = b.referencia_cliente
and (nullif(a.procesado::text, '') is null
or    a.procesado = 2)
and   a.e_codigo = v_empresa_val
and   b.procesado =1
and   a.id_estado_cheque = c.id_estado_cheque
and   c.id_estado_cheque = g.id_estado_cheque
and   g.tipo_operacion in ('ENFIRME','SBC','RECHAZADO')
and   c.c_abono_erp = d.code_combination_id
and   c.c_abono_erp = v_valida
and   a.id_estado_cheque = f.id_estado_cheque;/* dmap converted statement end *//* dmap converted statement start */
/* commit; */
insert into xxchk_bit_errores(codigo_error,
desc_error,
id_cheque,
code_combination,
compania,
status_cheque)
select distinct '1', 'ERROR EN LA CUENTA', a.id_estado_cheque,
concat(d.segment1, d.segment2, d.segment3, d.segment4, d.segment5, d.segment6, d.segment7)  as combinacion,
a.e_codigo, g.descripcion
from   xxchk_captura_cheques a,
xxchk_cheq_all_hist b,
xxchk_cat_edo_cheque c,
apps.gl_code_combinations__erp_prod d,
xxchk_mapeo_de_estados f,
xxchk_cat_edos g
where a.e_codigo = b.e_codigo
and   a.referencia_cliente = b.referencia_cliente
and (nullif(a.procesado::text, '') is null
or    a.procesado = 2)
and   a.e_codigo = v_empresa_val
and   b.procesado =1
and   a.id_estado_cheque = c.id_estado_cheque
and   c.id_estado_cheque = g.id_estado_cheque
and   g.tipo_operacion in ('ENFIRME','SBC','RECHAZADO')
and   c.c_cargo_erp = d.code_combination_id
and   c.c_cargo_erp = v_valida2
and   a.id_estado_cheque = f.id_estado_cheque;/* dmap converted statement end */
/* commit; */
end if;
exception
when no_data_found then
raise exception '%', 'No hay datos nuevos.' using errcode = '45000';
end;
v_fin_error:= null;
v_combinacion:= null;
v_combinacion2:= null;
end loop;
close valida_combinacion;/* dmap converted statement start */
--****************************************
--debitos y creditos en soin
--****************************************
perform dbms_output.put_line( concat('SEGUNDA PARTE', to_char(v_valida) , '  ', to_char(v_empresa_val))) ;/* dmap converted statement end *//* dmap converted statement start */
insert into xxchk_intarc_ora(
e_codigo,
intbat,
intori,
intsub,
intrel,
intdoc,
intref,
intmon,
intmoe,
inttip,
intdes,
intdia,
intfec,
intcam,
ctam01,
ctam02,
ctam03,
ctam04,
ctam05,
ctam06,
moncod,
impfpo,
tv6prd,
impref2,
tv9ide,
date_created,
created_by
)
select c.e_codigo           as empresa,
concat(c.id_sec_cheque, c.referencia_cliente, c.importe, c.importe)  as documento,
'XX'         as origen,
'CK'         as suborigen,
0            as relacion,
concat('  ', b.cr_cargo_soin, b.cr_cargo_soin2)   as documento,
c.referencia_cliente     as referencia,
c.importe    as imp_mon_loc,
c.importe    as imp_mon_ex,
'C'          as tipo_mov,
'MOV XXCHK'  as descripcion,
'DG'         as diario,
'20051201'      as fecha,
1                 as tipo_cambio,
b.c_cargo_soin    as ctam01,
b.sc_cargo_soin   as ctam02,
b.ssc_cargo_soin  as ctam03,
'0000'            as ctam04,
'000'             as ctam05,
'000'             as ctam06,
'01'              as moneda,
'20051201'      as fechapoliza,
null              as tipo_producto,
c.desc_cliente    as seg_ref_mov,
null              as id_del_tercero,
clock_timestamp()           as date_created,
'SISTEMA'         as created_by
from  xxchk_cat_edo_cheque b,
xxchk_captura_cheques c,
xxchk_cheq_all_hist f,
fecxc_empresas g, xxchk_cat_edos h
where  c.e_codigo = f.e_codigo
and    c.referencia_cliente = f.referencia_cliente
and    c.id_estado_cheque = h.id_estado_cheque
and    h.tipo_operacion in ('ENFIRME','SBC','RECHAZADO')
and    c.id_sec_cheque=f.id_sec_cheque
and    b.e_codigo = c.e_codigo
and    b.e_codigo=f.e_codigo
and    b.id_estado_cheque=c.id_estado_cheque
and    g.e_codigo=c.e_codigo
and    g.cual_erp = 'S'
and    nullif(c.procesado::text, '') is null
and    f.procesado = 1
and    b.contabiliza = 1
union all
select c.e_codigo           as empresa,
concat(c.id_sec_cheque, c.referencia_cliente, c.importe, c.importe)  as documento,
'XX'           as origen,
'CK'           as suborigen,
0              as relacion,
concat('  ', b.cr_abono_soin, b.cr_abono_soin2)     as documento,
c.referencia_cliente     as referencia,
c.importe      as imp_mon_loc,
c.importe      as imp_mon_ex,
'D'            as tipo_mov,
'MOV XXCHK'    as descripcion,
'DG'           as diario,
'20051201'     as fecha,
1                 as tipo_cambio,
b.c_abono_soin    as ctam01,
b.sc_abono_soin   as ctam02,
b.ssc_abono_soin  as ctam03,
'0000'            as ctam04,
'000'             as ctam05,
'000'             as ctam06,
'01'              as moneda,
'20051201'    as fechapoliza,
null             as tipo_producto,
c.desc_cliente   as seg_ref_mov,
null             as id_del_tercero,
clock_timestamp()          as date_created,
'SISTEMA'        as created_by
from  xxchk_cat_edo_cheque b,
xxchk_captura_cheques c,
xxchk_cheq_all_hist f,
fecxc_empresas g, xxchk_cat_edos h
where  c.e_codigo = f.e_codigo
and    c.referencia_cliente = f.referencia_cliente
and    c.id_estado_cheque = h.id_estado_cheque
and    h.tipo_operacion in ('ENFIRME','SBC','RECHAZADO')
and    c.id_sec_cheque=f.id_sec_cheque
and    b.e_codigo = c.e_codigo
and    b.e_codigo=f.e_codigo
and    b.id_estado_cheque=c.id_estado_cheque
and    g.e_codigo=c.e_codigo
and    g.cual_erp = 'S'
and    nullif(c.procesado::text, '') is null
and    f.procesado = 1
and    b.contabiliza = 1;/* dmap converted statement end */
/* commit; */
--*******************************************************************
--prueba actualiza el campo procesado con 2 para la siguiente vuelta
--*******************************************************************
update  xxchk_captura_cheques b
set procesado = (
select  2
from    xxchk_cheques_all a,xxchk_cheq_all_hist c, xxchk_mapeo_de_estados d, xxchk_cat_edos e
where   b.e_codigo = a.e_codigo
and     b.importe  = a.importe
and     b.referencia_cliente = a.referencia_cliente
and     b.moneda = a.moneda
and     b.e_codigo= c.e_codigo
and     b.referencia_cliente = c.referencia_cliente
and     b.id_sec_cheque = c.id_sec_cheque
and     a.id_tipo_operacion_set = c.id_tipo_operacion_set
and     c.id_tipo_operacion_set = d.id_tipo_operacion_set
and     d.id_estado_cheque      = e.id_estado_cheque
and     e.tipo_operacion   in ('SBC')
group by a.e_codigo, b.referencia_cliente, b.importe, b.moneda, a.id_tipo_operacion_set
)
where exists (
select  2
from    xxchk_cheques_all a,xxchk_cheq_all_hist c, xxchk_mapeo_de_estados d, xxchk_cat_edos e
where   b.e_codigo = a.e_codigo
and     b.importe  = a.importe
and     b.referencia_cliente = a.referencia_cliente
and     b.moneda = a.moneda
and     b.e_codigo= c.e_codigo
and     b.referencia_cliente = c.referencia_cliente
and     b.id_sec_cheque = c.id_sec_cheque
and     a.id_tipo_operacion_set = c.id_tipo_operacion_set
and     c.id_tipo_operacion_set = d.id_tipo_operacion_set
and     d.id_estado_cheque      = e.id_estado_cheque
and     e.tipo_operacion   in ('SBC')
group by a.e_codigo, b.referencia_cliente, b.importe, b.moneda, a.id_tipo_operacion_set
);
/* commit; */
--******************************************************************
--para poner los registro procesados que estan enfirme o rechazados
--******************************************************************
update  xxchk_captura_cheques b
set procesado = (
select  1
from    xxchk_cheques_all a,xxchk_cheq_all_hist c, xxchk_mapeo_de_estados d, xxchk_cat_edos e
where   b.e_codigo = a.e_codigo
and     b.importe  = a.importe
and     b.referencia_cliente = a.referencia_cliente
and     b.moneda = a.moneda
and     b.e_codigo= c.e_codigo
and     b.referencia_cliente = c.referencia_cliente
and     b.id_sec_cheque = c.id_sec_cheque
and     a.id_tipo_operacion_set = c.id_tipo_operacion_set
and     c.id_tipo_operacion_set = d.id_tipo_operacion_set
and     d.id_estado_cheque      = e.id_estado_cheque
and     e.tipo_operacion   in ('RECHAZADO','ENFIRME')
group by a.e_codigo, b.referencia_cliente, b.importe, b.moneda, a.id_tipo_operacion_set
)
where exists (
select  1
from    xxchk_cheques_all a,xxchk_cheq_all_hist c, xxchk_mapeo_de_estados d, xxchk_cat_edos e
where   b.e_codigo = a.e_codigo
and     b.importe  = a.importe
and     b.referencia_cliente = a.referencia_cliente
and     b.moneda = a.moneda
and     b.e_codigo= c.e_codigo
and     b.referencia_cliente = c.referencia_cliente
and     b.id_sec_cheque = c.id_sec_cheque
and     a.id_tipo_operacion_set = c.id_tipo_operacion_set
and     c.id_tipo_operacion_set = d.id_tipo_operacion_set
and     d.id_estado_cheque      = e.id_estado_cheque
and     e.tipo_operacion   in ('RECHAZADO','ENFIRME')
group by a.e_codigo, b.referencia_cliente, b.importe, b.moneda, a.id_tipo_operacion_set
);
/* commit; */
--********************************************
--genera polizas en la tabal de gl_interface
--********************************************
perform dbms_output.put_line('crear polzas gl');
/*
insert into gl_interface__erp_prod (
status,
set_of_books_id,
accounting_date,
currency_code,
date_created,
created_by,
actual_flag,
user_je_source_name,
user_je_category_name,
currency_conversion_date,
user_currency_conversion_type,
currency_conversion_rate,
entered_dr,
entered_cr,
accounted_dr,
accounted_cr,
segment1,
segment2,
segment3,
segment4,
segment5,
segment6,
segment7,
group_id,
reference1,
period_name)
select    status,
set_of_books_id,
accounting_date,
currency_code,
date_created,
v_usuario,
actual_flag,
user_je_source_name,
user_je_category_name,
currency_conversion_date,
user_currency_conversion_type,
currency_conversion_rate,
entered_dr,
entered_cr,
accounted_dr,
accounted_cr,
segment1,
segment2,
segment3,
segment4,
segment5,
segment6,
segment7,
group_id,
reference1,
period_name
from xxchk_gl_interface_chk
where nullif(procesado::text, '') is null;
/* commit; */
*/
--*******************************************
-- actualiza el campor group id del historico
--*******************************************
update xxchk_cheq_all_hist a
set    group_id = ( select b.group_id
from   xxchk_gl_interface_chk b,
xxchk_captura_cheques c
where  a.id_sec_cheque = b.id_sec_cheque
and    a.id_estado_cheque = b.id_estado_cheque
and    b.id_sec_cheque = c.id_sec_cheque
and    b.id_estado_cheque = c.id_estado_cheque
and    nullif(b.procesado::text, '') is null
and    a.procesado= 1
)
where exists (      select 1
from   xxchk_gl_interface_chk b,
xxchk_captura_cheques c
where  a.id_sec_cheque = b.id_sec_cheque
and    a.id_estado_cheque = b.id_estado_cheque
and    b.id_sec_cheque = c.id_sec_cheque
and    b.id_estado_cheque = c.id_estado_cheque
and    nullif(b.procesado::text, '') is null
and    a.procesado= 1
);
/* commit; */
--**************************************************
--actualiza estatus procesado tabla gl_interface
--**************************************************
update  xxchk_gl_interface_chk a
set procesado = (
select 1
from  gl_interface__erp_prod b
where a.status = b.status
and a.set_of_books_id = b.set_of_books_id
and a.currency_code = b.currency_code
and a.user_je_category_name = b.user_je_category_name
and a.user_je_source_name = b.user_je_source_name
and a.segment1 = b.segment1
and a.segment2 = b.segment2
and a.segment3 = b.segment3
and a.segment4 = b.segment4
and a.segment5 = b.segment5
and a.segment6 = b.segment6
and a.segment7 = b.segment7
and a.entered_dr = b.entered_dr
and a.entered_cr = b.entered_cr
and a.reference1 = b.reference1
and a.group_id = b.group_id
and a.period_name = b.period_name
and nullif(a.procesado::text, '') is null
group by a.status, a.set_of_books_id, a.currency_code,
a.user_je_category_name, a.user_je_source_name,
a.segment1, a.segment2, a.segment3, a.segment4,
a.segment5, a.segment6, a.segment7, a.entered_dr,
a.entered_cr, a.reference1,
a.group_id, a.period_name
)
where exists (
select 1
from  gl_interface__erp_prod b
where a.status = b.status
and a.set_of_books_id = b.set_of_books_id
and a.currency_code = b.currency_code
and a.user_je_category_name = b.user_je_category_name
and a.user_je_source_name = b.user_je_source_name
and a.segment1 = b.segment1
and a.segment2 = b.segment2
and a.segment3 = b.segment3
and a.segment4 = b.segment4
and a.segment5 = b.segment5
and a.segment6 = b.segment6
and a.segment7 = b.segment7
and a.entered_dr = b.entered_dr
and a.entered_cr = b.entered_cr
and a.reference1 = b.reference1
and a.group_id = b.group_id
and a.period_name = b.period_name
and nullif(a.procesado::text, '') is null
group by a.status, a.set_of_books_id, a.currency_code,
a.user_je_category_name, a.user_je_source_name,
a.segment1, a.segment2, a.segment3, a.segment4,
a.segment5, a.segment6, a.segment7, a.entered_dr,
a.entered_cr, a.reference1,
a.group_id, a.period_name
);
/* commit; */
--exception
--when no_data_found then dbms_output.put_line (exception|| to_char(v_combinacion));
--v_combinacion:= 2;
--raise_application_error(-20000,no hay datos nuevos.);
end;
$body$
language plpgsql
;
