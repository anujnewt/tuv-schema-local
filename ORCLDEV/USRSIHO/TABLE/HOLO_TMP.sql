-- dmap_object_gen_tag : type : table name : holo_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holo_tmp"  (
frp_keyrph numeric(10) not null,
frp_keydep varchar(16) not null,
frp_keyper varchar(7),
frp_fecact timestamp(0),
frp_stsfol varchar(1) not null,
frp_totcos decimal(15, 2) not null,
frp_keyusu numeric(10) not null,
frp_keynom numeric(5) not null,
frp_repeti varchar(3) not null,
frp_tiptra varchar(2),
frp_fecsol timestamp(0),
frp_fecitr timestamp(0),
frp_fectrab timestamp(0),
frp_forpag numeric(10),
frp_tipcam decimal(16, 6),
frp_pertra numeric(10),
frp_tipfol varchar(1),
frp_totemp decimal(15, 2),
frp_keypro numeric(5),
frp_unifor numeric(5),
frp_transp numeric(5),
frp_ident varchar(1),
frp_keyare varchar(6),
frp_desrep varchar(40),
frp_descap varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : holo_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holo_tmp add constraint pk_holo_tmp primary key (frp_keyrph);
-- dmap_object_gen_tag : type : alter table name : holo_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holo_tmp alter column frp_keyrph set not null;
-- dmap_object_gen_tag : type : alter table name : holo_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holo_tmp alter column frp_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : holo_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holo_tmp alter column frp_stsfol set not null;
-- dmap_object_gen_tag : type : alter table name : holo_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holo_tmp alter column frp_totcos set not null;
-- dmap_object_gen_tag : type : alter table name : holo_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holo_tmp alter column frp_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : holo_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holo_tmp alter column frp_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : holo_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holo_tmp alter column frp_repeti set not null;
