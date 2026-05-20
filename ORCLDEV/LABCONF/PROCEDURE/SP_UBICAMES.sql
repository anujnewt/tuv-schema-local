CREATE OR REPLACE EDITIONABLE PROCEDURE "LABCONF"."SP_UBICAMES" (vs_cod_acu IN VARCHAR2,vn_uni_dad IN NUMBER,vn_imp_ort IN NUMBER,wn_key_pro IN NUMBER,wn_key_per IN VARCHAR2,acu_uni_uno IN NUMBER,acu_uni_dos IN NUMBER,acu_uni_tre IN NUMBER,acu_uni_cua IN NUMBER,acu_uni_cin IN NUMBER,acu_uni_sei IN NUMBER,acu_uni_sie IN NUMBER,acu_uni_och IN NUMBER,acu_uni_nue IN NUMBER,acu_uni_die IN NUMBER,acu_uni_onc IN NUMBER,acu_uni_doc IN NUMBER,acu_uni_trc IN NUMBER,acu_uni_cat IN NUMBER,acu_uni_qui IN NUMBER,acu_imp_uno IN NUMBER,acu_imp_dos IN NUMBER,acu_imp_tre IN NUMBER,acu_imp_cua IN NUMBER,acu_imp_cin IN NUMBER,acu_imp_sei IN NUMBER,acu_imp_sie IN NUMBER,acu_imp_och IN NUMBER,acu_imp_nue IN NUMBER,acu_imp_die IN NUMBER,acu_imp_onc IN NUMBER,acu_imp_doc IN NUMBER,acu_imp_trc IN NUMBER,acu_imp_cat IN NUMBER,acu_imp_qui IN NUMBER,wn_uni_uno OUT NUMBER,wn_uni_dos OUT NUMBER,wn_uni_tre OUT NUMBER,wn_uni_cua OUT NUMBER,wn_uni_cin OUT NUMBER,wn_uni_sei OUT NUMBER,wn_uni_sie OUT NUMBER,wn_uni_och OUT NUMBER,wn_uni_nue OUT NUMBER,wn_uni_die OUT NUMBER,wn_uni_onc OUT NUMBER,wn_uni_doc OUT NUMBER,wn_uni_trc OUT NUMBER,wn_uni_cat OUT NUMBER,wn_uni_qui OUT NUMBER,wn_imp_uno OUT NUMBER,wn_imp_dos OUT NUMBER,wn_imp_tre OUT NUMBER,wn_imp_cua OUT NUMBER,wn_imp_cin OUT NUMBER,wn_imp_sei OUT NUMBER,wn_imp_sie OUT NUMBER,wn_imp_och OUT NUMBER,wn_imp_nue OUT NUMBER,wn_imp_die OUT NUMBER,wn_imp_onc OUT NUMBER,wn_imp_doc OUT NUMBER,wn_imp_trc OUT NUMBER,wn_imp_cat OUT NUMBER,wn_imp_qui OUT NUMBER ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wn_num_mes NUMBER(5);
		wn_acu_dos NUMBER(5);
		wn_acu_tre NUMBER(5);
		wn_acu_cua NUMBER(5);
		wn_mes NUMBER(5);
		BEGIN
	wn_uni_uno:=acu_uni_uno;
	wn_uni_dos:=acu_uni_dos;
	wn_uni_tre:=acu_uni_tre;
	wn_uni_cua:=acu_uni_cua;
	wn_uni_cin:=acu_uni_cin;
	wn_uni_sei:=acu_uni_sei;
	wn_uni_sie:=acu_uni_sie;
	wn_uni_och:=acu_uni_och;
	wn_uni_nue:=acu_uni_nue;
	wn_uni_die:=acu_uni_die;
	wn_uni_onc:=acu_uni_onc;
	wn_uni_doc:=acu_uni_doc;
	wn_uni_trc:=acu_uni_trc;
	wn_uni_cat:=acu_uni_cat;
	wn_uni_qui:=acu_uni_qui;
	wn_imp_uno:=acu_imp_uno;
	wn_imp_dos:=acu_imp_dos;
	wn_imp_tre:=acu_imp_tre;
	wn_imp_cua:=acu_imp_cua;
	wn_imp_cin:=acu_imp_cin;
	wn_imp_sei:=acu_imp_sei;
	wn_imp_sie:=acu_imp_sie;
	wn_imp_och:=acu_imp_och;
	wn_imp_nue:=acu_imp_nue;
	wn_imp_die:=acu_imp_die;
	wn_imp_onc:=acu_imp_onc;
	wn_imp_doc:=acu_imp_doc;
	wn_imp_trc:=acu_imp_trc;
	wn_imp_cat:=acu_imp_cat;
	wn_imp_qui:=acu_imp_qui;
	wn_imp_qui:=acu_imp_qui;
	BEGIN SELECT per_nummes, per_acudos, per_acutre, per_acucua
	INTO wn_num_mes, wn_acu_dos, wn_acu_tre, wn_acu_cua FROM nmloperi
	WHERE per_keypro = wn_key_pro
	AND per_keyper = wn_key_per;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
	IF (vs_cod_acu='ME' ) THEN
	wn_mes:=wn_num_mes;
	END IF;
	IF (vs_cod_acu='A2' ) THEN
	wn_mes:=wn_acu_dos;
	END IF;
	IF (vs_cod_acu='A3' ) THEN
	wn_mes:=wn_acu_tre;
	END IF;
	IF (vs_cod_acu='A4' ) THEN
	wn_mes:=wn_acu_cua;
	END IF;
	IF (wn_mes=1 ) THEN
	wn_uni_uno:=(acu_uni_uno+vn_uni_dad);
	wn_imp_uno:=(acu_imp_uno +vn_imp_ort);
	END IF;
	IF (wn_mes=2 ) THEN
	wn_uni_dos:=(acu_uni_dos+vn_uni_dad);
	wn_imp_dos:=(acu_imp_dos+vn_imp_ort);
	END IF;
	IF (wn_mes=3 ) THEN
	wn_uni_tre:=(acu_uni_tre+vn_uni_dad);
	wn_imp_tre:=(acu_imp_tre +vn_imp_ort);
	END IF;
	IF (wn_mes=4 ) THEN
	wn_uni_cua:=(acu_uni_cua+vn_uni_dad);
	wn_imp_cua:=(acu_imp_cua +vn_imp_ort);
	END IF;
	IF (wn_mes=5 ) THEN
	wn_uni_cin:=(acu_uni_cin+vn_uni_dad);
	wn_imp_cin:=(acu_imp_cin +vn_imp_ort);
	END IF;
	IF (wn_mes=6 ) THEN
	wn_uni_sei:=(acu_uni_sei+vn_uni_dad);
	wn_imp_sei:=(acu_imp_sei +vn_imp_ort);
	END IF;
	IF (wn_mes=7 ) THEN
	wn_uni_sie:=(acu_uni_sie+vn_uni_dad);
	wn_imp_sie:=(acu_imp_sie +vn_imp_ort);
	END IF;
	IF (wn_mes=8 ) THEN
	wn_uni_och:=(acu_uni_och+vn_uni_dad);
	wn_imp_och:=(acu_imp_och +vn_imp_ort);
	END IF;
	IF (wn_mes=9 ) THEN
	wn_uni_nue:=(acu_uni_nue+vn_uni_dad);
	wn_imp_nue:=(acu_imp_nue +vn_imp_ort);
	END IF;
	IF (wn_mes=10 ) THEN
	wn_uni_die:=(acu_uni_die+vn_uni_dad);
	wn_imp_die:=(acu_imp_die +vn_imp_ort);
	END IF;
	IF (wn_mes=11 ) THEN
	wn_uni_onc:=(acu_uni_onc+vn_uni_dad);
	wn_imp_onc:=(acu_imp_onc +vn_imp_ort);
	END IF;
	IF (wn_mes=12 ) THEN
	wn_uni_doc:=(acu_uni_doc+vn_uni_dad);
	wn_imp_doc:=(acu_imp_doc +vn_imp_ort);
	END IF;
	IF (wn_mes=13 ) THEN
	wn_uni_tre:=(acu_uni_trc+vn_uni_dad);
	wn_imp_tre:=(acu_imp_trc +vn_imp_ort);
	END IF;
	IF (wn_mes=14 ) THEN
	wn_uni_cat:=(acu_uni_cat+vn_uni_dad);
	wn_imp_cat:=(acu_imp_cat +vn_imp_ort);
	END IF;
	IF (wn_mes=15 ) THEN
	wn_uni_qui:=(acu_uni_qui+vn_uni_dad);
	wn_imp_qui:=(acu_imp_qui+vn_imp_ort);
	END IF;
		END;
/
