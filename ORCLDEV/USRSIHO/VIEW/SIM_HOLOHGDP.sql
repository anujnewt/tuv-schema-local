-- dmap_object_gen_tag : type : view name : sim_holohgdp
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "sim_holohgdp"  ("hgd_capini", "hgd_capfin", "hgd_keyrph", "hgd_keyfol", "hgd_keytco", "hgd_fechag") as select hgd_capini, hgd_capfin, hgd_keyrph, hgd_keyfol, hgd_keytco, hgd_fechag  from holohgdp;/* dmap converted statement end */
-- estimed cost of view [ sim_holohgdp ]: 1.00;
