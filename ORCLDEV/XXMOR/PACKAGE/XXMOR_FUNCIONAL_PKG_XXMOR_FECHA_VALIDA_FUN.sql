create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_fecha_valida_fun ( p_fecha varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_es_valida varchar(2) := '0';
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
if nullif(p_fecha::text, '') is not null then
begin
select (case when nullif(to_timestamp(p_fecha,'YYYYMMDD')::text, '') is not null then '1' else '0' end)
into strict v_es_valida
;
exception
when others then
v_es_valida := '0';
end;
end if;
return v_es_valida;end;
$body$
language plpgsql
;
