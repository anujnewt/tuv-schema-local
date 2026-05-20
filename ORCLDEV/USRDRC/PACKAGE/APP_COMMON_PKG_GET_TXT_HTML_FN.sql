create or replace  function  usrdrc.app_common_pkg_get_txt_html_fn (pisttext varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
listtext varchar(32000);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
listtext := pisttext;
listtext := replace(listtext,'A','A');
listtext := replace(listtext,'E','E');
listtext := replace(listtext,'I','I');
listtext := replace(listtext,'O','O');
listtext := replace(listtext,'U','U');
listtext := replace(listtext,'a','a');
listtext := replace(listtext,'e','e');
listtext := replace(listtext,'i','i');
listtext := replace(listtext,'o','o');
listtext := replace(listtext,'u','u');
listtext := replace(listtext,'?','N');
listtext := replace(listtext,'?','n');
return listtext;end;
$body$
language plpgsql
;
