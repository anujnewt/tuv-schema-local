-- dmap_object_gen_tag : type : table name : nmlobanc
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmlobanc"  (
ban_keyban varchar(3),
ban_desban varchar(30),
ban_keysuc varchar(4),
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
