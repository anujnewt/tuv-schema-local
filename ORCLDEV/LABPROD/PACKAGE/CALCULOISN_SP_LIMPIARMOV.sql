create or replace procedure labprod.calculoisn_sp_limpiarmov (ws_nom_rep varchar,ws_key_per varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from labprod.nmwkmovt
where mov_keypro in (select ran_keypro from labprod.glwkrang where ran_nomrep = ws_nom_rep)
and mov_keyper = ws_key_per;
/* commit; */
end;
$body$
language plpgsql
;
