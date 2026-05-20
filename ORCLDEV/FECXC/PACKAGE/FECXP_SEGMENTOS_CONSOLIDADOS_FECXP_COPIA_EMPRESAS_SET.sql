create or replace procedure fecxc.fecxp_segmentos_consolidados_fecxp_copia_empresas_set () as $body$
declare
-- pgv moved types start
-- pgv moved types end
recorre_cursor numeric;
c_emp_set cursor for select e_codigo, des_empresa from fecxc.fecxc_empresas;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from fecxc.fecxp_emp_no_set where tipo_empresa='SET' and cambio_set_no_set='N';
/* commit; */
for recorre_cursor in c_emp_set loop
begin
insert into fecxc.fecxp_emp_no_set(id_emp, desc_emp, tipo_empresa ) values (recorre_cursor.e_codigo, recorre_cursor.des_empresa,'SET');
exception
when others then
update fecxc.fecxp_emp_no_set
set  desc_emp=recorre_cursor.des_empresa
where id_emp =recorre_cursor.e_codigo;
end;
end loop;
/* commit; */
end;
$body$
language plpgsql
;
