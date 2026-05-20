create or replace procedure labprod.calculoisn_sp_prorrateo (ws_nom_rep varchar,ws_key_per varchar, wn_anio integer, wn_mes integer, wn_key_nom smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
insert into labprod.nmwkmovt(mov_keyemp,mov_keycon,mov_keynom,mov_keydep,mov_keypue,mov_cantid,mov_import,mov_fecmov,mov_keyper,mov_keypro,mov_keyfor,mov_codimp,mov_codacu,mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,mov_keyben,mov_comfam)
select mov_keyemp,con_isn.con_keycon mov_keycon,mov_keynom,mov_keydep,mov_keypue,0 mov_cantid,
round((mov_import * isn_impisn / isn_base)::numeric,2)  mov_import,mov_fecmov,mov_keyper,mov_keypro,'ISN',mov_codimp,'ME',mov_rowide,mov_ca1aux,mov_ca2aux,mov_uniope,mov_keyplz,mov_tipplz,mov_keyben,mov_comfam
from labprod.nmwkmovt
inner join labprod.nmloconc con_bas on mov_keycon = con_bas.con_keycon and con_bas.con_keyfor = 'IBAS'
inner join labprod.nmloconc con_isn on con_isn.con_keyfor = 'ISN' and con_isn.con_ca1aux = con_bas.con_ca1aux
inner join labprod.nmloproc on mov_keypro = pro_keypro
inner join labprod.isntotales on isn_keycia = pro_keycia and isn_keyent = con_bas.con_ca1aux and isn_keyper = mov_keyper
where mov_keypro in (select ran_keypro from labprod.glwkrang where ran_nomrep = ws_nom_rep)
and mov_keyper = ws_key_per
and isn_base > 0;
/* commit; */
end;
$body$
language plpgsql
;
