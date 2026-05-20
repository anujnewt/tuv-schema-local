create or replace procedure usrsiho."sp_hctcambiacto2"  (pn_a numeric, pnkeytva numeric, pnheader numeric, pnkeyplz numeric,pskeydep varchar, pskeypue varchar,pnejercicio numeric,pncosuni numeric, pnnumcdi numeric,pncosuniant numeric,pnctvplz numeric, pnmonto numeric ,pnfolasig numeric, lssigue inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_totcap  holocont.con_numcap %type;
ws_totdisp holocont.con_numcdi %type;
ws_numcap  holocont.con_numcap %type;
ws_ctvplz   numeric(10);
ws_status  varchar(1);
wndife     decimal(10,2);
ws_mto  decimal(13,2);
wnmtoejer  decimal(10,2);
lnpresu    hologlpr.glp_presup %type;
lnejeci    hologlpr.glp_ejerci %type;
lnanioo    numeric(5);
paso       varchar(60);
emple   numeric(10);
begin
if pnheader = 1 then		--lee los capitulos vigentes y los cancela
lssigue := 'N';
if pnkeytva = 1 then
update holococa set coc_stspag = 'C'
where coc_stspag = 'V'
and nullif(coc_keyrph::text, '') is null
and coc_keyplz = pnkeyplz;
end if;
insert into glwkcrys(cry_nomrep,cry_numsec,cry_chr001 ) values ('cla',1,pnkeyplz);
select count(*)
into strict ws_numcap
from holococa
where coc_keyplz = pnkeyplz
and coc_stspag='C';
begin
select con_ctvplz
into strict ws_ctvplz
from holocont
where con_keyplz = pnkeyplz;
exception when no_data_found then ws_ctvplz := 0;
end;
update holocont
set con_stspag='C', con_numcdi = con_numcap - ws_numcap
where con_keyplz = pnkeyplz;
insert into glwkcrys(cry_nomrep,cry_numsec,cry_chr001 ) values ('cla',2,ws_numcap);
insert into glwkcrys(cry_nomrep,cry_numsec,cry_chr001 ) values ('cla',3,pnfolasig);
update holoplza
set plz_status = 0
where plz_ctvplz = ws_ctvplz and plz_asig = pnfolasig;
begin
select glp_status
into strict ws_status
from hologlpr
where glp_keydep = trim(both oracle.substr(pskeydep,1,6))
and glp_keypue = trim(both pskeypue)
and glp_anio   = pnejercicio;
exception when no_data_found then ws_status:= null;
end;
if ws_status = 'A' then
update hologlpr set glp_ejerci = glp_ejerci - (pncosuni * pnnumcdi)
where glp_keydep = trim(both oracle.substr(pskeydep,1,6))
and glp_keypue = trim(both pskeypue)
and glp_anio   = pnejercicio
and glp_status = 'A';
lssigue := 'S';
end if;
--update holoplza
--set plz_mtoeje = plz_mtoeje - (pncosuni * pnnumcdi)
--where plz_ctvplz=ws_ctvplz;
else
if pnheader = 2 then --lee los capitulos cancelados y los deja vigentes
if pnkeytva = 1 then
update holococa
set coc_stspag = 'V'
where coc_stspag = 'C'
and nullif(coc_keyrph::text, '') is null
and coc_keyplz = pnkeyplz;
ws_totcap := 0;
select count(coc_keycap)
into strict ws_totcap
from holococa
where coc_stspag = 'V'
and nullif(coc_keyrph::text, '') is null
and coc_keyplz = pnkeyplz;
update holocont
set con_numcdi = ws_totcap,con_stspag='V'
where con_keyplz = pnkeyplz;
else
ws_totcap := 0;
begin
select con_numcap
into strict ws_numcap
from holocont
where con_keyplz = pnkeyplz;
exception when no_data_found then ws_numcap := 0;
end;
ws_totdisp := ws_numcap - pn_a;
update holocont
set con_stspag='V', con_numcdi = ws_totdisp
where con_keyplz = pnkeyplz;
end if;
select glp_status
into strict ws_status
from hologlpr
where glp_keydep = trim(both oracle.substr(pskeydep,1,6))
and glp_keypue = trim(both pskeypue)
and glp_anio   = pnejercicio;
if ws_status = 'A' then
update hologlpr set glp_ejerci = glp_ejerci + (pncosuni * pnnumcdi)
where glp_keydep = trim(both oracle.substr(pskeydep,1,6))
and glp_keypue = trim(both pskeypue)
and glp_anio   = pnejercicio
and glp_status = 'A';
end if;
else
if pnheader = 3 then -----------cambia costo unitario
if pnmonto < pncosuni then
lssigue := 'N';
else
lssigue := 'S';
end if;
--insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('cla',5,lssigue);
if lssigue = 'S' then
wndife := pncosuni - pncosuniant;
wnmtoejer := pnnumcdi*wndife;
begin
select glp_presup,glp_ejerci,glp_anio
into strict lnpresu, lnejeci, lnanioo
from hologlpr
where glp_keydep = oracle.substr(pskeydep,1,6)
and glp_keypue = pskeypue
and glp_anio   = pnejercicio;
exception when no_data_found then lnpresu := 0;
lnejeci := 0;
lnanioo := 0;
end;
end if;
if lssigue = 'S' then
if (lnpresu - lnejeci) < wnmtoejer then
lssigue := 'N';
else
lssigue := 'S';
end if;
end if;
if lssigue = 'S' then
update holocont
set con_cosuni=pncosuni
where con_keyplz = pnkeyplz;
begin
select glp_status
into strict ws_status
from hologlpr
where glp_keydep = trim(both oracle.substr(pskeydep,1,6))
and glp_keypue = trim(both pskeypue)
and glp_anio   = pnejercicio;
exception when no_data_found then ws_status:= null;
end;
if ws_status = 'A' then
update hologlpr set glp_ejerci = glp_ejerci + wnmtoejer
where glp_keydep = trim(both oracle.substr(pskeydep,1,6))
and glp_keypue = trim(both pskeypue)
and glp_anio   = pnejercicio
and glp_status = 'A';
end if;
end if;
else
if pnheader = 4 then
if pnmonto < pncosuni then
lssigue := 'N';
else
lssigue := 'S';
end if;
end if;
if lssigue = 'S' then
wndife :=  pncosuniant - pncosuni;
wnmtoejer := pnnumcdi*wndife;
select glp_presup,glp_ejerci,glp_anio
into strict lnpresu,lnejeci,lnanioo
from hologlpr
where glp_keydep = oracle.substr(pskeydep,1,6)
and glp_keypue = pskeypue
and glp_anio   = pnejercicio;
end if;
if lssigue = 'S' then
lnejeci := lnejeci - wnmtoejer;
if (lnpresu - lnejeci) < wnmtoejer then
lssigue := 'N';
else
lssigue := 'S';
end if;
end if;
if lssigue = 'S' then
update holocont
set con_cosuni=pncosuni
where con_keyplz = pnkeyplz;
begin
select glp_status
into strict ws_status
from hologlpr
where glp_keydep = trim(both oracle.substr(pskeydep,1,6))
and glp_keypue = trim(both pskeypue)
and glp_anio   = pnejercicio;
exception when no_data_found then ws_status:= null;
end;
if ws_status = 'A' then
update hologlpr set glp_ejerci = glp_ejerci - wnmtoejer
where glp_keydep = trim(both oracle.substr(pskeydep,1,6))
and glp_keypue = trim(both pskeypue)
and glp_anio   = pnejercicio
and glp_status = 'A';
end if;
end if;
end if;
end if;
end if;
--return lssigue;
end;
$body$
language plpgsql
;
