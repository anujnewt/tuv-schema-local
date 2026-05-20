create or replace procedure usrdrc.dercorp_consulta_pkg_get_cap_fij_var_soc_aum_dis_pr (porcrsresultado inout refcursor ,piinidmetarow numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select  val_c9  as capital_fijo_aum,
val_c10 as de_cap_fij_aum,
val_c11 as con_cap_fij_aum,
val_c12 as quedar_cap_fij_aum,
val_c13 as capital_variable_aum,
val_c14 as de_cap_var_aum,
val_c15 as con_cap_var_aum,
val_c16 as quedar_cap_var_aum,
val_c17 as capital_social_aum,
val_c43 as capital_fijo_dis,
val_c44 as de_cap_fij_dis,
val_c45 as con_cap_fij_dis,
val_c46 as quedar_cap_fij_dis,
val_c47 as capital_variable_dis,
val_c48 as de_cap_var_dis,
val_c49 as con_cap_var_dis,
val_c50 as quedar_cap_var_dis,
val_c51 as capital_social_dis,
val_c52 as capital_total
from    dercorp_metatbl_tab
where   1=1
and   id_meta_row = piinidmetarow
;end;
--ecm 04 agosto 2016 obtener los valores de los campos restantes en fusion.
$body$
language plpgsql
;
