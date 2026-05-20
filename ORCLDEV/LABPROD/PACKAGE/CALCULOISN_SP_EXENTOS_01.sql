create or replace procedure labprod.calculoisn_sp_exentos_01 (ws_nom_rep varchar,ws_key_per varchar, wn_anio integer, wn_mes integer, wn_key_nom smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_tope decimal(12,2);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
--exentos para el estado de aguascalientes
--exentos para mayores de 60   s01
insert into labprod.nmwkmovt(mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,
mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,
mov_keyben,mov_comfam)
select hem_keyemp mov_keyemp,
'S01' mov_keycon,
wn_key_nom mov_keynom,
hem_keydep mov_keydep,
null mov_keypue,
0 mov_cantid,
sum(case when con_tipcon = 1 then mov_import else mov_import * -1 end) * 0.5 mov_import,
to_timestamp('31/01/2020','DD/MM/YYYY') mov_fecmov,
ws_key_per mov_keyper,
hem_keypro mov_keypro,
'ISNE' mov_keyfor,
'03' mov_codimp,
'NO' mov_codacu,
0 mov_rowide,
hem_ca1aux mov_ca1aux,
null mov_ca2aux,
0 mov_uniope,
0 mov_keyplz,
0 mov_tipplz,
0 mov_keyben,
0 mov_comfam
from labprod.nmlohemp
inner join labprod.nmwkmovt on hem_keypro = mov_keypro and hem_keyper = mov_keyper and hem_keyemp = mov_keyemp and hem_keydep = mov_keydep and hem_ca1aux = mov_ca1aux
inner join labprod.glcopams iest on iest.pam_keypar = 'IEST' and iest.pam_cvesec = hem_ca1aux
inner join labprod.isnconf conf on con_keyent = iest.pam_folini and conf.con_keycon = mov_keycon and conf.con_tipcon in (1,2) and conf.con_anio = wn_anio
inner join labprod.isnentidades on ent_keyent = iest.pam_folini and ent_anio = wn_anio
left join labprod.nmloconc cpto on cpto.con_keyfor = 'IBAS' and cpto.con_ca1aux = iest.pam_folini
where hem_keypro  in (select ran_keypro from labprod.glwkrang where ran_nomrep = ws_nom_rep)
and hem_keyper = ws_key_per
and hem_diades >= 60
and iest.pam_folini = '01'
group by hem_keyemp,hem_keypro,hem_keydep,hem_ca1aux,cpto.con_keycon,hem_diades,ent_limeda;
--exentos vales de despensa s02
--hasta el 40% del uma elevada al mes  (86.88*30=2606.40*40%=1042.56)son exentos (281+284+334); el excendente grava
wn_tope := wn_uma * 30 * 0.4;
call calculoisn_sp_exentos_vales(ws_nom_rep,ws_key_per, '01',wn_tope, wn_tope);end;
$body$
language plpgsql
;
