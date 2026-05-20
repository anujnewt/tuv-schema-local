create or replace procedure usrsiho."sp_hctcapcoadd"  (pnini numeric,pnfin numeric,pnkeyplz numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
num_fil numeric(10);
begin
-- sumarle el numero de capitulos a holocont
update usrsiho.holocont
set con_numcap = con_numcap + ((pnfin - pnini) + 1),
con_numcdi = con_numcdi + ((pnfin - pnini) + 1)
where con_keyplz = pnkeyplz;
-- inserto en holococa  cada uno de los capitulos
for num_fil in pnini..pnfin loop
insert into usrsiho.holococa(coc_keyplz,coc_keycap,coc_numsec,coc_stspag,coc_keyrph,coc_keygdp)
values (pnkeyplz,num_fil,1,'V',null,null);
end loop;end;
$body$
language plpgsql
;
