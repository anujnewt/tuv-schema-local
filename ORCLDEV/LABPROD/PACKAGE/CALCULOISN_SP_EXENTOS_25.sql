create or replace procedure labprod.calculoisn_sp_exentos_25 (ws_nom_rep varchar,ws_key_per varchar, wn_anio integer, wn_mes integer, wn_key_nom smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_tope decimal(12,2);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
--exentos para el estado de sinaloa
--exentos aguinaldo s04
--30 umas (86.88*30=2,606.4)
--025 aguinaldo
--603 proprocion de aguinaldo finiq
--645 adeudo aguinaldo
wn_tope := wn_uma * 30;
insert into labprod.nmwkmovt(mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,
mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,
mov_keyben,mov_comfam)
select hem_keyemp,  --mov_keyemp
'S04',  --mov_keycon
per_keynom,   --mov_keynom
hem_keydep,  --mov_keydep
null, --mov_keypue
0, --mov_cantid
case when wn_tope > sum(mov_import) then sum(mov_import) else wn_tope end,  --mov_import
per_fecfin,   --mov_fecmov
hem_keyper,   --mov_keyper
hem_keypro,   --mov_keypro
'ISNE',  --mov_keyfor
'03',   --mov_codimp
'NO',   --mov_codacu
0,      --mov_rowide
hem_ca1aux,   --mov_ca1aux
null, --mov_ca2aux
0,  --mov_uniope
0,  --mov_keyplz
0,  --mov_tipplz
0,  --mov_keyben
0   --mov_comfam
from labprod.nmlohemp
inner join labprod.nmloperi on hem_keypro = per_keypro and hem_keyper = per_keyper
inner join labprod.nmwkmovt on hem_keypro = mov_keypro and hem_keyper = mov_keyper and hem_keyemp = mov_keyemp
and mov_keycon in ('025','603','645')
inner join labprod.glcopams iest on pam_keypar = 'IEST' and pam_cvesec = hem_ca1aux and pam_folini = '25'
where hem_keypro in (select ran_keypro from labprod.glwkrang where ran_nomrep = ws_nom_rep)
and hem_keyper = ws_key_per
group by hem_keyemp,'S04',per_keynom,hem_keydep,null,0,wn_tope,per_fecfin,hem_keyper,hem_keypro,'ISNE','03','NO',
0,hem_ca1aux;end;
$body$
language plpgsql
;
