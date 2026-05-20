create or replace procedure fecxc."xxchk_ver_per_contable"  ( p_fecha timestamp(0), /* cambio de tipo de dato de int a varchar2 por bug reportado 16abr/2010  hbchr */
p_empresa varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
vperiod_name varchar(250);
vorg_id integer;
v_empresa varchar(250);
begin 

/* validacion solicitada por facundo trejo para obtener organizacioin equivalente a la aplicacion*/
begin
select  e_codigo_soin
into strict   v_empresa
from fecxc.fecxc_empresas
where e_codigo= p_empresa;
exception
when no_data_found then
--                    dbms_output.put_line('NO HAY DATOS');
raise exception '%', 'Codigo de Empresa No encontrado' using errcode = '45001';
end;
---  obtengo org_id
begin
select hou.organization_id org_id
into strict vorg_id
from hr.hr_all_organization_units__erp_prod hou,
hr.hr_organization_information__erp_prod hoi    ,
ar.ar_system_parameters_all__erp_prod asp
where hou.organization_id                    = hoi.organization_id
and hou.organization_id                        = asp.org_id
and hoi.org_information1                       = 'OPERATING_UNIT'
and hoi.org_information2                       = 'Y'
and asp. set_of_books_id                       > 0
and oracle.substr(hou.name,1, position('-' in hou.name)-1) in (v_empresa);
-----  seteo de variables.
exception
when no_data_found then
--                    dbms_output.put_line('NO HAY DATOS');
raise exception '%', 'Codigo de Empresa No encontrado ERP' using errcode = '45002';
when others then
--                   dbms_output.put_line('Error desconocido');
raise exception '%', 'Error en DBLINK' using errcode = '45003';
end;
begin
perform dbms_output.put_line(vorg_id);
apps.fnd_client_info.set_org_context__erp_prod(vorg_id);
execute 'ALTER SESSION SET NULLIF(NLS_LANGUAGE::text, '') IS NULLAMERICAN ;' ; /* dmap converted statement */
execute 'ALTER SESSION SET NULLIF(NLS_NUMERIC_CHARACTERS::text, '') IS NULL.,;' ; /* dmap converted statement */
end;
--dbms_output.put_line('VORG_ID');
--- verifico periodo contable
begin
select period_name
--,start_date,end_date, closing_status
into strict vperiod_name
--vperiod_name,vstart_date,vend_date, vclosing_status
from apps.gl_period_statuses_v__erp_prod
where set_of_books_id =
(select asp.set_of_books_id
from hr.hr_all_organization_units__erp_prod hou,
hr.hr_organization_information__erp_prod hoi    ,
ap.ap_system_parameters_all__erp_prod asp
where hou.organization_id = hoi.organization_id
and hou.organization_id     = asp.org_id
and hoi.org_information1    = 'OPERATING_UNIT'
and hoi.org_information2    = 'Y'
and hou.organization_id     = vorg_id
)
and application_id = 222
and closing_status ='O'
and start_date    <=to_timestamp(p_fecha,'dd/mm/yy')
--and start_date<=to_timestamp('03/03/2010','dd/mm/yy')
and end_date>=to_timestamp(p_fecha,'dd/mm/yy')
--and end_date>=to_timestamp('03/03/2010','dd/mm/yy')
order by  period_year desc ,
period_num desc;
perform dbms_output.put_line(vperiod_name);
exception
when no_data_found then
--                    dbms_output.put_line('NO HAY DATOS');
raise exception '%', 'Periodo no disponible en AR' using errcode = '45000';
when others then
--                   dbms_output.put_line('Error desconocido');
raise exception '%', 'ERROR en DBLINK' using errcode = '45003';
end;end;
$body$
language plpgsql
;
