CREATE OR REPLACE FORCE EDITIONABLE VIEW "PPPT"."PPPPERFILPRUEBA" ("IDPERFIL", "IDPRUEBA", "PESO", "AUX", "OPCIONES", "RESULTADO", "AUXILIAR", "BDIRECTO") AS 
  SELECT     IdPuesto AS IdPerfil, IdPrueba, Peso, aux, Opciones, Resultado, Auxiliar, bDirecto
FROM       PuestosPruebas;
