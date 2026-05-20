-- DMAP_OBJECT_GEN_TAG : TYPE : EDITIONABLE NAME : tvcdesaf_local_empleado
SET search_path = labprod,oracle,dmap_extension,public;

CREATE TYPE tvcdesaf_local_empleado AS (
keyemp LABPROD.NUMERIC, keydep LABPROD.varchar, keypue LABPROD.varchar,
                            keypro LABPROD.NUMERIC, status LABPROD.NUMERIC

);
