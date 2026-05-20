create or replace procedure labprod.calculoisn_sp_cargarisn (ws_nom_rep varchar,ws_key_per varchar, wn_anio integer, wn_mes integer, wn_key_nom smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from labprod.isntotales
where isn_keycia in (select pro_keycia
from labprod.glwkrang
inner join labprod.nmloproc on pro_keypro = ran_keypro
where ran_nomrep = ws_nom_rep)
and isn_anio = wn_anio
and isn_mes = wn_mes;
insert into labprod.isntotales(isn_keycia,isn_keyent,isn_anio,isn_mes,isn_keyper,isn_porcen,isn_poradi,isn_keytab,isn_cuofij,isn_base,isn_totreg,isn_totemp,isn_impisn,isn_impadi)
select pro_keycia isn_keycia,iest.pam_folini isn_keyent,wn_anio isn_anio,wn_mes isn_mes,hem_keyper isn_keyper,
ent_porcen isn_porcen,ent_poradi ist_poradi,ent_keytab isn_keytab,0 isn_cuofij,
sum(mov_import) isn_base,count(*) isn_totreg,count(distinct hem_keyemp) isn_totemp,
0 isn_impisn,0 isn_impadi
from labprod.nmlohemp
inner join labprod.nmloproc on hem_keypro = pro_keypro
inner join labprod.glcopams iest on iest.pam_keypar = 'IEST' and pam_cvesec = hem_ca1aux
inner join labprod.nmwkmovt on hem_keypro = mov_keypro and hem_keyper = mov_keyper and hem_keyemp = mov_keyemp and hem_ca1aux = mov_ca1aux
inner join labprod.nmloconc  on mov_keycon = con_keycon and con_keyfor in ('IBAS')
inner join labprod.isnentidades on ent_keyent = iest.pam_folini and ent_anio = wn_anio
where hem_keypro in (select ran_keypro from labprod.glwkrang where ran_nomrep = ws_nom_rep)
and hem_keyper = ws_key_per
group by pro_keycia,iest.pam_folini,wn_anio,wn_mes,hem_keyper,ent_porcen,ent_poradi,ent_keytab,0,0
order by  isn_keycia,isn_keyent;
update isntotales
set isn_porcen = labprod.calculoisn_porcentaje(isn_keyent, isn_porcen,isn_keytab,isn_base),
isn_poradi = labprod.calculoisn_porcentaje_adicional(isn_keyent, isn_poradi,isn_keytab,isn_base,isn_keycia, wn_anio),
isn_cuofij = labprod.calculoisn_cuotafija(isn_keyent, isn_porcen,isn_keytab,isn_base)
where isn_keycia in (select pro_keycia
from labprod.glwkrang
inner join labprod.nmloproc on pro_keypro = ran_keypro
where ran_nomrep = ws_nom_rep)
and isn_anio = wn_anio
and isn_mes = wn_mes;
update isntotales
set isn_impisn = labprod.calculoisn_importeisn(isn_keyent,isn_base, isn_porcen, isn_poradi, isn_keytab,isn_cuofij, isn_totreg)
where isn_keycia in (select pro_keycia
from labprod.glwkrang
inner join labprod.nmloproc on pro_keypro = ran_keypro
where ran_nomrep = ws_nom_rep)
and isn_anio = wn_anio
and isn_mes = wn_mes;
update isntotales
set isn_impadi = labprod.calculoisn_importeadi(isn_keyent,isn_base, isn_porcen, isn_poradi, isn_keytab, isn_impisn)
where isn_keycia in (select pro_keycia
from labprod.glwkrang
inner join labprod.nmloproc on pro_keypro = ran_keypro
where ran_nomrep = ws_nom_rep)
and isn_anio = wn_anio
and isn_mes = wn_mes;
/* commit; */
end;
$body$
language plpgsql
;
