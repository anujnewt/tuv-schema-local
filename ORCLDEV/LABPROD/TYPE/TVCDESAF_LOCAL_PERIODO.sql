-- DMAP_OBJECT_GEN_TAG : TYPE : EDITIONABLE NAME : tvcdesaf_local_periodo
SET search_path = labprod,oracle,dmap_extension,public;

CREATE TYPE tvcdesaf_local_periodo AS (
period LABPROD.varchar, fecini LABPROD.varchar, fecfin LABPROD.varchar,
                             diaper integer, cvecal varchar(3)

);
