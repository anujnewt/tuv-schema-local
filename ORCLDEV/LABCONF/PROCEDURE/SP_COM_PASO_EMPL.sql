create or replace procedure labconf."sp_com_paso_empl"  (noctvo integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
vs_activo varchar(1);
vs_pering varchar(7);
vn_keyemp integer;
vn_existr integer;
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
ve_keyemp   integer;
ve_keydep   varchar(16);
ve_keypue   varchar(16);
ve_keycen   varchar(16);
ve_keycat   varchar(16);
ve_nomemp   varchar(60);
ve_nomcor   varchar(20);
ve_domemp   varchar(60);
ve_colemp   varchar(40);
ve_cidemp   varchar(20);
ve_pobemp   varchar(20);
ve_munemp   varchar(6);
ve_entemp   varchar(2);
ve_codemp   varchar(5);
ve_telemp   varchar(60);
ve_regrfc   varchar(13);
ve_recurp   varchar(18);
ve_regims   varchar(12);
ve_reginf   varchar(12);
ve_cvesex   varchar(1);
ve_keyims   varchar(5);
ve_cvezon   smallint;
ve_keypro   smallint;
ve_cvetur   smallint;
ve_tipemp   varchar(6);
ve_tipsal   varchar(1);
ve_status   smallint;
ve_salhor   decimal(12,6);
ve_saldia   decimal(12,6);
ve_salmes   decimal(12,2);
ve_salint   decimal(12,6);
ve_salivc   decimal(12,6);
ve_salinf   decimal(12,6);
ve_intsin   decimal(12,6);
ve_infsin   decimal(12,6);
ve_varims   decimal(12,6);
ve_varinf   decimal(12,6);
ve_anthor   decimal(12,6);
ve_antdia   decimal(12,6);
ve_antmes   decimal(12,2);
ve_antint   decimal(12,6);
ve_antivc   decimal(12,6);
ve_antinf   decimal(12,6);
ve_antits   decimal(12,6);
ve_antifs   decimal(12,6);
ve_refcon   varchar(20);
ve_cveban   varchar(7);
ve_ctaban   varchar(18);
ve_forpag   varchar(2);
ve_diades   smallint;
ve_numliq   varchar(6);
ve_keyloc   varchar(16);
ve_fecing   timestamp(0);
ve_fecrei   timestamp(0);
ve_fecven   timestamp(0);
ve_fecpla   timestamp(0);
ve_fecaum   timestamp(0);
ve_peraum   varchar(7);
ve_fecbaj   timestamp(0);
ve_cvebaj   varchar(4);
ve_jorlab   varchar(1);
ve_unijor   decimal(4,2);
ve_pering   varchar(7);
ve_perbaj   varchar(7);
ve_perdep   varchar(7);
ve_perpue   varchar(7);
ve_percat   varchar(7);
ve_perpro   varchar(7);
ve_fecaux   timestamp(0);
ve_ca1aux   varchar(10);
ve_ca2aux   varchar(10);
ve_ca3aux   varchar(10);
ve_ca4aux   varchar(10);
ve_pctbec   decimal(5,2);
ve_fecmod   timestamp(0);
ve_hormod   varchar(8);
ve_fecalt   timestamp(0);
ve_bajfec   timestamp(0);
ve_fecsal   timestamp(0);
ve_perpag   varchar(7);
ve_inifec   timestamp(0);
ve_finfec   timestamp(0);
ve_cobert   varchar(2);
vc_fecaum   timestamp(0);
wd_fec_act          varchar(10);
ws_hor_act          varchar(8);
ws_nom_rep          varchar(10);
ws_ide_pcc          varchar(15);
wn_key_usu          integer;
ws_hor_reg          varchar(8);
wn_tot_reg          integer;
begin
wd_fec_act := to_char(clock_timestamp(), 'mm/dd/yyyy');
ws_hor_act := to_char(clock_timestamp(), 'HH24:MI:SS');
ws_nom_rep := 'emplpaso';
ws_ide_pcc := 'sp_com_paso_emp';
wn_key_usu := noctvo;
ws_hor_reg := to_char(clock_timestamp(), 'HH24:MI:SS');
wn_tot_reg := 0;
insert into glcoresu(
res_idepro, res_idepcc, res_keyusu, res_fecini, res_horini,
res_horreg, res_totreg, res_status )
values (
ws_nom_rep, ws_ide_pcc, wn_key_usu, wd_fec_act, ws_hor_act,
ws_hor_reg, wn_tot_reg, 'P' );
select count(*)
into strict  vn_existr
from emplpaso
where emp_keyemp in (select emp_keyemp
from  com_orac_sips_empl
where  ora_noctvo = noctvo);/* dmap converted statement start */
select
emp_keyemp, rtrim(emp_keydep::text), emp_keypue, rtrim(emp_keycen::text), rtrim(emp_keycat::text),
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
emp_ca2aux, emp_ca3aux, emp_ca4aux, emp_pctbec,
wd_fec_act, ws_hor_act ,
emp_fecalt, emp_bajfec, emp_fecsal, emp_perpag,
emp_inifec, emp_finfec, emp_cobert
--to_char (sysdate, 'HH24:MI:SS')
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
from com_orac_sips_empl
where ora_noctvo = noctvo;/* dmap converted statement end */
update glcoresu set res_numreg = vn_existr,
res_isaerr = vg_keyemp
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = wd_fec_act
and res_horreg = ws_hor_reg;
--determina tipo fondo
select pro_ca4aux,pro_ca5aux
into strict ws_ca4aux,ws_ca5aux
from nmloproc
where pro_keypro=vg_keypro;
if ws_ca4aux = 'S' and ws_ca5aux = 'T' then
vg_ca4aux := 'F';
vg_refcon := '1';
elsif ws_ca4aux = 'N' then
vg_ca4aux := 'N';
vg_refcon := '2';
elsif ws_ca4aux = 'S' and ws_ca5aux = 'C' then
if vg_tipemp = '1' then
vg_ca4aux := 'F';
vg_refcon := '1';
elsif vg_tipemp <> '1' then
vg_ca4aux := 'N';
vg_refcon := '2';
end if;
elsif ws_ca4aux = 'S' and ws_ca5aux = 'S' then
if vg_tipemp = '2' then
vg_ca4aux := 'F';
vg_refcon := '1';
elsif vg_tipemp <> '2' then
vg_ca4aux := 'N';
vg_refcon := '2';
end if;
end if;
if vg_ca2aux ='3'or vg_ca2aux = '4' or
vg_ca2aux ='5'or vg_ca2aux = '6' or
vg_ca2aux ='7'
then
vg_ca4aux := 'N';
vg_refcon := '2';
end if;
--trae datos del maestro
begin
select
emp_keyemp, emp_keydep, emp_keypue, emp_keycen, emp_keycat,
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
emp_inifec, emp_finfec, emp_cobert
into strict
ve_keyemp, ve_keydep, ve_keypue, ve_keycen, ve_keycat,
ve_nomemp, ve_nomcor, ve_domemp, ve_colemp, ve_cidemp,
ve_pobemp, ve_munemp, ve_entemp, ve_codemp, ve_telemp,
ve_regrfc, ve_recurp, ve_regims, ve_reginf, ve_cvesex,
ve_keyims, ve_cvezon, ve_keypro, ve_cvetur, ve_tipemp,
ve_tipsal, ve_status, ve_salhor, ve_saldia, ve_salmes,
ve_salint, ve_salivc, ve_salinf, ve_intsin, ve_infsin,
ve_varims, ve_varinf, ve_anthor, ve_antdia, ve_antmes,
ve_antint, ve_antivc, ve_antinf, ve_antits, ve_antifs,
ve_refcon, ve_cveban, ve_ctaban, ve_forpag, ve_diades,
ve_numliq, ve_keyloc, ve_fecing, ve_fecrei, ve_fecven,
ve_fecpla, ve_fecaum, ve_peraum, ve_fecbaj, ve_cvebaj,
ve_jorlab, ve_unijor, ve_pering, ve_perbaj, ve_perdep,
ve_perpue, ve_percat, ve_perpro, ve_fecaux, ve_ca1aux,
ve_ca2aux, ve_ca3aux, ve_ca4aux, ve_pctbec, ve_fecmod,
ve_hormod, ve_fecalt, ve_bajfec, ve_fecsal, ve_perpag,
ve_inifec, ve_finfec, ve_cobert
from nmcoempl
where emp_keyemp = vg_keyemp;
exception
when no_data_found then
null;
end;
--  and emp_status = 1 ;
begin
select dep_keycen
into strict   vg_keycen
from   nmcodeps
where dep_keydep=vg_keydep;
exception
when no_data_found then
null;
end;
vc_fecaum := ve_fecaum;
if nullif(vg_fecaum::text, '') is not null then
vc_fecaum := vg_fecaum;
end if;
-- actualiza paso o inserta
if vn_existr = 0 then
insert into emplpaso(emp_keyemp, emp_keydep, emp_keypue, emp_keycen, emp_keycat,
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
vg_nomemp, ve_nomcor, vg_domemp, vg_colemp, vg_cidemp,
vg_pobemp, vg_munemp, vg_entemp, vg_codemp, vg_telemp,
vg_regrfc, vg_recurp, vg_regims, vg_reginf, vg_cvesex,
vg_keyims, vg_cvezon, vg_keypro, vg_cvetur, vg_tipemp,
vg_tipsal, vg_status, ve_salhor, ve_saldia, vg_salmes,
ve_salint, ve_salivc, ve_salinf, ve_intsin, ve_infsin,
ve_varims, ve_varinf, ve_anthor, ve_antdia, ve_antmes,
ve_antint, ve_antivc, ve_antinf, ve_antits, ve_antifs,
vg_refcon, vg_cveban, vg_ctaban, vg_forpag, ve_diades,
ve_numliq, vg_keyloc, vg_fecing, vg_fecrei, vg_fecven,
vg_fecpla, vc_fecaum, ve_peraum, vg_fecbaj, vg_cvebaj,
vg_jorlab, vg_unijor, ve_pering, vg_perbaj, ve_perdep,
ve_perpue, ve_percat, ve_perpro, vg_fecaux, vg_ca1aux,
vg_ca2aux, vg_ca3aux, vg_ca4aux, ve_pctbec, vg_fecmod,
vg_hormod, vg_fecalt, vg_bajfec, ve_fecsal, ve_perpag,
ve_inifec, ve_finfec, vg_cobert);
else
update emplpaso set
emp_keydep  =  vg_keydep  ,
emp_keypue  =  vg_keypue  , emp_keycen  =  vg_keycen  ,
emp_keycat  =  vg_keycat  , emp_nomemp  =  vg_nomemp  ,
emp_nomcor  =  ve_nomcor  , emp_domemp  =  vg_domemp  ,
emp_colemp  =  vg_colemp  , emp_cidemp  =  vg_cidemp  ,
emp_pobemp  =  vg_pobemp  , emp_munemp  =  vg_munemp  ,
emp_entemp  =  vg_entemp  , emp_codemp  =  vg_codemp  ,
emp_telemp  =  vg_telemp  , emp_regrfc  =  vg_regrfc  ,
emp_recurp  =  vg_recurp  , emp_regims  =  vg_regims  ,
emp_reginf  =  vg_reginf  , emp_cvesex  =  vg_cvesex  ,
emp_keyims  =  vg_keyims  , emp_cvezon  =  vg_cvezon  ,
emp_keypro  =  vg_keypro  , emp_cvetur  =  vg_cvetur  ,
emp_tipemp  =  vg_tipemp  , emp_tipsal  =  vg_tipsal  ,
emp_status  =  vg_status  , emp_salhor  =  ve_salhor  ,
emp_saldia  =  ve_saldia  , emp_salmes  =  vg_salmes  ,
emp_salint  =  ve_salint  , emp_salivc  =  ve_salivc  ,
emp_salinf  =  ve_salinf  , emp_intsin  =  ve_intsin  ,
emp_infsin  =  ve_infsin  , emp_varims  =  ve_varims  ,
emp_varinf  =  ve_varinf  , emp_anthor  =  ve_anthor  ,
emp_antdia  =  ve_antdia  , emp_antmes  =  ve_antmes  ,
emp_antint  =  ve_antint  , emp_antivc  =  ve_antivc  ,
emp_antinf  =  ve_antinf  , emp_antits  =  ve_antits  ,
emp_antifs  =  ve_antifs  , emp_refcon  =  vg_refcon  ,
emp_cveban  =  vg_cveban  , emp_ctaban  =  vg_ctaban  ,
emp_forpag  =  vg_forpag  , emp_diades  =  ve_diades  ,
emp_numliq  =  ve_numliq  , emp_keyloc  =  vg_keyloc  ,
emp_fecing  =  vg_fecing  , emp_fecrei  =  vg_fecrei  ,
emp_fecven  =  vg_fecven  , emp_fecpla  =  vg_fecpla  ,
emp_fecaum  =  vc_fecaum  , emp_peraum  =  ve_peraum  ,
emp_fecbaj  =  vg_fecbaj  , emp_cvebaj  =  vg_cvebaj  ,
emp_jorlab  =  vg_jorlab  , emp_unijor  =  vg_unijor  ,
emp_pering  =  ve_pering  , emp_perbaj  =  vg_perbaj  ,
emp_perdep  =  ve_perdep  , emp_perpue  =  ve_perpue  ,
emp_percat  =  ve_percat  , emp_perpro  =  ve_perpro  ,
emp_fecaux  =  vg_fecaux  , emp_ca1aux  =  vg_ca1aux  ,
emp_ca2aux  =  vg_ca2aux  , emp_ca3aux  =  vg_ca3aux  ,
emp_ca4aux  =  vg_ca4aux  , emp_pctbec  =  ve_pctbec  ,
emp_fecmod  =  vg_fecmod  , emp_hormod  =  vg_hormod  ,
emp_fecalt  =  vg_fecalt  , emp_bajfec  =  vg_bajfec  ,
emp_fecsal  =  ve_fecsal  , emp_perpag  =  ve_perpag  ,
emp_inifec  =  ve_inifec  , emp_finfec  =  ve_finfec  ,
emp_cobert  =  vg_cobert
where emp_keyemp=vg_keyemp;
end if;
if vg_status = 1 then
delete from traypaso
where       tra_keyemp=vg_keyemp
and       tra_tipmov=2;
end if;
-- actualiza la tabbaa deemnitoreo indicandoola finalizacion    --
-- del proceso.                                                 --
ws_hor_act := to_char(clock_timestamp(), 'HH24:MI:SS');
update glcoresu set res_numreg = vn_existr,
res_fecfin = wd_fec_act,
res_horfin = ws_hor_act,
res_status = 'T'
where res_idepro = ws_nom_rep
and res_idepcc = ws_ide_pcc
and res_keyusu = wn_key_usu
and res_fecini = wd_fec_act
and res_horreg = ws_hor_reg;end;
$body$
language plpgsql
;
