create or replace procedure usrsiho."sp_holoaltinc"  (pi_keyemp numeric,         --numero de empleado
pi_tipgra numeric,        --opci??n de grabado.
li_secrph numeric,         --numero de rph
pd_fechaact timestamp(0),          --fecha de actualizaci??n
ps_keyvia varchar,     --clave del viatico
pd_costvia numeric,  --costo del viatico
pi_keyusu numeric,         --clave del usuario
pi_num_id numeric,         --clave de la hoja de trabajo
pi_serial numeric,         --clave del detalle de la hoja de trabajo
pi_keypro numeric,        --numero del proceso
pi_capini numeric,        --numero del capitulo inicial
pi_capfin numeric,        --numero del capitulo final
pi_hraent numeric,         --minutos de la hr de entrada
pi_hrasal numeric,         --minutos de la hr de salida
pi_mincom numeric,         --minutos de la hr de comida
pi_numreg numeric,         --numero de registro la tabla temporal para saber que registro actualizar
pi_unreg numeric           --marca si solo es un capitulo
) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--returning integer,varchar(30),varchar(20);
-- -----------------------------------------------------------------
-- sp_holoaltinc: este stored procedure es el que utiliza en el
-- stored procedure principal 'sp_holotrarph' que sirve para
-- grabar el detalle de las incidencias a los rph generados
-- recibe como parametro principal la hoja de trabajo y el numero de registro, asi como el tipo
-- de incidencia que se va a procesar, esto para calcular la actividad.
-- realizado el 29 de septiembre de 2005
-- emilio pulido rangel
-- modifico:                    comentario:       fecha:
-- juan carlos reyes o.         se agrego la consulta y validaci??n  19/07/2011
--                              del calculo de la edad del actor.
--                              separacion de actividades segun el  19/09/2011
--                              tipo de incidencia a grabar.
-- -----------------------------------------------------------------
pd_cosuni decimal(15,2);
ps_regrfc varchar(13);              --rfc del empleado
ps_recurp varchar(18);              --curp del empleado
ps_keydep varchar(16);
pi_keytco numeric(10);
pi_keyfol numeric(10);
pi_keygdp numeric(10);
pi_keypue varchar(16);
ps_mensaje1 varchar(30);
ps_mensaje2 varchar(20);
pi_diafest numeric(10);
pi_markadf numeric(10);
ps_tipoinc varchar(2);
--variables para obtener el numero de capitulo de los viaticos
i numeric(10);
longitud numeric(10);
inicio numeric(10);fin numeric(10);
pi_capitulo numeric(10);
caracter varchar(1);
cadena varchar(20);
ps_keyconvia varchar(20);    --clave del viatico
--variables para el calculo de menores de edad
ld_menoredad numeric(10);
ls_nacionalidad varchar(2);
li_codigoanda numeric(10);
ld_anios numeric(10);
pd_fecgra timestamp(0);
ls_descvia varchar(20);
begin
ps_mensaje1:= null;
ps_mensaje2:= null;
pd_cosuni := 0;
ps_regrfc:= null;
ps_recurp:= null;
ps_keydep:= null;
pi_keytco := 0;
pi_keyfol := 0;
pi_keygdp := 0;
pi_keypue:= null;
pi_diafest := 0;
pi_markadf := 0;
ps_tipoinc:= null;
ps_keyconvia := ps_keyvia;
--inicializaci??n de variables para obtener el n??mero de capitulo de los viaticos
i := 1;
inicio := 1;
fin := 0;
pi_capitulo := 0;
caracter:= null;
cadena:= null;
--inicializacion de variables del calculo de menores de edad
ld_menoredad := 0;
ls_nacionalidad:= null;
li_codigoanda := 0;
ld_anios := 0;
pd_fecgra := '01/01/1900';
ls_descvia:= null;
---------------------------------------------------
-- //inicio cons-0530 mejoras sai juan carlos reyes olivera 19/09/2011
---------------------------------------------------
--insert into borra values(1,'pi_keyemp',pi_keyemp,'');
--insert into borra values(2,'pi_tipgra',pi_tipgra,'');
--insert into borra values(3,'pi_num_id',pi_num_id,'');
--insert into borra values(4,'pi_serial',pi_serial,'');
-- -----------------------------------------------------
-- obtenemos los a??os considerados para el menor de edad
-- -----------------------------------------------------
select coalesce(pam_folini,0)
into strict ld_menoredad
from usrsiho.glcopams
where pam_keypar = 'TEME';
-- -----------------------------------------------------
-- obtenemos la nacionalidad del empleado
-- -----------------------------------------------------
select emp_ca3aux
into strict ls_nacionalidad
from usrsiho.nmcoempl
where emp_keyemp = pi_keyemp;
-- -----------------------------------------------------
-- obtenemos el codigo de la anda
-- -----------------------------------------------------
select (pam_folini)::numeric
into strict li_codigoanda
from usrsiho.glcopams
where pam_keypar = 'ACP'
and pam_folfin = 'CODIGO ANDA';
-- -----------------------------------------------------
-- obtenemos la fecha de grabacion de la ht
-- -----------------------------------------------------
select enc_fecgra
into strict pd_fecgra
from usrsiho.holoenctra
where enc_num_id = pi_num_id;/* dmap converted statement start */
-- --------------------------------------------------------------------
-- calculamos la edad del empleado para determinar si es menor de edad
-- --------------------------------------------------------------------
if ls_nacionalidad = '02' then
select trunc(((pd_fecgra - ale_fecnac)/365.25)::numeric)
into strict ld_anios
from usrsiho.holoalem
where ale_keyemp = pi_keyemp;/* dmap converted statement end */
else
if li_codigoanda <> pi_keyemp then
select case when (oracle.substr(emp_regrfc,7,2))::numeric  > 0 and (oracle.substr(emp_regrfc,9,2))::numeric  > 0 and (oracle.substr(emp_regrfc,5,2))::numeric  >= 0 then
trunc( coalesce(to_number((pd_fecgra - to_date(oracle.substr(emp_regrfc,7,2) || '/' || oracle.substr(emp_regrfc,9,2) || '/' || case when (oracle.substr(emp_regrfc,5,2))::numeric  >= (extract(year from pd_fecgra)-2000) then '19' else '20' end || oracle.substr(emp_regrfc,5,2)))/365.25),0) )
else
99
end
into strict ld_anios
from usrsiho.nmcoempl
where emp_keyemp = pi_keyemp;
else
ld_anios := 99;
end if;
end if;
--insert into borra values(5,'Ld_Anios',ld_anios,'');
---------------------------------------------------
-- //fin cons-0530 mejoras sai juan carlos reyes olivera 19/09/2011
---------------------------------------------------
select emp_regrfc,emp_recurp
into strict   ps_regrfc,ps_recurp
from usrsiho.nmcoempl
where emp_keyemp = pi_keyemp;
if pi_tipgra = 1 then --graba los viaticos (de sindicato anda y otros)
--unificaci??n de conceptos
ls_descvia := oracle.substr(ps_keyconvia,4,17);
ps_keyconvia := oracle.substr(ps_keyconvia,1,3);
select pam_cvesec
into strict   pi_keypue
from usrsiho.glcopams,usrsiho.nmcopues
where pam_folfin = pue_keypue and
pam_keypar = 'AJEV' and
pam_folini = 'GM' and
pam_nompar = ls_descvia;
--pam_folfin = (
--              select det_keypue
--              from holodettra
--              where det_num_id = pi_num_id and
--                    det_serial = pi_serial
--             );
select det_capgra
into strict cadena
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
longitud := length(cadena);
for i in 1..longitud loop
caracter := oracle.substr(cadena , i , 1);
if caracter = ',' then
fin := i::numeric - 1;
pi_capitulo := oracle.substr(cadena , inicio , fin);
inicio := i::numeric + 1;
exit;
end if;
if i = longitud then
fin := longitud;
pi_capitulo := oracle.substr(cadena , inicio , fin);
exit;
end if;
end loop;
pi_capitulo := coalesce(pi_capitulo,0);/* dmap converted statement start */
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
--select det_keydep,li_secrph,pd_fechaact,coalesce(det_keyemp,0),ps_regrfc,ps_recurp,pi_keypue,pi_capitulo,pi_capitulo,
--1,ps_keyconvia,'x','x',coalesce(pd_costvia,0),0,coalesce(det_keytco,0),coalesce(det_keyfol,0),pi_keyusu,
select det_keydep,li_secrph,pd_fechaact,coalesce(det_keyemp,0),ps_regrfc,ps_recurp,pi_keypue,pi_capitulo,pi_capitulo,
1,ps_keyconvia,'x','x',coalesce(pd_costvia,0),0,0,0,pi_keyusu,
0,0,0,0
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;/* dmap converted statement end */
--   let ps_mensaje1 = 'ANDA Det viaticos';
--   let ps_mensaje2 = '';
--   return li_secrph,ps_mensaje1,ps_mensaje2 with resume;
else
select det_keydep,det_keytco,det_keyfol
into strict   ps_keydep,pi_keytco,pi_keyfol
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
--codigo nuevo sin la validacion del usuario
begin
select coalesce(tab.tab_import,0)
into strict pd_cosuni
from usrsiho.holocont cont, usrsiho.nmcoempl empl, usrsiho.nmcopues pues, usrsiho.nmloconc con,
usrsiho.holotabs tab, usrsiho.holofrph, usrsiho.nmloalde al
where cont.con_keyemp = empl.emp_keyemp
and cont.con_keypue = pues.pue_keypue
and cont.con_keydep = al.ald_keydep
and pue_nu1aux <> '2'
and al.ald_status = 'A'
and con.con_keycon = pues.pue_ca5aux
--     and cont.con_stspag = 'V'
and trim(both cont.con_keydep) = ps_keydep
and cont.con_keytco = pi_keytco
and cont.con_keyfol = pi_keyfol
and cont.con_keyemp = pi_keyemp
and tab.tab_keypro =  pi_keypro
and tab.tab_keypue = cont.con_keypue
and tab.tab_pertra = cont.con_pertra
and tab.tab_idioma = cont.con_idioma
and tab.tab_keynac = cont.con_keynac
--     and tab.tab_keytab = cont.con_keytco - 1
and tab.tab_keytab = (case when cont.con_keytco = 519 then 3 else cont.con_keytco end - 1)
and frp_keyrph = li_secrph
and tab.tab_fecini <= frp_fectrab
and coalesce(tab.tab_fecfin,frp_fectrab) >= frp_fectrab;
exception
when no_data_found then
pd_cosuni := 0;
end;
-- codigo anterior validando el usuario
--   select nvl(tab.tab_import,0)
--   into pd_cosuni
--   from holocont cont, nmcoempl empl, nmcopues pues, nmloconc con,
--   glcoactc act, holotabs tab, holofrph, nmloalde al
--   where cont.con_keyemp = empl.emp_keyemp
--     and cont.con_keypue = pues.pue_keypue
--     and cont.con_keydep = al.ald_keydep
--     and pue_nu1aux <> '2'
--     and al.ald_status = 'A'
--     and con.con_keycon = pues.pue_ca5aux
--     and act.act_keytco = cont.con_keytco
--     and cont.con_stspag = 'V'
--     and trim(cont.con_keydep) = ps_keydep
--     and act.act_keyusu = pi_keyusu
--     and cont.con_keytco =  pi_keytco
--     and cont.con_keyfol =  pi_keyfol
--     and tab.tab_keypro = pi_keypro
--     and tab.tab_keypue = cont.con_keypue
--     and tab.tab_pertra = cont.con_pertra
--     and tab.tab_idioma = cont.con_idioma
--     and tab.tab_keynac = cont.con_keynac
--     and tab.tab_keytab = cont.con_keytco - 1
--     and frp_keyrph = li_secrph
--     and tab.tab_fecini <= frp_fectrab
--     and nvl(tab.tab_fecfin,frp_fectrab) >= frp_fectrab;
if pi_tipgra = 2 then --graba la incidencia normal (de sindicato anda y otros)
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
select det_keydep,li_secrph,pd_fechaact,coalesce(det_keyemp,0),ps_regrfc,ps_recurp,det_keypue,
case
when pi_unreg = 1 and coalesce(pi_capini,0) = 0 then (det_capgra)::numeric
when pi_unreg = 1 and coalesce(pi_capini,0) > 0 then coalesce(pi_capini,0)
when pi_unreg = 0 and coalesce(pi_capini,0) = 0 then det_capini
when pi_unreg = 0 and coalesce(pi_capini,0) > 0 then coalesce(pi_capini,0)
else 0
end,
case
when pi_unreg = 1 and coalesce(pi_capfin,0) = 0 then (det_capgra)::numeric
when pi_unreg = 1 and coalesce(pi_capfin,0) > 0 then coalesce(pi_capfin,0)
when pi_unreg = 0 and coalesce(pi_capfin,0) = 0 then det_capfin
when pi_unreg = 0 and coalesce(pi_capfin,0) > 0 then coalesce(pi_capfin,0)
else 0
end,
(case
when pi_unreg = 1 and coalesce(pi_capfin,0) = 0 then (det_capgra)::numeric
when pi_unreg = 1 and coalesce(pi_capfin,0) > 0 then coalesce(pi_capfin,0)
when pi_unreg = 0 and coalesce(pi_capfin,0) = 0 then det_capfin
when pi_unreg = 0 and coalesce(pi_capfin,0) > 0 then coalesce(pi_capfin,0)
else 0
end -
case
when pi_unreg = 1 and coalesce(pi_capini,0) = 0 then (det_capgra)::numeric
when pi_unreg = 1 and coalesce(pi_capini,0) > 0 then coalesce(pi_capini,0)
when pi_unreg = 0 and coalesce(pi_capini,0) = 0 then det_capini
when pi_unreg = 0 and coalesce(pi_capini,0) > 0 then coalesce(pi_capini,0)
else 0
end) + 1,
case when ld_anios < ld_menoredad then 'HTI' else det_keycon end,   -- cons-0530 mejoras sai juan carlos reyes olivera 19/09/2011
's','s',
coalesce(pd_cosuni,0),
0,coalesce(det_keytco,0),coalesce(det_keyfol,0),pi_keyusu,
pi_hraent,pi_hrasal,0,pi_mincom
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
select currval('hologdpr_seq') into strict pi_keygdp;
--      update hologdpr
--      set gdp_cosuni = nvl(gdp_cosuni,0) * nvl(gdp_numcap,0)
--      where gdp_keyrph = li_secrph and
--            gdp_keysec = pi_keygdp;
--      let ps_mensaje1 = 'ANDA Det viaticos';
--      let ps_mensaje2 = '';
--      return li_secrph,ps_mensaje1,ps_mensaje2 with resume;
if pi_capini <> pi_capfin then --actualiza cuando son varios capitulos continuos
update usrsiho.holococa
set coc_keyrph = li_secrph,
coc_keygdp = pi_keygdp
where coc_keycap in (select capitulo from usrsiho.tmp_hologdpr) and
coc_hjatra = pi_num_id and
coc_keyplz =
(select con_keyplz
from usrsiho.holocont
where con_keyfol = pi_keyfol and
con_keyemp = pi_keyemp)
and coc_hjatra = pi_num_id;
delete from usrsiho.tmp_hologdpr;
else
if pi_numreg <> 0  then --actualiza cuando son varios capitulos salteados
if pi_unreg = 0 then
update usrsiho.holococa
set coc_keyrph = li_secrph,
coc_keygdp = pi_keygdp
where coc_keycap = (select capitulo from usrsiho.tmp_hologdpr where keycapitulo = pi_numreg) and
coc_hjatra = pi_num_id and
coc_keyplz =
(select con_keyplz
from usrsiho.holocont
where con_keyfol = pi_keyfol and
con_keyemp = pi_keyemp);
else --actualiza cuando es un solo capitulo
update usrsiho.holococa
set coc_keyrph = li_secrph,
coc_keygdp = pi_keygdp
where coc_keycap = pi_numreg and
coc_hjatra = pi_num_id and
coc_keyplz =
(select con_keyplz
from usrsiho.holocont
where con_keyfol = pi_keyfol and
con_keyemp = pi_keyemp);
end if;
end if;
end if;
end if;
if pi_tipgra = 3 then --graba la incidencia diferente de normal (de sindicato anda y otros)
select coalesce((oracle.substr(det_auxca2,8,1))::numeric ,0),det_tipinc
into strict pi_markadf,ps_tipoinc
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;/* dmap converted statement start */
if (ps_tipoinc = 'JE' or ps_tipoinc = 'JV') and pi_markadf = 1 then
select coalesce(count(*),0) noreg
into strict pi_diafest
from usrsiho.glcopams
where pam_keypar = 'CDF' and
pam_folfin in (
select oracle. concat(substr(to_char(det_fecgra) , 4 , 2), '/' , oracle.substr(to_char(det_fecgra) , 1 , 2) , '/' , oracle.substr(to_char(det_fecgra) , 7 , 4)
) from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial
);/* dmap converted statement end */
if pi_diafest > 0 then
select pue_ca5aux
into strict ps_keyconvia
from usrsiho.nmcopues
where pue_keypue =
(select pam_cvesec
from usrsiho.glcopams
where pam_keypar = 'AJEV' and
pam_folini ='DF' and
pam_folfin =
(select det_keypue
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial
)
);
select pam_cvesec
into strict pi_keypue
from usrsiho.glcopams
where pam_keypar = 'AJEV' and
pam_folini ='DF' and
pam_folfin =
(select det_keypue
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial
);
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
select det_keydep,li_secrph,pd_fechaact,coalesce(pi_keyemp,0),ps_regrfc,ps_recurp,det_keypue,det_capini,det_capfin,
1,
det_keycon,               -- cons-0530 mejoras sai juan carlos reyes olivera 19/09/2011
'x','x',coalesce(det_cosuni,0),'0',0,0,pi_keyusu,
0,0,0,0
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
select det_keydep,li_secrph,pd_fechaact,coalesce(pi_keyemp,0),ps_regrfc,ps_recurp,pi_keypue,det_capini,det_capfin,
1,
case when ld_anios < ld_menoredad then 'HTI' else ps_keyconvia end, -- cons-0530 mejoras sai juan carlos reyes olivera 19/09/2011
'x','x',coalesce(det_cosuni,0),'0',0,0,pi_keyusu,
0,0,0,0
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
select det_keydep,li_secrph,pd_fechaact,coalesce(pi_keyemp,0),ps_regrfc,ps_recurp,pi_keypue,det_capini,det_capfin,
1,
case when ld_anios < ld_menoredad then 'HTI' else ps_keyconvia end, -- cons-0530 mejoras sai juan carlos reyes olivera 19/09/2011
'x','x',coalesce(det_cosuni,0),'0',0,0,pi_keyusu,
0,0,0,0
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
else
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
select det_keydep,li_secrph,pd_fechaact,coalesce(pi_keyemp,0),ps_regrfc,ps_recurp,det_keypue,det_capini,det_capfin,
1,
det_keycon              , -- cons-0530 mejoras sai juan carlos reyes olivera 19/09/2011
'x','x',coalesce(det_cosuni,0),'0',0,0,pi_keyusu,
0,0,0,0
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
end if;
else
if (ps_tipoinc = 'PA' or ps_tipoinc = 'VL' or ps_tipoinc = 'DE' or ps_tipoinc = 'CM' or
ps_tipoinc = 'CN' or ps_tipoinc = 'TA' or ps_tipoinc = 'TE' or ps_tipoinc = 'ED'
or ps_tipoinc = 'DF' or ps_tipoinc = 'SD' or ps_tipoinc = 'TS') then
--obtiene el capitulo inicial de las incidencias extemporaneas
select det_capgra
into strict cadena
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
longitud := length(cadena);
for i in 1..longitud loop
caracter := oracle.substr(cadena , i , 1);
if caracter = ',' then
fin := i::numeric - 1;
pi_capitulo := oracle.substr(cadena , inicio , fin);
inicio := i::numeric + 1;
exit;
end if;
if i = longitud then
fin := longitud;
pi_capitulo := oracle.substr(cadena , inicio , fin);
exit;
end if;
end loop;
pi_capitulo := coalesce(pi_capitulo,0);
end if;
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
select det_keydep,li_secrph,pd_fechaact,coalesce(pi_keyemp,0),ps_regrfc,ps_recurp,det_keypue,case when pi_capitulo = 0 then det_capini else pi_capitulo end,case when pi_capitulo = 0 then det_capfin else pi_capitulo end,
-- inicia cons-0530 mejoras sai juan carlos reyes olivera 19/09/2011
1,case when ld_anios < ld_menoredad and ps_tipoinc = 'TA' then 'HTI'
when ld_anios < ld_menoredad and ps_tipoinc = 'TE' then 'HIT'
when ld_anios < ld_menoredad and ps_tipoinc = 'ED' then 'HTI'
else det_keycon
end,
-- fin cons-0530 mejoras sai juan carlos reyes olivera 19/09/2011
'x','x',coalesce(det_cosuni,0),'0',0,0,pi_keyusu,
0,0,0,0
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
--   let ps_mensaje1 = 'ANDA Det viaticos';
--   let ps_mensaje2 = '';
--   return li_secrph,ps_mensaje1,ps_mensaje2 with resume;
end if;
end if;
end if;
--insert into borra values(6,'Termino el proceso',0,'sin errores');
end;
$body$
language plpgsql
;
