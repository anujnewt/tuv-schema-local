-- dmap_object_gen_tag : type : table name : fecxc_caninter_alafecha_pre
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_caninter_alafecha_pre"  (
segmento numeric(38),
canal numeric(38),
codmoneda varchar(3),
mes numeric(38),
presup_mes decimal(20, 4),
presupreal_mes decimal(20, 4)
) ;
