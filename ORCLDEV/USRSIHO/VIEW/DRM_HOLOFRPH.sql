CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSIHO"."DRM_HOLOFRPH" ("FRP_KEYDEP", "FRP_FECTRAB", "FRP_KEYRPH", "FRP_KEYPRO", "FRP_KEYPER") AS 
  SELECT frp_keydep,frp_fectrab,frp_keyrph,frp_keypro,frp_keyper FROM holofrph;
