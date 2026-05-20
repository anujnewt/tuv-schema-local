-- dmap_object_gen_tag : type : view name : dercorp_rep_est_columns_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "dercorp_rep_est_columns_vw"  ("id_empresa", "grupo", "accionista", "rfc", "pais_residencia", "cf", "cv", "porcentaje", "total") as select cs2.id_empresa,
'Grupo' as grupo,
oracle.substr(cs2.cadena,  1 , instr(cs2.cadena,  '|',  1,  1)-1) as accionista,
'RFC' as rfc,
'Pais de Residencia' as pais_residencia,
oracle.substr(cs2.cadena,  instr(cs2.cadena, '|',  1,  1)+1,  instr(cs2.cadena, '|', 1, 2)-instr(cs2.cadena, '|', 1, 1)-1) as cf,
oracle.substr(cs2.cadena,  instr(cs2.cadena, '|',  1,  2)+1,  instr(cs2.cadena, '|', 1, 3)-instr(cs2.cadena, '|', 1, 2)-1) as cv,
'Porcentaje' as porcentaje,
oracle.substr(cs2.cadena,  instr(cs2.cadena, '|',  -1,  1)+1) as "total"
from (
select
cs.id_empresa,
xxtv_capital_soc_pkg_get_columns_fn(cs.id_empresa) as "cadena"
from dercorp_rep_estcapsoc_vw cs) cs2;/* dmap converted statement end */
-- estimed cost of view [ dercorp_rep_est_columns_vw ]: 1.00;
