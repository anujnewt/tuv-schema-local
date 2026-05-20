-- dmap_object_gen_tag : type : table name : glcomoti
set search_path = labconf,oracle,dmap_extension,public;
create table "glcomoti"  (
mot_keymot varchar(6) not null,
mot_desmot varchar(60),
mot_modulo varchar(16),
mot_motsup varchar(6),
mot_keyusu numeric(5),
mot_feccap timestamp(0),
mot_ca1aux varchar(10),
mot_ca2aux varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : glcomoti
set search_path = labconf,oracle,dmap_extension,public;
alter table glcomoti alter column mot_keymot set not null;
