-- DMAP_OBJECT_GEN_TAG : TYPE : EDITIONABLE NAME : tvcontab_partefija
SET search_path = labprod,oracle,dmap_extension,public;

CREATE TYPE tvcontab_partefija AS (
keyemp LABPROD.NUMERIC, keypro LABPROD.NUMERIC,
								keycon LABPROD.varchar, codimp LABPROD.varchar,
								descon LABPROD.varchar, keycia LABPROD.varchar,
								keypol LABPROD.varchar, cveban LABPROD.varchar,
								forpag LABPROD.varchar, keyben LABPROD.NUMERIC,
								comfam LABPROD.NUMERIC, fecmov LABPROD.TIMESTAMP WITHOUT TIME ZONE

);
