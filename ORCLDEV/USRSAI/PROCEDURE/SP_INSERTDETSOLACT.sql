create or replace procedure usrsai."sp_insertdetsolact"  ( numsol numeric, keyemp numeric, nomart varchar, person varchar, keypue varchar, keynac varchar, numcap varchar, coment varchar, stsreg numeric, tipodis varchar, revdis varchar, sindicato varchar, sigid inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
sigid := 0;
select coalesce(max(dsa_idereg), 0) + 1 into strict sigid from detsolact
where dsa_numsol = numsol;
insert into detsolact(  dsa_numsol, dsa_idereg, dsa_keyemp, dsa_nomart,     dsa_person,     dsa_keypue, dsa_keynac,
dsa_numcap, dsa_coment, dsa_stsreg, dsa_tipodis,    dsa_revdis,     dsa_sindicato)
values (  numsol,     sigid,      keyemp,     nomart,         person,         keypue,     keynac,
numcap,     coment,     stsreg,     tipodis,        revdis,         sindicato);end;
$body$
language plpgsql
;
