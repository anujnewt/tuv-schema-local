create or replace procedure usrdrc.dercorp_consulta_pkg_get_aes_otros_acuerdos_pr (porcrsresultado inout refcursor ,piinidmetarow numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select val_c8  as aprob_dic_fiscal
,val_c92 as decre_dividendos
,val_c22 as ratifi_consejeros
,val_c23 as ratifi_funcionarios
,val_c24 as ratifi_comisarios
,val_c25 as desig_consejeros
,val_c26 as desig_funcionarios
,val_c27 as desig_comisarios
,val_c29 as otorga_poderes
,val_c30 as revoca_poderes
from  dercorp_metatbl_tab
where 1=1
and   id_meta_row = piinidmetarow
;end;
$body$
language plpgsql
;
