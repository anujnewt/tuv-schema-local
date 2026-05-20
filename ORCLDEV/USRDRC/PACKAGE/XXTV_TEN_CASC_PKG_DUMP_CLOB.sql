create or replace procedure usrdrc.xxtv_ten_casc_pkg_dump_clob ("text" inout "text","action" numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
offset numeric := 1;
amount numeric;
len    numeric := octet_length("text");
buf    varchar(32767);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
while offset < len loop
-- this is slowwwwww...
amount := oracle.least(dbms_lob.instr(clob, chr(10), offset)
- offset, 32767);/* dmap converted statement start */
if amount > 0 then
-- this is slow...
call dmap_extension.dmap_dbms_lob_read(clob, amount, offset, buf);/* dmap converted statement end */
offset := offset + amount + 1;
else
buf := null;
offset := offset + 1;
end if;
--dbms_output.put_line(* || buf);
call xxtv_ten_casc_pkg_append_log(buf,action);
end loop;end;
$body$
language plpgsql
;
