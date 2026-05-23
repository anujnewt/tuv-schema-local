CREATE OR REPLACE PROCEDURE fecxc.feci_obtener_tipo_cambio_pr(
	INOUT feci_cursor refcursor DEFAULT NULL::refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
begin 

open feci_cursor for
select * from fecxc.feci_tipo_cambio_cat where ind_estado =1;

end;
$BODY$;
ALTER PROCEDURE fecxc.feci_obtener_tipo_cambio_pr(refcursor)
    OWNER TO postgres;

