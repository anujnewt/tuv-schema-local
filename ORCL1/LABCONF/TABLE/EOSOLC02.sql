-- dmap_object_gen_tag : type : index name : eosolc02
set search_path = labconf,oracle,dmap_extension,public;
create index eosolc02 on eolosolc (sol_keyest, sol_keydep, sol_keypue);
