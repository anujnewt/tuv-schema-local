-- dmap_object_gen_tag : type : view name : fecxp_orgs_v
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
DROP VIEW fecxp_orgs_v;
create or replace view "fecxp_orgs_v"  ("organization_id", "name", "cla_fe_id") as (select
o.organization_id, o.name, oi.cla_fe_id
from hr.hr_all_organization_units__erp_prod o,
fecxp_org_inv_flujo oi
where o.organization_id = oi.organization_id);/* dmap converted statement end */
-- estimed cost of view [ fecxp_orgs_v ]: 3.00;
