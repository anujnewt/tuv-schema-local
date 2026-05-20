-- dmap_object_gen_tag : type : table name : inlolugs
set search_path = labconf,oracle,dmap_extension,public;
create table "inlolugs"  (
lug_keylug varchar(8),
lug_nomlug varchar(40),
lug_nomcor varchar(20),
lug_nomcon varchar(30),
lug_domlug varchar(30),
lug_collug varchar(20),
lug_cidlug varchar(20),
lug_munlug varchar(6),
lug_entlug varchar(2),
lug_codlug varchar(5),
lug_tellug varchar(30),
lug_costo1 decimal(10, 2),
lug_costo2 decimal(10, 2),
lug_costo3 decimal(10, 2),
lug_unicos varchar(6),
lug_abrlug varchar(5),
lug_cielug varchar(5),
lug_diahab varchar(20),
lug_faxlug varchar(30),
lug_ca1aux varchar(10),
lug_ca2aux varchar(10),
lug_ca3aux varchar(10)
) ;
