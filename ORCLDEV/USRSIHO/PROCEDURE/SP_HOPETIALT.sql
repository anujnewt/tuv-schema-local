CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HOPETIALT" (Pi_Folio NUMBER,
                              Pi_IdEnc NUMBER,
                              Pi_IdDet NUMBER,
                              pd_Fecha VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- RETURNING DECIMAL(10,2);
   -- -----------------------------------------------------------------
   -- sp_hopetialt: Este stored procedure es el que utiliza en el
   -- modulo de captura de Contratos para actualizar el status del
   -- encabezado y del detalle si se realizo la captura por medio
   -- del boton de petici??e contrato.
   -- Devuelve :
   -- Realizado el 22 de Noviembre de 2005
   -- Emilio Pulido Rangel
   -- -----------------------------------------------------------------
   -- Definimos variables de Trabajo
   Li_Registros NUMBER(10);
BEGIN
   UPDATE pcdetalleanda
      SET deafoliocontrato = Pi_Folio,
          deafechacapturacon = pd_Fecha,
          deaestatus = 4    -- ---> Estatus 4 en pcdetalleanda = Ya se capturo Contrato para ese empleado
    WHERE deaidnumdet = Pi_IdDet
      AND deaidnumenc = Pi_IdEnc;
   -- ---> Buscamos en el detalle si existen todavia status 1 (Activo)
   Li_Registros := 0;
   SELECT COUNT(*)
     INTO Li_Registros
     FROM pcdetalleanda
    WHERE deaidnumenc = Pi_IdEnc
      AND deaestatus = 1;
   IF Li_Registros IS NULL THEN
	    Li_Registros := 0;
	 END IF;
   IF Li_Registros = 0 THEN
      UPDATE pcencabezadoanda
         SET enaestatus = 4    -- ---> Estatus 4 en pcencabezadoanda = Ya se capturaron TODOS los contratos de los empleados
       WHERE enaidnumenc = Pi_IdEnc;
   END IF;
-- -----------------------------------------------------------
END;
/
