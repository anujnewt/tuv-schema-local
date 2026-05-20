-- dmap_object_gen_tag : type : view name : codeac_nmlodata
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "codeac_nmlodata"  ("dat_valpar", "dat_keyemp", "dat_keypar") as select dat_valpar, dat_keyemp, dat_keypar	 from nmlodata;/* dmap converted statement end */
-- estimed cost of view [ codeac_nmlodata ]: 1.00;
