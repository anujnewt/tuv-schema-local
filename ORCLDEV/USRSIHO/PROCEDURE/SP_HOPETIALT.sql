create or replace procedure usrsiho."sp_hopetialt"  (pi_folio numeric, pi_idenc numeric, pi_iddet numeric, pd_fecha varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- returning decimal(10,2);
-- -----------------------------------------------------------------
-- sp_hopetialt: este stored procedure es el que utiliza en el
-- modulo de captura de contratos para actualizar el status del
-- encabezado y del detalle si se realizo la captura por medio
-- del boton de petici??e contrato.
-- devuelve :
-- realizado el 22 de noviembre de 2005
-- emilio pulido rangel
-- -----------------------------------------------------------------
-- definimos variables de trabajo
li_registros numeric(10);
begin
update pcdetalleanda
set deafoliocontrato = pi_folio,
deafechacapturacon = pd_fecha,
deaestatus = 4    -- ---> estatus 4 en pcdetalleanda = ya se capturo contrato para ese empleado
where deaidnumdet = pi_iddet
and deaidnumenc = pi_idenc;
-- ---> buscamos en el detalle si existen todavia status 1 (activo)
li_registros := 0;
select count(*)
into strict li_registros
from pcdetalleanda
where deaidnumenc = pi_idenc
and deaestatus = 1;
if nullif(li_registros::text, '') is null then
li_registros := 0;
end if;
if li_registros = 0 then
update pcencabezadoanda
set enaestatus = 4    -- ---> estatus 4 en pcencabezadoanda = ya se capturaron todos los contratos de los empleados
where enaidnumenc = pi_idenc;
end if;
-- -----------------------------------------------------------
end;
$body$
language plpgsql
;
