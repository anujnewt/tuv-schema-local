CREATE OR REPLACE FORCE EDITIONABLE VIEW "PPPT"."EVALPERSONAPREGUNTAPUNTOS" ("IDPERSONAEVALUACION", "IDPREGUNTA", "IDSECCION", "IDOPCION", "PUNTOS") AS 
  SELECT evalPersonaPregunta.IdPersonaEvaluacion, evalPersonaPregunta.IdPregunta, evalPersonaPregunta.IdSeccion, evalPersonaPregunta.IdOpcion, evacatOpcion.Puntos
FROM evalPersonaPregunta INNER JOIN evacatOpcion ON evalPersonaPregunta.IdOpcion = evacatOpcion.IdOpcion;
