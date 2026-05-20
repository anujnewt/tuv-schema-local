CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."SIASA_NMLOPERI" ("PER_KEYPRO", "PER_KEYNOM", "PER_KEYPER", "PER_FECPAG", "PER_NUMMES", "PER_NU3AUX", "PER_NU4AUX") AS 
  SELECT per_keypro,per_keynom,per_keyper,per_fecpag,per_nummes,per_nu3aux,per_nu4aux FROM nmloperi;
