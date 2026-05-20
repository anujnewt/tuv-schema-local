create or replace procedure labprod.calculoisn_sp_bases (ws_nom_rep varchar,ws_key_per varchar, wn_anio integer, wn_mes integer, wn_key_nom smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from labprod.nmwkmovt
where mov_keypro in (select ran_keypro from labprod.glwkrang where ran_nomrep = ws_nom_rep)
and mov_keyper = ws_key_per
and mov_keyfor = 'IBAS';
insert into labprod.nmwkmovt(mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,
mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,
mov_keyben,mov_comfam)
select hem_keyemp mov_keyemp,
case when hem_diades < ent_limeda then cpto.con_keycon else 'S01' end mov_keycon,
wn_key_nom mov_keynom,
hem_keydep mov_keydep,
null mov_keypue,
0 mov_cantid,
sum(case when con_tipcon = 1 then mov_import else mov_import * -1 end) mov_import,
per_fecpag mov_fecmov,
ws_key_per mov_keyper,
hem_keypro mov_keypro,
'IBAS' mov_keyfor,
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
inner join labprod.nmloperi on per_keypro = hem_keypro and per_keyper = hem_keyper
inner join labprod.nmwkmovt on hem_keypro = mov_keypro and hem_keyper = mov_keyper and hem_keyemp = mov_keyemp and hem_keydep = mov_keydep and hem_ca1aux = mov_ca1aux
inner join labprod.glcopams iest on iest.pam_keypar = 'IEST' and iest.pam_cvesec = hem_ca1aux
inner join labprod.isnconf conf on con_keyent = iest.pam_folini and conf.con_keycon = mov_keycon and conf.con_tipcon in (1,2) and conf.con_anio = wn_anio
inner join labprod.isnentidades on ent_keyent = iest.pam_folini and ent_anio = wn_anio
left join labprod.nmloconc cpto on cpto.con_keyfor = 'IBAS' and cpto.con_ca1aux = iest.pam_folini
where hem_keypro  in (select ran_keypro from labprod.glwkrang where ran_nomrep = ws_nom_rep)
and hem_keyper = ws_key_per
group by hem_keyemp,hem_keypro,per_fecpag,hem_keydep,hem_ca1aux,cpto.con_keycon,hem_diades,ent_limeda;
/* commit; */
end;
$body$
language plpgsql
;
