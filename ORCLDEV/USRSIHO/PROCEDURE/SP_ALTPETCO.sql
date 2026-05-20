create or replace procedure usrsiho."sp_altpetco"  (pi_folio numeric, pi_idenc numeric, pi_iddet numeric, pd_fecha varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- returning decimal(10,2);
-- -----------------------------------------------------------------
-- sp_altpetco: este stored procedure es el que utiliza en el
-- modulo de captura de contratos para actualizar el status del
-- encabezado y del detalle si se realizo la captura por medio
-- del boton de petici?e contrato.
-- devuelve :
-- realizado el 03 de julio de 2008
-- jose dolores cuellar mtz
-- -----------------------------------------------------------------
-- definimos variables de trabajo
li_registros numeric(10);
begin
update usrsiho.detpetco
set dpc_keyfol = pi_folio,
dpc_feccap = to_timestamp(pd_fecha,'DD/MM/YYYY'),
dpc_stsreg = 3    -- ---> estatus 3 en detpetco  = ya se capturo contrato para ese empleado y se encuentra contratado
where dpc_idereg = pi_iddet
and dpc_numpco = pi_idenc;
-- ---> buscamos en el detalle si existen todavia status 1 (activo)
li_registros := 0;
begin
select count(*)
into strict li_registros
from usrsiho.detpetco
where dpc_numpco = pi_idenc
and dpc_stsreg = 1;
exception when no_data_found then
li_registros := 0;
end;
if nullif(li_registros::text, '') is null then
li_registros := 0;
end if;
if li_registros = 0 then
update usrsiho.encpetco
set epc_stspet = 4    -- ---> estatus 4 en encpetco  = ya se capturaron todos los contratos de los empleados y se encuentra atendida
where epc_numpco = pi_idenc;
end if;
-- -----------------------------------------------------------
end;
$body$
language plpgsql
;
