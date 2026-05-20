create or replace procedure labprod.respuestasap_setrefcon ( ws_pro_ca4aux varchar, ws_pro_ca5aux varchar, ws_emp_ca2aux varchar, ws_emp_tipemp varchar, ws_emp_ca4aux inout varchar, ws_emp_refcon inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
if  nullif(ws_pro_ca4aux::text, '') is null and nullif(ws_pro_ca5aux::text, '') is null then
ws_emp_ca4aux :='N';
ws_emp_refcon :='2';
end if;
if  ws_pro_ca4aux ='S' and ws_pro_ca5aux ='T' then
ws_emp_ca4aux :='F';
ws_emp_refcon :='1';
end if;
if  ws_pro_ca4aux ='N' then
ws_emp_ca4aux :='N';
ws_emp_refcon :='2';
end if;
if  ws_pro_ca4aux ='S' and ws_pro_ca5aux ='C' then
if  ws_emp_tipemp ='1' then
ws_emp_ca4aux :='F';
ws_emp_refcon :='1';
else
ws_emp_ca4aux :='N';
ws_emp_refcon :='2';
end if;
end if;
if  ws_pro_ca4aux ='S' and ws_pro_ca5aux ='S' then
if  ws_emp_tipemp ='2' then
ws_emp_ca4aux :='F';
ws_emp_refcon :='1';
else
ws_emp_ca4aux :='N';
ws_emp_refcon :='2';
end if;
end if;
if  ws_emp_ca2aux > '2' and ws_emp_ca2aux < '8' then
ws_emp_ca4aux :='N';
ws_emp_refcon :='2';
end if;end;
$body$
language plpgsql
;
