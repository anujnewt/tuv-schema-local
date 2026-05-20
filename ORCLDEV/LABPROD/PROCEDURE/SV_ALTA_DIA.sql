create or replace procedure labprod."sv_alta_dia"  ( numero integer, dia varchar, medio smallint, periodo varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
insert
into svtempdia(
num_emp,
num_dia,
is_medio,
per_vac
)
values (
numero,
to_timestamp(dia,'yyyy/MM/dd'),
medio,
periodo
);
/* commit; */
end;
$body$
language plpgsql
;
