create or replace procedure labprod."sp_tvwkpoli"  (idepro glcoargu.arg_idepro%type, idepcc glcoargu.arg_idepcc%type, keyusu glcoargu.arg_keyusu%type, fecini glcoargu.arg_fecini%type, horini glcoargu.arg_horini%type) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
tvcontab.sp_poliza(idepro, idepcc, keyusu, fecini, horini);end;
$body$
language plpgsql
;
