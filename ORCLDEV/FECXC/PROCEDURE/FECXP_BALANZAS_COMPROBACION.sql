create or replace procedure fecxc."fecxp_balanzas_comprobacion"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

----- extrae e inserta los saldos ----
insert into fecxp_saldos_operativo_erp(
secuencia_saldos_opera_erp,
e_codigo,
periodo_extraccion,
mes_de_extraccion,
libro_id,
moneda,
code_combination_id,
oracle_segmento1,
oracle_segmento2,
oracle_segmento3,
oracle_segmento4,
oracle_segmento5,
oracle_segmento6,
oracle_segmento7,
periodo,
mes,
saldo_inicial_mo,
debito_inicial_mo,
credito_inicial_mo,
saldo_final_mo,
saldo_inicial_me,
debito_inicial_me,
credito_inicial_me,
saldo_final_me)
select  nextval('secuencia_saldos_opera_erp'),
gcc.segment1,
(to_char(clock_timestamp(),'YY'))::numeric ,
(to_char(clock_timestamp(),'MM'))::numeric ,
glb.set_of_books_id	as	libro_id,
glb.currency_code	as moneda,
gcc.code_combination_id	as	code_combination_id,
gcc.segment1		as		oracle_segment01,
gcc.segment2		as		oracle_segment02,
gcc.segment3		as		oracle_segment03,
gcc.segment4		as		oracle_segment04,
gcc.segment5		as		oracle_segment05,
gcc.segment6		as		oracle_segment06,
gcc.segment7		as		oracle_segment07,
glb.period_year 	as periodo,
glb.period_num		as mes,
coalesce(glb.begin_balance_dr - glb.begin_balance_cr,0) as saldo_inicial_mo,
coalesce(glb.period_net_dr,0)   as debito_inicial_mo,
coalesce(glb.period_net_cr,0)   as credito_inicial_mo,
coalesce(glb.begin_balance_dr - glb.begin_balance_cr + glb.period_net_dr - glb.period_net_cr,0)  as  saldo_final_mo,
coalesce(glb.begin_balance_dr_beq - glb.begin_balance_cr_beq,0) as saldo_inicial_me,
coalesce(glb.period_net_dr_beq,0) as debito_final_me,
coalesce(glb.period_net_cr_beq,0) as credito_inicial_me,
coalesce(glb.begin_balance_dr_beq-glb.begin_balance_cr_beq+glb.period_net_dr_beq-glb.period_net_cr_beq,0) as saldo_final_me
from	gl_code_combinations__erp_prod gcc, gl_balances__erp_prod glb
where 	glb.currency_code <> 'PSS'
and 	gcc.enabled_flag='Y'
and 	gcc.summary_flag='N'
and 	gcc.chart_of_accounts_id='101'
and		glb.period_year = to_char(clock_timestamp(),'YYYY')
and 	glb.period_num >= 1
and		glb.actual_flag = 'A'
and 	gcc.code_combination_id = glb.code_combination_id;
exception
when no_data_found then
raise exception '%', 'No hay datos nuevos.' using errcode = '45000';end;
$body$
language plpgsql
;
