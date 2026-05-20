-- dmap_object_gen_tag : type : view name : drm_holohgdp
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "drm_holohgdp"  ("hgd_keyrph", "hgd_keyemp", "hgd_keypue", "hgd_numcap", "hgd_capini", "hgd_capfin", "hgd_keyfol", "hgd_keytco", "hgd_costog") as select hgd_keyrph, hgd_keyemp, hgd_keypue, hgd_numcap, hgd_capini, hgd_capfin, hgd_keyfol, hgd_keytco, hgd_costog  from holohgdp;/* dmap converted statement end */
-- estimed cost of view [ drm_holohgdp ]: 1.00;
