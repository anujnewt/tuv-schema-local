CREATE OR REPLACE FORCE EDITIONABLE VIEW "PPPT"."PPPPERSONAPRUEBARECIENTE" ("IDPERSONA", "IDPRUEBA", "FECHA", "RESULTADO") AS 
  SELECT     pppPersonaPrueba."IDPERSONA",pppPersonaPrueba."IDPRUEBA",pppPersonaPrueba."FECHA",pppPersonaPrueba."RESULTADO"
FROM         pppPersonaPrueba INNER JOIN
                          (SELECT     IdPersona, IdPrueba, MAX(Fecha) AS fecha
                            FROM          pppPersonaPrueba unica
                            GROUP BY IdPersona, IdPrueba) Ultima ON pppPersonaPrueba.IdPersona = Ultima.IdPersona AND
                      pppPersonaPrueba.IdPrueba = Ultima.IdPrueba AND pppPersonaPrueba.Fecha = Ultima.fecha;
