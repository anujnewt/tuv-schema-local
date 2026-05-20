-- dmap_object_gen_tag : type : index name : idx_nmloinfo_01
set search_path = labprod,oracle,dmap_extension,public;
create index idx_nmloinfo_01 on nmloinfo (inf_keyemp);
