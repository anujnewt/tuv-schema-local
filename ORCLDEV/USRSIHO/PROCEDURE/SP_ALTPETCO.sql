CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_ALTPETCO" (Pi_Folio NUMBER,
                                        Pi_IdEnc NUMBER,
                                        Pi_IdDet NUMBER,
                                        pd_Fecha VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- RETURNING DECIMAL(10,2);
   -- -----------------------------------------------------------------
   -- sp_altpetco: Este stored procedure es el que utiliza en el
   -- modulo de captura de Contratos para actualizar el status del
   -- encabezado y del detalle si se realizo la captura por medio
   -- del boton de petici?e contrato.
   -- Devuelve :
   -- Realizado el 03 de Julio de 2008
   -- Jose Dolores Cuellar Mtz
   -- -----------------------------------------------------------------
   -- Definimos variables de Trabajo
   Li_Registros NUMBER(10);
BEGIN
   UPDATE USRSIHO.detpetco
      SET dpc_keyfol = Pi_Folio,
          dpc_feccap = TO_DATE(pd_Fecha, 'DD/MM/YYYY'),
          dpc_stsreg = 3    -- ---> Estatus 3 en detpetco  = Ya se capturo Contrato para ese empleado y se encuentra CONTRATADO
    WHERE dpc_idereg = Pi_IdDet
      AND dpc_numpco = Pi_IdEnc;
   -- ---> Buscamos en el detalle si existen todavia status 1 (Activo)
   Li_Registros := 0;
   BEGIN
     SELECT COUNT(*)
       INTO Li_Registros
       FROM USRSIHO.detpetco
      WHERE dpc_numpco = Pi_IdEnc
        AND dpc_stsreg = 1;
      EXCEPTION WHEN no_data_found THEN
          Li_Registros := 0;
    END;
   IF Li_Registros IS NULL THEN
	    Li_Registros := 0;
	 END IF;
   IF Li_Registros = 0 THEN
      UPDATE USRSIHO.encpetco
         SET epc_stspet = 4    -- ---> Estatus 4 en encpetco  = Ya se capturaron TODOS los contratos de los empleados y se encuentra ATENDIDA
       WHERE epc_numpco = Pi_IdEnc;
   END IF;
-- -----------------------------------------------------------
END;
/
