CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."XXFNC_DEBUG_TMP_P" (
    l_place                 VARCHAR2
    ,l_calling_module       VARCHAR2
    ,l_msg                    VARCHAR2
    ) as
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    --
PRAGMA AUTONOMOUS_TRANSACTION;
    v_consec number;
BEGIN
    select fecxc.xxfnc_debug_tmp_s.nextval
    into v_consec
    from dual;
    --
    insert into fecxc.xxfnc_debug_tbl_tmp
    values( v_consec
        , sysdate
        , l_place
        , l_calling_module
        , l_msg);
    commit;
EXCEPTION
    when others then null;
END;
/
