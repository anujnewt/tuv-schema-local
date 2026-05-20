create or replace procedure usrsiho."sp_holotrarph_df"  (pi_rph numeric,         --numero de rph
pd_fechaact timestamp(0),       --fecha de actualizaci?n
pd_fechapag timestamp(0),       --fecha de pago
pi_keyemp numeric,      --numero del empleado
pi_num_id numeric,      --numero de la hoja de trabajo
pi_serial numeric,      --numero del detalle de la hoja de trabajo
--pi_capini number,      --capitulo inicial
--pi_capfin number,      --capitulo final
pi_keyusu numeric,      --clave del usuario
ps_fechapagdf varchar, --fecha de pago en texto con formato 'DD/MM/YYYY'
pi_keypro numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--numero de proceso
--variables para proceso normal
ps_regrfc varchar(13);
ps_recurp varchar(18);
pi_valdf numeric(10);
ps_keyconvia varchar(10);
pi_keygdp numeric(10);
ps_mensaje varchar(30);
ps_keydep varchar(16);
pi_keytco numeric(10);
pi_keyfol numeric(10);
pd_cosuni decimal(15,2);
ps_keypue varchar(16);
--define pi_capitulo integer;
ps_tipinc varchar(2);
--variables para proceso del detalle de los capitulos
ps_capgra varchar(100);
ps_caracter varchar(1);
pi_numcap numeric(10);
pi_inicial numeric(10);
pi_final numeric(10);
pi_capfin integer;
pi_capini integer;
pi_auxiliar numeric(10);
pi_continuos numeric(10);
pi_lencad numeric(10);
--variables para el calculo de menores de edad
ld_menoredad numeric(10);
ls_nacionalidad varchar(2);
li_codigoanda numeric(10);
ld_anios numeric(10);
pd_fecgra timestamp(0);
rec record;
rec2 record;
begin
--inicializacion de variables del proceso normal
ps_regrfc:= null;
ps_recurp:= null;
pi_valdf := 0;
ps_keyconvia:= null;
pi_keygdp := 0;
ps_mensaje:= null;
ps_keydep:= null;
pi_keytco := 0;
pi_keyfol := 0;
pd_cosuni := 0;
ps_keypue:= null;
ps_tipinc:= null;
--inicializacion de variables para proceso del detalle de los capitulos
ps_caracter:= null;
pi_numcap := 0;
pi_inicial := 0;
pi_final := 0;
pi_auxiliar := 0;
pi_continuos := 0;
pi_lencad := 0;
--inicializacion de variables del calculo de menores de edad
ld_menoredad := 0;
ls_nacionalidad:= null;
li_codigoanda := 0;
ld_anios := 0;
pd_fecgra := to_timestamp('01/01/1900','DD/MM/YYYY');
---------------------------------------------------
-- inician modificacion jcro para menores de edad--
---------------------------------------------------
-- -----------------------------------------------------
-- obtenemos los a?os considerados para el menor de edad
-- -----------------------------------------------------
begin
select coalesce(pam_folini,0)
into strict ld_menoredad
from usrsiho.glcopams
where pam_keypar = 'TEME';
exception when no_data_found then ld_menoredad := 0;
end;
-- -----------------------------------------------------
-- obtenemos la nacionalidad del empleado
-- -----------------------------------------------------
begin
select emp_ca3aux
into strict ls_nacionalidad
from usrsiho.nmcoempl
where emp_keyemp = pi_keyemp;
exception when no_data_found then ls_nacionalidad:= null;
end;
-- -----------------------------------------------------
-- obtenemos el codigo de la anda
-- -----------------------------------------------------
begin
select (pam_folini)::numeric
into strict li_codigoanda
from usrsiho.glcopams
where pam_keypar = 'ACP'
and pam_folfin = 'CODIGO ANDA';
exception when no_data_found then li_codigoanda := 0;
end;
-- -----------------------------------------------------
-- obtenemos la fecha de grabacion de la ht
-- -----------------------------------------------------
begin
select enc_fecgra
into strict pd_fecgra
from usrsiho.holoenctra
where enc_num_id = pi_num_id;
exception when no_data_found then pd_fecgra:= null;
end;/* dmap converted statement start */
-- --------------------------------------------------------------------
-- calculamos la edad del empleado para determinar si es menor de edad
-- --------------------------------------------------------------------
if ls_nacionalidad = '02' then
begin
select ((pd_fecgra - ale_fecnac)/365.25::numeric)
into strict ld_anios
from usrsiho.holoalem
where ale_keyemp = pi_keyemp;/* dmap converted statement end */
exception when no_data_found then ld_anios := 0;
end;
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
---------------------------------------------------
-- termina modificacion jcro para menores de edad--
---------------------------------------------------
begin
select det_tipinc
into strict ps_tipinc
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then ps_tipinc:= null;
end;
--insert into borra values(1,'ps_tipinc',0,ps_tipinc);
begin
select count(*)
into strict pi_valdf
from usrsiho.glcopams
where pam_keypar = 'CDF' and
pam_cvesec <> 1 and
to_timestamp(pam_folfin,'DD/MM/YYYY') =
(select enc_fecgra
from usrsiho.holoenctra
where  enc_num_id = pi_num_id);
exception when no_data_found then pi_valdf := 0;
end;
--insert into tmp_errores values(0,pi_valdf,0,0,'pi_valdf','','');
--insert into borra values(2,'pi_valdf',pi_valdf,'');
if pi_valdf > 0 then
begin
select emp_regrfc,emp_recurp
into strict ps_regrfc, ps_recurp
from usrsiho.nmcoempl
where emp_keyemp = pi_keyemp;
exception when no_data_found then ps_regrfc:= null; ps_recurp:= null;
end;
if ps_tipinc = 'N' then--ig-cons-0823
begin
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
exception when no_data_found then ps_keyconvia:= null;
end;
begin
select pam_cvesec
into strict ps_keypue
from usrsiho.glcopams
where pam_keypar = 'AJEV' and
pam_folini ='DF' and
pam_folfin =
(select det_keypue
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial
);
exception when no_data_found then ps_keypue:= null;
end;
else
begin
select pue_ca5aux
into strict ps_keyconvia
from usrsiho.nmcopues
where pue_keypue =
(select pam_cvesec
from usrsiho.glcopams
where pam_keypar = 'AJEV' and
pam_folini = ps_tipinc and
pam_cvesec =
(select det_keypue
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial
)
);
exception when no_data_found then ps_keyconvia:= null;
end;
begin
select pam_cvesec
into strict ps_keypue
from usrsiho.glcopams
where pam_keypar = 'AJEV' and
pam_folini = ps_tipinc and
pam_cvesec =
(select det_keypue
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial
);
exception when no_data_found then ps_keypue:= null;
end;
end if;--ig-cons-0823 fin
select det_keydep,det_keytco,det_keyfol,det_capfin,det_capgra
into strict   ps_keydep,pi_keytco,pi_keyfol,pi_numcap,ps_capgra
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
if ps_tipinc = 'N' then
if coalesce(pi_keytco,0) > 0 then
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
and trim(both cont.con_keydep) = ps_keydep
and cont.con_keytco = pi_keytco
and cont.con_keyfol = pi_keyfol
and cont.con_keyemp = pi_keyemp
and tab.tab_keypro =  pi_keypro
and tab.tab_keypue = cont.con_keypue
and tab.tab_pertra = cont.con_pertra
and tab.tab_idioma = cont.con_idioma
and tab.tab_keynac = cont.con_keynac
and tab.tab_keytab = (case when cont.con_keytco = 519 then 3 else cont.con_keytco end - 1)
and frp_keyrph = pi_rph
and tab.tab_fecini <= frp_fectrab
and coalesce(tab.tab_fecfin,frp_fectrab) >= frp_fectrab;
else
pi_keytco := 0;
end if;
else
begin
select coalesce(det_cosuni,0)
into strict pd_cosuni
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then pd_cosuni := 0;
end;
end if;
--   insert into tmp_errores values(0,pd_cosuni,pi_capitulo,0,'pd_cosuni','pi_capitulo','');
if ps_tipinc = 'N' then
if pi_numcap > 1 then
pi_inicial := 1;
pi_final := 1;
pi_capini := 1;
pi_auxiliar := 1;
pi_continuos := 1;
pi_numcap := 1;
pi_lencad := length(trim(both ps_capgra));
if pi_keyemp = 490212363 then
pi_valdf := 1;
end if;
while pi_final <= pi_lencad loop
ps_caracter := oracle.substr(ps_capgra,pi_final,1);
if ps_caracter = ',' or pi_final = pi_lencad then
if pi_lencad = pi_final then pi_auxiliar := pi_final + 1; else pi_auxiliar := pi_final; end if;
if pi_inicial = 1 then
pi_capini := (oracle.substr(ps_capgra , pi_inicial , pi_auxiliar - pi_inicial))::numeric;
pi_capfin := 0;
else
pi_capfin := pi_capini;
pi_capini := (oracle.substr(ps_capgra , pi_inicial , pi_auxiliar - pi_inicial))::numeric;
end if;
insert into usrsiho.temp_capitulos values (pi_capini); --capitulo
pi_inicial := pi_final + 1;
pi_numcap := pi_numcap +1;
if pi_capfin > 0 then
if pi_capfin + 1 <> pi_capini and pi_continuos = 1 then
pi_continuos := 0;
end if;
end if;
end if;
pi_final := pi_final + 1;
end loop;
else
pi_capini := (trim(both ps_capgra))::numeric;
insert into usrsiho.temp_capitulos values (pi_capini);
pi_continuos := 1;
pi_numcap := 2;
end if;
pi_numcap := pi_numcap -1;
if pi_continuos = 1 then
--graba un solo registro por el n?mero de capitulos
pi_capini := 0;
pi_capfin := 0;
for rec in (select capitulo
from usrsiho.temp_capitulos
order by  1) loop
pi_auxiliar := rec.capitulo;
if pi_capini = 0 then
pi_capini := pi_auxiliar;
pi_capfin := pi_auxiliar;
else
pi_capfin := pi_auxiliar;
end if;
end loop;
--insert into borra values(7,'pi_capini',pi_capini,'');
--insert into borra values(8,'pi_capfin',pi_capfin,'');
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
select det_keydep,pi_rph,pd_fechaact,coalesce(det_keyemp,0),ps_regrfc,ps_recurp,ps_keypue,coalesce(pi_capini,0),coalesce(pi_capfin,0),
pi_numcap,case when ld_anios < ld_menoredad then 'HTI' else ps_keyconvia end,'x','x',case when coalesce(pd_cosuni,0) = 0 then det_cosuni else coalesce(pd_cosuni,0) end ,0,0,0,pi_keyusu,
0,0,0,0
from usrsiho.holodettra, usrsiho.holoenctra
where det_num_id = enc_num_id and
det_num_id = pi_num_id and
det_serial = pi_serial;
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
--- aedo 05/04/2011 se agrego la liga de numero de empleado
select det_keydep,pi_rph,pd_fechaact,coalesce(det_keyemp,0),ps_regrfc,ps_recurp,ps_keypue,coalesce(pi_capini,0),coalesce(pi_capfin,0),
pi_numcap,case when ld_anios < ld_menoredad then 'HTI' else ps_keyconvia end,'x','x',case when coalesce(pd_cosuni,0) = 0 then det_cosuni else coalesce(pd_cosuni,0) end ,0,0,0,pi_keyusu,
0,0,0,0
from usrsiho.holodettra, usrsiho.holocont
where det_keyfol = con_keyfol and
det_keyemp = con_keyemp  and
det_num_id = pi_num_id and
det_serial = pi_serial;
else
--graba un registro por cada capitulo en la tabla temporal
for rec2 in (select capitulo
from usrsiho.temp_capitulos
order by  1) loop
pi_auxiliar := rec2.capitulo;
pi_capini := pi_auxiliar;
pi_capfin := pi_auxiliar;
insert into usrsiho.hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
select det_keydep,pi_rph,pd_fechaact,coalesce(det_keyemp,0),ps_regrfc,ps_recurp,ps_keypue,coalesce(pi_capini,0),coalesce(pi_capfin,0),
1,case when ld_anios < ld_menoredad then 'HTI' else ps_keyconvia end,'x','x',case when coalesce(pd_cosuni,0) = 0 then det_cosuni else coalesce(pd_cosuni,0) end ,0,0,0,pi_keyusu,
0,0,0,0
from usrsiho.holodettra, usrsiho.holoenctra
where det_num_id = enc_num_id and
det_num_id = pi_num_id and
det_serial = pi_serial;
insert into hologdpr(gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
--- aedo 05/04/2011 se agrego la liga de numero de empleado
select det_keydep,pi_rph,pd_fechaact,coalesce(det_keyemp,0),ps_regrfc,ps_recurp,ps_keypue,coalesce(pi_capini,0),coalesce(pi_capfin,0),
1,case when ld_anios < ld_menoredad then 'HTI' else ps_keyconvia end,'x','x',case when coalesce(pd_cosuni,0) = 0 then det_cosuni else coalesce(pd_cosuni,0) end ,0,0,0,pi_keyusu,
0,0,0,0
from usrsiho.holodettra, usrsiho.holocont
where det_keyfol = con_keyfol and
det_keyemp = con_keyemp and
det_num_id = pi_num_id and
det_serial = pi_serial;
end loop;
end if;
end if;
end if;
--drop table temp_capitulos;
end;
$body$
language plpgsql
;
