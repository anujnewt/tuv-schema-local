CREATE OR REPLACE FORCE EDITIONABLE VIEW "PPPT"."PPPENTREVISTA" ("IDENTREVISTA", "IDPERSONA", "IDPERFIL", "FECHA", "RESULTADO", "COMPATIBILIDAD", "ENTREVISTADOR", "COMENTARIOS") AS 
  SELECT     IdEntrevista, IdPersonal AS IdPersona, IdPuesto AS IdPerfil, Fecha, Resultado, Compatibilidad, Entrevistador, Comentarios
FROM         ECPersonaPuesto;
