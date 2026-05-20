create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_valor_paquetes_fn ( pistusrfl varchar, pistdescpaquete varchar ) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
lst_parametro    varchar(30);
lin_valor_usrfl  integer;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
lst_parametro := null;
if pistdescpaquete = 'SIN VALOR' then
lin_valor_usrfl := 0;
else
begin
select nombre_parametro
into strict   lst_parametro
from   xxmor_conf_params_grls_tab
where  tipo_parametro  = 'PLATAFORMA'
and    valor_parametro = pistdescpaquete;
exception
when no_data_found then
lst_parametro := 'SIN PAQUETE';
when others then
lst_parametro := 'SIN PAQUETE';
end;
if lst_parametro = 'SIN PAQUETE' then
lin_valor_usrfl := 0;
elsif lst_parametro = 'SIN_TV_DIGITAL' then
if pistusrfl = 'USRFL19' then
lin_valor_usrfl := 1;
else
lin_valor_usrfl := 0;
end if;
elsif lst_parametro = 'SIN_TV_PAGA' then
if pistusrfl = 'USRFL19' then
lin_valor_usrfl := 0;
else
lin_valor_usrfl := 1;
end if;
elsif lst_parametro = 'TV_ABIERTA' then
if pistusrfl = 'USRFL19' then
lin_valor_usrfl := 1;
else
lin_valor_usrfl := 1;
end if;
end if;
end if;
return lin_valor_usrfl;
exception
when no_data_found then
return 0;
when others then
return 0;end;
$body$
language plpgsql
;
