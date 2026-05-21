-- dmap_object_gen_tag : type : table name : eul4_sequences
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_sequences"  ( seq_id numeric(10) not null, 
seq_name varchar(100) not null, 
seq_nextval numeric(22) not null );
-- dmap_object_gen_tag : type : alter table name : eul4_sequences
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sequences alter column seq_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sequences
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sequences alter column seq_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sequences
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sequences alter column seq_nextval set not null;
