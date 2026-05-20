-- dmap_object_gen_tag : type : index name : ix_detpetco1
set search_path = usrsiho,oracle,dmap_extension,public;
create index ix_detpetco1 on detpetco (dpc_numpco, dpc_idereg);
