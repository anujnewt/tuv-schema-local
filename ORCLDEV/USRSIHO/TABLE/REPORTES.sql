-- dmap_object_gen_tag : type : table name : reportes
set search_path = usrsiho,oracle,dmap_extension,public;
create table "reportes"  (
rep_keyfol numeric(10) not null,
rep_fecrep timestamp(0),
rep_fecasi timestamp(0),
rep_fecsol timestamp(0),
rep_status numeric(5),
rep_severi numeric(5),
rep_descri varchar(400),
rep_tipser numeric(5),
rep_keyusu numeric(5),
rep_keyres numeric(5),
rep_modulo varchar(40),
rep_tierep varchar(8),
rep_tieasi varchar(8),
rep_keyreu numeric(5),
rep_fecten timestamp(0),
rep_feccer timestamp(0),
rep_fecrea timestamp(0),
rep_submod varchar(35),
rep_porcen numeric(5)
) ;
-- dmap_object_gen_tag : type : alter table name : reportes
set search_path = usrsiho,oracle,dmap_extension,public;
alter table reportes alter column rep_keyfol set not null;
