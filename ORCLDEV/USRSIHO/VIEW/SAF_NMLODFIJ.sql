-- dmap_object_gen_tag : type : view name : saf_nmlodfij
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "saf_nmlodfij"  ("dfi_keyemp", "dfi_keycon", "dfi_keypro", "dfi_perini", "dfi_perfin", "dfi_keydep", "dfi_keypue", "dfi_fecmov", "dfi_cantid", "dfi_import", "dfi_ca1aux", "dfi_ca2aux") as select  dfi_keyemp, dfi_keycon, dfi_keypro, dfi_perini, dfi_perfin, dfi_keydep, dfi_keypue, dfi_fecmov, dfi_cantid, dfi_import, dfi_ca1aux, dfi_ca2aux  from nmlodfij;/* dmap converted statement end */
-- estimed cost of view [ saf_nmlodfij ]: 1.00;
