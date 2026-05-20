CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_PASO_LOAD_DATA" (keyemp integer) AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  vs_activo       varchar2(1);
  vn_existr       integer;
  vg_keyemp       integer;
  vg_keypar       varchar2(4);
  vg_valpar       varchar2(30);
  vg_largo        smallint;
CURSOR namedCursor IS
SELECT trim(dat_keyemp), trim(dat_keypar), trim(dat_valpar)
  INTO vg_keyemp,vg_keypar,vg_valpar FROM datapaso WHERE dat_keyemp =  keyemp;
BEGIN
OPEN namedCursor;
    LOOP
		FETCH namedCursor INTO vg_keyemp,vg_keypar,vg_valpar;
	EXIT WHEN namedCursor%NOTFOUND;
           SELECT count(*) INTO  vn_existr FROM nmlodata
		   WHERE  dat_keyemp=vg_keyemp AND  dat_keypar=vg_keypar;
		IF (vn_existr = 0 or vn_existr is null)  and vg_keyemp is not null THEN
			INSERT INTO nmlodata(dat_keyemp,dat_keypar,dat_valpar) VALUES(vg_keyemp,vg_keypar,vg_valpar);
		ELSE
			UPDATE nmlodata SET dat_valpar=vg_valpar WHERE dat_keyemp=vg_keyemp AND dat_keypar=vg_keypar;
END IF;
    END LOOP;
CLOSE namedCursor;
END;
/
