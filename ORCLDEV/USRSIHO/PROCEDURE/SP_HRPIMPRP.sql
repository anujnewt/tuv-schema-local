CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HRPIMPRP" (vs_des_rep IN VARCHAR2,
                                         vs_pro_yec IN VARCHAR2,
                                         vn_key_usu IN NUMBER,
                                         vs_rut_arp OUT VARCHAR2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  -- SIPROS, S. A. DE C. V.
  -- Sistema  : RH-2000  C/S
  -- Modulo   : Nomina de honorarios
  -- Programa : sp_htpimprp
  --            Generacion de nombre de reporte
  -- Autor    : Veronica Vazquez Rodriguez
  -- Fecha    : 13 de Septiembre de 1999
   vn_key_rep NUMBER;
BEGIN
-- INICIALIZA VARIABLES
   vn_key_rep := 0;
-- SELECCIONA RUTA DE GENERACION
begin
   SELECT pam_nompar
     INTO vs_rut_arp
     FROM usrsiho.glcopams
    WHERE pam_keypar = 'H001'
      AND pam_cvesec = 'OPCI09';
  exception
     when no_data_found then
        vs_rut_arp := '';
  end;
-- OBTIENE NUMERO DE REPORTE ASIGNADO
   -- vn_key_rep := sp_lee_serial();
   SELECT MAX(rep_keyrep)+1
   INTO   vn_key_rep
   FROM   usrsiho.holorepo;
-- ARMA NOMBRE DE ARCHIVO Y RUTA DE IMPRESION
   vs_rut_arp := TRIM(vs_rut_arp) || TO_CHAR(vn_key_rep);
-- INSERTA VALORES A TABLA DE REPORTES
   INSERT INTO usrsiho.holorepo(rep_keyrep,rep_desrep,rep_proyec,rep_keyusu,rep_fechag,rep_rutarp)
   VALUES(vn_key_rep,
          vs_des_rep,
          vs_pro_yec,
          vn_key_usu,
          TRUNC(SYSDATE),
          vs_rut_arp);
--  ACTUALIZA NOMBRE DE ARCHIVO
--   UPDATE usrsiho.holorepo
--      SET rep_rutarp = vs_rut_arp
--    WHERE rep_keyrep = vn_key_rep;
END;
/
