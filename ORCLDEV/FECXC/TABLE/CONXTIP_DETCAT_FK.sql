-- dmap_object_gen_tag : type : index name : conxtip_detcat_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index conxtip_detcat_fk on fecxc_conceptos_x_tipo (cod_sec_tipcat, cod_sec_lin);
