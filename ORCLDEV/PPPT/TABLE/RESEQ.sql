-- dmap_object_gen_tag : type : table name : reseq
set search_path = pppt,oracle,dmap_extension,public;
create table "reseq"  (
idpersonal numeric(38) not null,
fecha timestamp(0) not null,
status numeric(38),
res1 numeric(38),
res2 numeric(38),
res3 numeric(38),
res4 numeric(38),
res5 numeric(38),
res6 numeric(38),
res7 numeric(38),
res8 numeric(38),
res9 numeric(38),
res10 numeric(38),
res11 numeric(38),
res12 numeric(38),
res13 numeric(38),
res14 numeric(38),
res15 numeric(38),
res16 numeric(38),
res17 numeric(38),
res18 numeric(38),
res19 numeric(38),
res20 numeric(38),
res21 numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : reseq
set search_path = pppt,oracle,dmap_extension,public;
alter table reseq alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : reseq
set search_path = pppt,oracle,dmap_extension,public;
alter table reseq alter column fecha set not null;
