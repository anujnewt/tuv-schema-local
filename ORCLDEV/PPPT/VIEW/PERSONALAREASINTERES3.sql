CREATE OR REPLACE FORCE EDITIONABLE VIEW "PPPT"."PERSONALAREASINTERES3" ("IDPERSONAL", "IDAREAINTERES", "AREAINTERES") AS 
  SELECT PersonalAreaInteres.IdPersonal, PersonalAreaInteres.IdAreaInteres, CatExpFuncional.ExpFuncional AS AreaInteres FROM PersonalAreaInteres INNER JOIN CatExpFuncional ON PersonalAreaInteres.IdAreaInteres = CatExpFuncional.IdExpFuncional;
