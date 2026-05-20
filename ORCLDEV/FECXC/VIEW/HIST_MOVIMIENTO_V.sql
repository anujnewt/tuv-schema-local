-- dmap_object_gen_tag : type : view name : hist_movimiento_v
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "hist_movimiento_v"  ("no_empresa", "no_folio_det", "referencia", "id_codigo", "id_subcodigo", "desc_subcodigo") as select hist.no_empresa no_empresa,
hist.no_folio_det no_folio_det,
hist.referencia referencia,
hist.id_codigo id_codigo,
hist.id_subcodigo id_subcodigo,
cats.desc_subcodigo desc_subcodigo
from "hist2movimiento"__sybtsm1 hist, "cat_subcodigo"__sybtsm1 cats
where     hist.no_empresa = cats.no_empresa
and hist.id_codigo = cats.id_codigo
and hist.id_subcodigo = cats.id_subcodigo;/* dmap converted statement end */
-- estimed cost of view [ hist_movimiento_v ]: 1.00;
