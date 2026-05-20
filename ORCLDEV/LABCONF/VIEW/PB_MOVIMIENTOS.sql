CREATE OR REPLACE FORCE EDITIONABLE VIEW "LABCONF"."PB_MOVIMIENTOS" ("FECHA_CAPTURA", "EMP_KEYEMP", "NOMBRE", "FECHA_MOVIMIENTO", "TIPO_MOVIMIENTO", "PLZ_ACT", "PLZ_ANT", "DPTO_ACT", "DPTO_ANT", "PTO_ACT", "PTO_ANT") AS 
  SELECT TRA_FECMOD FECHA_CAPTURA,
          TRA_KEYEMP EMP_KEYEMP,
          EMP_NOMEMP NOMBRE,
          TRA_FECMOV FECHA_MOVIMIENTO,
          CASE
             WHEN TRA_TIPMOV = '8' THEN 'DEPARTAMENTO'
             WHEN TRA_TIPMOV = '9' THEN 'PUESTO'
             WHEN TRA_TIPMOV = '10' THEN 'PLAZA'
             ELSE ''
          END
             TIPO_MOVIMIENTO,
          CASE
             WHEN TRA_TIPMOV = '8' THEN NULL
             WHEN TRA_TIPMOV = '9' THEN NULL
             WHEN TRA_TIPMOV = '10' THEN TRA_KEYPLA
             ELSE NULL
          END
             PLZ_ACT,
          CASE
             WHEN TRA_TIPMOV = '8' THEN NULL
             WHEN TRA_TIPMOV = '9' THEN NULL
             WHEN TRA_TIPMOV = '10' THEN TRA_CA2AUX
             ELSE NULL
          END
             PLZ_ANT,
          CASE
             WHEN TRA_TIPMOV = '8' THEN TRA_KEYDEP
             WHEN TRA_TIPMOV = '9' THEN NULL
             WHEN TRA_TIPMOV = '10' THEN NULL
             ELSE NULL
          END
             DPTO_ACT,
          CASE
             WHEN TRA_TIPMOV = '8' THEN TRA_CA2AUX
             WHEN TRA_TIPMOV = '9' THEN NULL
             WHEN TRA_TIPMOV = '10' THEN NULL
             ELSE NULL
          END
             DPTO_ANT,
          CASE
             WHEN TRA_TIPMOV = '8' THEN NULL
             WHEN TRA_TIPMOV = '9' THEN TRA_KEYPUE
             WHEN TRA_TIPMOV = '10' THEN NULL
             ELSE NULL
          END
             PTO_ACT,
          CASE
             WHEN TRA_TIPMOV = '8' THEN NULL
             WHEN TRA_TIPMOV = '9' THEN TRA_CA2AUX
             WHEN TRA_TIPMOV = '10' THEN NULL
             ELSE NULL
          END
             PTO_ANT
     FROM LABCONF.NMLOTRAY
     INNER JOIN LABCONF.NMCOEMPL ON TRA_KEYEMP = EMP_KEYEMP
    WHERE     TRA_TIPMOV IN ('8', '9', '10')
          AND TRA_FECMOV >= SYSDATE - 2
          AND TRA_FECMOV < SYSDATE;
