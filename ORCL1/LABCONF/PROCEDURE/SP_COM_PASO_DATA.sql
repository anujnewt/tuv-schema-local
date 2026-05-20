CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_COM_PASO_DATA" (noctvo integer) AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
vs_activo       char(1);
vn_existr       integer;
vg_keyemp       integer;
vg_keypar       varchar2(2);
vg_valpar        char(30);
BEGIN
SELECT dat_keyemp,trim(dat_keypar),dat_valpar INTO vg_keyemp,vg_keypar,vg_valpar
  FROM com_orac_sips_data WHERE ora_noctvo=noctvo;
IF length(vg_keypar) = 1 THEN vg_keypar := '0'||trim(vg_keypar); END IF;
SELECT count(*) INTO vn_existr FROM datapaso WHERE  dat_keyemp=vg_keyemp AND  dat_keypar=vg_keypar;
IF vn_existr = 0 or vn_existr is null THEN
     INSERT INTO datapaso (dat_keyemp,dat_keypar,dat_valpar)
     VALUES (vg_keyemp,vg_keypar,vg_valpar);
ELSE
	UPDATE datapaso SET dat_valpar=vg_valpar WHERE dat_keyemp=vg_keyemp AND dat_keypar=vg_keypar;
END IF;
END;
/
