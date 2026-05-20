create or replace procedure usrsiho."sp_hrpdesin"  (wn_usuario numeric,ws_terminal varchar, wn_proceso numeric,ws_periodo varchar, ws_numemi varchar,ws_keyapr varchar, ws_tipfol varchar,wn_tipmon numeric, wn_tipcam numeric,ws_idprovi varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
li_keypue numeric(10);li_keypue1 numeric(10);ln_keyrph numeric(10);lnn_keyrph numeric(10);ln_keyemp numeric(10);ln_numcap numeric(10);
---variables or cesar gonzalez
li_porcent numeric(10);
li_keysec  varchar(16);
li_keyemp  numeric(10);
ls_keyemp  varchar(16);
li_import  decimal(16,2);
wi_keyrph numeric(10);
ln_keynom numeric(10);
ln_reg107 numeric(10);
ws_numsec numeric(10);
--termina cesar g
ls_keycon varchar(3);
ls_keydep varchar(16);
ln_suma   decimal(15,2);
ln_base_iva1 decimal(15,2);
ln_base_iva2 decimal(15,2);
ln_base_exenta1 decimal(15,2);
ln_base_exenta2 decimal(15,2);
ln_base_fomentos decimal(15,2);
ld_fechasys timestamp(0);
ln_tipcam decimal(16,6);
ls_diauno varchar(10);
ls_diados varchar(10);
li_keyagr numeric(10);
ws_puesto holocont.con_keypue%type;
ws_pertra holocont.con_pertra%type;
ws_idioma holocont.con_idioma%type;
ws_nacion holocont.con_keynac%type;
wn_costot decimal(16,6);
wn_numcap numeric(10);
--se insertaron estas definiciones para la validacion
--de uniformes grabados y transportes grabados, ya que
--antes estaba los conceptos por codigo duro.
suniforme       varchar(003);
stransporte     varchar(003);
ls_tiptra       varchar(001);
--- se agrego la variable incremento para darle un numero consecutivo al campo inc_diasei ljc 20/05/2008
incremento numeric(10);
ls_repeti varchar(003);    --agrego jdcm 19/mzo/2010 para validar tipo de repeticion n, g, vp o gp
li_encontrado numeric(10);  --agrego jcro 20/mzo/2012 para validar tipo de repeticion incluido como opci.
ls_con_iva varchar(003);    --agrego jdcm 06/jul/2012 para concepto de iva nomina 113
ls_con_rep varchar(003);    --agrego jdcm 06/jul/2012 para concepto de repeticion set nomina 113
ls_con_repcs varchar(003);    --agrego jdcm 06/jul/2012 para concepto de repeticion set nomina 213
ln_por_iva decimal(16,2); --agrego jdcm 06/jul/2012 para obtener porcentaje de iva
ln_por_rep decimal(16,2); --agrego jdcm 06/jul/2012 para obtener porcentaje de repeticion set
ls_rph_retro varchar(12);    --agrego jdcm 12/feb/2014 para obtener identificar si es un rph de retroactivo
ln_fom_tab_act numeric(10);   --agrego jdcm 12/feb/2014 para obtener fomento con tabulador actual
ln_fom_tab_ant numeric(10);   --agrego jdcm 12/feb/2014 para obtener fomento con tabulador anterior
ln_tabact decimal(16,2);  --agrego jdcm 12/feb/2014 para obtener tabulador tabulador actual
ln_tabant decimal(16,2);  --agrego jdcm 12/feb/2014 para obtener tabulador tabulador anterior
ln_tabpag decimal(16,2);  --agrego jdcm 12/feb/2014 para obtener tabulador pagado de la hoja origen
ld_fecgra timestamp(0);           --agrego jdcm 12/feb/2014 para obtener fecha grabacion del rph
ln_keytab numeric(10);        --agrego jdcm 12/feb/2014 para obtener clave de tabulador registrado
ln_pertra numeric(10);        --agrego jdcm 12/feb/2014 para obtener periodo de transmision para ajustes
ln_sihay numeric(10);
valores varchar(40);
valor varchar(40);
posincad numeric(10);
ls_perretro varchar(12);
ln_sec_cry numeric(10);
ln_rph_ant numeric(10);
ld_ptjeretro decimal(9,6);
rec record;
rec2 record;
rec3 record;
rec4 record;
rec5 record;
rec6 record;
rec7 record;
rec8 record;
rec9 record;
rec10 record;
begin
li_encontrado := 0;
suniforme:= null;
stransporte:= null;
ls_tiptra:= null;
ls_perretro:= null;
begin
select pam_folini
into strict ld_ptjeretro
from usrsiho.glcopams
where pam_keypar in (select pam_folini
from usrsiho.glcopams
where pam_keypar='00'
and pam_cvesec='loretr')
and pam_nompar like '%PORCENTAJE%';
exception
when no_data_found then
ld_ptjeretro:= null;
end;
-- eliminado de incidencias
delete
from usrsiho.nmcoinci
where inc_keyper = ws_periodo and
inc_keypro = wn_proceso;
-- reinicializacion de rphs
update usrsiho.holofrph
set frp_stsfol = '0',
frp_keyper = 0
where frp_keypro = wn_proceso
and frp_keyper = ws_periodo;
-- lectura de la fecha de pago para las incidencias
begin
select per_fecpag,per_keynom,per_despol
into strict ld_fechasys,ln_keynom,ls_perretro
from usrsiho.nmloperi
where per_keypro=wn_proceso
and per_keyper= ws_periodo;
exception
when no_data_found then
ld_fechasys:= null;
ln_keynom:= null;
ls_perretro:= null;
end;
-- lectura de datos
for rec in (select gdp.gdp_keyemp,gdp.gdp_keycon,gdp.gdp_keypue,
frp.frp_keydep,sum(gdp.gdp_cosuni*gdp.gdp_numcap) suma,
frp.frp_tipcam,pue_ca3aux
from   usrsiho.hologdpr gdp,usrsiho.glwkcrys cry,usrsiho.holofrph frp,usrsiho.nmcopues pue
where  frp.frp_keyrph = gdp.gdp_keyrph and
gdp.gdp_keyrph = cry.cry_numsec and
cry.cry_nomrep = 'HODESINC' and
cry.cry_keyusu = wn_usuario and
gdp.gdp_keypue = pue.pue_keypue and
cry.cry_idepcc = ws_terminal and
frp.frp_stsfol <> 2 and
gdp.gdp_cosuni >= 0.01
group by gdp.gdp_keyemp,gdp.gdp_keycon,gdp.gdp_keypue,
frp.frp_keydep,frp.frp_tipcam,pue_ca3aux) loop
----lineas adicionadas el dia 13/08/2001  cesar gonzalez sanchez
ln_keyemp := rec.gdp_keyemp;
ls_keycon := rec.gdp_keycon;
li_keypue := rec.gdp_keypue;
ls_keydep := rec.frp_keydep;
ln_suma := rec.suma;
ln_tipcam := rec.frp_tipcam;
ls_diauno := rec.pue_ca3aux;
li_keyemp := 0;
---aedo 04/07/2007 se agrego la lectura del importe
begin
select  cus_keyemp,coalesce(cus_porcen,0),cus_keysec,coalesce(cus_import,0)
into strict    li_keyemp,li_porcent,li_keysec,li_import
from    usrsiho.holocusi
where   cus_keyemp = ln_keyemp
and     cus_keypue = li_keypue
and     cus_keycen = ls_keydep;
exception
when no_data_found then
li_keyemp:= null;
end;/* dmap converted statement start */
--- inserccion por cada registro obtenido
if  nullif(li_keyemp::text, '') is null then
insert into
usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
values (wn_proceso,ws_periodo,ln_keyemp,ls_keycon,ls_keydep,
li_keypue,ln_suma,ld_fechasys,ln_tipcam,(rtrim(ls_diauno::text))::numeric );/* dmap converted statement end */
else
----obtiene datos de la tabla holocusi y los inserta en la tabla
----aedo  04/07/2007 se agrego la siguiente validacion para mandar
----                 el importe o el porcentaje
if li_import > 0 then
ls_diados := li_import;   ----importe
else
ls_diados := li_porcent;  ----porcentaje
end if;
---let ln_keyemp = li_keyemp;  ----clave de empleado
ls_diauno := li_keysec;  ----clave de seccion
/* dmap converted statement start */
---let ls_diados = li_porcent;  ----porcentaje
insert into usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno,inc_diados)
values (wn_proceso,ws_periodo,ln_keyemp,ls_keycon,ls_keydep,li_keypue,ln_suma,
ld_fechasys,ln_tipcam,(rtrim(ls_diauno::text))::numeric ,(rtrim(ls_diados::text))::numeric );/* dmap converted statement end */
end if;
----------termina c.g.s
----           insert into nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
----                            inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
----          values(wn_proceso,ws_periodo,ln_keyemp,ls_keycon,ls_keydep,li_keypue,ln_suma,ld_fechasys,ln_tipcam,ls_diauno);
--actualizacio del area de produccion y del periodo en nmloperi
update usrsiho.nmloperi
set per_nu3aux = ws_keyapr,
per_nu4aux = ws_numemi,
per_nu5aux = ws_tipfol,
per_nu1aux = wn_tipcam,
per_nu2aux = wn_tipmon
--per_keypol = ws_idprovi
where per_keyper = ws_periodo
and per_keypro = wn_proceso;
end loop;
--para frp.frp_unifor > 0
for rec2
in (select gdp.gdp_keyemp,gdp.gdp_keypue,
frp.frp_keydep,sum(frp_unifor) suma,
frp.frp_tipcam,pue.pue_ca3aux,frp.frp_tiptra
from usrsiho.hologdpr gdp,usrsiho.glwkcrys cry,usrsiho.holofrph frp,usrsiho.nmcopues pue
where frp.frp_keyrph = gdp.gdp_keyrph and
gdp.gdp_keyrph = cry.cry_numsec and
cry.cry_nomrep = 'HODESINC' and
cry.cry_keyusu = wn_usuario and
frp.frp_unifor > 0 and
gdp.gdp_keypue = pue.pue_keypue and
oracle.substr(pue_ca4aux,6, 1) = '1' and --solo losque tengan activiado campo d uniforme
cry.cry_idepcc = ws_terminal and
frp.frp_stsfol <> 2 and
gdp.gdp_cosuni >= 0.01
group by gdp.gdp_keyemp,gdp.gdp_keypue,
frp.frp_keydep,frp.frp_tipcam,
pue.pue_ca3aux,frp.frp_tiptra) loop
--asigno variable transporte
ln_keyemp := rec2.gdp_keyemp;
li_keypue := rec2.gdp_keypue;
ls_keydep := rec2.frp_keydep;
ln_suma := rec2.suma;
ln_tipcam := rec2.frp_tipcam;
ls_diauno := rec2.pue_ca3aux;
ls_tiptra := rec2.frp_tiptra;
suniforme:='H09';
-- si trae una g el valor debe de ser 'HE9', transportes
if ls_tiptra='G' then
suniforme:='HE9';
end if;
ls_tiptra:= null;
-- inserccion por cada registro obtenido
insert into usrsiho.nmcoinci(
inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid,inc_fecmov,inc_diauno)
values (
wn_proceso,ws_periodo,ln_keyemp,suniforme,ls_keydep,
li_keypue,ln_suma,ln_tipcam,ld_fechasys,(trim(both ls_diauno))::numeric );
end loop;
--para frp.frp_transp > 0
for rec3
in (select gdp.gdp_keyemp,gdp.gdp_keypue,
frp.frp_keydep,sum(frp_transp) suma,
frp.frp_tipcam,pue.pue_ca3aux,
pue.pue_nu4aux,frp.frp_tiptra
from usrsiho.hologdpr gdp,usrsiho.glwkcrys cry,usrsiho.holofrph frp,usrsiho.nmcopues pue
where frp.frp_keyrph=gdp.gdp_keyrph and
gdp.gdp_keyrph=cry.cry_numsec and
cry.cry_nomrep='HODESINC' and
cry.cry_keyusu=wn_usuario and
frp.frp_transp > 0 and
gdp.gdp_keypue=pue.pue_keypue and
oracle.substr(pue_ca4aux,5, 1)='1' and --solo los que tengan activiado campo transp.
cry.cry_idepcc=ws_terminal and
gdp.gdp_cosuni >= 0.01
group by gdp.gdp_keyemp,gdp.gdp_keypue,
frp.frp_keydep,frp.frp_tipcam,
pue.pue_ca3aux,pue.pue_nu4aux
,frp.frp_tiptra) loop
--asigno variable transporte
ln_keyemp := rec3.gdp_keyemp;
li_keypue := rec3.gdp_keypue;
ls_keydep := rec3.frp_keydep;
ln_suma := rec3.suma;
ln_tipcam := rec3.frp_tipcam;
ls_diauno := rec3.pue_ca3aux;
ls_diados := rec3.pue_nu4aux;
ls_tiptra := rec3.frp_tiptra;
stransporte:='H08';
-- si trae una g el valor debe de ser 'HE8', transportes
if ls_tiptra='G' then
stransporte:='HE8';
end if;
-- inserccion por cada registro obtenido
insert into usrsiho.nmcoinci(
inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,
inc_diados)
values (wn_proceso,ws_periodo,ln_keyemp,stransporte,ls_keydep,
li_keypue,ln_suma,ln_tipcam,ld_fechasys,(trim(both ls_diauno))::numeric ,
(trim(both ls_diados))::numeric );
end loop;
--para prestaciones de musicos
for rec4 in (select gdp.gdp_keyrph,gdp.gdp_keyemp,gdp.gdp_keypue,
frp.frp_keydep,sum(gdp_cosuni*gdp_numcap) suma,
frp.frp_tipcam,agc_keyagr,frp_repeti
from usrsiho.hologdpr gdp,usrsiho.glwkcrys cry,usrsiho.holofrph frp,usrsiho.holoagcp
where frp.frp_keyrph=gdp.gdp_keyrph and
gdp.gdp_keyrph=cry.cry_numsec and
cry.cry_nomrep='HODESINC' and
cry.cry_keyusu=wn_usuario and
gdp_keycon = agc_keycon and
agc_keyagr in (19,20) and
cry.cry_idepcc=ws_terminal and
frp.frp_stsfol<>2 and
gdp.gdp_cosuni >= 0.01
group by gdp.gdp_keyrph,gdp.gdp_keyemp,gdp.gdp_keypue,
frp.frp_keydep,frp.frp_tipcam,agc_keyagr,frp_repeti) loop
-- inserccion por cada registro obtenido
ln_keyrph := rec4.gdp_keyrph;
ln_keyemp := rec4.gdp_keyemp;
li_keypue := rec4.gdp_keypue;
ls_keydep := rec4.frp_keydep;
ln_suma := rec4.suma;
ln_tipcam := rec4.frp_tipcam;
li_keyagr := rec4.agc_keyagr;
ls_repeti := rec4.frp_repeti;
if li_keyagr = 19 then
insert into usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
values (wn_proceso,ws_periodo,ln_keyemp,'H10',ls_keydep,li_keypue,ln_suma,ln_tipcam,ld_fechasys,
null,null);
insert into usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
values (wn_proceso,ws_periodo,ln_keyemp,'H07',ls_keydep,li_keypue,ln_suma,ln_tipcam,ld_fechasys,
null,null);
else
insert into usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
values (wn_proceso,ws_periodo,ln_keyemp,'HE6',ls_keydep,li_keypue,ln_suma,ln_tipcam,ld_fechasys,
null,null);
insert into usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
values (wn_proceso,ws_periodo,ln_keyemp,'HE7',ls_keydep,li_keypue,ln_suma,ln_tipcam,ld_fechasys,
null,null);
end if;
--insert into paso values('sp_hrpdesin','li_Encontrado',li_encontrado,0,'','');
-- jcro 20/mzo/2012 para validar tipo de repeticion incluido como opci
begin
select coalesce(pam_folfin,0)
into strict li_encontrado
from usrsiho.glcopams
where pam_keypar in (select pam_folini
from usrsiho.glcopams
where pam_cvesec = 'pdesin')
and pam_cvesec = 'OPCI12'
and pam_folini = ls_repeti;
exception when no_data_found then
li_encontrado:= null;
end;
--insert into paso values('sp_hrpdesin','ls_repeti',ls_repeti,0,'','');
--insert into paso values('sp_hrpdesin','li_Encontrado',li_encontrado,0,'','');
--           if ls_repeti = 'VP' or ls_repeti = 'GP' then
-- jcro 20/mzo/2012 para validar tipo de repeticion incluido como opci
if li_encontrado > 0 then
insert into usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados,inc_diacin)
values (wn_proceso,ws_periodo,ln_keyemp,'H20',ls_keydep,li_keypue,ln_suma,ln_tipcam,ld_fechasys,
null,null,li_encontrado);
else
insert into usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
values (wn_proceso,ws_periodo,ln_keyemp,'H20',ls_keydep,li_keypue,ln_suma,ln_tipcam,ld_fechasys,
null,null);
end if;
insert into usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
--  values(wn_proceso,ws_periodo,ln_keyemp,'H04',ls_keydep,li_keypue,ln_suma,ln_keyrph,ld_fechasys,
--                  null,null);
values (wn_proceso,ws_periodo,ln_keyemp,'H4D',ls_keydep,li_keypue,ln_suma,ln_keyrph,ld_fechasys,
null,null);
insert into usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
values (wn_proceso,ws_periodo,ln_keyemp,'H4R',ls_keydep,li_keypue,ln_suma,ln_keyrph,ld_fechasys,
null,null);
end loop;
-- calculo de previsisn social de anda e insercisn de las incidencias
for rec5 in (select gdp.gdp_keyemp,gdp.gdp_keypue,
frp.frp_keydep,sum(gdp_cosuni::numeric * gdp_numcap * 0.18) suma,
frp.frp_tipcam,frp_repeti
from usrsiho.hologdpr gdp,usrsiho.glwkcrys cry,usrsiho.holofrph frp,usrsiho.nmcopues
where frp.frp_keyrph=gdp.gdp_keyrph and
gdp.gdp_keyrph=cry.cry_numsec and
cry.cry_nomrep='HODESINC' and
cry.cry_keyusu=wn_usuario and
pue_keypue = gdp_keypue and
oracle.substr(pue_ca4aux,2, 1) = '1' and
cry.cry_idepcc=ws_terminal and
gdp.gdp_cosuni >= 0.01
group by gdp.gdp_keyemp,gdp.gdp_keypue,frp.frp_keydep,frp.frp_tipcam,frp_repeti) loop
-- jcro 20/mzo/2012 para validar tipo de repeticion incluido como opci
--insert into paso values('sp_hrpdesin','li_Encontrado',li_encontrado,0,'','');
ln_keyemp := rec5.gdp_keyemp;
li_keypue := rec5.gdp_keypue;
ls_keydep := rec5.frp_keydep;
ln_suma := rec5.suma;
ln_tipcam := rec5.frp_tipcam;
ls_repeti := rec5.frp_repeti;
begin
select count(*)
into strict li_encontrado
from usrsiho.glcopams
where pam_keypar in (select pam_folini
from usrsiho.glcopams
where pam_cvesec = 'pdesin'
)
and pam_cvesec = 'OPCI12'
and pam_folini = ls_repeti;
exception when no_data_found then
li_encontrado:= null;
end;
-- jcro 20/mzo/2012 para validar tipo de repeticion incluido como opci
-- insercion de la previsisn social por cada registro obtenido
--           if ls_repeti = 'VP' or ls_repeti = 'GP' then     --se usa campo inc_diacin para validar en formula
--insert into paso values('sp_hrpdesin','li_Encontrado',li_encontrado,1,'','');
if li_encontrado > 0 then
insert into usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados,inc_diacin)
values (wn_proceso,ws_periodo,ln_keyemp,'H20',ls_keydep,
li_keypue,ln_suma,ln_tipcam,ld_fechasys,null,null,1);
else
insert into usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados)
values (wn_proceso,ws_periodo,ln_keyemp,'H20',ls_keydep,
li_keypue,ln_suma,ln_tipcam,ld_fechasys,null,null);
end if;
end loop;
-- calculo de fomentos de anda e insercion de las incidencias
incremento := 1;
ln_sec_cry := 0;
for rec6 in (select gdp.gdp_keyemp,pue_ca2aux,pue_ca3aux,
frp.frp_keydep,frp.frp_tipcam,
gdp_keypue,con_pertra,con_idioma,con_keynac,
gdp_cosuni,gdp_numcap,
gdp.gdp_keyrph, cry.cry_numsec,frp.frp_fecitr
from usrsiho.hologdpr gdp
join glwkcrys cry on cry.cry_nomrep = 'HODESINC' and cry.cry_keyusu = wn_usuario and gdp.gdp_keyrph = cry.cry_numsec
join holofrph frp on frp.frp_keyrph = gdp.gdp_keyrph
join nmcopues on pue_keypue = gdp_keypue and oracle.substr(pue_ca4aux,1, 1) = '1'
left join usrsiho.holocont on  gdp_keyfol = con_keyfol and gdp_keytco = con_keytco
where  cry.cry_idepcc = ws_terminal
and frp.frp_stsfol <> 2
and gdp.gdp_cosuni >= 0.01
order by  gdp_keyrph,gdp_keyemp,gdp_keypue) loop
-- calculo de fomentos a la cultura y eficiencia
-- duracisn     tabu  factor fomento activ idi - nac
-- 30 minutos   514   0.0312 16.0368 1000  em
-- 15 minutos   178   0.0312  5.5536 1004  em
-- 30 minutos   1441  0.0306 44.0946 1009  ee
-- 30 minutos   1103  0.0312 34.4136 1006  om-oe
-- 150 minutos  3082  0.0302 93.0764 1003  om-oe
ln_keyemp := rec6.gdp_keyemp;
li_keypue := rec6.pue_ca2aux;
li_keypue1 := rec6.pue_ca3aux;
ls_keydep := rec6.frp_keydep;
ln_tipcam := rec6.frp_tipcam;
ws_puesto := rec6.gdp_keypue;
ws_pertra := rec6.con_pertra;
ws_idioma := rec6.con_idioma;
ws_nacion := rec6.con_keynac;
wn_costot := rec6.gdp_cosuni;
wn_numcap := rec6.gdp_numcap;
wi_keyrph := rec6.gdp_keyrph;
ws_numsec := rec6.cry_numsec;
ld_fecgra := rec6.frp_fecitr;
ln_sec_cry := ln_sec_cry + 1;
--insert into glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) values ('RETRO',ln_sec_cry,wi_keyrph,'0 INICIO',ws_puesto,ln_keyemp);
ln_suma := null;
ls_rph_retro:= null;
ln_fom_tab_act := 0;
ln_fom_tab_ant := 0;
ln_keytab := 0;
ln_sihay := 0;
if trim(both ws_puesto) = '1000' and
trim(both ws_pertra) = '30'   and
trim(both ws_idioma) = 'E'    and
trim(both ws_nacion) = 'M'    then
ln_suma := round(wn_costot * 0.0300) * wn_numcap;
elsif trim(both ws_puesto) = '1004'   and
trim(both ws_pertra) = '15'   and
trim(both ws_idioma) = 'E'    and
trim(both ws_nacion) = 'M'    then
ln_suma := round(wn_costot * 0.0300) * wn_numcap;
elsif trim(both ws_puesto) = '1009' and
trim(both ws_pertra) = '30'   and
trim(both ws_idioma) = 'E'    and
trim(both ws_nacion) = 'E'    then
ln_suma := round(wn_costot * 0.0300) * wn_numcap;
elsif trim(both ws_puesto) = '1006' and
trim(both ws_pertra) = '30'   and
((trim(both ws_idioma) = 'O' and trim(both ws_nacion) = 'M') or (trim(both ws_idioma) = 'O' and trim(both ws_nacion) = 'E')) then
ln_suma := round(wn_costot * 0.0300) * wn_numcap;
elsif trim(both ws_puesto) = '1003' and
trim(both ws_pertra) = '150'  and
((trim(both ws_idioma) = 'O' and trim(both ws_nacion) = 'M') or (trim(both ws_idioma) = 'O' and trim(both ws_nacion) = 'E')) then
ln_suma := round(wn_costot * 0.0300) * wn_numcap;
else
ln_suma := round(wn_costot * 0.0300) * wn_numcap;
end if;
if ln_suma >= 1 then
---aedo 22/02/2008 se agrego a los insert de los conceptos hf1 y hf2, los valores del rph, numero de secuencia
--**********busca si es un rph de ********** retroactivo ***********  jdcm
if (ln_keynom = 110 or ln_keynom = 210) and ls_perretro='RETROACTIVO' then
--insert into glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) values ('RETRO',ln_sec_cry,wi_keyrph,'01',ws_puesto,ln_keyemp);
begin
select oracle.substr(enc_descap,1,11)
into strict ls_rph_retro
from usrsiho.holoenctra
where enc_num_id in (select distinct det_num_id
from usrsiho.holodettra
where det_keyrph=wi_keyrph);
exception when no_data_found then
ls_rph_retro:= null;
end;
if ls_rph_retro = 'RETROACTIVO' then
if nullif(ws_pertra::text, '') is null or ws_pertra=' ' then
ln_keytab := 5;
--insert into glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) values ('RETRO',ln_sec_cry,wi_keyrph,'02',ws_puesto,ln_keyemp);
begin
select ald_pertra,ald_idioma,'M'
into strict ws_pertra,ws_idioma,ws_nacion
from usrsiho.nmloalde
where ald_keydep=ls_keydep;
exception when no_data_found then
ws_pertra:= null;
ws_idioma:= null;
ws_nacion:= null;
end;
--insert into glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) values ('RETRO',ln_sec_cry,wi_keyrph,'03',ws_puesto,ln_keyemp);
begin
select coalesce((oracle.substr(det_auxca2,12,3))::numeric ,0)
into strict ln_pertra
from usrsiho.holodettra
where det_num_id=(select distinct det_num_id
from usrsiho.holodettra
where det_keyrph=wi_keyrph)
and det_keyemp=ln_keyemp
and det_keypue=ws_puesto
and det_stsreg='V';
exception when no_data_found then
ln_pertra := 0;
end;
if ln_pertra = 0 then
ln_pertra := ws_pertra;
end if;
else
ln_keytab := 1;
ln_pertra := ws_pertra;
end if;
--insert into glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) values ('RETRO',ln_sec_cry,wi_keyrph,'04',ws_puesto,ln_keyemp);
--tabulador actual
begin
select (round(max(tab_import) * 0.0300) * wn_numcap),max(tab_import)
into strict ln_fom_tab_act,ln_tabact
from usrsiho.holotabs
where tab_keypro=138
and tab_keytab=ln_keytab
and tab_keypue=ws_puesto
--and tab_pertra=ws_pertra
and (tab_pertra)::numeric <=ln_pertra
and tab_idioma=ws_idioma
and tab_keynac=ws_nacion
and extract(year from tab_fecfin) = extract(year from ld_fecgra)+1;
exception when no_data_found then
ln_fom_tab_act := 0;
ln_tabact := 0;
end;
--insert into glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) values ('RETRO',ln_sec_cry,wi_keyrph,'05',ws_puesto,ln_keyemp);
--tabulador anterior
begin
select (round(max(tab_import) * 0.0300) * wn_numcap),max(tab_import)
into strict ln_fom_tab_ant,ln_tabant
from usrsiho.holotabs
where tab_keypro=138
and tab_keytab=ln_keytab
and tab_keypue=ws_puesto
--and tab_pertra=ws_pertra
and (tab_pertra)::numeric <=ln_pertra
and tab_idioma=ws_idioma
and tab_keynac=ws_nacion
and extract(year from tab_fecfin) = extract(year from ld_fecgra);
exception when no_data_found then
ln_fom_tab_ant := 0;
ln_tabant := 0;
end;
if ln_fom_tab_act>0 and ln_fom_tab_ant>0 then
--insert into glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) values ('RETRO',ln_sec_cry,wi_keyrph,'06',ws_puesto,ln_keyemp);
begin
select count(*)
into strict ln_sihay
from usrsiho.holotabs
where tab_keypro=138
and tab_keytab=5
and tab_keypue=ws_puesto;
exception when no_data_found then
ln_sihay := 0;
end;
if ln_sihay > 0 then
--insert into glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006) values ('RETRO',ln_sec_cry,wi_keyrph,'07',ws_puesto,ln_keyemp);
begin
select coalesce(det_cosuni,0)
into strict ln_tabpag
from usrsiho.holodettra
where det_num_id=(select oracle.substr(enc_descap,24,5)
from usrsiho.holoenctra
where enc_num_id in (select distinct det_num_id
from usrsiho.holodettra
where det_keyrph=wi_keyrph
and det_keyemp=ln_keyemp
and det_stsreg='V'))
and det_keyemp=ln_keyemp
and det_keypue=ws_puesto
and det_stsreg='V';
exception when no_data_found then
ln_tabpag := 0;
end;
if ln_tabpag=ln_tabant then
ln_suma := ln_fom_tab_act - ln_fom_tab_ant;
else
ln_suma := round(wn_costot * 0.0300) * wn_numcap;
end if;
else
ln_suma := ln_fom_tab_act - ln_fom_tab_ant;
end if;
else
--para las actividades que no tienen tabulador, calcular la diferencia del fomento con el costo anterior
-- y el fomento con el costo nuevo
--obtener el rph anterior
begin
select distinct det_keyrph  --rph anterior
into strict ln_rph_ant
from usrsiho.holodettra
where det_num_id=(select (oracle.substr(enc_descap,23,8))::numeric   --ht anterior
from usrsiho.holoenctra
where enc_num_id=(select distinct det_num_id
from usrsiho.holodettra
where det_keyrph = wi_keyrph
and det_keyemp = ln_keyemp
)
)  --ht neva
and det_keyemp = ln_keyemp
and det_stsreg='V';
exception when no_data_found then
ln_rph_ant := 0;
end;
--del rph anterior obtener el costo
begin
select max(hgd_costog)
into strict wn_costot
from usrsiho.holohgdp
where hgd_keyrph = ln_rph_ant
and hgd_keyemp = ln_keyemp
and hgd_keypue = ws_puesto;
exception when no_data_found then
wn_costot := 0;
end;
ln_fom_tab_ant := round(wn_costot * 0.0300) * wn_numcap;
ln_fom_tab_act := round(wn_costot * (1 + (ld_ptjeretro / 100)) * 0.03) * wn_numcap;
ln_suma := ln_fom_tab_act - ln_fom_tab_ant;
end if;
end if;
end if;   --solo retroactivo
--**********termina busca si es un rph de ********** retroactivo ***********   jdcm
--insert into glwkcrys (cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006,cry_dec007) values ('RETRO_FOM',ln_sec_cry,wi_keyrph,'07',ws_puesto,ln_keyemp,ln_suma);
-- eljm 16.03.2021 se quita hf1 y hf2 para la nomina 109
if ln_keynom <> 109 then
-- insercion de los fomentos por cada registro obtenido
insert into usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados,
inc_numfol,inc_keyinc,inc_diasie,inc_diasei)
values (wn_proceso,ws_periodo,ln_keyemp,'HF1',ls_keydep,
li_keypue,ln_suma,ln_tipcam,ld_fechasys,null,null,
wi_keyrph,ws_numsec,wn_costot,incremento);
incremento:= incremento + 1;
insert into usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_cantid, inc_fecmov,inc_diauno,inc_diados,
inc_numfol,inc_keyinc,inc_diasie,inc_diasei)
values (wn_proceso,ws_periodo,ln_keyemp,'HF2',ls_keydep,li_keypue1,ln_suma,ln_tipcam,ld_fechasys,
null,null,
wi_keyrph,ws_numsec,wn_costot,incremento);
incremento:= incremento + 1;
end if;
end if;
end loop;
--*********************nominas  113 y 213 ***********************
-------calculo codigo eje
--jdcm se obtiene la nomina
begin
select per_keynom
into strict ln_keynom
from usrsiho.nmloperi
where per_keypro=wn_proceso
and per_keyper=ws_periodo;
exception when no_data_found then
ln_keynom := 0;
end;
--jdcm termina se obtiene la nomina
-- jdcm obtiene el porcentaje de iva
begin
select coalesce((pam_folini)::numeric ,0)
into strict ln_por_iva
from usrsiho.glcopams
where pam_keypar in (select pam_folini
from usrsiho.glcopams
where pam_cvesec = 'pdesin')
and pam_cvesec = 'OPCI10';
exception when no_data_found then
ln_por_iva := 0;
end;
if ln_por_iva = 0 then
ln_por_iva := 0.16;
end if;
ln_por_iva := ln_por_iva/100;
-- jdcm termina obtiene el porcentaje de iva
--jdcm obtiene el % repeticion para el concepto set
begin
select coalesce((pam_nompar)::numeric ,0)
into strict ln_por_rep
from usrsiho.glcopams
where pam_keypar in (select pam_folini
from usrsiho.glcopams
where pam_cvesec = 'pdesin')
and pam_folini = 'Porc_Repet'
and pam_folfin = ln_keynom;
exception
when no_data_found then
ln_por_rep := 0;
end;
if ln_por_rep = 0 then
ln_por_rep:=0.12;
end if;
ln_por_rep := ln_por_rep/100;
-- jdcm obtiene el % repeticion para el concepto set
--jdcm busca si existe parametrizado concepto iva para la nomina que se esta ejecutando
ls_con_iva := '000';
begin
select pam_nompar
into strict ls_con_iva
from usrsiho.glcopams
where pam_keypar in (select pam_folini
from usrsiho.glcopams
where pam_cvesec = 'pdesin')
and pam_folini='Concepto_IVA'
and pam_folfin=ln_keynom;
exception
when no_data_found then
ls_con_iva := '000';
end;
--jdcm termina busca si existe parametrizado concepto iva
--jdcm busca si existe parametrizado concepto set para la nomina que se esta ejecutando
ls_con_rep := '000';
begin
select pam_nompar
into strict ls_con_rep
from usrsiho.glcopams
where pam_keypar in (select pam_folini
from usrsiho.glcopams
where pam_cvesec = 'pdesin')
and pam_folini='Concepto_Repet'
and pam_folfin=ln_keynom;
exception
when no_data_found then
ls_con_rep := '000';
end;
--jdcm termina busca si existe parametrizado concepto set
--jdcm busca si existe parametrizado concepto se2 para la nomina que se esta ejecutando
ls_con_repcs := '000';
begin
select pam_nompar
into strict ls_con_repcs
from usrsiho.glcopams
where pam_keypar in (select pam_folini
from usrsiho.glcopams
where pam_cvesec = 'pdesin')
and pam_folini='Conc_Repet_CS'
and pam_folfin=ln_keynom;
exception
when no_data_found then
ls_con_repcs := '000';
end;
--jdcm termina busca si existe parametrizado concepto se2
for rec7 in (select gdp.gdp_keycon,gdp.gdp_keypue,
frp.frp_keydep,sum(gdp.gdp_cosuni*gdp.gdp_numcap) suma,
frp.frp_tipcam,pue_ca3aux
from  	usrsiho.hologdpr gdp,usrsiho.glwkcrys cry,usrsiho.holofrph frp,usrsiho.nmcopues pue
where  	frp.frp_keyrph = gdp.gdp_keyrph and
gdp.gdp_keyrph = cry.cry_numsec and
cry.cry_nomrep = 'HODESINC' and
cry.cry_keyusu = wn_usuario and
gdp.gdp_keypue = pue.pue_keypue and
cry.cry_idepcc = ws_terminal and
frp.frp_stsfol <> 2 and
frp.frp_keynom=113 and     --jdcm comenta linea con nomina fija
-- frp.frp_keynom=ln_keynom and --jdcm agrega variable nomina
gdp.gdp_cosuni >= 0.01
group by gdp.gdp_keycon,gdp.gdp_keypue,frp.frp_keydep,frp.frp_tipcam,pue_ca3aux) loop
ls_keycon := rec7.gdp_keycon;
li_keypue := rec7.gdp_keypue;
ls_keydep := rec7.frp_keydep;
ln_suma := rec7.suma;
ln_tipcam := rec7.frp_tipcam;
ls_diauno := rec7.pue_ca3aux;
if ls_con_iva <> '000' then --jdcm condicion para insertar concepto iva
li_keyemp := 0;
-- eljm codigo para nomina 113 --
-- ln_keyemp := 490195711;
if ln_keynom = 113 then
ln_keyemp := 195711;
else
-- eljm codigo para nomina 109
-- ln_keyemp := 490195711;
ln_keyemp := 83496;
end if;
-- let ln_suma = ln_suma * 0.15;
-- let ln_suma = ln_suma * 0.16;
ln_suma := ln_suma * ln_por_iva;  --jdcm reemplaza linea de arriba por esta
/* dmap converted statement start */
--- inserccion por cada registro obtenido
insert into
usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
--values(wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
values (wn_proceso,ws_periodo,ln_keyemp,ls_con_iva,ls_keydep,  --jdcm reemplazo linea de arriba por esta
li_keypue,ln_suma,ld_fechasys,ln_tipcam,(rtrim(ls_diauno::text))::numeric );/* dmap converted statement end */
ln_suma := 0;
end if;
end loop;
-- calculo conceptos segunda trasmision 12%
-- -------------------------------------------------------------------------------------------------------
for rec8 in
(select gdp.gdp_keyrph,gdp.gdp_keyemp,gdp.gdp_keycon,gdp.gdp_keypue,frp.frp_keydep,
(gdp.gdp_cosuni*gdp.gdp_numcap) producto,frp.frp_tipcam,pue_ca3aux
from   	usrsiho.hologdpr gdp,usrsiho.glwkcrys cry,usrsiho.holofrph frp,usrsiho.nmcopues pue
where  	frp.frp_keyrph = gdp.gdp_keyrph and
gdp.gdp_keyrph = cry.cry_numsec and
cry.cry_nomrep = 'HODESINC' and
cry.cry_keyusu = wn_usuario and
gdp.gdp_keypue = pue.pue_keypue and
cry.cry_idepcc = ws_terminal and
frp.frp_stsfol <> 2 and
--frp.frp_keynom=113 and      --jdcm comenta linea con nomina fija
frp.frp_keynom=ln_keynom and  --jdcm agrega variable nomina
gdp.gdp_cosuni >= 0.01 and
--gdp.gdp_keycon='H82'        --jdcm comenta linea con concepto fijo
gdp.gdp_keycon in (select 	pam_nompar
from 	usrsiho.glcopams
where	pam_keypar in (select pam_folini
from usrsiho.glcopams
where pam_cvesec = 'pdesin')
and pam_folini = 'Base_Para_Repet'
and pam_folfin = (select per_keynom
from usrsiho.nmloperi
where per_keypro = wn_proceso
and per_keyper = ws_periodo))) loop
ln_keyrph := rec8.gdp_keyrph;
ln_keyemp := rec8.gdp_keyemp;
ls_keycon := rec8.gdp_keycon;
li_keypue := rec8.gdp_keypue;
ls_keydep := rec8.frp_keydep;
ln_suma := rec8.producto;
ln_tipcam := rec8.frp_tipcam;
ls_diauno := rec8.pue_ca3aux;
if ls_con_rep <> '000' then --jdcm condicion para insertar concepto set
--let ln_suma = ln_suma * 0.12;
ln_suma := ln_suma * ln_por_rep;   --jdcm reemplazo esta linea por la de arriba
/* dmap converted statement start */
--- inserccion por cada registro obtenido
insert into
usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
--values(wn_proceso,ws_periodo,ln_keyemp,'SET',ls_keydep,
values (wn_proceso,ws_periodo,ln_keyemp,ls_con_rep,ls_keydep,   --jdcm reemplaza linea de arriba por esta
li_keypue,ln_suma,ld_fechasys,ln_keyrph,(rtrim(ls_diauno::text))::numeric );/* dmap converted statement end */
end if;
if ls_con_iva <> '000' then  --jdcm condicion para insertar concepto iva
--let ln_suma = ln_suma * 0.15;
--let ln_suma = ln_suma * 0.16;
ln_suma := ln_suma * ln_por_iva;  --jdcm reemplaza linea de arriba por esta
-- eljm codigo para nomina 113 --
ln_keyemp := 195711;/* dmap converted statement start */
-- if ln_keynom = 113 then
-- 	ln_keyemp := 195711;
-- else
-- 	ln_keyemp := 490195711;
-- end if;
-- -----------------------------------------------
--- inserccion por cada registro obtenido
insert into
usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
--values(wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
values (wn_proceso,ws_periodo,ln_keyemp,ls_con_iva,ls_keydep,  --jdcm reemplazo linea de arriba por esta
li_keypue,ln_suma,ld_fechasys,ln_keyrph,(rtrim(ls_diauno::text))::numeric );/* dmap converted statement end */
ln_suma := 0;
end if;
end loop;
for rec9 in (select gdp.gdp_keyrph,gdp.gdp_keyemp,gdp.gdp_keycon,gdp.gdp_keypue,
frp.frp_keydep,(gdp.gdp_cosuni*gdp.gdp_numcap) producto,
frp.frp_tipcam,pue_ca3aux
from   usrsiho.hologdpr gdp,usrsiho.glwkcrys cry,usrsiho.holofrph frp,usrsiho.nmcopues pue
where  frp.frp_keyrph = gdp.gdp_keyrph and
gdp.gdp_keyrph = cry.cry_numsec and
cry.cry_nomrep = 'HODESINC' and
cry.cry_keyusu = wn_usuario and
gdp.gdp_keypue = pue.pue_keypue and
cry.cry_idepcc = ws_terminal and
frp.frp_stsfol <> 2 and
--frp.frp_keynom=113 and      --jdcm comenta linea con nomina fija
frp.frp_keynom=ln_keynom and  --jdcm agrega variable nomina
gdp.gdp_cosuni >= 0.01 and
--gdp.gdp_keycon='CSR'        --jdcm comenta linea con concepto fijo
gdp.gdp_keycon in (select pam_nompar
from usrsiho.glcopams
where pam_keypar in (select pam_folini
from usrsiho.glcopams
where pam_cvesec = 'pdesin')
and pam_folini = 'Base_Repet_CS'
and pam_folfin = (select per_keynom
from usrsiho.nmloperi
where per_keypro = wn_proceso
and per_keyper = ws_periodo))) loop
ln_keyrph := rec9.gdp_keyrph;
ln_keyemp := rec9.gdp_keyemp;
ls_keycon := rec9.gdp_keycon;
li_keypue := rec9.gdp_keypue;
ls_keydep := rec9.frp_keydep;
ln_suma := rec9.producto;
ln_tipcam := rec9.frp_tipcam;
ls_diauno := rec9.pue_ca3aux;
if ls_con_repcs <> '000' then --jdcm condicion para insertar concepto se2
--let ln_suma = ln_suma * 0.12;
ln_suma := ln_suma * ln_por_rep;   --jdcm reemplazo esta linea por la de arriba
/* dmap converted statement start */
--- inserccion por cada registro obtenido
insert into
usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
--values(wn_proceso,ws_periodo,ln_keyemp,'SE2',ls_keydep,
values (wn_proceso,ws_periodo,ln_keyemp,ls_con_repcs,ls_keydep,   --jdcm reemplaza linea de arriba por esta
li_keypue,ln_suma,ld_fechasys,ln_keyrph,(rtrim(ls_diauno::text))::numeric );/* dmap converted statement end */
end if;
if ls_con_iva <> '000' then --jdcm condicion para insertar concepto iva
--let ln_suma = ln_suma * 0.15;
--let ln_suma = ln_suma * 0.16;
ln_suma := ln_suma * ln_por_iva;  --jdcm reemplaza linea de arriba por esta
-- eljm codigo para nomina 113 --
-- ln_keyemp := 490195711;
ln_keyemp := 195711;/* dmap converted statement start */
-- if ln_keynom = 113 then
--	ln_keyemp := 195711;
-- else
--	ln_keyemp := 490195711;
-- end if;
-- -----------------------------------------------
--- inserccion por cada registro obtenido
insert into
usrsiho.nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
--values(wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
values (wn_proceso,ws_periodo,ln_keyemp,ls_con_iva,ls_keydep,  --jdcm reemplazo linea de arriba por esta
li_keypue,ln_suma,ld_fechasys,ln_keyrph,(rtrim(ls_diauno::text))::numeric );/* dmap converted statement end */
ln_suma := 0;
end if;
end loop;
--*************jdcm
-------calcula conceptos iva 16% para la andi
-- ig-andi, eje, musicos
-- comentado para c??lculo del pbe y pbi
-- foreach select 490083496,'600999',1000,0,'',frp.frp_keynom,sum(gdp.gdp_cosuni*gdp.gdp_numcap)*.16
--    into  ln_keyemp,ls_keydep,li_keypue,ln_keyrph,ls_diauno,ln_keynom,ln_suma
--    from hologdpr gdp,glwkcrys cry,holofrph frp,nmcopues pue
--   where frp.frp_keyrph = gdp.gdp_keyrph and
--         gdp.gdp_keyrph = cry.cry_numsec and
--         cry.cry_nomrep = 'HODESINC' and
--         cry.cry_keyusu = wn_usuario and
--         gdp.gdp_keypue = pue.pue_keypue and
--         cry.cry_idepcc = ws_terminal    and
--         frp.frp_stsfol <> 2 and
--         frp.frp_keynom=109 and
--         gdp.gdp_cosuni >= 0.01 and
--         gdp.gdp_keycon in('H93','HA4')
--   group by frp.frp_keynom
--     if ln_keynom = 109 then
--        let ln_keyemp = 490083496;
--            --- inserccion por cada registro obtenido
--                insert into
--                    nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
--                             inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
--                              values(wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
--                     li_keypue,ln_suma,ld_fechasys,ln_keyrph,ls_diauno);
--        let ln_suma = 0;
--     end if
--   end foreach
-- comentado para c??lculo del pbe y pbi
if ln_keynom = 109 then
-- construye regimen fiscal
-- -----------------------------------------------------------------
begin
select  trim(both pam_nompar) into strict valores		-- 001,002
from    glcopams
where   pam_keypar='Z037'
and pam_cvesec = 'OPCI14'
and pam_folini = 'Regimen Fiscal'
and pam_folfin = '109';
exception when no_data_found then valores:= null;
end;
--create temp table regfis ( reg varchar(40) );
posincad := 1;
valor:= null;/* dmap converted statement start */
while( posincad <= length(valores)) loop
if ( oracle.substr( valores, posincad, 1) <> ',') then
valor := concat( trim(both valor), oracle.substr( valores, posincad, 1)) ;/* dmap converted statement end */
else
if ( length(valor) > 0 ) then
insert into regfis(reg) values (valor);
valor:= null;
end if;
end if;
posincad := posincad + 1;
end loop;
if ( length(valor) > 0 ) then
insert into regfis(reg) values (valor);
valor:= null;
end if;
-- construye base_grav_musico
-- ---------------------------------------------------------------------
begin
select 	trim(both pam_nompar) into strict valores		-- h93,ha4,ha7,hf4,h82
from   	glcopams
where  	pam_keypar='Z037'
and 	pam_cvesec = 'OPCI15'
and 	pam_folini = 'Base_Grav_Musico'
and 	pam_folfin = '109';
exception when no_data_found then valores:= null;
end;
-- create temp table conceptos( con varchar(40) );
posincad := 1;
valor:= null;/* dmap converted statement start */
while( posincad <= length(valores)) loop
if ( oracle.substr( valores, posincad, 1) <> ',') then
valor := concat( trim(both valor), oracle.substr( valores, posincad, 1)) ;/* dmap converted statement end */
else
if ( length(valor) > 0 ) then
insert into conceptos(con) values (valor);
valor:= null;
end if;
end if;
posincad := posincad + 1;
end loop;
if ( length(valor) > 0 ) then
insert into conceptos(con) values (valor);
valor:= null;
end if;
for rec10 in (select frp.frp_keynom,sum(gdp.gdp_cosuni*gdp.gdp_numcap)*.16 suma
from  	hologdpr gdp,glwkcrys cry,holofrph frp,nmcopues pue,nmcoempl
where   frp.frp_keyrph = gdp.gdp_keyrph and
gdp.gdp_keyrph = cry.cry_numsec and
cry.cry_nomrep = 'HODESINC' and
cry.cry_keyusu = wn_usuario and
gdp.gdp_keypue = pue.pue_keypue and
cry.cry_idepcc = ws_terminal    and
frp.frp_stsfol <> 2 and
-- frp.frp_keynom = 109 and
frp.frp_keynom = ln_keynom and
gdp.gdp_cosuni >= 0.01 and
-- gdp.gdp_keycon in ( select con from conceptos ) and
gdp.gdp_keycon in ( 'H93','HA4','ha7','hf4','H82') and
emp_keyemp = gdp_keyemp -- and
-- emp_ca2aux not in ( select  reg from regfis )
-- emp_ca2aux not in ('001','002')
group by frp.frp_keynom) loop
-- eljm 10.01.2023
-- ln_keyemp := 490083496;
ln_keyemp := 83496;
ls_keydep := '600999';
li_keypue := 1000;
ln_keyrph := 0;
ls_diauno:= null;
ln_keynom := rec10.frp_keynom;
ln_suma := rec10.suma;/* dmap converted statement start */
--- inserccion por cada registro obtenido
insert into nmcoinci(
inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
values (
wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
li_keypue,ln_suma,ld_fechasys,ln_keyrph,(rtrim(ls_diauno::text))::numeric );/* dmap converted statement end */
end loop;		-- ciclo de for rec10
-- calcula el pbi
-- ----------------------------------------------------------------------------------
if ln_suma > 0 and ln_keynom = 109 then
begin
select  sum(gdp.gdp_cosuni * gdp.gdp_numcap)
into strict    ln_suma
from  	hologdpr gdp,glwkcrys cry,holofrph frp,nmcopues pue, nmcoempl
where   frp.frp_keyrph = gdp.gdp_keyrph and
gdp.gdp_keyrph = cry.cry_numsec and
cry.cry_nomrep = 'HODESINC' and
cry.cry_keyusu = wn_usuario and
gdp.gdp_keypue = pue.pue_keypue and
cry.cry_idepcc = ws_terminal and
frp.frp_stsfol <> 2 and
frp.frp_keynom = ln_keynom and
gdp.gdp_cosuni >= 0.01 and
-- gdp.gdp_keycon in ( select con from conceptos ) and
gdp.gdp_keycon in ( 'H93','HA4','ha7','hf4','H82') and
emp_keyemp = gdp_keyemp; -- and
-- emp_ca2aux not in   ( select  reg from regfis );
-- emp_ca2aux not in  ('001','002' );
exception when no_data_found then ln_suma := 0;
end;
li_keyemp := 0;
-- ln_keyemp := 490083496;
ln_keyemp := 83496;/* dmap converted statement start */
insert into nmcoinci(
inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno, inc_diados)
values (
wn_proceso,ws_periodo,ln_keyemp,'PBI',ls_keydep,
li_keypue,ln_suma,ld_fechasys,ln_tipcam,(rtrim(ls_diauno::text))::numeric ,8);/* dmap converted statement end */
end if;
-- calcula el pbe
-- ------------------------------------------------------------------------------
if ln_suma > 0 and ln_keynom = 109 then
begin
select  sum(gdp.gdp_cosuni*gdp.gdp_numcap)
into strict  	ln_suma
from  	hologdpr gdp,glwkcrys cry,holofrph frp,nmcopues pue, nmcoempl
where   frp.frp_keyrph = gdp.gdp_keyrph and
gdp.gdp_keyrph = cry.cry_numsec and
cry.cry_nomrep = 'HODESINC' and
cry.cry_keyusu = wn_usuario and
gdp.gdp_keypue = pue.pue_keypue and
cry.cry_idepcc = ws_terminal and
frp.frp_stsfol <> 2 and
frp.frp_keynom=ln_keynom and
gdp.gdp_cosuni >= 0.01 and
-- gdp.gdp_keycon in ( select con from conceptos ) and
gdp.gdp_keycon in ( 'H93','HA4','ha7','hf4','H82') and
emp_keyemp = gdp_keyemp and
-- emp_ca2aux in   ( select  reg from regfis );
emp_ca2aux in ('001','002' );
exception when no_data_found then ln_suma := 0;
end;
li_keyemp := 0;
ln_keyemp := 490083496;/* dmap converted statement start */
insert into nmcoinci(
inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno, inc_diados)
values (
wn_proceso,ws_periodo,ln_keyemp,'PBE',ls_keydep,
li_keypue,ln_suma,ld_fechasys,ln_tipcam,(rtrim(ls_diauno::text))::numeric ,8);/* dmap converted statement end */
ln_suma := 0;
end if;
end if;
-- nomina 110 anda
-- -----------------------------------------------------
begin
select per_keynom
into strict ln_keynom
from nmloperi
where per_keypro=wn_proceso
and per_keyper=ws_periodo;
exception when no_data_found then ln_keynom := 0;
end;
-- insert into paso values('sp_hrpdesin','','',1,'','');
if ln_keynom = 110 then
--insert into paso values('sp_hrpdesin','','',2,'','');
---********percepcion base iva  e  iva 16%  sin extranjeros 25% **********010311 se sustituyo cc 600999 x un 0
--foreach select 490041032,'0',1000,0,'',frp.frp_keynom,sum(gdp.gdp_cosuni*gdp.gdp_numcap),sum(gdp.gdp_cosuni*gdp.gdp_numcap)*.16
begin
select 	490041032,'0',1000,0,'',frp.frp_keynom,sum(gdp.gdp_cosuni*gdp.gdp_numcap),sum(gdp.gdp_cosuni*gdp.gdp_numcap)*.16
into strict  	ln_keyemp, ls_keydep, li_keypue, ln_keyrph, ls_diauno, ln_keynom, ln_base_iva1 , ln_suma
from 	hologdpr gdp,glwkcrys cry,holofrph frp,nmcopues pue, nmcoempl emp
where 	frp.frp_keyrph = gdp.gdp_keyrph
and 	gdp.gdp_keyrph = cry.cry_numsec
and 	cry.cry_nomrep = 'HODESINC'
and 	cry.cry_keyusu = wn_usuario
and 	gdp.gdp_keypue = pue.pue_keypue
and 	cry.cry_idepcc = ws_terminal
and 	gdp.gdp_keyemp = emp.emp_keyemp
and 	emp.emp_ca2aux not in ('107')
and 	frp.frp_stsfol <> 2
and 	frp.frp_keynom=110
and 	gdp.gdp_cosuni >= 0.01
and 	gdp.gdp_keycon in ('HA4','h15','ha6','ha7','he4','HF1','HF2','hti','hit')
group by frp.frp_keynom;
exception when no_data_found then
ln_keyemp := 490041032;
ls_keydep := '0';
li_keypue := 1000;
ln_keyrph := 0;
ls_diauno:= null;
ln_keynom := 0;
ln_base_iva1 := 0;
ln_suma := 0;
end;
--insert into paso values('sp_hrpdesin','','',3,'','');
ln_keyemp := 490041032;/* dmap converted statement start */
-- inserccion por cada registro obtenido
if ln_suma > 0 then
insert into nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
values (wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
li_keypue,ln_suma,ld_fechasys,ln_keyrph,(rtrim(ls_diauno::text))::numeric );/* dmap converted statement end */
end if;
ln_suma := 0;
--insert into paso values('sp_hrpdesin','','',4,'','');
--iva fomentos
begin
select 	490041032,'0',1000,0,'',110,sum(inc_import),sum(inc_import)*.16
into strict  	ln_keyemp,ls_keydep,li_keypue,ln_keyrph,ls_diauno,ln_keynom,ln_base_iva2, ln_suma
from 	nmcoinci,nmcoempl
where 	inc_keyemp=emp_keyemp
and 	emp_ca2aux not in ('107')
and 	inc_keypro=138
and 	inc_keyper=ws_periodo
and 	inc_keycon in ('HF1','HF2');
exception when no_data_found then
ln_keyemp := 490041032;
ls_keydep := '0';
li_keypue := 1000;
ln_keyrph := 0;
ls_diauno:= null;
ln_keynom := 0;
ln_base_iva1 := 0;
ln_suma := 0;
end;
ln_keyemp := 490041032;/* dmap converted statement start */
--- inserccion por cada registro obtenido
if ln_suma > 0 then
insert into nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
values (wn_proceso,ws_periodo,ln_keyemp,'IVA',ls_keydep,
li_keypue,ln_suma,ld_fechasys,ln_keyrph,(rtrim(ls_diauno::text))::numeric );/* dmap converted statement end */
end if;
--- aedo 23-02-2011
--- inserccion por cada registro obtenido para el pbi
--- percepcisn base iva  = percepciones de empleados con situacisn fiscal diferente a .25% extranjeros.
ln_suma := 0;
ln_suma := ln_base_iva1 + ln_base_iva2;/* dmap converted statement start */
if ln_suma > 0 then
insert into nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
values (wn_proceso,ws_periodo,ln_keyemp,'PBI',ls_keydep,
li_keypue,ln_suma,ld_fechasys,ln_keyrph,(rtrim(ls_diauno::text))::numeric );/* dmap converted statement end */
end if;
-- *******************percepcion base exenta***********************
ln_base_exenta1 := 0;
ln_base_exenta2 := 0;
---solo extranjeros 25%     per_base_exenta
begin
select  490041032,'0',1000,0,'',frp.frp_keynom,sum(gdp.gdp_cosuni*gdp.gdp_numcap)
into strict 	ln_keyemp, ls_keydep, li_keypue, ln_keyrph, ls_diauno, ln_keynom, ln_base_exenta1
from 	hologdpr gdp,glwkcrys cry,holofrph frp,nmcopues pue, nmcoempl emp
where 	frp.frp_keyrph = gdp.gdp_keyrph
and 	gdp.gdp_keyrph = cry.cry_numsec
and 	cry.cry_nomrep = 'HODESINC'
and 	cry.cry_keyusu = wn_usuario
and 	gdp.gdp_keypue = pue.pue_keypue
and 	cry.cry_idepcc = ws_terminal
and 	gdp.gdp_keyemp = emp.emp_keyemp
and 	emp.emp_ca2aux in ('107')
and 	frp.frp_stsfol <> 2
and 	frp.frp_keynom = 110
and 	gdp.gdp_cosuni >= 0.01
and 	gdp.gdp_keycon in ('HA4','h15','ha6','ha7','he4','HF1','HF2','hti','hit')
group by frp.frp_keynom;
exception when no_data_found then
ln_keyemp := 490041032;
ls_keydep := '0';
li_keypue := 1000;
ln_keyrph := 0;
ls_diauno:= null;
end;
-- ig-cons-0823
-- comenta para cambio de separar base exenta de cuota de transito
-- cuota de transito                     per_base_exenta_ct
-- select 490041032,'0',1000,0,'',110,sum(inc_import)
--   into ln_keyemp,ls_keydep,li_keypue,ln_keyrph,ls_diauno,ln_keynom,ln_base_exenta2
--   from nmcoinci
--  where inc_keypro = 138
--    and inc_keyper = ws_periodo
--    and inc_keycon = 'H42';
-- termina comenta para cambio de separar base exenta de cuota de transito
----*******************base fomentos exentos***********************
----fomentos   solo extranjeros 25%       base_fomentos_exenta
ln_base_fomentos := 0;
begin
select    490041032,'0',1000,0,'',110,sum(inc_import)
into strict      ln_keyemp,ls_keydep,li_keypue,ln_keyrph,ls_diauno,ln_keynom,ln_base_fomentos
from      nmcoinci,nmcoempl
where     inc_keyemp = emp_keyemp
and emp_ca2aux in ('107')
and inc_keypro = 138
and inc_keyper = ws_periodo
and inc_keycon in ('HF1','HF2');
exception when no_data_found then
ln_keyemp := 490041032;
ls_keydep := '0';
li_keypue := 1000;
ln_keyrph := 0;
ln_keyrph:= null;
ln_keynom := 0;
ln_base_fomentos := 0;
end;
--- aedo 23-02-2011
--- inserccion por cada registro obtenido para el pbe
--- pbe    percepcisn base exenta = cuotas de transito + percepciones de empleados con situacisn fiscal .25% extranjeros.
--- ig-cons-0823 cambia: percepcisn base exenta = base fomentos excentos + percepciones de empleados con situacisn fiscal .25% extranjeros.
ln_suma := 0;
if nullif(ln_base_exenta1::text, '') is null then
ln_base_exenta1 := 0;
end if;
--ig-cons-0823
--comenta para cambio de separar base exenta de cuota de transito
-- if ln_base_exenta2 is null then
--     let ln_base_exenta2 = 0;
-- end if
-- let ln_suma = ln_base_exenta1 + ln_base_exenta2;
--termina comenta para cambio de separar base exenta de cuota de transito
--ig-cons-0823
--substituye para cambio sumar pbe con bfe
if nullif(ln_base_fomentos::text, '') is null then
ln_base_fomentos := 0;
end if;
ln_suma := ln_base_exenta1 + ln_base_fomentos;/* dmap converted statement start */
--substituye para cambio sumar pbe con bfe
if ln_suma > 0 then
insert into nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
values (wn_proceso,ws_periodo,ln_keyemp,'PBE',ls_keydep,
li_keypue,ln_suma,ld_fechasys,ln_keyrph,(rtrim(ls_diauno::text))::numeric );/* dmap converted statement end */
end if;
----*******************cuota de transito exenta***********************
--ig-cons-0823
--inserta para cambio de separar base exenta de cuota de transito y adicionarla con el nuevo concepto auxiliar
---cuota de transito                     per_base_exenta_ct
begin
select  490041032,'0',1000,0,'',110,sum(inc_import)
into strict    ln_keyemp,ls_keydep,li_keypue,ln_keyrph,ls_diauno,ln_keynom,ln_base_exenta2
from    nmcoinci
where   inc_keypro = 138
and 	inc_keyper = ws_periodo
and 	inc_keycon = 'H42';
exception when no_data_found then
ln_keyemp := 490041032;
ls_keydep := '0';
li_keypue := 1000;
ln_keyrph := 0;
ln_keyrph:= null;
ln_keynom := 110;
end;
if nullif(ln_base_exenta2::text, '') is null then
ln_base_exenta2 := 0;
end if;/* dmap converted statement start */
if ln_base_exenta2 > 0 then
insert into nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
values (wn_proceso,ws_periodo,ln_keyemp,'CTA',ls_keydep,
li_keypue,ln_base_exenta2,ld_fechasys,ln_keyrph,(rtrim(ls_diauno::text))::numeric );/* dmap converted statement end */
end if;
-- termina inserta para cambio de separar base exenta de cuota de transito y adicionarla con el nuevo concepto auxiliar
----*******************base fomentos exentos***********************
---- fomentos   solo extranjeros 25%       base_fomentos_exenta
-- ig-cons-0823
-- comentado para cambio cambio sumar pbe con bfe
-- let ln_base_fomentos = 0;
--  select 490041032,'0',1000,0,'',110,sum(inc_import)
--    into ln_keyemp,ls_keydep,li_keypue,ln_keyrph,ls_diauno,ln_keynom,ln_base_fomentos
--    from nmcoinci,nmcoempl
--   where inc_keyemp = emp_keyemp
--     and emp_ca2aux in('107')
--     and inc_keypro = 138
--     and inc_keyper = ws_periodo
--     and inc_keycon in('HF1','HF2');
--   if ln_base_fomentos > 0 then
--      insert into nmcoinci(inc_keypro,inc_keyper,inc_keyemp,inc_keycon,inc_keydep,
--                           inc_keypue,inc_import,inc_fecmov,inc_cantid,inc_diauno)
--                    values(wn_proceso,ws_periodo,ln_keyemp,'BFE',ls_keydep,
--                           li_keypue,ln_base_fomentos,ld_fechasys,ln_keyrph,ls_diauno);
--   end if
-- termina comentado para cambio cambio sumar pbe con bfe
-- se limpian las variables
ln_base_iva1 := 0;
ln_base_iva2 := 0;
ln_base_exenta1 := 0;
ln_base_exenta2 := 0;
ln_base_fomentos := 0;
ln_suma := 0;
-- end foreach;
end if;
-- actualzacion de rph
update 	holofrph
set 	frp_stsfol='1',
frp_keyper=ws_periodo,
frp_keypro=wn_proceso
where exists (	select 	cry_numsec
from 	glwkcrys cry
where 	cry_numsec = frp_keyrph and
cry.cry_nomrep = 'HODESINC' and
cry.cry_keyusu = wn_usuario and
cry.cry_idepcc = ws_terminal);
--elimincaion de registros de la tabla de paso
--delete  from glwkcrys  where cry_nomrep = 'HODESINC' and cry_keyusu = wn_usuario and cry_idepcc = ws_terminal;
end;
$body$
language plpgsql
;
