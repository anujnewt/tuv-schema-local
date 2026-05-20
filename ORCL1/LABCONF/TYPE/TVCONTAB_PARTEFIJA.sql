-- DMAP_OBJECT_GEN_TAG : TYPE : EDITIONABLE NAME : tvcontab_partefija
SET search_path = labconf,oracle,dmap_extension,public;

CREATE TYPE tvcontab_partefija AS (
keyemp LABCONF.NUMERIC, keypro LABCONF.NUMERIC,
								keycon LABCONF.varchar, codimp LABCONF.varchar,
								descon LABCONF.varchar, keycia LABCONF.varchar,
								keypol LABCONF.varchar, cveban LABCONF.varchar,
								forpag LABCONF.varchar, keyben LABCONF.NUMERIC,
								comfam LABCONF.NUMERIC, fecmov LABCONF.TIMESTAMP WITHOUT TIME ZONE

);
