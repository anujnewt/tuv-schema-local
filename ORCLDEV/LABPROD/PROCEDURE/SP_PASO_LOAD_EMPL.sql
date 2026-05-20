create or replace procedure labprod."sp_paso_load_empl"  (keyemp integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
vs_activo   varchar(1);
vs_pering   varchar(7);
vn_keyemp   integer;
vn_existr   integer;
vg_keyemp   integer;
vg_keydep   varchar(16);
vg_keypue   varchar(16);
vg_keycen   varchar(16);
vg_keycat   varchar(16);
vg_nomemp   varchar(60);
vg_nomcor   varchar(20);
vg_domemp   varchar(60);
vg_colemp   varchar(40);
vg_cidemp   varchar(20);
vg_pobemp   varchar(20);
vg_munemp   varchar(6);
vg_entemp   varchar(2);
vg_codemp   varchar(5);
vg_telemp   varchar(60);
vg_regrfc   varchar(13);
vg_recurp   varchar(18);
vg_regims   varchar(12);
vg_reginf   varchar(12);
vg_cvesex   varchar(1);
vg_keyims   varchar(5);
vg_cvezon   smallint;
vg_keypro   smallint;
vg_cvetur   smallint;
vg_tipemp   varchar(6);
vg_tipsal   varchar(1);
vg_status   smallint;
vg_salhor   decimal(12,6);
vg_saldia   decimal(12,6);
vg_salmes   decimal(12,2);
vg_salint   decimal(12,6);
vg_salivc   decimal(12,6);
vg_salinf   decimal(12,6);
vg_intsin   decimal(12,6);
vg_infsin   decimal(12,6);
vg_varims   decimal(12,6);
vg_varinf   decimal(12,6);
vg_anthor   decimal(12,6);
vg_antdia   decimal(12,6);
vg_antmes   decimal(12,2);
vg_antint   decimal(12,6);
vg_antivc   decimal(12,6);
vg_antinf   decimal(12,6);
vg_antits   decimal(12,6);
vg_antifs   decimal(12,6);
vg_refcon   varchar(20);
vg_cveban   varchar(7);
vg_ctaban   varchar(18);
vg_forpag   varchar(2);
vg_diades   smallint;
vg_numliq   varchar(6);
vg_keyloc   varchar(16);
vg_fecing   timestamp(0);
vg_fecrei   timestamp(0);
vg_fecven   timestamp(0);
vg_fecpla   timestamp(0);
vg_fecaum   timestamp(0);
vg_peraum   varchar(7);
vg_fecbaj   timestamp(0);
vg_cvebaj   varchar(4);
vg_jorlab   varchar(1);
vg_unijor   decimal(4,2);
vg_pering   varchar(7);
vg_perbaj   varchar(7);
vg_perdep   varchar(7);
vg_perpue   varchar(7);
vg_percat   varchar(7);
vg_perpro   varchar(7);
vg_fecaux   timestamp(0);
vg_ca1aux   varchar(10);
vg_ca2aux   varchar(10);
vg_ca3aux   varchar(10);
vg_ca4aux   varchar(10);
vg_pctbec   decimal(5,2);
vg_fecmod   timestamp(0);
vg_hormod   varchar(8);
vg_fecalt   timestamp(0);
vg_bajfec   timestamp(0);
vg_fecsal   timestamp(0);
vg_perpag   varchar(7);
vg_inifec   timestamp(0);
vg_finfec   timestamp(0);
vg_cobert   varchar(2);
ws_ca4aux        varchar(2);
ws_ca5aux        varchar(2);
ws_cveban       varchar(5);
pa_keyper       varchar(10);
begin
begin
select count(*)
into strict  vn_existr
from nmcoempl
where emp_keyemp  = keyemp;
exception
when no_data_found then
null;
end;
begin
select
trim(both emp_keyemp), trim(both emp_keydep), trim(both emp_keypue), trim(both emp_keycen), trim(both emp_keycat),
trim(both emp_nomemp), trim(both emp_nomcor), trim(both emp_domemp), trim(both emp_colemp), trim(both emp_cidemp),
trim(both emp_pobemp), trim(both emp_munemp), trim(both emp_entemp), trim(both emp_codemp), trim(both emp_telemp),
trim(both emp_regrfc), trim(both emp_recurp), trim(both emp_regims), trim(both emp_reginf), trim(both emp_cvesex),
trim(both emp_keyims), trim(both emp_cvezon), trim(both emp_keypro), trim(both emp_cvetur), trim(both emp_tipemp),
trim(both emp_tipsal), trim(both emp_status), trim(both emp_salhor), trim(both emp_saldia), trim(both emp_salmes),
trim(both emp_salint), trim(both emp_salivc), trim(both emp_salinf), trim(both emp_intsin), trim(both emp_infsin),
trim(both emp_varims), trim(both emp_varinf), trim(both emp_anthor), trim(both emp_antdia), trim(both emp_antmes),
trim(both emp_antint), trim(both emp_antivc), trim(both emp_antinf), trim(both emp_antits), trim(both emp_antifs),
trim(both emp_refcon), trim(both emp_cveban), trim(both emp_ctaban), trim(both emp_forpag), trim(both emp_diades),
trim(both emp_numliq), trim(both emp_keyloc), trim(both emp_fecing), trim(both emp_fecrei), trim(both emp_fecven),
trim(both emp_fecpla), trim(both emp_fecaum), trim(both emp_peraum), trim(both emp_fecbaj), trim(both emp_cvebaj),
trim(both emp_jorlab), trim(both emp_unijor), trim(both emp_pering), trim(both emp_perbaj), trim(both emp_perdep),
trim(both emp_perpue), trim(both emp_percat), trim(both emp_perpro), trim(both emp_fecaux), trim(both emp_ca1aux),
trim(both emp_ca2aux), trim(both emp_ca3aux), trim(both emp_ca4aux), trim(both emp_pctbec), trim(both emp_fecmod),
trim(both emp_hormod), trim(both emp_fecalt), trim(both emp_bajfec), trim(both emp_fecsal), trim(both emp_perpag),
trim(both emp_inifec), trim(both emp_finfec), trim(both emp_cobert)
into strict
vg_keyemp, vg_keydep, vg_keypue, vg_keycen, vg_keycat,
vg_nomemp, vg_nomcor, vg_domemp, vg_colemp, vg_cidemp,
vg_pobemp, vg_munemp, vg_entemp, vg_codemp, vg_telemp,
vg_regrfc, vg_recurp, vg_regims, vg_reginf, vg_cvesex,
vg_keyims, vg_cvezon, vg_keypro, vg_cvetur, vg_tipemp,
vg_tipsal, vg_status, vg_salhor, vg_saldia, vg_salmes,
vg_salint, vg_salivc, vg_salinf, vg_intsin, vg_infsin,
vg_varims, vg_varinf, vg_anthor, vg_antdia, vg_antmes,
vg_antint, vg_antivc, vg_antinf, vg_antits, vg_antifs,
vg_refcon, vg_cveban, vg_ctaban, vg_forpag, vg_diades,
vg_numliq, vg_keyloc, vg_fecing, vg_fecrei, vg_fecven,
vg_fecpla, vg_fecaum, vg_peraum, vg_fecbaj, vg_cvebaj,
vg_jorlab, vg_unijor, vg_pering, vg_perbaj, vg_perdep,
vg_perpue, vg_percat, vg_perpro, vg_fecaux, vg_ca1aux,
vg_ca2aux, vg_ca3aux, vg_ca4aux, vg_pctbec, vg_fecmod,
vg_hormod, vg_fecalt, vg_bajfec, vg_fecsal, vg_perpag,
vg_inifec, vg_finfec, vg_cobert
from emplpaso
where emp_keyemp = keyemp;
exception
when no_data_found then
null;
end;
-- actualiza paso o inserta
if vn_existr = 0  and nullif(vg_keyemp::text, '') is not null then
insert into nmcoempl(emp_keyemp, emp_keydep, emp_keypue, emp_keycen, emp_keycat,
emp_nomemp, emp_nomcor, emp_domemp, emp_colemp, emp_cidemp,
emp_pobemp, emp_munemp, emp_entemp, emp_codemp, emp_telemp,
emp_regrfc, emp_recurp, emp_regims, emp_reginf, emp_cvesex,
emp_keyims, emp_cvezon, emp_keypro, emp_cvetur, emp_tipemp,
emp_tipsal, emp_status, emp_salhor, emp_saldia, emp_salmes,
emp_salint, emp_salivc, emp_salinf, emp_intsin, emp_infsin,
emp_varims, emp_varinf, emp_anthor, emp_antdia, emp_antmes,
emp_antint, emp_antivc, emp_antinf, emp_antits, emp_antifs,
emp_refcon, emp_cveban, emp_ctaban, emp_forpag, emp_diades,
emp_numliq, emp_keyloc, emp_fecing, emp_fecrei, emp_fecven,
emp_fecpla, emp_fecaum, emp_peraum, emp_fecbaj, emp_cvebaj,
emp_jorlab, emp_unijor, emp_pering, emp_perbaj, emp_perdep,
emp_perpue, emp_percat, emp_perpro, emp_fecaux, emp_ca1aux,
emp_ca2aux, emp_ca3aux, emp_ca4aux, emp_pctbec, emp_fecmod,
emp_hormod, emp_fecalt, emp_bajfec, emp_fecsal, emp_perpag,
emp_inifec, emp_finfec, emp_cobert)
values (
vg_keyemp, vg_keydep, vg_keypue, vg_keycen, vg_keycat,
vg_nomemp, vg_nomcor, vg_domemp, vg_colemp, vg_cidemp,
vg_pobemp, vg_munemp, vg_entemp, vg_codemp, vg_telemp,
vg_regrfc, vg_recurp, vg_regims, vg_reginf, vg_cvesex,
vg_keyims, vg_cvezon, vg_keypro, vg_cvetur, vg_tipemp,
vg_tipsal, vg_status, vg_salhor, vg_saldia, vg_salmes,
vg_salint, vg_salivc, vg_salinf, vg_intsin, vg_infsin,
vg_varims, vg_varinf, vg_anthor, vg_antdia, vg_antmes,
vg_antint, vg_antivc, vg_antinf, vg_antits, vg_antifs,
vg_refcon, vg_cveban, vg_ctaban, vg_forpag, vg_diades,
vg_numliq, vg_keyloc, vg_fecing, vg_fecrei, vg_fecven,
vg_fecpla, vg_fecaum, vg_peraum, vg_fecbaj, vg_cvebaj,
vg_jorlab, vg_unijor, vg_pering, vg_perbaj, vg_perdep,
vg_perpue, vg_percat, vg_perpro, vg_fecaux, vg_ca1aux,
vg_ca2aux, vg_ca3aux, vg_ca4aux, vg_pctbec, vg_fecmod,
vg_hormod, vg_fecalt, vg_bajfec, vg_fecsal, vg_perpag,
vg_inifec, vg_finfec, vg_cobert);
else
update nmcoempl set
emp_keydep  =  vg_keydep  ,
emp_keypue  =  vg_keypue  , emp_keycen  =  vg_keycen  ,
emp_keycat  =  vg_keycat  , emp_nomemp  =  vg_nomemp  ,
emp_nomcor  =  vg_nomcor  , emp_domemp  =  vg_domemp  ,
emp_colemp  =  vg_colemp  , emp_cidemp  =  vg_cidemp  ,
emp_pobemp  =  vg_pobemp  , emp_munemp  =  vg_munemp  ,
emp_entemp  =  vg_entemp  , emp_codemp  =  vg_codemp  ,
emp_telemp  =  vg_telemp  , emp_regrfc  =  vg_regrfc  ,
emp_recurp  =  vg_recurp  , emp_regims  =  vg_regims  ,
emp_reginf  =  vg_reginf  , emp_cvesex  =  vg_cvesex  ,
emp_keyims  =  vg_keyims  , emp_cvezon  =  vg_cvezon  ,
emp_keypro  =  vg_keypro  , emp_cvetur  =  vg_cvetur  ,
emp_tipemp  =  vg_tipemp  , emp_tipsal  =  vg_tipsal  ,
emp_status  =  vg_status  , emp_salhor  =  vg_salhor  ,
emp_saldia  =  vg_saldia  , emp_salmes  =  vg_salmes  ,
emp_salint  =  vg_salint  , emp_salivc  =  vg_salivc  ,
emp_salinf  =  vg_salinf  , emp_intsin  =  vg_intsin  ,
emp_infsin  =  vg_infsin  , emp_varims  =  vg_varims  ,
emp_varinf  =  vg_varinf  , emp_anthor  =  vg_anthor  ,
emp_antdia  =  vg_antdia  , emp_antmes  =  vg_antmes  ,
emp_antint  =  vg_antint  , emp_antivc  =  vg_antivc  ,
emp_antinf  =  vg_antinf  , emp_antits  =  vg_antits  ,
emp_antifs  =  vg_antifs  , emp_refcon  =  vg_refcon  ,
emp_cveban  =  vg_cveban  , emp_ctaban  =  vg_ctaban  ,
emp_forpag  =  vg_forpag  , emp_diades  =  vg_diades  ,
emp_numliq  =  vg_numliq  , emp_keyloc  =  vg_keyloc  ,
emp_fecing  =  vg_fecing  , emp_fecrei  =  vg_fecrei  ,
emp_fecven  =  vg_fecven  , emp_fecpla  =  vg_fecpla  ,
emp_fecaum  =  vg_fecaum  , emp_peraum  =  vg_peraum  ,
emp_fecbaj  =  vg_fecbaj  , emp_cvebaj  =  vg_cvebaj  ,
emp_jorlab  =  vg_jorlab  , emp_unijor  =  vg_unijor  ,
emp_pering  =  vg_pering  , emp_perbaj  =  vg_perbaj  ,
emp_perdep  =  vg_perdep  , emp_perpue  =  vg_perpue  ,
emp_percat  =  vg_percat  , emp_perpro  =  vg_perpro  ,
emp_fecaux  =  vg_fecaux  , emp_ca1aux  =  vg_ca1aux  ,
emp_ca2aux  =  vg_ca2aux  , emp_ca3aux  =  vg_ca3aux  ,
emp_ca4aux  =  vg_ca4aux  , emp_pctbec  =  vg_pctbec  ,
emp_fecmod  =  vg_fecmod  , emp_hormod  =  vg_hormod  ,
emp_fecalt  =  vg_fecalt  , emp_bajfec  =  vg_bajfec  ,
emp_fecsal  =  vg_fecsal  , emp_perpag  =  vg_perpag  ,
emp_inifec  =  vg_inifec  , emp_finfec  =  vg_finfec  ,
emp_cobert  =  vg_cobert
where emp_keyemp=vg_keyemp;
end if;
vn_existr := 0;
ws_cveban := oracle.substr(vg_cveban,1,3);
begin
select count(*)
into strict vn_existr
from  nmloctas
where cta_keyemp=vg_keyemp
and cta_keypro=vg_keypro;
exception
when no_data_found then
null;
end;
if vn_existr = 0 then
insert into nmloctas
select trim(both emp_keypro),trim(both emp_keyemp), trim(both emp_ctaban)
from  emplpaso
where emp_keyemp=keyemp;
else
update nmloctas set cta_ctaban=vg_ctaban,
cta_keypro=vg_keypro
where  cta_keyemp = keyemp
and  cta_keypro = vg_keypro;
end if;end;
$body$
language plpgsql
;
