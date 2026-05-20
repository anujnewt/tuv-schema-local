-- dmap_object_gen_tag : type : index name : det_pres_diario_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index det_pres_diario_fk on fecxc_det_pres_diario (sec_presup);
