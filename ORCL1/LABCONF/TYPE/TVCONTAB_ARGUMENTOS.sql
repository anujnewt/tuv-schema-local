-- DMAP_OBJECT_GEN_TAG : TYPE : EDITIONABLE NAME : tvcontab_argumentos
SET search_path = labconf,oracle,dmap_extension,public;

CREATE TYPE tvcontab_argumentos AS (
idepro LABCONF.varchar, idepcc LABCONF.varchar,
								keyusu LABCONF.NUMERIC, fecini LABCONF.TIMESTAMP WITHOUT TIME ZONE,
								horini LABCONF.varchar

);
