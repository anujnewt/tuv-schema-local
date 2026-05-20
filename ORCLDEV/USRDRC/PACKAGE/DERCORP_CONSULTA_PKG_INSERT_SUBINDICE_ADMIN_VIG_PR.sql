create or replace procedure usrdrc.dercorp_consulta_pkg_insert_subindice_admin_vig_pr (piinidflex numeric ,piinidemp numeric ,postrefnotapies inout varchar ) as $body$
declare
i record;
-- pgv moved types start
-- pgv moved types end
lstrefnotapie  varchar(32000);
lisubindice    numeric;
liexisteval_c8 numeric;
ref_nota_pie_cur  cursor(piidflex numeric, piidemp  numeric)
for
--jjaq 06/12/2016 indice desde 1
/* select t1.val_c8, rownum as subindice, id_meta_row
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
;
*/
select t1.val_c8, row_number() over () as subindice
from (
select  distinct(val_c8) as val_c8, coalesce((select  cod_cat_val
from dercorp_add_campo_cat_val_tab
where 1=1
and id_catalogo_valor  (val_c8)), 0) as subindice
--, id_meta_row
--from    dercorp_metatbl_tab
from    dercorp_con_adm_vig_tmp
where   1=1
and     id_flex_tbl = piidflex
and     id_empresa  = piidemp
and     nullif(val_c5::text, '') is not null
and     val_c5 > 0
order by val_c8 )t1
;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--jjaq indices desde 1 admin y vigilancia
delete from usrdrc.pendium_indices_admin_vig_tab
where id_empresa  = piinidemp
and   id_flex_tbl = piinidflex;
for i in select * from ref_nota_pie_cur(piinidflex, piinidemp)
loop
begin
--and   id_meta_row = i.id_meta_row;
insert into pendium_indices_admin_vig_tab(
id_empresa,
id_flex_tbl
--id_meta_row
,num_indice
,val_c8
)
values (
piinidemp,
piinidflex
--i.id_meta_row
,i.subindice
,i.val_c8
);
exception
when no_data_found then
lstrefnotapie :=sqlerrm;
end;
end loop;end;
$body$
language plpgsql
;
