-- dmap_object_gen_tag : type : table name : rbosmsgs
set search_path = labconf,oracle,dmap_extension,public;
create table "rbosmsgs"  (
msg_keypro numeric(38) not null,
msg_keyper varchar(7) not null,
msg_keynom numeric(38) not null,
msg_nompar varchar(140) not null,
msg_folini varchar(16) not null,
msg_folfin varchar(16) not null
) ;
-- dmap_object_gen_tag : type : alter table name : rbosmsgs
set search_path = labconf,oracle,dmap_extension,public;
alter table rbosmsgs alter column msg_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : rbosmsgs
set search_path = labconf,oracle,dmap_extension,public;
alter table rbosmsgs alter column msg_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : rbosmsgs
set search_path = labconf,oracle,dmap_extension,public;
alter table rbosmsgs alter column msg_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : rbosmsgs
set search_path = labconf,oracle,dmap_extension,public;
alter table rbosmsgs alter column msg_nompar set not null;
-- dmap_object_gen_tag : type : alter table name : rbosmsgs
set search_path = labconf,oracle,dmap_extension,public;
alter table rbosmsgs alter column msg_folini set not null;
-- dmap_object_gen_tag : type : alter table name : rbosmsgs
set search_path = labconf,oracle,dmap_extension,public;
alter table rbosmsgs alter column msg_folfin set not null;
