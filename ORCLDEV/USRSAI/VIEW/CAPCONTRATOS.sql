CREATE OR REPLACE FORCE EDITIONABLE VIEW "USRSAI"."CAPCONTRATOS" ("CAC_KEYPLZ", "CAC_KEYCAP", "CAC_STSPAG", "COC_KEYRPH") AS 
  select x0.coc_keyplz ,x0.coc_keycap ,x0.coc_stspag ,x0.coc_keyrph
    from usrsiho.holococa x0 ,usrsiho.holocont x1 ,
         usrsiho.nmcoempl x2 where (((x0.coc_keyplz
    = x1.con_keyplz ) AND (x1.con_keyemp = x2.emp_keyemp ) )
    AND (x2.emp_keypro = 138 ) ) ;
