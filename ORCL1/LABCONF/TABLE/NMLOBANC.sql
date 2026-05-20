-- dmap_object_gen_tag : type : table name : nmlobanc
set search_path = labconf,oracle,dmap_extension,public;
create table "nmlobanc"  (
ban_keyban varchar(3) not null,
ban_desban varchar(30) not null,
ban_keysuc varchar(4) not null,
ban_dessuc varchar(30),
ban_cenreg varchar(4),
ban_dirsuc varchar(30),
ban_codpos varchar(6),
ban_ciudad varchar(20),
ban_estado varchar(20),
ban_nomleg varchar(40),
ban_rfcleg varchar(14),
ban_telleg varchar(15)
) ;
-- dmap_object_gen_tag : type : alter table name : nmlobanc
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlobanc alter column ban_keyban set not null;
-- dmap_object_gen_tag : type : alter table name : nmlobanc
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlobanc alter column ban_desban set not null;
-- dmap_object_gen_tag : type : alter table name : nmlobanc
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlobanc alter column ban_keysuc set not null;
