create or replace procedure usrsiho."sp_hrpcapau"  (ps_programa varchar, pi_tipcont varchar, pd_fecsol timestamp(0), pd_fechatrab timestamp(0), pi_capini smallint, pi_capfin smallint, pi_keyusu integer, pi_keynom smallint, ps_tiptra varchar, pi_forpag smallint, pd_fechaact timestamp(0), pl_unifor smallint, pl_transp smallint, pn_tipcam decimal, pn_keypro smallint, pd_fechatrabhas timestamp(0), pdk_keyare varchar, vi_valret inout integer) as $body$
-- se agrego pd_fechatrabdes para guardar la fecha hasta para el rph
-- ultima modificacion 12-abril-2004 cesar gonzalez sanchez
-- se agrego funcionalidad para que se puedan asignar varios conrtratos a un mismo rph
-- regresara el secuencial del rph y a continuacion los
-- secuenciales de los gdp's.
-- returning integer;
declare
-- pgv moved types start
-- pgv moved types end
li_secrph     integer;
li_secgdp     integer;
li_captot     integer;
li_numcap     integer;
li_capdis     integer;
li_plaza      integer;
li_empleado   integer;
li_tipcon     integer;
li_folio      integer;
ld_valor      decimal(16,2);
ld_costo      decimal(16,2);
ld_costototal decimal(16,2);
ls_puesto     varchar(16);
ls_keycon     varchar(4);
li_valsec     integer;
li_emptotal   decimal(15,0);
ws_equiva    varchar(1);
cur_01 record;
cur_02 record;
begin
li_secrph     := -1;
li_emptotal   := 0;
ld_costototal := 0;
vi_valret := 0;
if pi_keynom <> 102 then
-- dbms_output.put_line('entrar');
-- foreach
for cur_01
in (select con.con_keyemp, con.con_keytco,con.con_cosuni,
con.con_keypue,con.con_keyplz,con.con_keyfol,
con.con_numcdi, count(*) cuantos, onc.con_keycon
-- into   li_empleado, li_tipcon, ld_costo, ls_puesto,
--        li_plaza,li_folio,
--        li_capdis, li_numcap,ls_keycon
from   usrsiho.holocont con, usrsiho.holococa coc, usrsiho.nmloconc onc, usrsiho.nmcoempl empl,
usrsiho.nmcopues pues, usrsiho.holoalem ale
where  con.con_keydep = ps_programa and
con.con_keytco in (select contratos from usrsiho.contratos_tmp) and
con.con_stspag = 'V' and
con.con_fecini <= pd_fechatrab and (con.con_fecven >= pd_fechatrabhas or nullif(con.con_fecven::text, '') is null) and
con.con_keytva = 1 and
con.con_keyplz = coc.coc_keyplz and
coc.coc_stspag = 'V' and
nullif(coc.coc_keyrph::text, '') is null and
-- coc.coc_keygdp is null and
coc.coc_keycap between pi_capini and pi_capfin and
con.con_keyemp = empl.emp_keyemp and
empl.emp_keyemp = ale.ale_keyemp and                          -- nuevo emilio
con.con_keypue = pues.pue_keypue and
onc.con_keycon = pues.pue_ca5aux and
-- pues.pue_ca4aux[7]='1' and
oracle.substr(pues.pue_ca4aux, 7, 1) = '1' and
empl.emp_status = 1 and                                       -- and nuevo emilio
coalesce(ale.ale_keyem2,0) = 0                                   -- nuevo emilio
group by con.con_keyemp,con.con_keytco,con.con_cosuni,con.con_keypue,
con.con_keyplz,con.con_keyfol,con.con_numcdi,onc.con_keycon)
loop
--dbms_output.put_line('loop');
li_empleado := cur_01.con_keyemp;
li_tipcon   := cur_01.con_keytco;
ld_costo    := cur_01.con_cosuni;
ls_puesto   := cur_01.con_keypue;
li_plaza    := cur_01.con_keyplz;
li_folio    := cur_01.con_keyfol;
li_capdis   := cur_01.con_numcdi;
li_numcap   := cur_01.cuantos;
ls_keycon   := cur_01.con_keycon;
if li_numcap = pi_capfin - pi_capini + 1 then
-- inserccion del header
if li_secrph = -1 then
-- definicion de la equivalencia y concepto, dependiendo de la nomina
if pi_keynom = 102 then
ws_equiva := 'I';
begin
select cpf_keycof
into strict ls_keycon
from usrsiho.nmloconc,usrsiho.nmcopues,usrsiho.holocpfj
where pue_ca5aux = cpf_keycon and
cpf_keycon = con_keycon and
cpf_repeti = 'I' and
pue_keypue = ls_puesto;
exception when no_data_found then ls_keycon:= null;
end;
else
ws_equiva := 'N';
end if;
ld_valor := ld_costo;
---aedo  14/08/06   claudia islas pidio que se actualizara el campo frp_pertra con el valor 1, en lugar del null.
insert into usrsiho.holofrph(frp_keydep,frp_keyper,frp_fecact,frp_stsfol,
frp_totcos,frp_keyusu,frp_keynom,frp_repeti,
frp_tiptra,frp_fecsol,frp_fectrab,frp_forpag,
frp_pertra,frp_tipfol,frp_unifor,frp_transp,
frp_tipcam,frp_keypro,frp_fecitr,frp_keyare)
values (  ps_programa,null,pd_fechaact,'0'      ,
ld_valor ,pi_keyusu,pi_keynom,ws_equiva  ,
ps_tiptra,pd_fecsol,pd_fechatrabhas,pi_forpag,
1, 'N' ,pl_unifor,pl_transp  ,pn_tipcam,
pn_keypro,pd_fechatrab,pdk_keyare)
returning frp_keyrph into li_secrph;
-- lectura del secuencial del rph =>
-- li_secrph := dbinfo('SQLCA.SQLERRD1');
-- return li_secrph with resume;
--li_secrph := sqlcode;
--dbms_output.put_line('salida '||to_char(li_secrph));
vi_valret := li_secrph;
end if;
-- capitulos totales
li_captot := pi_capfin - pi_capini + 1;
-- insercion de gastos de produccion
ld_valor := ld_costo;
ld_costototal := ld_costototal + ld_valor  * ( pi_capfin - pi_capini + 1 );
li_emptotal := li_emptotal + li_empleado;
-- cesar gonzalez sanchez   abril 2004
-- se cambio pi_tipcont x li_tipcon  para que se puedan insertar los contratos que regrese el select
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_keypue,gdp_capini,
gdp_capfin,gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,
gdp_keysue,gdp_keytco,gdp_keyfol,gdp_minleg,gdp_minsal,gdp_minext,
gdp_mincom,gdp_keyusu)
values (               ps_programa,li_secrph,pd_fechatrab,li_empleado,ls_puesto,pi_capini,
pi_capfin  ,li_captot,ls_keycon   ,'S'        ,'S'      ,ld_valor ,
null       ,li_tipcon,li_folio   ,0          ,0        ,0        ,
0          ,pi_keyusu)
returning gdp_keysec into li_secgdp;
-- lectura del secuencial del  gdp =>
-- li_secgdp := dbinfo('SQLCA.SQLERRD1');
-- return li_secgdp with resume;
--li_secgdp := sqlcode;
--vi_valret := li_secgdp;
-- actualizacion de capitulos
update usrsiho.holococa
set coc_keyrph = li_secrph ,
coc_keygdp = li_secgdp
where coc_keyplz = li_plaza and
coc_keycap between pi_capini and pi_capfin;
-- actualizacion de contratos
update usrsiho.holocont
set con_numcdi = con_numcdi - ( pi_capfin - pi_capini + 1 )
where con_keyplz=li_plaza and
con_keytco=li_tipcon;
end if;
-- end foreach
end loop;
--si el cursor inserto un rph --> actualizar el total costo y el total empleado en este con las sumas de los detalles
if li_secrph > -1 then
update usrsiho.holofrph
set frp_totcos = ld_costototal,
frp_totemp = li_emptotal
where frp_keyrph = li_secrph;
end if;
else   -- cuando la nomina es 102 internos
-- foreach
for cur_02
in ( select con.con_keyemp, con.con_keytco, con.con_cosuni,
con.con_keypue,con.con_keyplz,con.con_keyfol,
con.con_numcdi, count(*) cuantos, onc.con_keycon
from   usrsiho.holocont con,usrsiho.holococa coc,usrsiho.nmloconc onc,usrsiho.nmcoempl empl,
usrsiho.nmcopues pues,usrsiho.holoalem ale
where  con.con_keydep=ps_programa and
con.con_keytco in (select contratos from usrsiho.contratos_tmp) and
con.con_stspag = 'V' and
con.con_fecini <= pd_fechatrab and (con.con_fecven >= pd_fechatrabhas or nullif(con.con_fecven::text, '') is null) and
con.con_keytva = 1 and
con.con_keyplz = coc.coc_keyplz and
coc.coc_stspag = 'V' and
nullif(coc.coc_keyrph::text, '') is null and
--coc.coc_keygdp is null and
coc.coc_keycap between pi_capini and pi_capfin and
con.con_keyemp=empl.emp_keyemp and
empl.emp_keyemp=ale.ale_keyemp and                          -- nuevo emilio
con.con_keypue=pues.pue_keypue and
onc.con_keycon=pues.pue_ca5aux and
-- pues.pue_ca4aux[7]='1' and
oracle.substr(pues.pue_ca4aux, 7, 1) = '1' and
empl.emp_status=1 and                                       -- and nuevo emilio
coalesce(ale.ale_keyem2,0) > 0                                   -- nuevo emilio
group by con.con_keyemp,con.con_keytco,con.con_cosuni,con.con_keypue,
con.con_keyplz,con.con_keyfol,con.con_numcdi,onc.con_keycon)
loop
li_empleado := cur_02.con_keyemp;
li_tipcon   := cur_02.con_keytco;
ld_costo    := cur_02.con_cosuni;
ls_puesto   := cur_02.con_keypue;
li_plaza    := cur_02.con_keyplz;
li_folio    := cur_02.con_keyfol;
li_capdis   := cur_02.con_numcdi;
li_numcap   := cur_02.cuantos;
ls_keycon   := cur_02.con_keycon;
if li_numcap = pi_capfin - pi_capini + 1 then
-- inserccion del header
if li_secrph = -1 then
-- definicion de la equivalencia y concepto, dependiendo de la nomina
if pi_keynom = 102 then
ws_equiva := 'I';
begin
select cpf_keycof
into strict ls_keycon
from usrsiho.nmloconc,usrsiho.nmcopues,usrsiho.holocpfj
where pue_ca5aux = cpf_keycon and
cpf_keycon = con_keycon and
cpf_repeti = 'I' and
pue_keypue = ls_puesto;
exception when no_data_found then ls_keycon:= null;
end;
else
ws_equiva := 'N';
end if;
ld_valor := ld_costo;
-- aedo  14/08/06   claudia islas pidio que se actualizara el campo frp_pertra con el valor 1, en lugar del null.
insert into usrsiho.holofrph(frp_keydep,frp_keyper,frp_fecact,frp_stsfol,
frp_totcos,frp_keyusu,frp_keynom,frp_repeti,
frp_tiptra,frp_fecsol,frp_fectrab,frp_forpag,
frp_pertra,frp_tipfol,frp_unifor,frp_transp,
frp_tipcam,frp_keypro,frp_fecitr,frp_keyare)
values (  ps_programa,null     ,pd_fechaact,'0'      ,
ld_valor   ,pi_keyusu,pi_keynom,ws_equiva  ,
ps_tiptra  ,pd_fecsol,pd_fechatrabhas,pi_forpag,
1, 'N'   ,pl_unifor,pl_transp  ,pn_tipcam,
pn_keypro  ,pd_fechatrab, pdk_keyare)
returning frp_keyrph into li_secrph;
-- lectura del secuencial del rph =>
-- li_secrph := dbinfo('SQLCA.SQLERRD1');
-- return li_secrph with resume;
--li_secrph := sqlcode;
vi_valret := li_secrph;
end if;
-- capitulos totales
li_captot := pi_capfin - pi_capini + 1;
-- insercion de gastos de produccion
ld_valor := ld_costo;
ld_costototal := ld_costototal + ld_valor  * ( pi_capfin - pi_capini + 1 );
li_emptotal := li_emptotal + li_empleado;
-- cesar gonzalez sanchez   abril 2004
-- se cambio pi_tipcont x li_tipcon  para que se puedan insertar los contratos que regrese el select
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_keypue,gdp_capini,
gdp_capfin,gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,
gdp_keysue,gdp_keytco,gdp_keyfol,gdp_minleg,gdp_minsal,gdp_minext,
gdp_mincom,gdp_keyusu)
values ( ps_programa,li_secrph,pd_fechatrab,li_empleado,ls_puesto,pi_capini,
pi_capfin  ,li_captot,ls_keycon   ,'S'        ,'S'      ,ld_valor ,
null       ,li_tipcon,li_folio   ,0          ,0        ,0        ,
0          ,pi_keyusu)
returning gdp_keysec into li_secgdp;
-- lectura del secuencial del  gdp =>
-- li_secgdp := dbinfo('SQLCA.SQLERRD1');
-- return li_secgdp with resume;
--li_secgdp := sqlcode;
--vi_valret := li_secgdp;
-- act  ualizacion de capitulos
update usrsiho.holococa
set coc_keyrph = li_secrph ,
coc_keygdp = li_secgdp
where coc_keyplz = li_plaza and
coc_keycap between pi_capini and pi_capfin;
-- actualizacion de contratos
update usrsiho.holocont
set con_numcdi = con_numcdi - ( pi_capfin - pi_capini + 1 )
where con_keyplz = li_plaza and
con_keytco = li_tipcon;
end if;
-- end foreach
end loop;
--si el cursor inserto un rph --> actualizar el total costo y el total empleado en este con las sumas de los detalles
if li_secrph > -1 then
update usrsiho.holofrph
set frp_totcos = ld_costototal,
frp_totemp = li_emptotal
where frp_keyrph = li_secrph;
end if;
end if;
end;
-- -----------------------------------------------------------------------------------------------------------
$body$
language plpgsql
;
