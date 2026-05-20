-- dmap_object_gen_tag : type : table name : holopres
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holopres"  (
pre_keydep varchar(16) not null,
pre_keypue varchar(16) not null,
pre_presup decimal(16, 2) not null,
pre_ejerci decimal(16, 2) not null,
pre_pagado decimal(16, 2),
pre_anio numeric(5) not null,
pre_status varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : holopres
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopres add constraint pk_hpres primary key (pre_anio,pre_keydep,pre_keypue);
-- dmap_object_gen_tag : type : alter table name : holopres
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopres alter column pre_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : holopres
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopres alter column pre_keypue set not null;
-- dmap_object_gen_tag : type : alter table name : holopres
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopres alter column pre_presup set not null;
-- dmap_object_gen_tag : type : alter table name : holopres
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopres alter column pre_ejerci set not null;
