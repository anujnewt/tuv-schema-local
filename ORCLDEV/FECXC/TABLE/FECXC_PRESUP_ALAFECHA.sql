-- dmap_object_gen_tag : type : table name : fecxc_presup_alafecha
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_presup_alafecha"  (
segmento numeric(38),
codmoneda varchar(3),
presup_alafecha decimal(20, 4),
presupreal_alafecha decimal(20, 4)
) ;
