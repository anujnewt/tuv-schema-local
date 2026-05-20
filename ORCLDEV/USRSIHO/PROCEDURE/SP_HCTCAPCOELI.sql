create or replace procedure usrsiho."sp_hctcapcoeli"  (pnkeyplz numeric,pskeydep varchar, pskeypue varchar,pnejercicio numeric, pncosuni numeric,pnnumcdi numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
--actualizo prestamosr
update usrsiho.holopres
set pre_ejerci = pre_ejerci - (pncosuni * pnnumcdi)
where pre_keydep = trim(both pskeydep)
and pre_keypue = trim(both pskeypue)
and pre_anio   = pnejercicio;
--elimino el contrato
delete from usrsiho.holocont
where con_keyplz = pnkeyplz;end;
$body$
language plpgsql
;
