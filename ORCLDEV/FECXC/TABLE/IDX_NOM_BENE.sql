-- dmap_object_gen_tag : type : index name : idx_nom_bene
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_nom_bene on fecxc_enc_clasificados (nom_bene);
