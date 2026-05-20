CREATE OR REPLACE FORCE EDITIONABLE VIEW "PPPT"."PPPENTREVISTACOMPETENCIA" ("IDENTREVISTA", "IDPERSONA", "IDPERFIL", "RESULTADO", "COMPATIBILIDAD", "NIVEL", "COMENTARIOS", "IDCOMPETENCIA", "COMPETENCIA", "TIPO", "IDEMPRESA", "INACTIVA", "DEFINICION") AS 
  SELECT pppEntrevista.IdEntrevista, pppEntrevista.IdPersona, pppEntrevista.IdPerfil, ECPersonaCompetencia.Resultado,
  ECPersonaCompetencia.Compatibilidad, ECPersonaCompetencia.Nivel, ECPersonaCompetencia.Comentarios, pppCompetencia."IDCOMPETENCIA",pppCompetencia."COMPETENCIA",pppCompetencia."TIPO",pppCompetencia."IDEMPRESA",pppCompetencia."INACTIVA",pppCompetencia."DEFINICION"
FROM pppEntrevista INNER JOIN
  ECPersonaCompetencia ON pppEntrevista.IdEntrevista = ECPersonaCompetencia.IdEntrevista INNER JOIN
  pppCompetencia ON ECPersonaCompetencia.IdCompetencia = pppCompetencia.IdCompetencia;
