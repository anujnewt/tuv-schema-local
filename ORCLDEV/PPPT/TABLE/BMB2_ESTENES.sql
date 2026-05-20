-- dmap_object_gen_tag : type : table name : bmb2_estenes
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb2_estenes"  (
idpruebaabc numeric(38) not null,
idx1 numeric(38),
idx2 numeric(38),
idx3 numeric(38),
idx4 numeric(38),
idx5 numeric(38),
idx6 numeric(38),
idx7 numeric(38),
idx8 numeric(38),
idx9 numeric(38),
idx10 numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb2_estenes
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb2_estenes alter column idpruebaabc set not null;
