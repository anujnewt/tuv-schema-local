-- dmap_object_gen_tag : type : table name : auxiliar
set search_path = pppt,oracle,dmap_extension,public;
create table "auxiliar"  (
idauxiliar numeric(38) not null default 0,
id1 numeric(38),
id2 numeric(38),
id3 numeric(38),
id4 numeric(38),
txt1 varchar(50),
txt2 varchar(50),
txt3 varchar(50),
txt4 varchar(50),
txt5 varchar(50),
txt6 varchar(50),
txt7 varchar(50),
txt8 varchar(50),
txt9 varchar(50),
txt10 varchar(50),
txt11 varchar(50),
txt12 varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : auxiliar
set search_path = pppt,oracle,dmap_extension,public;
alter table auxiliar alter column idauxiliar set not null;
