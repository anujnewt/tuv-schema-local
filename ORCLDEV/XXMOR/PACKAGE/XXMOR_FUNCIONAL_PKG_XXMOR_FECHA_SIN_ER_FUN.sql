create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_fecha_sin_er_fun ( p_fecha varchar, p_tipo varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_fecha_out varchar(50);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
if p_tipo = 'AUT_TM' then
begin
select to_char(to_timestamp(p_fecha,'YYYYMMDD'), 'YYYY-MM-DD')
into strict v_fecha_out
;
exception
when others then
v_fecha_out := '0001-01-01';
end;
end if;
return v_fecha_out;end;
$body$
language plpgsql
;
