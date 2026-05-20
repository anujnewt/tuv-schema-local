-- dmap_object_gen_tag : type : table name : nmloproc
set search_path = labconf,oracle,dmap_extension,public;
create table "nmloproc"  (
pro_keypro numeric(5) not null,
pro_despro varchar(26) not null,
pro_keycia varchar(5) not null,
pro_tipsal varchar(1),
pro_dirpag varchar(30),
pro_diaper numeric(5),
pro_perano numeric(5),
pro_faccon decimal(4, 2),
pro_keynom numeric(5),
pro_pereje varchar(7),
pro_vercon numeric(5),
pro_nu1aux varchar(10),
pro_nu2aux varchar(10),
pro_nu3aux varchar(10),
pro_nu4aux varchar(10),
pro_nu5aux varchar(10),
pro_ca1aux varchar(10),
pro_ca2aux varchar(10),
pro_ca3aux varchar(10),
pro_ca4aux varchar(10),
pro_ca5aux varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : nmloproc
set search_path = labconf,oracle,dmap_extension,public;
alter table nmloproc add constraint nmproc01 unique (pro_keypro);
-- dmap_object_gen_tag : type : alter table name : nmloproc
set search_path = labconf,oracle,dmap_extension,public;
alter table nmloproc alter column pro_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : nmloproc
set search_path = labconf,oracle,dmap_extension,public;
alter table nmloproc alter column pro_despro set not null;
-- dmap_object_gen_tag : type : alter table name : nmloproc
set search_path = labconf,oracle,dmap_extension,public;
alter table nmloproc alter column pro_keycia set not null;
