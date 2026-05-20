create or replace procedure usrdrc.dercorp_consulta_pkg_get_adm_vig_ref_nota_pie_pr (piinidflex numeric ,piinidemp numeric ,postrefnotapies inout varchar ) as $body$
declare
i record;
-- pgv moved types start
-- pgv moved types end
lstrefnotapie varchar(32000);
lisubindice   numeric;
lstsubini  varchar(32000) := '<sup class=''superIndice''>';
lstsubfin  varchar(32000) := '</sup>';
ref_nota_pie_cur  cursor(piidflex numeric, piidemp  numeric)
for
/*select  distinct(val_c8), nvl((select  cod_cat_val
from dercorp_add_campo_cat_val_tab
where 1=1
and id_catalogo_valor  (val_c8)), 0) as subindice
--from    dercorp_metatbl_tab
from    dercorp_con_adm_vig_tmp
where   1=1
and     id_flex_tbl = piidflex
and     id_empresa  = piidemp
and     val_c5 is not null
and     val_c5 > 0
order by val_c8
;
--jjaq 06/12/2016 indice desde 1
select t1.val_c8, rownum as subindice, id_meta_row
from (
select  distinct(val_c8) as val_c8, nvl((select  cod_cat_val
from dercorp_add_campo_cat_val_tab
where 1=1
and id_catalogo_valor  (val_c8)), 0) as subindice, id_meta_row
--from    dercorp_metatbl_tab
from    dercorp_con_adm_vig_tmp
where   1=1
and     id_flex_tbl = piidflex
and     id_empresa  = piidemp
and     val_c5 is not null
and     val_c5 > 0
order by val_c8 )t1
;*/
--ulr indice desde 1 sin repetir registros
--select t1.val_c8
--from (
select  distinct(tmp.val_c8) as val_c8, (select num_indice
from pendium_indices_admin_vig_tab ind
where 1           = 1
and   ind.val_c8 = tmp.val_c8
and   ind.id_flex_tbl = piidflex
and   ind.id_empresa = piidemp)as subindice
--from    dercorp_metatbl_tab
from    dercorp_con_adm_vig_tmp tmp
where   1=1
and     id_flex_tbl = piidflex
and     id_empresa  = piidemp
and     nullif(val_c5::text, '') is not null
and     val_c5 > 0
order by tmp.val_c8
--)t1
;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--lisubindice :=0;
for i in select * from ref_nota_pie_cur(piinidflex, piinidemp)
loop
begin
--lisubindice :=lisubindice +1;
select  val_cat_val
into strict    lstrefnotapie
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo_valor = i.val_c8
;/* dmap converted statement start */
postrefnotapies :=  concat(postrefnotapies, chr(13), '<br>', lstrefnotapie, lstsubini, i.subindice, lstsubfin) ;/* dmap converted statement end */
exception
when no_data_found then
lstrefnotapie:= null;/* dmap converted statement start */
postrefnotapies :=  concat(postrefnotapies, chr(13), lstrefnotapie, i.subindice) ;/* dmap converted statement end */
end;
end loop;end;
$body$
language plpgsql
;
