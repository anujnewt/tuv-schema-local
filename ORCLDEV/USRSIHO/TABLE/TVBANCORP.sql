-- dmap_object_gen_tag : type : table name : tvbancorp
set search_path = usrsiho,oracle,dmap_extension,public;
create table "tvbancorp"  (
cor_keycia varchar(240),
cor_orgid numeric(10) not null,
cor_provee varchar(240),
cor_keyrfc varchar(30) not null,
cor_sucurs varchar(15),
cor_forpag varchar(25),
cor_keyemp varchar(115),
cor_fecalt timestamp(0),
cor_fecbaj timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : tvbancorp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table tvbancorp add constraint pk_banco primary key (cor_orgid,cor_keyrfc);
-- dmap_object_gen_tag : type : alter table name : tvbancorp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table tvbancorp alter column cor_orgid set not null;
-- dmap_object_gen_tag : type : alter table name : tvbancorp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table tvbancorp alter column cor_keyrfc set not null;
