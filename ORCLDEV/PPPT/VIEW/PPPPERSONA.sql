CREATE OR REPLACE FORCE EDITIONABLE VIEW "PPPT"."PPPPERSONA" ("IDPERSONA", "NOMBRE", "EMAIL", "CLAVE", "IDPREFIJO", "FOLIO", "LOGIN", "PASSWORD") AS 
  SELECT     Personal.IdPersonal AS IdPersona, Personal.Nombre, Personal.email, Personal.Clave, Prefijo.IdPrefijo, Personal.Folio,
                      Personal.email AS Login, PersonalPassword.Password
FROM         Prefijo RIGHT OUTER JOIN
                      Personal ON Prefijo.Prefijo = Personal.Prefijo LEFT OUTER JOIN
                      PersonalPassword ON Prefijo.IdPrefijo = PersonalPassword.IdPrefijo AND Personal.Folio = PersonalPassword.Folio;
