-- dmap_object_gen_tag : type : index name : ps_ipw_msgconcs01
set search_path = labconf,oracle,dmap_extension,public;
create index ps_ipw_msgconcs01 on ps_tpw_msgxconcs (msgs_keypro, msgs_keyper);
