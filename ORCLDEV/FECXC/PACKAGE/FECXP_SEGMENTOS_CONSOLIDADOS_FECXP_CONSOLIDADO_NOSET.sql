create or replace procedure fecxc.fecxp_segmentos_consolidados_fecxp_consolidado_noset (id_segmento numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
recorre_cursor numeric;
c_emp_set cursor for select id_emp from  fecxc.fecxp_emp_no_set where tipo_empresa='NO SET';
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
for recorre_cursor in c_emp_set loop
begin
insert into fecxc.fecxp_emp_x_segmento_no_set(id_segmento, e_codigo, tipo_empresa  ) values (id_segmento, recorre_cursor.id_emp, 'NO SET');
exception
when others then
null;
end;
end loop;
/* commit; */
end;
$body$
language plpgsql
;
