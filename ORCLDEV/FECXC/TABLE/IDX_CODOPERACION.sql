-- dmap_object_gen_tag : type : index name : idx_codoperacion
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_codoperacion on fecxc_enc_clasificados (codoperacion);
