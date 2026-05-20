-- DMAP_OBJECT_GEN_TAG : TYPE : EDITIONABLE NAME : tvcdesaf_periodo
SET search_path = labprod,oracle,dmap_extension,public;

CREATE TYPE tvcdesaf_periodo AS (
period varchar, fecini varchar, fecfin varchar,
                             diaper integer, cvecal varchar(3)

);
