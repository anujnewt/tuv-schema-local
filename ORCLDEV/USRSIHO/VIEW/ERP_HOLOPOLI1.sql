-- dmap_object_gen_tag : type : view name : erp_holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "erp_holopoli1"  ("pol_keypol", "pol_ctvpol", "pol_keypro", "pol_keyapr", "pol_keynom", "pol_numemi", "pol_keyrec", "pol_keyemp", "pol_regrfc", "pol_emipag", "pol_tippol", "pol_stspol", "pol_cvepol", "pol_fecpol", "pol_percon", "pol_numrem", "pol_remrec", "pol_totcar", "pol_totabo", "pol_carpas", "pol_abopas", "pol_usugen", "pol_fecgen", "pol_usurem", "pol_fecrem", "pol_usuaut", "pol_fecaut", "pol_contra", "pol_semana", "pol_tipcta", "pol_keymad", "pol_ctvmad", "pol_regfis", "pol_forpag", "pol_tipcam", "pol_fpafin", "pol_tcafin", "pol_auxnu1", "pol_auxca1") as select
pol_keypol, pol_ctvpol, pol_keypro, pol_keyapr, pol_keynom, pol_numemi, pol_keyrec, pol_keyemp, pol_regrfc,
pol_emipag, pol_tippol, pol_stspol, pol_cvepol, pol_fecpol, pol_percon, pol_numrem, pol_remrec, pol_totcar,
pol_totabo, pol_carpas, pol_abopas, pol_usugen, pol_fecgen, pol_usurem, pol_fecrem, pol_usuaut, pol_fecaut,
pol_contra, pol_semana, pol_tipcta, pol_keymad, pol_ctvmad, pol_regfis, pol_forpag, pol_tipcam, pol_fpafin,
pol_tcafin, pol_auxnu1, pol_auxca1
from holopoli1;/* dmap converted statement end */
-- estimed cost of view [ erp_holopoli1 ]: 1.00;
