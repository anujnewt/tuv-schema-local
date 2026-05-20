-- dmap_object_gen_tag : type : view name : eul4_odbc_catalogs
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "eul4_odbc_catalogs"  ("oc_catalog_name") as select
db_link
from all_db_links;/* dmap converted statement end */
-- estimed cost of view [ eul4_odbc_catalogs ]: 1.00;
