-- dmap_object_gen_tag : type : table name : fecxp_gl_je_sources
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_gl_je_sources"  (
je_source_name varchar(25) not null,
user_je_source_name varchar(25),
description varchar(240),
attribute1 varchar(150),
attribute2 varchar(150),
attribute3 varchar(150),
attribute4 varchar(150),
attribute5 varchar(150),
context varchar(150),
flag_origen_mc numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_gl_je_sources
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gl_je_sources add constraint pk_fecxp_gl_je_sources primary key (je_source_name);
-- dmap_object_gen_tag : type : alter table name : fecxp_gl_je_sources
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gl_je_sources add constraint ckc_flag_origen_mc_fecxp_gl check (flag_origen_mc is null or (flag_origen_mc between 0 and 1 ));
-- dmap_object_gen_tag : type : alter table name : fecxp_gl_je_sources
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gl_je_sources alter column je_source_name set not null;
