-- dmap_object_gen_tag : type : table name : hoctaban
set search_path = usrsiho,oracle,dmap_extension,public;
create table "hoctaban"  (
cta_keypro numeric(5) not null,
cta_keyban numeric(5) not null,
cta_ctaban varchar(11) not null,
cta_sucban varchar(4),
cta_contrato varchar(12)
) ;
-- dmap_object_gen_tag : type : alter table name : hoctaban
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hoctaban alter column cta_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : hoctaban
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hoctaban alter column cta_keyban set not null;
-- dmap_object_gen_tag : type : alter table name : hoctaban
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hoctaban alter column cta_ctaban set not null;
