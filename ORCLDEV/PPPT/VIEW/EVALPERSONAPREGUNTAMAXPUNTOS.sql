CREATE OR REPLACE FORCE EDITIONABLE VIEW "PPPT"."EVALPERSONAPREGUNTAMAXPUNTOS" ("IDPERSONAEVALUACION", "IDPREGUNTA", "IDSECCION", "IDOPCION", "MAXPUNTOS") AS 
  SELECT evalPersonaPregunta.IdPersonaEvaluacion, evalPersonaPregunta.IdPregunta, evalPersonaPregunta.IdSeccion, evalPersonaPregunta.IdOpcion, MAX(evacatOpcion.Puntos) AS MaxPuntos
FROM evalPersonaPregunta INNER JOIN evacatOpcion ON evalPersonaPregunta.IdPregunta = evacatOpcion.IdPregunta
GROUP BY evalPersonaPregunta.IdPregunta, evalPersonaPregunta.IdPersonaEvaluacion, evalPersonaPregunta.IdSeccion,  evalPersonaPregunta.IdOpcion;
