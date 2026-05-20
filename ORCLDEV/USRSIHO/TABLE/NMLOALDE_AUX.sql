-- dmap_object_gen_tag : type : table name : nmloalde_aux
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmloalde_aux"  (
ald_keydep varchar(16) not null,
ald_keytpr varchar(6) not null,
ald_keyemp numeric(10),
ald_keyapr varchar(6) not null,
ald_keyeve varchar(6),
ald_pertra varchar(3),
ald_idioma varchar(6),
ald_equcon varchar(15),
ald_fecidur timestamp(0) not null,
ald_fecfdur timestamp(0),
ald_equcpr varchar(15),
ald_ctabaj varchar(20),
ald_marcco varchar(1),
ald_cosgas varchar(1),
ald_keypro numeric(5) not null,
ald_status varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : nmloalde_aux
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmloalde_aux alter column ald_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : nmloalde_aux
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmloalde_aux alter column ald_keytpr set not null;
-- dmap_object_gen_tag : type : alter table name : nmloalde_aux
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmloalde_aux alter column ald_keyapr set not null;
-- dmap_object_gen_tag : type : alter table name : nmloalde_aux
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmloalde_aux alter column ald_fecidur set not null;
-- dmap_object_gen_tag : type : alter table name : nmloalde_aux
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmloalde_aux alter column ald_keypro set not null;
