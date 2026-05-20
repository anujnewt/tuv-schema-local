CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NOMDES" (ws_cve_des IN VARCHAR2,wn_num_aux IN  NUMBER,ws_des_cam OUT VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	ws_cve_alf VARCHAR2(5);
		ws_nom_cam VARCHAR2(10);
		BEGIN
	IF (wn_num_aux=1 ) THEN
	BEGIN SELECT pam_folini
	INTO ws_nom_cam FROM glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='calnom')
	AND pam_cvesec='OPCI05';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
   ELSE
	BEGIN SELECT pam_folini
	INTO ws_nom_cam FROM glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='calnom')
	AND pam_cvesec='OPCI06';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  END IF;
		 IF ws_nom_cam='emp_keycen' THEN
			BEGIN SELECT cen_descen
	INTO ws_des_cam FROM nmlocenc
	WHERE cen_keycen=ws_cve_des;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ELSIF ws_nom_cam='emp_keyloc' THEN
			BEGIN SELECT loc_desloc
	INTO ws_des_cam FROM nmlolocp
	WHERE loc_keyloc=ws_cve_des;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ELSIF ws_nom_cam='emp_keyims' THEN
			BEGIN SELECT ims_razsoc
	INTO ws_des_cam FROM nmloimss
	WHERE ims_keyims=ws_cve_des;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ELSIF ws_nom_cam='emp_keycat' THEN
			BEGIN SELECT cat_descat
	INTO ws_des_cam FROM nmlocate
	WHERE cat_keycat=ws_cve_des;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ELSIF ws_nom_cam='emp_cvezon' THEN
			BEGIN SELECT pam_folini
	INTO ws_cve_alf FROM glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='cifdep')
	AND pam_cvesec='OPCI01';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT pam_nompar
	INTO ws_des_cam FROM glcopams
	WHERE pam_keypar=ws_cve_alf
	AND pam_cvesec=ws_cve_des;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ELSIF ws_nom_cam='emp_tipemp' THEN
			BEGIN SELECT pam_folini
	INTO ws_cve_alf FROM glcopams
	WHERE pam_keypar = (
	SELECT pam_folini FROM glcopams
	WHERE pam_keypar='00'
	AND pam_cvesec='cifdep')
	AND pam_cvesec='OPCI02';
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  BEGIN SELECT pam_nompar
	INTO ws_des_cam FROM glcopams
	WHERE pam_keypar=ws_cve_alf
	AND pam_cvesec=ws_cve_des;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  NULL;
  END;
  ELSE
			ws_des_cam:='No Existe Descripci?
	  END IF;
			END;
/
