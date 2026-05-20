-- dmap_object_gen_tag : type : table name : eul4_plan_table
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_plan_table"  (
statement_id varchar(30),
timestamp timestamp(0),
remarks varchar(80),
operation varchar(30),
options varchar(30),
object_node varchar(128),
object_owner varchar(30),
object_name varchar(30),
object_instance numeric,
object_type varchar(30),
optimizer varchar(255),
search_columns numeric(38),
id numeric,
parent_id numeric,
position numeric,
cost numeric,
cardinality numeric,
bytes numeric,
other_tag varchar(255),
partition_start varchar(255),
partition_stop varchar(255),
partition_id numeric,
other text,
distribution varchar(30)
) ;
