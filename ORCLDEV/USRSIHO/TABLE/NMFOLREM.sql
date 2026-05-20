-- dmap_object_gen_tag : type : table name : nmfolrem
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmfolrem"  (
lre_fecha timestamp(0),
lre_numrem numeric(10) not null,
lre_consec numeric(10),
lre_nombre varchar(8)
) ;
-- dmap_object_gen_tag : type : alter table name : nmfolrem
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmfolrem alter column lre_numrem set not null;
