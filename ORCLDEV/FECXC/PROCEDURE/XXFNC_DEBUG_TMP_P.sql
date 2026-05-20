create or replace procedure fecxc.dmap_xxfnc_debug_tmp_p  ( l_place varchar ,l_calling_module varchar ,l_msg varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--
-- pragma autonomous_transaction;
v_consec numeric;
begin 

select nextval('fecxc.xxfnc_debug_tmp_s')
into strict v_consec
;
--
insert into fecxc.xxfnc_debug_tbl_tmp
values ( v_consec
, clock_timestamp()
, l_place
, l_calling_module
, l_msg);
/* commit; */
exception
when others then null;end;
$body$
language plpgsql
;
CREATE OR REPLACE PROCEDURE fecxc.xxfnc_debug_tmp_p(l_place varchar,l_calling_module varchar,l_msg varchar) 


AS

$$

DECLARE

v_sql text;

v_con_count int;

v_con_name text;

output1 text;

BEGIN

v_con_name := 'pragma_at_dmap_dblink';

SELECT count(1) INTO v_con_count FROM dblink_get_connections()

WHERE dblink_get_connections__>'{pragma_at_dmap_dblink}';


IF v_con_count = 0 THEN

    PERFORM dblink_connect(v_con_name, 'pragma_at_dmap_dblink');

END IF;


v_sql := FORMAT('CALL dmap_xxfnc_debug_tmp_p(l_place=> %L,l_calling_module=> %L,l_msg=> %L)' , l_place,l_calling_module,l_msg);


SELECT * INTO output1 FROM dblink(v_con_name, v_sql) AS t(result text);


END;

$$ LANGUAGE plpgsql;
CREATE OR REPLACE PROCEDURE fecxc.xxfnc_debug_tmp_p(l_place varchar,l_calling_module varchar,l_msg varchar) 


AS

$$

DECLARE

v_sql text;

v_con_count int;

v_con_name text;

output1 text;

BEGIN

v_con_name := 'pragma_at_dmap_dblink';

SELECT count(1) INTO v_con_count FROM dblink_get_connections()

WHERE dblink_get_connections@>'{pragma_at_dmap_dblink}';


IF v_con_count = 0 THEN

    PERFORM dblink_connect(v_con_name, 'pragma_at_dmap_dblink');

END IF;


v_sql := FORMAT('CALL dmap_xxfnc_debug_tmp_p(l_place=> %L,l_calling_module=> %L,l_msg=> %L)' , l_place,l_calling_module,l_msg);


SELECT * INTO output1 FROM dblink(v_con_name, v_sql) AS t(result text);


END;

$$ LANGUAGE plpgsql;
