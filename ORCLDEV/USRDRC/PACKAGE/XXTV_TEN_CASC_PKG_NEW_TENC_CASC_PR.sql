create or replace procedure usrdrc.xxtv_ten_casc_pkg_new_tenc_casc_pr () as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstidpadre varchar(32767);
linbandera numeric := 0;
id_padre_cur cursor for
select   log_id
,oracle.substr(text, (instr(text, '''',-1, 4))::numeric +1 ,  (instr(text, '''',-1, 3))::numeric  - (instr(text, '''',-1, 4))::numeric  -1) as id_padre
,text
from     app_temp_log
where    1=1
and      nullif(text::text, '') is not null
and      text <> 'null'
order by log_id
;
id_hijo_cur cursor for
select   oracle.substr(text, (instr(text, '''',1, 1))::numeric +1,  (instr(text, '''',1, 2))::numeric  - (instr(text, '''',1, 1))::numeric -1 ) as id_hijo
from     app_temp_log
where    1=1
and      nullif(text::text, '') is not null
and      text <> 'null'
order by log_id
;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
for i in id_padre_cur
loop
for j in id_hijo_cur
loop
if i.id_padre = j.id_hijo then
linbandera := linbandera + 1;
end if;
end loop;/* dmap converted statement start */
if i.log_id > 1 then
if linbandera = 0 then
perform dbms_output.put_line( concat(i.log_id, ' ', linbandera, ' ', i.text, ' ', oracle.substr(i.text, (instr(i.text, '''',-1, 4))::numeric +1 ,  (instr(i.text, '''',-1, 3))::numeric  - (instr(i.text, '''',-1, 4))::numeric  -1) , ' ', replace(i.text, ''||oracle.substr(i.text, (instr(i.text, '''',-1, 4))::numeric +1 ,  (instr(i.text, '''',-1, 3))::numeric  - (instr(i.text, '''',-1, 4))::numeric  -1)||'','')
)) ;/* dmap converted statement end *//* dmap converted statement start */
lstidpadre := replace(i.text,  concat('', oracle.substr(i.text, (instr(i.text, '''',-1, 4))::numeric +1 ,  (instr(i.text, '''',-1, 3))::numeric  - (instr(i.text, '''',-1, 4))::numeric  -1), '') ,'');/* dmap converted statement end */
update app_temp_log set text = lstidpadre
where 1=1
and log_id = i.log_id
;
end if;
end if;
linbandera := 0;
end loop;
exception
when others then
null;end;
$body$
language plpgsql
;
