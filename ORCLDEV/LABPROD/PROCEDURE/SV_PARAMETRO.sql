create or replace procedure labprod."sv_parametro"  ( nom varchar, parametro inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open parametro for
select val_param from svconfig where nom_param = nom;end;
$body$
language plpgsql
;
