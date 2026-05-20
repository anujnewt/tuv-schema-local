-- dmap_object_gen_tag : type : view name : xxlmk_errores_ord_ln_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxlmk_errores_ord_ln_vw"  ("id_error", "id_ordhdr", "num_linea", "des_error") as select
el.id_error,
l.id_ordhdr,
l.num_linea,
el.des_error
from
xxmor.xxlmk_errores_ord_lns_tab el
join
xxmor.xxlmk_ordln_tab l
on
el.id_linea = l.id_linea
order by
l.num_linea;/* dmap converted statement end */
-- estimed cost of view [ xxlmk_errores_ord_ln_vw ]: 1.00;
