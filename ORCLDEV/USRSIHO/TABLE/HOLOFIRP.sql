-- dmap_object_gen_tag : type : table name : holofirp
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holofirp"  (
fir_keypro numeric(5) not null,
fir_keyapr varchar(6) not null,
fir_keynom numeric(5) not null,
fir_keydep varchar(16) not null,
fir_codvb1 numeric(10),
fir_codvb2 numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : holofirp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holofirp add constraint pk_hfirp primary key (fir_keypro,fir_keyapr,fir_keynom,fir_keydep);
-- dmap_object_gen_tag : type : alter table name : holofirp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holofirp alter column fir_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : holofirp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holofirp alter column fir_keyapr set not null;
-- dmap_object_gen_tag : type : alter table name : holofirp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holofirp alter column fir_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : holofirp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holofirp alter column fir_keydep set not null;
