-- dmap_object_gen_tag : type : table name : cge000
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge000"  (
cge0niv numeric(38),
cge1cod char(5),
cge5cod varchar(5),
cge0usr varchar(30),
cge0pas varchar(30),
cge0pce char(1) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge000
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge000 alter column cge0pce set not null;
