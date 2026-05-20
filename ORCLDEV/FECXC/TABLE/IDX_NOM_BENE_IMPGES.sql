-- dmap_object_gen_tag : type : index name : idx_nom_bene_impges
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_nom_bene_impges on fecxc_enc_impges (nom_bene);
