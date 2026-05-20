-- dmap_object_gen_tag : type : table name : glcodeco
set search_path = labppto,oracle,dmap_extension,public;
create table "glcodeco"  (
dco_razsoc varchar(60),
dco_numlic numeric(38),
dco_idenpc varchar(16),
dco_sisope varchar(20),
dco_fecreg timestamp(0),
dco_cvelic varchar(25)
) ;
