-- dmap_object_gen_tag : type : table name : empagexm
set search_path = usrsiho,oracle,dmap_extension,public;
create table "empagexm"  (
pag_keypag numeric(10) not null,
pag_keydep varchar(16) not null,
pag_keyfor numeric(10) not null,
pag_fecpag timestamp(0) not null,
pag_keyrph numeric(10),
pag_keyenv numeric(10),
pag_keyest numeric(5),
pag_firmas varchar(11),
pag_observ text
) ;
-- dmap_object_gen_tag : type : alter table name : empagexm
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empagexm alter column pag_keypag set not null;
-- dmap_object_gen_tag : type : alter table name : empagexm
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empagexm alter column pag_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : empagexm
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empagexm alter column pag_keyfor set not null;
-- dmap_object_gen_tag : type : alter table name : empagexm
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empagexm alter column pag_fecpag set not null;
