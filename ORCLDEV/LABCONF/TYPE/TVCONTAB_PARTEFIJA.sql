-- DMAP_OBJECT_GEN_TAG : TYPE : EDITIONABLE NAME : tvcontab_partefija
SET search_path = labconf,oracle,dmap_extension,public;

CREATE TYPE tvcontab_partefija AS (
keyemp LABCONF.nmlohism.his_keyemp%TYPE, keypro LABCONF.nmlohism.his_keypro%TYPE,
    													 keycon LABCONF.nmlohism.his_keycon%TYPE, codimp LABCONF.nmlohism.his_codimp%TYPE,
                               descon LABCONF.varchar, keycia LABCONF.varchar,
                               keypol LABCONF.varchar, cveban LABCONF.nmcoempl.emp_cveban%TYPE,
                               forpag LABCONF.nmcoempl.emp_forpag%TYPE, keyben LABCONF.nmlohism.his_keyben%TYPE,
                               comfam LABCONF.nmlohism.his_comfam%TYPE, fecmov LABCONF.nmlohism.his_fecmov%TYPE

);
