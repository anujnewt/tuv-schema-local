-- dmap_object_gen_tag : type : view name : cat_talento_artistico
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "cat_talento_artistico"  ("emp_nomemp", "emp_nomcor") as select emp_nomemp, emp_nomcor  from usrsiho.nmcoempl where emp_keypro =138 and emp_status = 1 and emp_ca2aux not in ('009','010','012');/* dmap converted statement end */
-- estimed cost of view [ cat_talento_artistico ]: 1.00;
