-- DMAP_OBJECT_GEN_TAG : TYPE : FUNCTION NAME : trigger_fct_xxmor_sol_est_rep_tab_au_tr_01()
SET search_path = xxmor,oracle,dmap_extension,public;
CREATE OR REPLACE FUNCTION trigger_fct_xxmor_sol_est_rep_tab_au_tr_01() RETURNS trigger AS $BODY$
DECLARE
/******************************************************************************
   NAME:       XXMOR_SOL_EST_REP_TAB_AU_TR_01
   PURPOSE:
   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        30/05/2011             1. Created this trigger.
   NOTES:
   Automatically available Auto Replace Keywords:
      Object Name:     XXMOR_SOL_EST_REP_TAB_AU_TR_01
      Sysdate:         30/05/2011
      Date and Time:   30/05/2011, 04:30:57 p.m., and 30/05/2011 04:30:57 p.m.
      Username:         (set in TOAD Options, Proc Templates)
      Table Name:      XXMOR_SOLICITUDES_EST_REP_TAB (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
V_TOT_LINEAS_SOL    integer;
V_TOT_LINEAS_E60    integer;
V_EST_ACTUAL_SOL    integer;
BEGIN
   IF NEW.ESTAT_REP = 2 THEN
        SELECT ORDEN_ESTATUS
        INTO STRICT V_EST_ACTUAL_SOL
        FROM XXMOR_SOLICITUDES_enc_TAB
        WHERE ID_SOLICITUD = NEW.ID_SOLICITUD;
        UPDATE XXMOR_SOLICITUDES_DET_TAB
        SET LINEA_ESTATUS = 60
        WHERE ID_SOLICITUD = NEW.ID_SOLICITUD
        AND   LINEA = NEW.LINEA;
        SELECT COUNT(1)
        INTO STRICT V_TOT_LINEAS_E60
        FROM XXMOR_SOLICITUDES_DET_TAB
        WHERE LINEA_ESTATUS = 60
        AND   ID_SOLICITUD = NEW.ID_SOLICITUD;
        SELECT COUNT(1)
        INTO STRICT V_TOT_LINEAS_SOL
        FROM XXMOR_SOLICITUDES_DET_TAB
        WHERE ID_SOLICITUD = NEW.ID_SOLICITUD;
        IF  V_TOT_LINEAS_SOL = V_TOT_LINEAS_E60 AND V_EST_ACTUAL_SOL != 60  THEN
            UPDATE XXMOR_SOLICITUDES_ENC_TAB
            SET  ORDEN_ESTATUS = 60
            WHERE ID_SOLICITUD = NEW.ID_SOLICITUD;
            call XXMOR_FUNCIONAL_PKG_XXMOR_ENV_NOTIF_OCPGM_PR(NEW.ID_SOLICITUD);
        END IF;
   END IF;
   /*EXCEPTION
     WHEN OTHERS THEN
       NULL;*/
RETURN NEW;
END
$BODY$
 LANGUAGE 'plpgsql';
