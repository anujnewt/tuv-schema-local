-- dmap_object_gen_tag : type : view name : erp_tmp_cont_exclu
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "erp_tmp_cont_exclu"  ("con_keyfol", "con_keydep", "con_keypue", "con_keyemp", "con_numcap", "con_fecpag", "con_fecpro", "con_cosuni", "con_numerr", "con_stscon", "con_tipfol", "con_numlin", "con_keynom", "con_forpag", "con_tipcam", "con_tiptra", "con_keypro", "con_arefis", "con_descap", "con_fpafin", "con_tcafin", "con_keyrph", "con_keyusu", "con_fecmod", "con_odcori") as select
con_keyfol, con_keydep, con_keypue, con_keyemp, con_numcap, con_fecpag, con_fecpro, con_cosuni, con_numerr,
con_stscon, con_tipfol, con_numlin, con_keynom, con_forpag, con_tipcam, con_tiptra, con_keypro, con_arefis,
con_descap, con_fpafin, con_tcafin, con_keyrph, con_keyusu, con_fecmod, con_odcori
from tmp_cont_exclu;/* dmap converted statement end */
-- estimed cost of view [ erp_tmp_cont_exclu ]: 1.00;
