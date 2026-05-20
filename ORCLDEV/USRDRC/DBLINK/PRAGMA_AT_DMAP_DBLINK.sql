-- dmap_object_gen_tag : type : database link name : dmap;
/* dmap converted statement start */
set search_path = usrdrc,oracle,dmap_extension,public;
create extension if not exists postgres_fdw;
create server pragma_at_dmap_dblink foreign data wrapper dblink_fdw options (hostaddr 'localhost', dbname 'dmap');
/* dmap converted statement end */
-- dmap_object_gen_tag : type : database link name : postgres;
/* dmap converted statement start */
SET search_path = usrdrc,oracle,dmap_extension,public;
CREATE EXTENSION IF NOT EXISTS postgres_fdw;
CREATE SERVER pragma_at_dmap_dblink FOREIGN DATA WRAPPER dblink_fdw OPTIONS (hostaddr 'localhost', dbname 'postgres');
/* dmap converted statement end */
