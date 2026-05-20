CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_TVWKPOLI" (idepro IN glcoargu.arg_idepro%TYPE,
                               idepcc IN glcoargu.arg_idepcc%TYPE,
                               keyusu IN glcoargu.arg_keyusu%TYPE,
                               fecini IN glcoargu.arg_fecini%TYPE,
                               horini IN glcoargu.arg_horini%TYPE) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
   TVCONTAB.SP_POLIZA(idepro, idepcc, keyusu, fecini, horini);
END SP_TVWKPOLI;
/
