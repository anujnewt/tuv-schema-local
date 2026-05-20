-- dmap_object_gen_tag : type : view name : siasa_holotabs
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_holotabs"  ("tab_keypro", "tab_keytab", "tab_keypue", "tab_pertra", "tab_idioma", "tab_keynac", "tab_import", "tab_fecini", "tab_fecfin") as select tab_keypro, tab_keytab, tab_keypue, tab_pertra, tab_idioma, tab_keynac, tab_import, tab_fecini, tab_fecfin  from holotabs;/* dmap converted statement end */
-- estimed cost of view [ siasa_holotabs ]: 1.00;
