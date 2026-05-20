-- DMAP_OBJECT_GEN_TAG : TYPE : EDITIONABLE NAME : tvcdesaf_empleado
SET search_path = labprod,oracle,dmap_extension,public;

CREATE TYPE tvcdesaf_empleado AS (
keyemp NUMERIC, keydep varchar, keypue varchar,
                            keypro NUMERIC, status NUMERIC

);
