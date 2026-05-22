create or replace procedure fecxc."feci_obtener_tipo_cambio_fecha_pr"  ( p_fecha timestamp(0), INOUT feci_cursor refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end

begin 

open feci_cursor for
select * from fecxc.feci_tipo_cambio_cat
where
fec_fecha_tc = to_timestamp(to_char(p_fecha, 'yyyy-MM-dd'),'yyyy-MM-dd')
and ind_estado =1;
end;
$body$
language plpgsql
;
