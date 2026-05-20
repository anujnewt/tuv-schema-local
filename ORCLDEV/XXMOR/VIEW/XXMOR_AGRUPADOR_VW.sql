CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_AGRUPADOR_VW" ("AGRUPADOR") AS 
  select ident_fza_val as agrupador from XXMOR_FZAS_VTAS_IDENT_TAB
where ident_fza_tipo = 'G'
group by ident_fza_val order by ident_fza_val
 ;
