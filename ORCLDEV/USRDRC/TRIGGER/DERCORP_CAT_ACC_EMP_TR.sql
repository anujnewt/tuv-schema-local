CREATE OR REPLACE NONEDITIONABLE TRIGGER "USRDRC"."DERCORP_CAT_ACC_EMP_TR" 
  BEFORE UPDATE ON USRDRC.DERCORP_ADD_CAMPO_CAT_VAL_TAB
  FOR EACH ROW
    WHEN (NEW.id_catalogo =40) DECLARE
    linIdEmpresa NUMBER;
    lstCveEmpresa VARCHAR2(100);
    lstNomEmpresa VARCHAR2(250);
    lstAtributo1  VARCHAR2(250);
    lstAtributo2  VARCHAR2(250);
BEGIN
    BEGIN
      SELECT id_empresa INTO linIdEmpresa
      FROM DERCORP_EMPRESA_TAB
      WHERE nom_empresa = :old.val_cat_val;
    EXCEPTION
      WHEN OTHERS THEN
        linIdEmpresa:= 0;
    END;

    UPDATE  DERCORP_EMPRESA_TAB 
    SET     cve_empresa             = :new.nom_cat_val
           ,nom_empresa             = :new.val_cat_val
           ,atributo1               = :new.atributo1
           ,atributo2               = :new.atributo2
           ,fec_last_update_date    = SYSDATE
    WHERE   id_empresa              = linIdEmpresa;

    /*UPDATE dercorp_add_campo_cat_val_tab 
    SET  nom_cat_val            = :new.nom_cat_val
        ,val_cat_val            = :new.val_cat_val
        ,des_cat_val            = :new.val_cat_val
        ,atributo1              = :new.atributo1
       ,atributo2               = :new.atributo2
       ,fec_last_update_date    = SYSDATE
    WHERE id_catalogo = DECODE(:new.id_catalogo,1,40,40,1)
    AND  val_cat_val  = :old.val_cat_val; */
END;


/
ALTER TRIGGER "USRDRC"."DERCORP_CAT_ACC_EMP_TR" ENABLE;
