-- dmap_object_gen_tag : type : view name : jaja666
set search_path = fe_egresos,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "jaja666"  ("organization_id", "name", "cla_fe_id") as (select o.organization_id, o.name, oi.cla_fe_id
from hr.hr_all_organization_units__erp_prod o,fecxp_org_inv_flujo oi
where o.organization_id = oi.organization_id);/* dmap converted statement end */
-- estimed cost of view [ jaja666 ]: 3.00;
