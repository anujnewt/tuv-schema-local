CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."DRM_NMLOPERI" ("PER_KEYPRO", "PER_KEYPER", "PER_NU3AUX", "PER_KEYNOM", "PER_NU4AUX", "PER_FECPAG") AS 
  SELECT per_keypro,per_keyper,per_nu3aux,per_keynom,per_nu4aux,per_fecpag FROM nmloperi;
