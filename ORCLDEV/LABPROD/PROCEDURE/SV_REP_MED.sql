create or replace procedure labprod."sv_rep_med"  ( val_num integer, reporte inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open reporte for
select to_char(num_dia, 'dd'),
to_char(num_dia, 'Month'),
to_char(num_dia, 'yyyy'),
(
case is_medio
when 0
then 1.0
when 1
then 0.5
end)
from svtempdia
where num_emp= val_num;end;
$body$
language plpgsql
;
