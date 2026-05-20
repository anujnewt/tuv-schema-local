CREATE OR REPLACE FUNCTION trigger_fct_dercorp_cat_acc_emp_tr() RETURNS trigger AS $body$
DECLARE
linIdEmpresa numeric;
lstCveEmpresa varchar(100);
lstNomEmpresa varchar(250);
lstAtributo1  varchar(250);
lstAtributo2  varchar(250);
BEGIN
BEGIN
BEGIN
SELECT id_empresa INTO STRICT linIdEmpresa
FROM DERCORP_EMPRESA_TAB
WHERE nom_empresa = OLD.val_cat_val;
EXCEPTION
WHEN OTHERS THEN
linIdEmpresa:= 0;
END;
UPDATE  DERCORP_EMPRESA_TAB
SET     cve_empresa             = NEW.nom_cat_val
,nom_empresa             = NEW.val_cat_val
,atributo1               = NEW.atributo1
,atributo2               = NEW.atributo2
,fec_last_update_date    = statement_timestamp()
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
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
