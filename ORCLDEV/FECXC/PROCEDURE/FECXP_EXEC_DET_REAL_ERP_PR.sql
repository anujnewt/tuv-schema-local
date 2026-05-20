CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECXP_EXEC_DET_REAL_ERP_PR" 
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   err_code    NUMBER;
   err_msg     VARCHAR2 (255);
   fecha_ini   VARCHAR2 (8);
BEGIN
   SELECT SUBSTR
             (estatus_ppto_sig_ejecucion, 42, 8)
--Se obtiena la fecha INCICIAL, como es automatico la fecha final siempre sera el SYSDATE
     INTO fecha_ini
     FROM fecxc.fecxp_ppto_extraccion_params
    WHERE proceso_id = 11;
   fecxc.fecxp_base_iva_intermpresas (TO_DATE(fecha_ini,'DDMMYYYY'), SYSDATE);
   UPDATE fecxc.fecxp_ppto_extraccion_params
      SET atributo2 =
                SUBSTR (NVL (atributo2, ''), 1, 190)
             || 'Aperturacion CXC termino con Exito'||to_char(SYSDATE,'DD-MM-YYYY')
    WHERE proceso_id = 11;
EXCEPTION
   WHEN OTHERS
   THEN
      err_code := SQLCODE;
      err_msg := SUBSTR (SQLERRM, 1, 100);
      UPDATE fecxc.fecxp_ppto_extraccion_params
         SET atributo2 =
                   SUBSTR (NVL (atributo2, ''), 1, 100)
                || 'Aperturacion CXC termino con ERROR'
                || err_msg
       WHERE proceso_id = 11;
END fecxp_exec_det_real_erp_pr;
/
