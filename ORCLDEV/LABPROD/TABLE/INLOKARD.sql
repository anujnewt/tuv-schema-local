-- dmap_object_gen_tag : type : table name : inlokard
set search_path = labprod,oracle,dmap_extension,public;
create table "inlokard"  (
kar_keyemp numeric(5),
kar_keycur varchar(8),
kar_keygpo numeric(5),
kar_keydep varchar(16),
kar_keypue varchar(16),
kar_califi decimal(8, 4),
kar_aproba varchar(1),
kar_horcur varchar(5),
kar_keyfte varchar(13),
kar_fecact timestamp(0),
kar_horact varchar(8)
) ;
