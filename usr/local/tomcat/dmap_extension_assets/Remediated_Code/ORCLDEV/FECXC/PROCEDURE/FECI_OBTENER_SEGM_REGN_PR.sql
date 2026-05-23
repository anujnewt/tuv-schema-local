CREATE OR REPLACE PROCEDURE fecxc.feci_obtener_segm_regn_pr(
	IN OUT feci_cursor refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursor refcursor;

begin 

open feci_cursor for
select * from fecxc.feci_segm_regn_cat where ind_estado =1;
end;
$BODY$;
ALTER PROCEDURE fecxc.feci_obtener_segm_regn_pr(refcursor)
    OWNER TO postgres;

