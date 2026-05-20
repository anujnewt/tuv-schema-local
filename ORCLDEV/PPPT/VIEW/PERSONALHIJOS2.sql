CREATE OR REPLACE FORCE EDITIONABLE VIEW "PPPT"."PERSONALHIJOS2" ("IDHIJO", "IDPERSONAL", "NOMBRE", "SEXO", "FECHA_NACIMIENTO", "OCUPACION") AS 
  SELECT PersonalHijos.IdHijo, PersonalHijos.IdPersonal, PersonalHijos.Nombre, Sexo.Sexo, PersonalHijos.DOB AS Fecha_Nacimiento, PersonalHijos.Ocupacion FROM PersonalHijos LEFT JOIN Sexo ON PersonalHijos.Sexo = Sexo.IdSexo;
