create or replace procedure usrsiho."sp_hctcapcocam"  (pnkeyplz numeric,pskeydep varchar, pskeypue varchar,pnejercicio numeric, pncosuni numeric,pnnumcdi numeric,pnproc numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lsstatus holopres.pre_status%type;
lsstatus2 hologlpr.glp_status%type;
pnejerciciog numeric(5);
begin
--lee los capitulos vigentes y los cancela
update usrsiho.holococa
set coc_stspag = 'C'
where coc_stspag = 'V'
and nullif(coc_keyrph::text, '') is null
and coc_keyplz = pnkeyplz;
--actualizamos holopres o hologlpr lo ejercido por cada capitulo vigente
--dependiendo del proceso
if pnproc = 138 then
begin
select pre_status
into strict lsstatus
from usrsiho.holopres
where pre_keydep = pskeydep
and pre_keypue = trim(both pskeypue)
and pre_anio   = pnejercicio;
end;
if lsstatus = 'A' then
update usrsiho.holopres
set pre_ejerci = pre_ejerci - (pncosuni * pnnumcdi)
where pre_keydep = pskeydep
and pre_keypue = trim(both pskeypue)
and pre_anio   = pnejercicio
and pre_status = 'A';
else
select max(pre_anio)
into strict pnejerciciog
from usrsiho.holopres
where pre_keydep = pskeydep
and pre_keypue = trim(both pskeypue);
update usrsiho.holopres
set pre_ejerci = pre_ejerci - (pncosuni * pnnumcdi)
where pre_keydep = pskeydep
and pre_keypue = trim(both pskeypue)
and pre_anio   = pnejerciciog;
end if;
else
insert into usrsiho.glwkcrys(cry_nomrep,cry_chr001,cry_numsec)
values ('claud',pnejercicio,1);
begin
select glp_status
into strict lsstatus2
from usrsiho.hologlpr
where glp_keydep = oracle.substr(pskeydep,1,6)
and glp_keypue = trim(both pskeypue)
and glp_anio   = pnejercicio;
exception when no_data_found then lsstatus2:= null;
end;
if lsstatus2 = 'A' then
update usrsiho.hologlpr
set glp_ejerci = glp_ejerci - (pncosuni * pnnumcdi)
where glp_keydep = oracle.substr(pskeydep,1,6)
and glp_keypue = trim(both pskeypue)
and glp_anio   = pnejercicio
and glp_status = 'A';
else
begin
select max(glp_anio)
into strict pnejerciciog
from usrsiho.hologlpr
where glp_keydep = oracle.substr(pskeydep,1,6)
and glp_keypue = trim(both pskeypue);
exception when no_data_found then pnejerciciog := 0;
end;
update usrsiho.hologlpr
set glp_ejerci = glp_ejerci - (pncosuni * pnnumcdi)
where glp_keydep = oracle.substr(pskeydep,1,6)
and glp_keypue = trim(both pskeypue)
and glp_anio   = pnejerciciog;
end if;
end if;
update usrsiho.holocont
set con_numcdi = 0
where con_keyplz = pnkeyplz;end;
$body$
language plpgsql
;
