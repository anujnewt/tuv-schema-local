CREATE OR REPLACE FORCE EDITIONABLE VIEW "PPPT"."PERSONALEXPFUNCIONAL2" ("IDPERSONAL", "IDEXPFUNCIONAL", "EXPFUNCIONAL") AS 
  SELECT PersonalExpFuncional.IdPersonal, PersonalExpFuncional.IdExpFuncional, CatExpFuncional.ExpFuncional FROM PersonalExpFuncional INNER JOIN CatExpFuncional ON PersonalExpFuncional.IdExpFuncional = CatExpFuncional.IdExpFuncional;
