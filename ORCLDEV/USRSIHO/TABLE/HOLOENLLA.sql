-- dmap_object_gen_tag : type : table name : holoenlla
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoenlla"  (
enl_numfol numeric(10) not null,
enl_keydep varchar(16) not null,
enl_feclla timestamp(0),
enl_keytpr varchar(6),
enl_nomprd varchar(60),
enl_feccap timestamp(0) not null,
enl_horcom varchar(20),
enl_keypro numeric(5),
enl_auxnu1 numeric(10),
enl_auxca1 varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : holoenlla
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoenlla alter column enl_numfol set not null;
-- dmap_object_gen_tag : type : alter table name : holoenlla
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoenlla alter column enl_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : holoenlla
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoenlla alter column enl_feccap set not null;
