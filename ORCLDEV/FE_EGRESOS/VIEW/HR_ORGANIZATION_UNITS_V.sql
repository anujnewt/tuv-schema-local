-- dmap_object_gen_tag : type : view name : hr_organization_units_v
set search_path = fe_egresos,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "hr_organization_units_v"  ("organization_id", "name") as select a.organization_id,  a.name
from hr.hr_all_organization_units__erp_prod a;/* dmap converted statement end */
-- estimed cost of view [ hr_organization_units_v ]: 3.00;
