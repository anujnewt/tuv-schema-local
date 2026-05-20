-- dmap_object_gen_tag : type : table name : emgencat
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emgencat"  (
gen_keycat numeric(10) not null,
gen_descri varchar(60) not null,
gen_keydat numeric(10),
gen_ranini varchar(30),
gen_ranfin varchar(255),
gen_ranmed varchar(30)
) ;
-- dmap_object_gen_tag : type : alter table name : emgencat
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emgencat alter column gen_keycat set not null;
-- dmap_object_gen_tag : type : alter table name : emgencat
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emgencat alter column gen_descri set not null;
