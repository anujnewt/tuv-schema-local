create or replace procedure usrdrc.dercorp_consulta_pkg_get_adm_vig_nombre_suplente_pr (piinidmetarow numeric ,piinidempresa numeric ,piinidflex numeric ,poinsuperindice inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
pisuperindice numeric;
pivalor_c8    varchar(3000);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
/*select  cod_cat_val
into    pisuperindice
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo_valor = (select val_c8
from   dercorp_metatbl_tab
where  1=1
and    id_meta_row = piinidmetarow
)
;*/
--jjaq para asignar numero de indice desde 1
/* select num_indice into    pisuperindice
from pendium_indices_admin_vig_tab
where 1           = 1
and   id_meta_row = piinidmetarow
order by  val_c8;
*/
select val_c8 into strict pivalor_c8
from   dercorp_metatbl_tab
where  1=1
and    id_meta_row = piinidmetarow;
select num_indice into strict    pisuperindice
from pendium_indices_admin_vig_tab ind
where 1           = 1
and   ind.val_c8 = pivalor_c8
and   ind.id_flex_tbl = piinidflex
and   ind.id_empresa = piinidempresa;
poinsuperindice := pisuperindice;
exception
when no_data_found then
pisuperindice := 0;
poinsuperindice := pisuperindice;end;
$body$
language plpgsql
;
