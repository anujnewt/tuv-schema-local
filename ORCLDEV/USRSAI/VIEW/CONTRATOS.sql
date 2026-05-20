-- dmap_object_gen_tag : type : view name : contratos
set search_path = usrsai,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "contratos"  ("cco_keyemp", "cco_nomemp", "cco_nomart", "cco_keydep", "cco_keyfol", "cco_fecini", "cco_stspag", "cco_numcap", "cco_numcdi", "cco_descap", "cco_keytic", "cco_keyplz", "cco_keytco", "cco_keypue", "cco_fecoto") as select x0.con_keyemp , x1.emp_nomemp , x1.emp_nomcor , x0.con_keydep
, x0.con_keyfol , x0.con_fecini , x0.con_stspag , x0.con_numcap
, x0.con_numcdi , x0.con_descap , x0.con_keytic , x0.con_keyplz
, x0.con_keytco , x0.con_keypue , x0.con_fecoto  from usrsiho.holocont x0 ,
usrsiho.nmcoempl x1 where
(x0.con_keyemp = x1.emp_keyemp  and x1.emp_keypro = 138
);/* dmap converted statement end */
-- estimed cost of view [ contratos ]: 1.00;
