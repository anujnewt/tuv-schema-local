-- DMAP_OBJECT_GEN_TAG : TYPE : EDITIONABLE NAME : tvcontab_argumentos
SET search_path = labprod,oracle,dmap_extension,public;

CREATE TYPE tvcontab_argumentos AS (
idepro LABPROD.varchar, idepcc LABPROD.varchar,
								keyusu LABPROD.NUMERIC, fecini LABPROD.TIMESTAMP WITHOUT TIME ZONE,
								horini LABPROD.varchar

);
