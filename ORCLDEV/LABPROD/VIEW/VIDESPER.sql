CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "LABPROD"."VIDESPER" ("PER_KEYPER", "PER_DESPER", "PER_KEYPRO", "PER_FECPAG", "ID", "PER_KEYNOM") AS 
  SELECT per_keyper,per_keyper||' DE '||TO_CHAR(per_fecini,'dd/mm/yyyy')||' A '||TO_CHAR(per_fecfin,'dd/mm/yyyy')||' Proceso: '||per_keypro  as per_desper, per_keypro,per_fecpag,
  per_keyper||'-'||per_keypro ID,PER_KEYNOM
FROM labprod.nmloperi;
