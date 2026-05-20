-- dmap_object_gen_tag : type : table name : nmrepleg
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmrepleg"  (
ple_nomrep varchar(100),
ple_rfcrep varchar(20) not null,
ple_curp varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : nmrepleg
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmrepleg add constraint pk_nmrepleg primary key (ple_rfcrep);
