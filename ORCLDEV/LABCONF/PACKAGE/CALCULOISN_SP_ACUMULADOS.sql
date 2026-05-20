create or replace procedure labconf.calculoisn_sp_acumulados (ws_nom_rep varchar,ws_key_per varchar, wn_anio integer, wn_mes integer, wn_key_nom smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wd_fec_mov timestamp(0);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
wd_fec_mov := calculoisn_fecha_mov(ws_nom_rep, ws_key_per);
insert into labconf.nmwkmovt(mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,
mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,
mov_keyben,mov_comfam)
select hem_keyemp,  --mov_keyemp
his_keycon,  --mov_keycon
wn_key_nom,   --mov_keynom
hem_keydep,  --mov_keydep
null, --mov_keypue
0, --mov_cantid
sum(his_import),  --mov_import
wd_fec_mov,   --mov_fecmov
ws_key_per,   --mov_keyper
hem_keypro,   --mov_keypro
'ACU',  --mov_keyfor
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
from labconf.nmloperi
inner join labconf.nmlohemp on hem_keypro = per_keypro and hem_keyper = per_keyper
inner join labconf.nmlohism on hem_keyemp = his_keyemp and per_keypro = his_keypro and per_keyper = his_keyper
where per_anioa1 = to_char(wn_anio)
and per_nummes = wn_mes
and per_keypro in (select ran_keypro from labconf.glwkrang where ran_nomrep = ws_nom_rep)
and per_keynom in (1,3,6,14,15,16,20,23,25,26,30,32,38,62,31)
and his_keycon in (select distinct con_keycon from labconf.isnconf where con_anio = wn_anio)
and his_codacu <> 'NO'
group by hem_keyemp,  --mov_keyemp
his_keycon,  --mov_keycon
hem_keydep,  --mov_keydep
hem_keypro,   --mov_keypro
hem_ca1aux; --mov_ca2aux
/* commit; */
end;
$body$
language plpgsql
;
