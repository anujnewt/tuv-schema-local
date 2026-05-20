-- dmap_object_gen_tag : type : view name : xxlmk_err_lin_arch_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxlmk_err_lin_arch_vw"  ("id_error", "id_archivo", "nom_orden", "cve_posicion", "des_error", "num_linea") as select
err.id_error,
err.id_archivo,
err.nom_orden,
err.cve_posicion,
err.des_error,
err.num_linea
from
xxmor.xxlmk_errores_arch_tab err
where
err.cve_posicion = 'L'
order by
err.nom_orden,
err.num_linea;/* dmap converted statement end */
-- estimed cost of view [ xxlmk_err_lin_arch_vw ]: 1.00;
