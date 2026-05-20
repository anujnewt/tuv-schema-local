create or replace procedure fecxc."xxchk_envia_chks_manual"  ( p_id_sec_cheq integer, p_modified_by varchar, p_nuevo_estatus integer ) as $body$
declare
flg0 text;
-- pgv moved types start
-- pgv moved types end
--******************************************************************
-- procedimiento automatico de cambio de estatus y envio de correos
-- creado por soin 'SOLUCIONES INTEGRALES'  (omar hernandez)
--******************************************************************
v_cual_erp         varchar(2);
v_mail_cliente     varchar(50);
v_referencia       xxchk_captura_cheques.referencia_cliente%type;
v_banco            xxchk_captura_cheques.id_banco%type;
v_moneda           xxchk_captura_cheques.moneda%type;
v_empresa          xxchk_captura_cheques.e_codigo%type;
v_importe          xxchk_captura_cheques.importe%type;
v_fecha            xxchk_captura_cheques.date_created%type;
v_procesado        xxchk_captura_cheques.procesado%type;
v_cliente          xxchk_captura_cheques.id_cliente%type;
v_desc_estado      xxchk_catalogo_bancos.descripcion_banco%type;
v_id_estado        xxchk_captura_cheques.id_estado_cheque%type;
v_fecha_original   varchar(10);
v_fecha_c          timestamp(0);
v_usuario          integer:= 1;
v_valida           numeric;
v_valida2          numeric;
v_empresa_val      numeric;
v_combinacion      numeric;
v_combinacion2     numeric;
v_error            numeric;
v_error2           numeric;
v_fin_error        numeric;
v_status                    varchar(50);
v_set_of_books_id           numeric;
v_accounting_date           timestamp(0);
v_currency_code             varchar(3);
v_date_created                 timestamp(0);
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
v_nvo_estado                numeric;
v_libro                       numeric;
v_dec_edo                   varchar(100);
v_moneda_val                  xxchk_captura_cheques.moneda%type;
secuencia1                  integer;
secuencia2                  integer;
incremento                  integer;
valida_moneda                 integer; --ojo ooc
v_cia                       varchar(25);
v_moneda_f                   varchar(15);
not_valid_mon                 exception;
estatus_no_valido             exception;
inserta_gl                   exception;
inserta_gl_interface_chk       exception;
actualiza_interface_chk       exception;
actualiza_historico           exception;
valida_combinacion cursor for
select c.c_abono_erp, c.c_cargo_erp, a.e_codigo, a.moneda
from   xxchk_captura_cheques a,
xxchk_cat_edo_cheque c,
gl.gl_code_combinations__erp_prod d,
fecxc_empresas e,
xxchk_cat_edos g
where  a.id_sec_cheque = p_id_sec_cheq
and    a.e_codigo = c.e_codigo
and    a.id_estado_cheque = c.id_estado_cheque
and   a.e_codigo = e.e_codigo
and   a.id_estado_cheque = g.id_estado_cheque
and   c.c_abono_erp = d.code_combination_id
and   c.contabiliza=1
and   e.cual_erp= 'O'
group by c.c_abono_erp, c.c_cargo_erp, a.e_codigo, a.moneda
order by a.e_codigo ,a.moneda asc;
l_maicon utl_smtp.connection;
begin 

--**************************************************
--  validar si se puede hacer el cambio  de estatus
--**************************************************
if nullif(p_nuevo_estatus::text, '') is not null then
begin
select case when count(*)=0 then 1  else 1 end
into strict      v_nvo_estado
from      xxchk_captura_cheques a,
xxchk_cat_cambios_estado b
where  a.id_sec_cheque = p_id_sec_cheq
and    a.id_estado_cheque = b.id_estado_cheque
and    b.id_estado_b = p_nuevo_estatus;
end;
if  v_nvo_estado = 1 then
update xxchk_captura_cheques a
set id_estado_cheque = p_nuevo_estatus
where a.id_sec_cheque = p_id_sec_cheq;
end if;
else  if nullif(p_nuevo_estatus::text, '') is null then
v_nvo_estado := 1;
end if;
end if;
-- **************************************************
-- valida la empresa a donde pertenece soin u oracle
-- **************************************************
select  cual_erp
into strict    v_cual_erp
from    xxchk_captura_cheques xxcch, fecxc_empresas fcxce
where  xxcch.id_sec_cheque=p_id_sec_cheq
and  fcxce.e_codigo=xxcch.e_codigo;
--**************************************************
--actualiza tabla historico  de los cheques
--que cambiaron de salvo buen cobre manualmente
--**************************************************
insert into xxchk_cheq_all_hist(
e_codigo,
no_cheque,
id_sec_cheque,
modified_by,
tipo_cheq,
referencia_cliente,
procesado,
id_estado_cheque
)
select  a.e_codigo,
a.no_cheque,
a.id_sec_cheque,
p_modified_by,
'Manual',
a.referencia_cliente,
case when v_cual_erp='O' then 1 else 9 end,
a.id_estado_cheque
from       xxchk_captura_cheques a
where   a.id_sec_cheque = p_id_sec_cheq;
perform dbms_output.put_line('NEW');
--****************************************
--actuzaliza gl_interface_chk
--****************************************
open valida_combinacion;
loop
fetch valida_combinacion
into v_valida,v_valida2,v_empresa_val, v_moneda_val;
flg0 := found;
exit when (not flg0);/* dmap converted statement start *//* apply on valida_combinacion */
perform dbms_output.put_line( concat('ENTRO AL CURSOR', to_char(v_valida) , '  ', to_char(v_empresa_val))) ;
exit when (not flg0);
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
else if secuencia1<secuencia2 then
select nextval('xxchk_group_id_abono')
into strict incremento
;
end if;
end if;
end loop;/* dmap converted statement start */
perform dbms_output.put_line( concat('SALIO DE SECUENCIAS', to_char(v_valida) , '  ', to_char(v_empresa_val))) ;/* dmap converted statement end *//* dmap converted statement start */
--***********************************************************
--  valida si existe la code_combination_:id
-- **********************************************************
begin
perform dbms_output.put_line( concat('ENTRO EN ASIGNAR COMBINACION  ', to_char(v_valida))) ;/* dmap converted statement end */
v_combinacion:=v_valida;
v_combinacion2:=v_valida2;/* dmap converted statement start */
perform dbms_output.put_line( concat('ESTO VALE LA COMBINACION DESPUES DE ASIGNAR ', to_char(v_combinacion2))) ;/* dmap converted statement end */
select segment1
into strict   v_cia
from   gl_code_combinations__erp_prod
where  code_combination_id=v_valida;/* dmap converted statement start */
perform dbms_output.put_line( concat('ESTO VALE LA COMPA?IA', to_char(v_cia))) ;/* dmap converted statement end */
select distinct set_of_books_id
into strict   v_libro
from   xxfm_cia_libro_v__erp_prod
where  compania=v_cia;
select distinct currency_code
into strict   v_moneda_f
from   gl.gl_sets_of_books__erp_prod
where  set_of_books_id=v_libro;/* dmap converted statement start */
perform dbms_output.put_line( concat('ESTO VALE EL LIBRO ', to_char(v_libro))) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('ESTO VALE LA MONEDA FUNCIONAL', to_char(v_moneda_f))) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('ESTO VALE LA MONEDA DEL CHEQUE', to_char(v_moneda_val))) ;/* dmap converted statement end */
end;/* dmap converted statement start */
perform dbms_output.put_line( concat('ESTO VALE COMPA?IA DE LA COMBINACION', to_char(v_cia))) ;/* dmap converted statement end */
--***********************************************************
--  valida si existe el tipo de cambio al d?a
-- **********************************************************
if v_moneda_val='MN' then
perform dbms_output.put_line('ENTRO EN ASIGNAR MXP');
select 'MXP' into strict v_moneda_val;
end if;
if v_moneda_val='PC' then
perform dbms_output.put_line('ENTRO EN ASIGNAR PC');
select 'COP' into strict v_moneda_val;
end if;
if v_moneda_val<>v_moneda_f then
begin
perform dbms_output.put_line('ENTRO EN VALIDAR MONEDA EXTRANJERA');
if v_moneda_val='PAD' then select 'ARS' into strict v_moneda_val; end if;
if v_moneda_val='DLA' then select 'AUD' into strict v_moneda_val; end if;
if v_moneda_val='BRA' then select 'BRL' into strict v_moneda_val; end if;
if v_moneda_val='DLC' then select 'CAD' into strict v_moneda_val; end if;
if v_moneda_val='FS'     then select 'CHF' into strict v_moneda_val; end if;
if v_moneda_val='MA'     then select 'DEM' into strict v_moneda_val; end if;
if v_moneda_val='PS'     then select 'ESP' into strict v_moneda_val; end if;
if v_moneda_val='EUR' then select 'EUR' into strict v_moneda_val; end if;
if v_moneda_val='FF'     then select 'FRF' into strict v_moneda_val; end if;
if v_moneda_val='LIE' then select 'GBP' into strict v_moneda_val; end if;
if v_moneda_val='LI'     then select 'ITL' into strict v_moneda_val; end if;
if v_moneda_val='YEN' then select 'JPY' into strict v_moneda_val; end if;
if v_moneda_val='FLH' then select 'NLG' into strict v_moneda_val; end if;
if v_moneda_val='COR' then select 'SEK' into strict v_moneda_val; end if;
if v_moneda_val='DLS' then select 'USD' into strict v_moneda_val; end if;
if v_moneda_val='BOL' then select 'VEB' into strict v_moneda_val; end if;
if v_moneda_val='MN'     then select 'MXP' into strict v_moneda_val; end if;
if v_moneda_val='ARS' then select 'ARS' into strict v_moneda_val; end if;
if v_moneda_val='PC' then select 'COP' into strict v_moneda_val; end if;
select to_char(date_created, 'DD/MM/YYYY')
into strict   v_fecha_original
from   xxchk_captura_cheques
where  id_sec_cheque=p_id_sec_cheq;
select 1
into strict   valida_moneda
from    gl.gl_daily_rates__erp_prod a
where  from_currency=v_moneda_val
and    to_currency=v_moneda_f
and    conversion_type='Corporate'
and    to_char(conversion_date,'DD/MM/YYYY')=v_fecha_original;
exception
when no_data_found then
raise not_valid_mon;
end;
end if;
---------------------------------------------------------------------------
if nullif(v_combinacion::text, '') is not null then
if nullif(v_combinacion2::text, '') is not null then
--*******************************
--validar que tipo de moneda es
--*******************************
if v_moneda_val <> v_moneda_f then --ojo ooc
--****************************************
--para insertar registros en la tabla de gl_interface  de cargo  moneda extranjera
--****************************************
begin
perform dbms_output.put_line('INSERTA CARGO EN INTERFAZ GL CHEQUES MONEDA EXTRANJERA');/* dmap converted statement start */
perform dbms_output.put_line( concat('ESTO VALE EL LIBRO ', to_char(v_libro))) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('ESTO VALE LA MONEDA EN EXTRANJERA ', to_char(v_moneda_val))) ;/* dmap converted statement end *//* dmap converted statement start */
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
select           secuencia,
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
--case grupo when 0 then
--xxchk_group_id_cargo.nextval end as grupo_id,
secuencia1,
reference1,
period_name,
clock_timestamp(),
'SISTEMA'
from (
select distinct      c.id_sec_cheque as secuencia,
c.id_estado_cheque as id_estado,
'NEW',
v_libro as set_of_books_id,
to_char(clock_timestamp(), 'DD/MON/YY')  as fec1,
v_moneda_val as moneda,
to_char(c.date_created, 'DD/MON/YY')  as fecha,
'Corporate'  as usuario,
i.conversion_rate as conversion,
'A',
'ESTATUS_CHEQUE',
'ESTATUS_CHEQUE' as est_2,
c.importe as dr,
0 as cr,
(c.importe*i.conversion_rate) as dr_me,
0 as cr_me,
a.segment1,
a.segment2,
a.segment3,
a.segment4,
a.segment5,
a.segment6,
a.segment7,
0 as grupo,
concat(a.segment1, '-', c.no_cheque, '-', h.descripcion)  as reference1,
to_char(clock_timestamp(), 'MON-YY') as period_name,
clock_timestamp(),
'SISTEMA'
from     gl.gl_code_combinations__erp_prod a,
xxchk_cat_edo_cheque b,
xxchk_captura_cheques c,
xxchk_cheq_all_hist f,
fecxc_empresas g,
xxchk_cat_edos h,
gl.gl_daily_rates__erp_prod i
where    a.code_combination_id = b.c_cargo_erp
and    b.c_cargo_erp = v_valida2
and    b.id_estado_cheque = c.id_estado_cheque
and    c.e_codigo = f.e_codigo
and    c.e_codigo = g.e_codigo
and (nullif(c.procesado::text, '') is null
or     c.procesado = 200)
and    c.id_sec_cheque = p_id_sec_cheq
and    c.id_estado_cheque = h.id_estado_cheque
and    b.e_codigo = c.e_codigo
and    c.e_codigo = v_empresa_val
and    c.referencia_cliente = f.referencia_cliente
and    i.from_currency = v_moneda_val
and    i.to_currency = v_moneda_f
and    i.conversion_type ='Corporate'
and    to_char(i.conversion_date,'DD/MM/YYYY')= v_fecha_original
and    f.procesado = 1
and    b.contabiliza = 1
and    g.cual_erp= 'O'
) alias11;/* dmap converted statement end */
exception
when others then
raise inserta_gl;
end;
--************************************************************************************
-- para insertar registros en la tabla de gl_interface  abono moneda extranjera
--***********************************************************************************
begin
perform dbms_output.put_line('INSERTA ABONO EN INTERFAZ GL CHEQUES MONEDA EXTRANJERA');/* dmap converted statement start */
perform dbms_output.put_line( concat('ESTO VALE EL LIBRO ', to_char(v_libro))) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('ESTO VALE LA MONEDA EN EXTRANJERA', to_char(v_moneda_val))) ;/* dmap converted statement end *//* dmap converted statement start */
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
--case grupo when 0 then
--xxchk_group_id_abono.nextval end as grupo_id,
secuencia1,
reference1,
period_name,
clock_timestamp(),
'SISTEMA'
from (
select distinct
c.id_sec_cheque as secuencia,
c.id_estado_cheque as id_estado,
'NEW',
v_libro as set_of_books_id,
to_char(clock_timestamp(), 'DD/MON/YY')  as fec1,
v_moneda_val as moneda,
to_char(c.date_created, 'DD/MON/YY')  as fecha,
'Corporate'  as usuario,
i.conversion_rate as conversion,
'A',
'ESTATUS_CHEQUE',
'ESTATUS_CHEQUE' as est_2,
0 as dr,
c.importe as cr,
0 as dr_me,
(c.importe*i.conversion_rate) as cr_me,
a.segment1,
a.segment2,
a.segment3,
a.segment4,
a.segment5,
a.segment6,
a.segment7,
0 as grupo,
concat(a.segment1, '-', c.no_cheque, '-', h.descripcion)  as reference1,
to_char(clock_timestamp(), 'MON-YY') as period_name,
clock_timestamp(),
'SISTEMA'
from              gl.gl_code_combinations__erp_prod a,
xxchk_cat_edo_cheque b,
xxchk_captura_cheques c,
xxchk_cheq_all_hist f,
fecxc_empresas g,
xxchk_cat_edos h,
gl.gl_daily_rates__erp_prod i
where           a.code_combination_id = b.c_abono_erp
and             b.c_abono_erp = v_valida
and             b.id_estado_cheque = c.id_estado_cheque
and             c.e_codigo = f.e_codigo
and             c.e_codigo = g.e_codigo
and (nullif(c.procesado::text, '') is null
or              c.procesado = 200)
and             c.id_sec_cheque = p_id_sec_cheq
and            c.id_estado_cheque = h.id_estado_cheque
and            b.e_codigo = c.e_codigo
and             c.e_codigo = v_empresa_val
and             c.referencia_cliente = f.referencia_cliente
and             i.from_currency = v_moneda_val
and             i.to_currency = v_moneda_f
and             i.conversion_type ='Corporate'
and             to_char(i.conversion_date,'DD/MM/YYYY')=v_fecha_original
and             f.procesado = 1
and             b.contabiliza = 1
and             g.cual_erp= 'O'
) alias11;/* dmap converted statement end */
exception
when others then
raise inserta_gl;
end;
else if v_moneda_val = v_moneda_f then
--****************************************
--para insertar registros en la tabla de gl_interface  de cargo moneda local
--****************************************
begin
perform dbms_output.put_line('INSERTA CARGO EN INTERFAZ GL CHEQUES');/* dmap converted statement start */
perform dbms_output.put_line( concat('ESTO VALE EL LIBRO ', to_char(v_libro))) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('CARGO: ESTO VALE LA MONEDA EN MONEDA LOCAL', to_char(v_moneda_val))) ;/* dmap converted statement end *//* dmap converted statement start */
insert into xxchk_gl_interface_chk(
id_sec_cheque,
id_estado_cheque,
status,
set_of_books_id,
accounting_date,
currency_code,
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
--case grupo when 0 then
--xxchk_group_id_cargo.nextval end as grupo_id,
secuencia2,
reference1,
period_name,
clock_timestamp(),
'SISTEMA'
from (
select     distinct
c.id_sec_cheque as secuencia,
c.id_estado_cheque as id_estado,
'NEW',
v_libro as set_of_books_id,
to_char(clock_timestamp(), 'DD/MON/YY')  as fec1,
v_moneda_val as moneda,
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
concat(a.segment1, '-', c.no_cheque, '-', h.descripcion)  as reference1,
to_char(clock_timestamp(), 'MON-YY') as period_name
from      gl.gl_code_combinations__erp_prod a,
xxchk_cat_edo_cheque b,
xxchk_captura_cheques c,
xxchk_cheq_all_hist f,
fecxc_empresas g,
xxchk_cat_edos h
where  a.code_combination_id = b.c_cargo_erp
and    b.c_cargo_erp = v_valida2
and    b.id_estado_cheque = c.id_estado_cheque
and    c.e_codigo = f.e_codigo
and    c.e_codigo = g.e_codigo
and (nullif(c.procesado::text, '') is null
or     c.procesado = 200)
and    c.id_sec_cheque = p_id_sec_cheq
and    c.id_estado_cheque = h.id_estado_cheque
and    b.e_codigo = c.e_codigo
and    c.e_codigo = v_empresa_val
and    c.referencia_cliente = f.referencia_cliente
and    f.procesado = 1
and    b.contabiliza = 1
and    g.cual_erp= 'O'
) alias8;/* dmap converted statement end */
exception
when others then
raise inserta_gl_interface_chk;
end;
--************************************************************************************
-- para insertar registros en la tabla de gl_interface  abono
--***********************************************************************************
begin
perform dbms_output.put_line('INSERTA ABON OEN INTERFAZ GL CHEQUES');/* dmap converted statement start */
perform dbms_output.put_line( concat('ESTO VALE EL LIBRO ', to_char(v_libro))) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('ABONO: ESTO VALE LA MONEDA EN MONEDA LOCAL', to_char(v_moneda_val))) ;/* dmap converted statement end *//* dmap converted statement start */
insert into xxchk_gl_interface_chk(
id_sec_cheque,
id_estado_cheque,
status,
set_of_books_id,
accounting_date,
currency_code,
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
select      secuencia,
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
--case grupo when 0 then
--xxchk_group_id_abono.nextval end as grupo_id,
secuencia2,
reference1,
period_name,
clock_timestamp(),
'SISTEMA'
from (
select distinct
c.id_sec_cheque as secuencia,
c.id_estado_cheque as id_estado,
'NEW',
v_libro as set_of_books_id,
to_char(clock_timestamp(), 'DD/MON/YY')  as fec1,
v_moneda_val as moneda,
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
concat(a.segment1, '-', c.no_cheque, '-', h.descripcion)  as reference1,
to_char(clock_timestamp(), 'MON-YY') as period_name
from    gl.gl_code_combinations__erp_prod a,
xxchk_cat_edo_cheque b,
xxchk_captura_cheques c,
xxchk_cheq_all_hist f,
fecxc_empresas g,
xxchk_cat_edos h
where   a.code_combination_id = b.c_abono_erp
and     b.c_abono_erp = v_valida
and     b.id_estado_cheque = c.id_estado_cheque
and     c.e_codigo = f.e_codigo
and     c.e_codigo = g.e_codigo
and (nullif(c.procesado::text, '') is null
or      c.procesado = 200)
and     c.id_sec_cheque = p_id_sec_cheq
and     c.id_estado_cheque = h.id_estado_cheque
and     c.e_codigo = v_empresa_val
and     b.e_codigo = c.e_codigo
and     c.referencia_cliente = f.referencia_cliente
and     f.procesado = 1
and     b.contabiliza = 1
and     g.cual_erp= 'O'
) alias8;/* dmap converted statement end */
exception
when others then
raise inserta_gl_interface_chk;
end;
end if;
end if;
end if;
end if;
end loop;
close valida_combinacion;
--**********************************************
--genera polizas en la tabal de gl_interface
--*********************************************
begin
perform dbms_output.put_line('INSERTA EN GL_INTERFACE');
insert into gl.gl_interface__erp_prod(
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
period_name
)
select        status,
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
from         xxchk_gl_interface_chk
where         nullif(procesado::text, '') is null;
exception
when others then
raise inserta_gl;
end;
--/* commit; */
--**************************
--actualiza estatus procesado tabla gl_interface
--**************************
begin
perform dbms_output.put_line('ACTUALIZA EN GL_INTERFACE_CHK');
update  xxchk_gl_interface_chk a
set      procesado = (
select 1
from  gl.gl_interface__erp_prod b
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
from  gl.gl_interface__erp_prod b
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
exception
when others then
raise actualiza_interface_chk;
end;
--*******************************************
-- actualiza el campor group id del historico
--*******************************************
begin
perform dbms_output.put_line('ACTUALIZA EN GL_CHEQ_ALL_HIST');
update xxchk_cheq_all_hist a
set    group_id = ( select b.group_id
from   xxchk_gl_interface_chk b,
xxchk_captura_cheques c
where  a.id_sec_cheque = b.id_sec_cheque
and    a.id_estado_cheque = b.id_estado_cheque
and    b.id_sec_cheque = c.id_sec_cheque
and    b.id_estado_cheque = c.id_estado_cheque
and    c.id_sec_cheque = p_id_sec_cheq
and    b.entered_cr = 0
)
where exists (      select 1
from   xxchk_gl_interface_chk b,
xxchk_captura_cheques c
where  a.id_sec_cheque = b.id_sec_cheque
and    a.id_estado_cheque = b.id_estado_cheque
and    b.id_sec_cheque = c.id_sec_cheque
and    b.id_estado_cheque = c.id_estado_cheque
and    c.id_sec_cheque = p_id_sec_cheq
and    b.entered_cr = 0
);
exception
when others then
raise actualiza_historico;
end;
/* commit; */
exception
when actualiza_historico then
rollback;
raise exception '%', 'ERROR AL ACTUALIZAR HISTORICO' using errcode = '45000';
when inserta_gl_interface_chk then
rollback;
raise exception '%', 'ERROR AL INSERTAR EN LA INTERFACE_CHK' using errcode = '45000';
when inserta_gl then
rollback;
raise exception '%', 'ERROR AL INSERTAR EN GL' using errcode = '45000';
when not_valid_mon then
rollback;
raise exception '%', 'NO EXISTE EL TIPO DE CAMBIO PARA LA FECHA ESPECIFICADA' using errcode = '45000';
when estatus_no_valido then
rollback;
raise exception '%', 'CAMBIO DE ESTADO NO V?LIDO' using errcode = '45000';
when actualiza_interface_chk then
rollback;
raise exception '%', 'ERROR AL TRATAR DE ACTUALIZAR INTERFACE_CHK' using errcode = '45000';
when others then
rollback;
raise exception '%', 'SE ENCONTRO UN ERROR AL PROCESAR LA INFORMACI?N, NO SE GENER? MOVIMIENTO' using errcode = '45000';
end;
$body$
language plpgsql
;
