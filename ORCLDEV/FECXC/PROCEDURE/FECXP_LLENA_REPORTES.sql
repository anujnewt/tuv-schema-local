create or replace procedure fecxc."fecxp_llena_reportes"  ( panio numeric, pmes numeric, ptipo numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

if ptipo = 1  then
call fecxc.fecxp_llena_caratula_real (panio, pmes);
call fecxc.fecxp_llena_caratula_ppto (panio, pmes);
end if;
if ptipo = 2  then
call fecxc.fecxp_llena_forecast ( panio, pmes );
end if;
if ptipo = 3  then
call fecxc.fecxp_llena_rep_concil_erp ( panio, pmes );
call fecxc.fecxp_llena_rep_concil_soin ( panio, pmes );
end if;
if ptipo = 4  then
call fecxc.fecxp_llena_rep_mcomp_erp ( panio, pmes );
call fecxc.fecxp_llena_rep_mcomp_soin ( panio, pmes );
end if;
if ptipo = 5  then
call fecxc.fecxp_llena_rep_ppto_erp ( panio, pmes );
call fecxc.fecxp_llena_rep_ppto_soin ( panio, pmes );
end if;
if ptipo = 6  then
call fecxc.fecxp_llena_rep_real_erp ( panio, pmes );
call fecxc.fecxp_llena_rep_real_soin ( panio, pmes );
end if;
/* commit; */
end;
$body$
language plpgsql
;
