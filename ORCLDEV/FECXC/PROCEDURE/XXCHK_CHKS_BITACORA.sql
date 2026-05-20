create or replace procedure fecxc."xxchk_chks_bitacora"  ( p_id_sec_cheq integer, p_modified_by varchar, p_nuevo_estatus integer ) as $body$
declare
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
v_date_created      		   timestamp(0);
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
v_libro					   numeric;
v_dec_edo                   varchar(100);
v_moneda_val       		   xxchk_captura_cheques.moneda%type;
secuencia1                  integer;
secuencia2                  integer;
incremento                  integer;
valida_moneda      		   integer; --ojo ooc
v_cia					   varchar(25);
v_moneda_f				   varchar(15);
not_valid_mon      		   exception;
estatus_no_valido  		   exception;
inserta_gl    			   exception;
inserta_gl_interface_chk	   exception;
actualiza_interface_chk	   exception;
actualiza_historico		   exception;
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
--que cambiaron
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
p_nuevo_estatus
from 	  xxchk_captura_cheques a
where   a.id_sec_cheque = p_id_sec_cheq;
exception
when others then
rollback;
raise exception '%', 'ERROR AL ACTUALIZAR HISTORICO' using errcode = '45000';end;
$body$
language plpgsql
;
