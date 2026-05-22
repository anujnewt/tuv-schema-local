-- dmap_object_gen_tag : type : view name : eul4_odbc_schemas
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "eul4_odbc_schemas"  ("os_schema_name") as 
SELECT usename AS username
FROM pg_catalog.pg_user;/* dmap converted statement end */
-- estimed cost of view [ eul4_odbc_schemas ]: 1.00;
