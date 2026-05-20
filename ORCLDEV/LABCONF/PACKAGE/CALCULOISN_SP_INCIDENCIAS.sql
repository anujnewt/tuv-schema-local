create or replace procedure labconf.calculoisn_sp_incidencias (ws_nom_rep varchar,ws_key_per varchar, wn_anio integer, wn_mes integer, wn_key_nom smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wd_fec_mov timestamp(0);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
insert into labconf.nmwkmovt(mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,
mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,
mov_keyben,mov_comfam)
select hem_keyemp,  --mov_keyemp
inc_keycon,  --mov_keycon
wn_key_nom,   --mov_keynom
min(hem_keydep) keep(dense_rank first  order by  hem_ca1aux),  --mov_keydep
null, --mov_keypue
0, --mov_cantid
inc_import,  --mov_import
wd_fec_mov,   --mov_fecmov
hem_keyper,   --mov_keyper
hem_keypro,   --mov_keypro
'INC',  --mov_keyfor
'03',   --mov_codimp
'NO',   --mov_codacu
inc_keyinc,      --mov_rowide
min(hem_ca1aux),   --mov_ca1aux
null, --mov_ca2aux
0,  --mov_uniope
0,  --mov_keyplz
0,  --mov_tipplz
0,  --mov_keyben
0   --mov_comfam
from labconf.nmlohemp
inner join labconf.nmcoinci on hem_keyemp = inc_keyemp and hem_keypro = inc_keypro and hem_keyper = inc_keyper and inc_keycon = 'S07'
where hem_keypro in (select ran_keypro from labconf.glwkrang where ran_nomrep = ws_nom_rep)
and hem_keyper = ws_key_per
and hem_ca1aux in (select pam_cvesec from labconf.glcopams where pam_keypar = 'IEST' and pam_folini in ('15','03'))
group by hem_keyemp,inc_keycon,inc_import,hem_keyper,hem_keypro,inc_keyinc;
/* commit; */
end;
$body$
language plpgsql
;
