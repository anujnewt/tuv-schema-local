create or replace procedure labconf.calculoisn_sp_historicoemp (ws_nom_rep varchar, ws_key_per varchar, wn_anio integer, wn_mes integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wd_fec_fin timestamp(0);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
select per_fecfin into strict wd_fec_fin
from labconf.nmloperi
where per_keypro in (select ran_keypro from labconf.glwkrang where ran_nomrep = ws_nom_rep)
and per_keyper = ws_key_per  limit 1;
delete from labconf.nmlohemp
where hem_keypro in (select ran_keypro from labconf.glwkrang where ran_nomrep = ws_nom_rep)
and hem_keyper = ws_key_per;
insert into labconf.nmlohemp(hem_keypro,hem_keyper,hem_keyemp,hem_keydep,hem_ca1aux,hem_diades,hem_keypue,hem_keycen,hem_tipemp,hem_keyloc,hem_keyims,hem_fecaum,hem_salmes)
select distinct hem_keypro, ws_key_per,hem_keyemp,hem_keydep,hem_ca1aux,labconf.edadxfecha(hem_regrfc,wd_fec_fin),emp_keypue,emp_keycen,emp_tipemp,emp_keyloc,emp_keyims,emp_fecaum,emp_salmes
from labconf.nmlohemp
inner join labconf.nmloperi on hem_keypro = per_keypro and hem_keyper = per_keyper
inner join labconf.nmlohism on his_keypro = hem_keypro and his_keyper = hem_keyper and his_keyemp = hem_keyemp and his_keycon in ('311','268','C25','658','627','281','334')
left join labconf.nmcoempl on hem_keyemp = emp_keyemp
where per_keypro in (select ran_keypro from labconf.glwkrang where ran_nomrep = ws_nom_rep)
and per_anioa1 = wn_anio
and per_nummes = wn_mes
and per_keynom in (1,3,6,14,15,16,20,23,25,26,30,32,38,62,31);
/* commit; */
end;
$body$
language plpgsql
;
