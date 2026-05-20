-- dmap_object_gen_tag : type : index name : idx_f_deposito
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_f_deposito on fecxc_enc_clasificados (f_deposito);
