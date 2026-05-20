-- dmap_object_gen_tag : type : type name : tvcontab_tvcontab_partefija;
set search_path = labconf,oracle,dmap_extension,public;
drop type  if exists tvcontab_tvcontab_partefija;
-- dmap_object_gen_tag : type : type name : LABCONF.tvcontab_tvcontab_partefija
set search_path = labconf,oracle,dmap_extension,public;
create type LABCONF.tvcontab_tvcontab_partefija as (keyemp labconf.nmlohism.his_keyemp%type, keypro labconf.nmlohism.his_keypro%type,keycon labconf.nmlohism.his_keycon%type, codimp labconf.nmlohism.his_codimp%type,descon labconf.nmloconc.con_descon%type, keycia labconf.nmloproc.pro_keycia%type,keypol labconf.nmloperi.per_keypol%type, cveban labconf.nmcoempl.emp_cveban%type,forpag labconf.nmcoempl.emp_forpag%type, keyben labconf.nmlohism.his_keyben%type,comfam labconf.nmlohism.his_comfam%type, fecmov labconf.nmlohism.his_fecmov%type);
-- dmap_object_gen_tag : type : type name : tvcontab_tvcontab_partefija;
set search_path = labconf,oracle,dmap_extension,public;
drop type  if exists tvcontab_tvcontab_partefija;
-- dmap_object_gen_tag : type : type name : LABCONF.tvcontab_tvcontab_partefija
set search_path = labconf,oracle,dmap_extension,public;
create type LABCONF.tvcontab_tvcontab_partefija as (keyemp labconf.nmlohism.his_keyemp%type, keypro labconf.nmlohism.his_keypro%type,keycon labconf.nmlohism.his_keycon%type, codimp labconf.nmlohism.his_codimp%type,descon labconf.nmloconc.con_descon%type, keycia labconf.nmloproc.pro_keycia%type,keypol labconf.nmloperi.per_keypol%type, cveban labconf.nmcoempl.emp_cveban%type,forpag labconf.nmcoempl.emp_forpag%type, keyben labconf.nmlohism.his_keyben%type,comfam labconf.nmlohism.his_comfam%type, fecmov labconf.nmlohism.his_fecmov%type);
