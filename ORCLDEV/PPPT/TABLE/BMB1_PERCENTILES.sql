-- dmap_object_gen_tag : type : table name : bmb1_percentiles
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb1_percentiles"  (
idpais numeric(38) not null,
leyenda varchar(100),
punt1 varchar(50),
punt2 varchar(50),
punt3 varchar(50),
punt4 varchar(50),
p1 numeric(38),
p2 numeric(38),
p3 numeric(38),
p4 numeric(38),
p5 numeric(38),
p6 numeric(38),
p7 numeric(38),
p8 numeric(38),
p9 numeric(38),
p10 numeric(38),
p11 numeric(38),
p12 numeric(38),
p13 numeric(38),
p14 numeric(38),
p15 numeric(38),
p16 numeric(38),
p17 numeric(38),
p18 numeric(38),
p19 numeric(38),
p20 numeric(38),
p21 numeric(38),
p22 numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb1_percentiles
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_percentiles alter column idpais set not null;
