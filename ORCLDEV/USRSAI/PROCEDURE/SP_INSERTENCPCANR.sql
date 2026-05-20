create or replace procedure usrsai."sp_insertencpcanr"  ( keydep varchar, observ varchar, keyusu varchar, stspet numeric, sigid inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
sigid := 0;
select coalesce(max(epc_numpco), 0) + 1 into strict sigid from encpcanr;
insert into encpcanr(epc_numpco, epc_keydep, epc_fecpet, epc_observ, epc_keyusu, epc_stspet) values (sigid, keydep, clock_timestamp(), observ, keyusu, stspet);end;
$body$
language plpgsql
;
