-- dmap_object_gen_tag : type : view name : fecxc_tpc_multimoneda_vw
set search_path = fecxc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "fecxc_tpc_multimoneda_vw"  ("from_currency", "to_currency", "conversion_date", "conversion_rate") as select from_currency,  to_currency,  conversion_date,  conversion_rate
from gl.gl_daily_rates__erp_prod
where status_code like 'O'
and
conversion_type like 'Corporate';/* dmap converted statement end */
-- estimed cost of view [ fecxc_tpc_multimoneda_vw ]: 3.00;
