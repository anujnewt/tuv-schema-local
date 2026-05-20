CREATE OR REPLACE EDITIONABLE PROCEDURE "LABCONF"."SP_FECHA" IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
	wd_fec_mov DATE;
		ws_ide_fec VARCHAR2(10);
		ws_ide_hor VARCHAR2(8);
		BEGIN
	ws_ide_fec:='_FECHADIA_';
	sp_glfechor(wd_fec_mov, ws_ide_hor);
	DELETE FROM glwkcrys
	WHERE cry_nomrep=ws_ide_fec;
		INSERT INTO glwkcrys( cry_nomrep,cry_dat001,cry_chr012,cry_chr017)
		VALUES(ws_ide_fec,wd_fec_mov,USER,ws_ide_hor);
		END;
/
