create or replace procedure usrsiho."sp_holotrarphretro"  (pi_hojatrab numeric, pd_fechapag timestamp(0), pd_fechaact timestamp(0), pi_keyusu numeric, pd_comidagm numeric, pd_cenagm numeric, pd_desayunogm numeric, pd_pasajesgm numeric, pd_viaticoslocgm numeric,li_secrph inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--declaraci??e variables
ld_ptjeretro decimal(9,6);
li_totcos decimal(15,2);
li_totemp numeric(15);
li_rphorigen numeric(10);
li_hojatraborig numeric(10);
w_keydep usrsiho.holofrph.frp_keydep%type;
w_keynom usrsiho.holofrph.frp_keynom%type;
w_repeti usrsiho.holofrph.frp_repeti%type;
w_tiptra usrsiho.holofrph.frp_tiptra%type;
w_fecitr usrsiho.holofrph.frp_fecitr%type;
w_fectrab usrsiho.holofrph.frp_fectrab%type;
w_forpag usrsiho.holofrph.frp_forpag%type;
w_tipcam usrsiho.holofrph.frp_tipcam%type;
w_pertra usrsiho.holofrph.frp_pertra%type;
w_tipfol usrsiho.holofrph.frp_tipfol%type;
w_totemp usrsiho.holofrph.frp_totemp%type;
w_keypro usrsiho.holofrph.frp_keypro%type;
w_unifor usrsiho.holofrph.frp_unifor%type;
w_transp usrsiho.holofrph.frp_transp%type;
w_ident usrsiho.holofrph.frp_ident%type;
w_keyare usrsiho.holofrph.frp_keyare%type;
w_desrep usrsiho.holofrph.frp_desrep%type;
w_descap usrsiho.holofrph.frp_descap%type;
begin
--inicializacion de variables
li_secrph := 0;
ld_ptjeretro := 0;
li_totcos := 0.0;
li_totemp := 0;
li_rphorigen := 0;
li_hojatraborig := 0;
--obtenemos el porcentaje del retroactivo
begin
select pam_folini
into strict ld_ptjeretro
from usrsiho.glcopams
where pam_keypar in (select pam_folini
from usrsiho.glcopams
where pam_keypar='00'
and pam_cvesec='loretr')
and pam_nompar like '%PORCENTAJE%';
exception when no_data_found then ld_ptjeretro := 0;
end;
--obtenemos la hoja origen para obtener el rph
begin
select (oracle.substr(enc_descap,23,8))::numeric
into strict li_hojatraborig
from usrsiho.holoenctra
where enc_num_id = pi_hojatrab;
exception when no_data_found then li_hojatraborig := 0;
end;
--obtenemos el numero del rph origen
begin
select distinct det_keyrph
into strict li_rphorigen
from usrsiho.holoenctra, usrsiho.holodettra, usrsiho.holofrph
where enc_num_id = det_num_id
and det_keyrph = frp_keyrph
and nullif(det_keyrph::text, '') is not null
and enc_num_id = li_hojatraborig;
exception when no_data_found then li_rphorigen := 0;
end;
select frp_keydep,frp_keynom,
frp_repeti,frp_tiptra,frp_fecitr,frp_fectrab,frp_forpag,frp_tipcam,
frp_pertra,frp_tipfol,frp_totemp,frp_keypro,frp_unifor,frp_transp,coalesce(frp_ident,''),
frp_keyare,coalesce(frp_desrep,''),coalesce(frp_descap,'')
into strict w_keydep,w_keynom,
w_repeti,w_tiptra,w_fecitr,w_fectrab,w_forpag,w_tipcam,
w_pertra,w_tipfol,w_totemp,w_keypro,w_unifor,w_transp,w_ident,
w_keyare,w_desrep,w_descap
from usrsiho.holofrph
where frp_keyrph = li_rphorigen;
insert into usrsiho.holofrph(frp_keydep,frp_keyper,frp_fecact,frp_stsfol,frp_totcos,frp_keyusu,frp_keynom,
frp_repeti,frp_tiptra,frp_fecsol,frp_fecitr,frp_fectrab,frp_forpag,frp_tipcam,
frp_pertra,frp_tipfol,frp_totemp,frp_keypro,frp_unifor,frp_transp,frp_ident,
frp_keyare,frp_desrep,frp_descap)
values (w_keydep,'0',pd_fechaact,'0',0,pi_keyusu,w_keynom,
w_repeti,w_tiptra,pd_fechapag,w_fecitr,w_fectrab,w_forpag,w_tipcam,
w_pertra,w_tipfol,w_totemp,w_keypro,w_unifor,w_transp,w_ident,
w_keyare,w_desrep,w_descap)
returning frp_keyrph into li_secrph;
--insertamos el detalle del rph a partir del rph origen calculando el porcentaje del retroactivo en una tabla temporal
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,
gdp_capini,gdp_capfin,gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,
gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,gdp_minleg,gdp_minsal,gdp_minext,
gdp_mincom)
select hgd_keydep,li_secrph,pd_fechaact,hgd_keyemp,coalesce(hgd_regrfc,''),coalesce(hgd_recurp,''),hgd_keypue,
hgd_capini,hgd_capfin,hgd_numcap,hgd_keycon,hgd_marcon,hgd_marcos,round(case when holohgdp.hgd_keypue = 1053 then round((pd_pasajesgm)::numeric,0)
when holohgdp.hgd_keypue = 1055 then round((pd_viaticoslocgm)::numeric,0)
when holohgdp.hgd_keypue = 1056 then round((pd_desayunogm)::numeric,0)
when holohgdp.hgd_keypue = 1060 then round((pd_comidagm)::numeric,0)
when holohgdp.hgd_keypue = 1060 then round((pd_cenagm)::numeric,0)
when holohgdp.hgd_keypue = 1095 then round((pd_comidagm)::numeric,0)
when holohgdp.hgd_keypue = 1096 then round((pd_cenagm)::numeric,0)
when holohgdp.hgd_keycon = 'HE4' then round((hgd_costog::numeric * (4.5/100)),2)
when holohgdp.hgd_keycon = 'HIT' then round((hgd_costog::numeric * (4.5/100)),2)
else
round(hgd_costog::numeric * (ld_ptjeretro/100),0)
end,2),
coalesce(hgd_keysue,''),coalesce(hgd_keytco,0),coalesce(hgd_keyfol,0),pi_keyusu,coalesce(hgd_minleg,0),coalesce(hgd_minsal,0),coalesce(hgd_minext,0),
coalesce(hgd_mincom,0)
from usrsiho.holohgdp
where hgd_keyrph = li_rphorigen
and (hgd_keycon not in ('HE4','HIT') or hgd_keypue not in (select pue_ca1aux from usrsiho.nmcopues where nullif(pue_ca1aux::text, '') is not null));
--calcula el importe extra retroactivo
insert into usrsiho.hex_hologdpr
select gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,pue_ca1aux gdp_keypue,
max(gdp_capini) gdp_capini,max(gdp_capfin) gdp_capfin,sum(gdp_numcap) gdp_numcap,gdp_keycon,'X' gdp_marcon,'X' gdp_marcos,
0 gdp_cosuni,
gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom,frp_fecitr,gdp_cosuni hex_salario
from usrsiho.hologdpr,usrsiho.holofrph,usrsiho.nmcopues
where gdp_keyrph=frp_keyrph
and gdp_keypue=pue_keypue
and gdp_keyrph= li_secrph
and (gdp_minleg>0 or gdp_minsal>0)
and gdp_keycon in ('HA4','HTI')
and gdp_keyemp in (select ret.hgd_keyemp from usrsiho.holohgdp ret where ret.hgd_keyrph= li_rphorigen
and ret.hgd_keycon in ('HE4','HIT')
and ret.hgd_keypue in (select pue_ca1aux from usrsiho.nmcopues))
and nullif(pue_ca1aux::text, '') is not null
group by gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,pue_ca1aux,gdp_keycon,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom,frp_fecitr,gdp_cosuni
;
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,
gdp_capini,gdp_capfin,gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,
gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
select gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,
gdp_capfin,gdp_capfin,1,
case when gdp_keycon = 'HA4' then 'HE4'
when gdp_keycon = 'HTI' then 'HIT'
end,
gdp_marcon,gdp_marcos,
sp_calimptiext(gdp_minleg,gdp_minsal,gdp_mincom,1,gdp_numcap,gdp_keydep,gdp_keyfol,gdp_keypue,hex_salario,gdp_keytco,gdp_keyemp,frp_fecitr,1,pi_hojatrab) gdp_cosuni,
gdp_keysue,0,0,gdp_keyusu,gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom
from usrsiho.hex_hologdpr;
--**************
--sp_calimptiext(gdp_minleg,gdp_minsal,gdp_mincom,1,gdp_numcap,gdp_keydep,gdp_keyfol,gdp_keypue,gdp_keytco,gdp_keyemp,frp_fecitr,1,pi_hojatrab) gdp_cosuni,
--elimina los registros que tengan monto cero
delete
from usrsiho.hologdpr
where gdp_keyrph = li_secrph
and gdp_cosuni = 0;
--consulta para obtener los campos frp_totcos y frp_totemp del encabezado del rph
select sum(coalesce(gdp_numcap,0)*coalesce(gdp_cosuni,0)),sum(coalesce(gdp_keyemp,0))
into strict li_totcos,li_totemp
from usrsiho.hologdpr
where gdp_keyrph = li_secrph;
--actualiza el importe total y el total de empleados del nuevo rph
update usrsiho.holofrph
set frp_totcos = coalesce(li_totcos,0),
frp_totemp = coalesce(li_totemp,0)
where frp_keyrph = li_secrph;
--actualiza la hoja de trabajo del retroactivo con el n??o del rph generado.
update usrsiho.holodettra
set det_keyrph = li_secrph
where det_num_id = pi_hojatrab;
--actualiza el estatus de la hoja de trabajo.
update usrsiho.holoenctra
set enc_stsrep = 3
where enc_num_id = pi_hojatrab;
/* commit; */
end;
$body$
language plpgsql
;
