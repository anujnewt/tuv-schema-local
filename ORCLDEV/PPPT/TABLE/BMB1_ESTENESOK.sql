-- dmap_object_gen_tag : type : table name : bmb1_estenesok
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb1_estenesok"  (
idpais numeric(38) not null,
idfactor numeric(38) not null,
leyenda varchar(50),
orden numeric(38),
c1 numeric(38),
c2 numeric(38),
c3 numeric(38),
c4 numeric(38),
c5 numeric(38),
c6 numeric(38),
c7 numeric(38),
c8 numeric(38),
c9 numeric(38),
c10 numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb1_estenesok
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_estenesok alter column idpais set not null;
-- dmap_object_gen_tag : type : alter table name : bmb1_estenesok
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_estenesok alter column idfactor set not null;
