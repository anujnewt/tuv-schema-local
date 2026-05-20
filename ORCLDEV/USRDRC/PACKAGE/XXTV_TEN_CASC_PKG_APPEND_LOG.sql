create or replace procedure usrdrc.xxtv_ten_casc_pkg_append_log ("text" varchar,"action" numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
liincount numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
count(*) into strict liincount
from
app_temp_log;
liincount := liincount + 1;
if action = 3 --primer organigrama
then
insert into app_temp_log(log_id,text,id_row,id_parent)
values (liincount
,text
,oracle.substr(text,position('id:' in text)+4,(position(',' in text))::numeric -(position('id:' in text)+4)::numeric )
,replace(replace(oracle.substr(text, (instr(text, 't:  ',1, 1)+4)::numeric ,  (instr(text, ', e',1, 1))::numeric -19),',',''),'null','')
);
else if action = 4
then
insert into app_temp_log(log_id,text,id_row,id_parent)
values (liincount
,text
,oracle.substr(text, (instr(text, '''', 1, 1)+1)::numeric ,(instr(text, '''',1, 2)-6)::numeric )
,oracle.substr(text, (instr(text, '''',-1, 4))::numeric +1 ,  (instr(text, '''',-1, 3))::numeric  - (instr(text, '''',-1, 4))::numeric  -1));
else
insert into app_temp_log(log_id,text,id_row,id_parent)
values (liincount
,text
,null
,null);
end if;
end if;
perform dbms_output.put_line('LINE');
perform dbms_output.put_line(text);end;
$body$
language plpgsql
;
