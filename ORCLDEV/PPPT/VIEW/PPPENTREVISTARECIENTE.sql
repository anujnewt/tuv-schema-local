CREATE OR REPLACE FORCE EDITIONABLE VIEW "PPPT"."PPPENTREVISTARECIENTE" ("IDENTREVISTA", "IDPERSONA", "IDPERFIL", "FECHA", "RESULTADO", "COMPATIBILIDAD", "ENTREVISTADOR", "COMENTARIOS") AS 
  SELECT     pppEntrevista."IDENTREVISTA",pppEntrevista."IDPERSONA",pppEntrevista."IDPERFIL",pppEntrevista."FECHA",pppEntrevista."RESULTADO",pppEntrevista."COMPATIBILIDAD",pppEntrevista."ENTREVISTADOR",pppEntrevista."COMENTARIOS"
FROM         pppEntrevista INNER JOIN
                          (SELECT     IdPersona, IdPerfil, MAX(Fecha) AS fecha
                            FROM          pppEntrevista unica
                            GROUP BY IdPersona, IdPerfil) Ultima ON pppEntrevista.IdPersona = Ultima.IdPersona AND pppEntrevista.IdPerfil = Ultima.IdPerfil AND
                      pppEntrevista.Fecha = Ultima.fecha;
