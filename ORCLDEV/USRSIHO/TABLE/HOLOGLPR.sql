-- dmap_object_gen_tag : type : table name : hologlpr
set search_path = usrsiho,oracle,dmap_extension,public;
create table "hologlpr"  (
glp_keydep varchar(16) not null,
glp_keypue varchar(16) not null,
glp_presup decimal(16, 2) not null,
glp_ejerci decimal(16, 2) not null,
glp_pagado decimal(16, 2),
glp_anio numeric(5) not null,
glp_status varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : hologlpr
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologlpr add constraint pk_hglpr primary key (glp_anio,glp_keydep,glp_keypue);
-- dmap_object_gen_tag : type : alter table name : hologlpr
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologlpr alter column glp_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : hologlpr
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologlpr alter column glp_keypue set not null;
-- dmap_object_gen_tag : type : alter table name : hologlpr
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologlpr alter column glp_presup set not null;
-- dmap_object_gen_tag : type : alter table name : hologlpr
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hologlpr alter column glp_ejerci set not null;
