-- dmap_object_gen_tag : type : index name : ix_detsolact1
set search_path = usrsiho,oracle,dmap_extension,public;
create index ix_detsolact1 on detsolact (dsa_numsol, dsa_idereg);
