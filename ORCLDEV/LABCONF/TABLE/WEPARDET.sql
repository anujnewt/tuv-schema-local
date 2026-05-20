-- dmap_object_gen_tag : type : table name : wepardet
set search_path = labconf,oracle,dmap_extension,public;
create table "wepardet"  (
det_cvedet numeric(38) not null,
det_cvemen numeric(38),
det_cvepro numeric(38),
det_numpad numeric(38),
det_numpos numeric(38),
det_valper varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : wepardet
set search_path = labconf,oracle,dmap_extension,public;
alter table wepardet add primary key (det_cvedet);
