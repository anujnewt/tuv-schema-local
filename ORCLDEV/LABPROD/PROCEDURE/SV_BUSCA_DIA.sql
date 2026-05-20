create or replace procedure labprod."sv_busca_dia"  ( numero integer, busca_dia inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open busca_dia for
select num_dia, is_medio, per_vac from svtempdia where num_emp = numero;end;
$body$
language plpgsql
;
