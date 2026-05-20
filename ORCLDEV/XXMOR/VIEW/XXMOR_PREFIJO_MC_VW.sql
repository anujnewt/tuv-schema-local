CREATE OR REPLACE FORCE EDITIONABLE VIEW "XXMOR"."XXMOR_PREFIJO_MC_VW" ("REGION") AS 
  select ident_fza_val from XXMOR_FZAS_VTAS_IDENT_TAB
where ident_fza_tipo = 'P'
group by ident_fza_val order by ident_fza_val
 ;
