-- dmap_object_gen_tag : type : table name : consagrup
set search_path = usrsiho,oracle,dmap_extension,public;
create table "consagrup"  (
gru_cvegpo varchar(3) not null,
gru_consec numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : consagrup
set search_path = usrsiho,oracle,dmap_extension,public;
alter table consagrup alter column gru_cvegpo set not null;
-- dmap_object_gen_tag : type : alter table name : consagrup
set search_path = usrsiho,oracle,dmap_extension,public;
alter table consagrup alter column gru_consec set not null;
