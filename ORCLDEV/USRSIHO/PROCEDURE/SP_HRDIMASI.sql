create or replace procedure usrsiho."sp_hrdimasi"  (ps_programa varchar, ps_proceso numeric, ps_keyusu numeric, ps_ejercicio numeric, ps_mesini numeric, ps_mesfin numeric, ps_zonageo numeric, ps_banproceso numeric, ps_banempl numeric, st_bansqlnotin numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- ps_proceso  / proceso que se consulto
-- ps_keyusu  / usuario que esta generando la consulta
-- ps_ejercicio / ejercicio a aplicar en la consulta
-- ps_mesini / periodo de mes inicial a consultar
-- ps_mesfin / periodo de mes final a consultar
-- ps_zonageo / parametro para realizar la consulta y aplicar una columna
-- ps_banproceso / parametro para asignar el valor de siesasimsal
-- ps_banempl / parametro para generar la consulta en el caso de constancias por codigos o todos
-- ps_empin / parametro de que codigos se realizara la consulta
-- se crea stored para asimilables
li_mesinirec numeric(10);li_mesfinrec numeric(10);li_mesinihis numeric(10);li_mesfinhis numeric(10);li_calcanual numeric(10);
li_tarifautil numeric(10);li_tarifa1991 numeric(10);li_sindicalizado numeric(10);li_mesini numeric(10);li_mesfin numeric(10);li_contregimen  numeric(10);
ld_ingasimasdos decimal(16,2);ld_isrretenido decimal(16,2);ld_isrconftaranual decimal(16,2);ld_mtosubacred decimal(16,2);ld_imptoingacum decimal(16,2);
ls_cvesec varchar(10);
ls_codempl varchar(10);
ls_rfc varchar(20);
ls_curp varchar(20);
ls_paterno varchar(50);
ls_materno varchar(50);
ls_nombres varchar(50);
ls_aregeos varchar(2);
ls_propsub varchar(10);
ls_siesasimsal varchar(1);
ls_cveentidad varchar(2);
ls_empstatus varchar(1);
ls_vacio1 varchar(1);
ls_vacio2 varchar(1);
ls_vacio3 varchar(1);
ls_vacio4 varchar(1);
ls_vacio5 varchar(1);
ls_vacio6 varchar(1);
ls_vacio7 varchar(1);
ls_vacio8 varchar(1);
ls_vacio9 varchar(1);
ls_vacio10 varchar(1);
ls_vacio11 varchar(1);
ls_vacio12 varchar(1);
ls_vacio13 varchar(1);
ls_vacio14 varchar(1);
ls_vacio15 varchar(1);
ls_vacio16 varchar(1);
ls_vacio17 varchar(1);
rec record;
rec2 record;
rec3 record;
rec4 record;
rec5 record;
rec6 record;
begin
ls_vacio1  := '0';
ls_vacio2  := '2';
ls_vacio3  := '0';
ls_vacio4  := '0';
ls_vacio5  := '0';
ls_vacio6  := '1';
ls_vacio7  := '0';
ls_vacio8  := '0';
ls_vacio9  := '0';
ls_vacio10  := '0';
ls_vacio11  := '0';
ls_vacio12  := '0';
ls_vacio13  := '0';
ls_vacio14  := '0';
ls_vacio15  := '0';
ls_vacio16  := '0';
ls_vacio17  := '0';
li_tarifautil := 1;
li_tarifa1991 := 2;
ls_propsub := '0.00000';
li_sindicalizado := 2;
--ps_programa in varchar2, ps_proceso in number, ps_keyusu in number,
--        ps_ejercicio in number, ps_mesini in number, ps_mesfin in number,
--        ps_zonageo in number, ps_banproceso in number, ps_banempl in number, st_bansqlnotin in number
insert into usrsiho.glwkcrys(cry_nomrep,cry_chr016,cry_dec006,cry_dec007,cry_dec008,cry_dec009,cry_dec010,cry_dec011,
cry_dec012,cry_dec013,cry_dec014)
values ('debug',ps_programa,ps_proceso,ps_keyusu,ps_ejercicio,ps_mesini,ps_mesfin,ps_zonageo,ps_banproceso,ps_banempl,    st_bansqlnotin);
/* commit; */
if ps_banproceso = 1 then   -- valor 1 es proceso 143,144,145;
ls_siesasimsal := 'B';
else
ls_siesasimsal := 'E';
end if;
--  realiza la consulta para archivo xls, txt
if ps_zonageo = 1 then  --  (impresion en excel)
if st_bansqlnotin = 0 then   -- caso de no aplicar filtro not in - empleado (impresion en excel)
-- genera un for de la consulta principal y hacer un insert del resultado
for rec  in (select pam_cvesec, emp_keyemp codigo, emp_regrfc rfc, emp_recurp curp,
emp_nomemp,
case when dat_valpar='1' then '1'  else '2' end  calculoanual,
sum(case when agc_keyagr=11 then ((his_import)*1)  else 0 end ) ingasimasdos,
sum(case when agc_keyagr=15 then (his_import)*1  else 0 end ) isrretenido,
sum(case when agc_keyagr=15 then ((his_import)*1)  else 0 end )  isrconftaranual,
sum(case when agc_keyagr=79 then ((his_import)*1)  else 0 end )  mtosubacred,
sum(case when agc_keyagr=15 then (his_import)*1  else 0 end ) imptoingacum, emp_status
from usrsiho.nmlohism_cons h1
join usrsiho.nmloperi on per_keypro=h1.his_keypro and per_keyper = h1.his_keyper
join usrsiho.nmcoempl on h1.his_keyemp=emp_keyemp
join usrsiho.holoagcp on agc_keyagr in (11,12,13,14,15,45) and h1.his_keycon=agc_keycon
join usrsiho.glcopams g2 on g2.pam_keypar = 'H2' and g2.pam_cvesec = per_nu3aux
left join usrsiho.nmlodata on dat_keyemp=his_keyemp and dat_keypar=27
where per_keypro = ps_proceso
and extract(year from per_fecpag) = ps_ejercicio
and extract(month from per_fecpag) >= ps_mesini and extract(month from per_fecpag) <= ps_mesfin
and oracle.substr(h1.his_ca1aux,1,3) in ('001','501')
and agc_keyagr in (11,12,13,15) and h1.his_keynom not in (103,110)
and oracle.substr(h1.his_ca1aux,4,1) in ('1','3')
group by pam_cvesec, emp_keyemp, emp_regrfc, emp_recurp,
emp_nomemp, emp_status,dat_valpar
order by  curp) loop
-- area geografica / claveentidad
------------------------------------------------------------
ls_cvesec := rec.pam_cvesec;
ls_codempl := rec.codigo;
ls_rfc := rec.rfc;
ls_curp := rec.curp;
--sp_delimitador(emp_nomemp,'/',1) paterno,
--sp_delimitador(emp_nomemp,'/',2) materno,
--sp_delimitador(emp_nomemp,'/',3) nombres,
ls_paterno := sp_delimitador(rec.emp_nomemp,'/',1);
ls_materno := sp_delimitador(rec.emp_nomemp,'/',2);
ls_nombres := sp_delimitador(rec.emp_nomemp,'/',3);
li_calcanual := rec.calculoanual;
ld_ingasimasdos := rec.ingasimasdos;
ld_isrretenido := rec.isrretenido;
ld_isrconftaranual := rec.isrconftaranual;
ld_mtosubacred := rec.mtosubacred;
ld_imptoingacum := rec.imptoingacum;
ls_empstatus := rec.emp_status;
begin
select pam_cvesec areageosmg, pam_folini claveentidad
into strict ls_aregeos, ls_cveentidad
from usrsiho.glcopams
where pam_keypar = 'AEN'
and pam_folfin = ls_cvesec;
exception when no_data_found then ls_aregeos:= null; ls_cveentidad:= null;
end;
------------------------------------------------------------
-- obtiene el dato de mes inicial y final de recibos
------------------------------------------------------------
begin
select min(extract(month from rec_feccob)), max(extract(month from rec_feccob))
into strict li_mesinirec, li_mesfinrec
from usrsiho.holoreci
where rec_ejerci = ps_ejercicio
and rec_keyemp = ls_codempl
and rec_keypro = ps_proceso
and rec_stsrec = 3;
exception when no_data_found then li_mesinirec := 0; li_mesfinrec := 0;
end;
-- obtiene el mes min y max de regimen fiscal del empleado
------------------------------------------------------------
begin
select min(extract(month from his_fecmov)), max(extract(month from his_fecmov))
into strict  li_mesinihis, li_mesfinhis
from usrsiho.nmlohism_cons, usrsiho.holoagcp
where agc_keyagr in (11,12,13,14,15,45)
and his_keycon=agc_keycon
and oracle.substr(his_ca1aux,1,3) in ('001','501')
and his_keynom not in (103,110)
and oracle.substr(his_ca1aux,4,1) in ('1','3')
and extract(year from his_fecmov) = ps_ejercicio
and his_keyemp = ls_codempl;
exception when no_data_found then li_mesinihis := 0; li_mesfinhis := 0;
end;
-- compara el mes inicial y final de recibos y regimenfiscal para una validacion
------------------------------------------------------------
if li_mesinirec = li_mesinihis and li_mesfinrec = li_mesfinhis then
li_mesini := li_mesinirec;
li_mesfin := li_mesfinrec;
else
select count(distinct oracle.substr(his_ca1aux,1,3))
into strict li_contregimen
from usrsiho.nmlohism_cons, holoagcp
where agc_keyagr in (11,12,13,14,15,45)
and his_keycon=agc_keycon
and his_keynom not in (103,110)
and oracle.substr(his_ca1aux,4,1) in ('1','3')
and his_keyemp = ls_codempl;
if li_contregimen > 1 then
li_mesini := li_mesinihis;
li_mesfin := li_mesfinhis;
else
li_mesini := li_mesinirec;
li_mesfin := li_mesfinrec;
end if;
end if;
-- inserta en la tabla glwkcrys para tabla de paso y seguir en visual el proceso
------------------------------------------------------------
insert into usrsiho.glwkcrys(cry_nomrep, cry_keyusu,
cry_chr001, cry_chr002, cry_dec006, cry_dec007, cry_chr003, cry_chr004, cry_chr005,
cry_chr006, cry_chr007, cry_chr008, cry_dec008, cry_dec009, cry_dec010,
cry_chr009, cry_chr040, cry_chr010, cry_chr011, cry_chr012,
cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr017, cry_chr018, cry_chr019, cry_chr020, cry_chr021,
cry_chr022, cry_chr023, cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_dec011, cry_dec012,
cry_chr029, cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
cry_dec013, cry_chr041, cry_chr035, cry_dec014, cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr042)
values (ps_programa, ps_keyusu,
ls_cvesec, ls_codempl, li_mesini, li_mesfin, ls_rfc, ls_curp, ls_paterno,
ls_materno, ls_nombres, ls_aregeos, li_calcanual, li_tarifautil, li_tarifa1991,
ls_propsub, li_sindicalizado, ls_siesasimsal, ls_cveentidad, ' ',
' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ls_vacio1, ls_vacio2, ls_vacio3,
ls_vacio4, ls_vacio5, ls_vacio6, ls_vacio7, ld_ingasimasdos, ld_isrretenido,
ls_vacio8, ls_vacio9, ls_vacio10, ls_vacio11, ls_vacio12, ls_vacio13,
ld_isrconftaranual, ld_mtosubacred, ls_vacio14, ld_imptoingacum, ls_vacio15,
ls_vacio16, ls_vacio17, ls_empstatus, ps_proceso);
------------------------------------------------------------
/* commit; */
end loop;
else --- caso de aplicar filtro de not in - empleados (impresion en excel)
-- genera un for de la consulta principal y hacer un insert del resultado
for rec2  in (select pam_cvesec, emp_keyemp codigo, emp_regrfc rfc, emp_recurp curp,
emp_nomemp,
case when dat_valpar='1' then '1'  else '2' end  calculoanual,
sum(case when agc_keyagr=11 then ((his_import)*1)  else 0 end ) ingasimasdos,
sum(case when agc_keyagr=15 then (his_import)*1  else 0 end ) isrretenido,
sum(case when agc_keyagr=15 then ((his_import)*1)  else 0 end )  isrconftaranual,
sum(case when agc_keyagr=79 then ((his_import)*1)  else 0 end )  mtosubacred,
sum(case when agc_keyagr=15 then (his_import)*1  else 0 end ) imptoingacum, emp_status
from usrsiho.nmlohism_cons h1
join usrsiho.nmloperi on per_keypro=h1.his_keypro and per_keyper = h1.his_keyper
join usrsiho.nmcoempl on h1.his_keyemp=emp_keyemp
join usrsiho.holoagcp on agc_keyagr in (11,12,13,14,15,45) and h1.his_keycon=agc_keycon
join usrsiho.glcopams g2 on g2.pam_keypar = 'H2' and g2.pam_cvesec = per_nu3aux
left join usrsiho.nmlodata on dat_keyemp=his_keyemp and dat_keypar=27
where per_keypro = ps_proceso
and extract(year from per_fecpag) = ps_ejercicio
and extract(month from per_fecpag) >= ps_mesini and extract(month from per_fecpag) <= ps_mesfin
and oracle.substr(h1.his_ca1aux,1,3) in ('001','501')
and agc_keyagr in (11,12,13,15) and h1.his_keynom not in (103,110)
and oracle.substr(h1.his_ca1aux,4,1) in ('1','3')
and emp_keyemp not in (select cry_dec006
from usrsiho.glwkcrys
where cry_nomrep = 'SqlNOTIN'
and cry_keyusu = ps_keyusu)
group by pam_cvesec, emp_keyemp, emp_regrfc, emp_recurp ,
emp_nomemp, emp_status,dat_valpar
order by  curp) loop
-- area geografica / claveentidad
------------------------------------------------------------
ls_cvesec := rec2.pam_cvesec;
ls_codempl := rec2.codigo;
ls_rfc := rec2.rfc;
ls_curp := rec2.curp;
--ls_paterno := rec2.paterno;
--ls_materno := rec2.materno;
--ls_nombres := rec2.nombres;
ls_paterno := sp_delimitador(rec2.emp_nomemp,'/',1);
ls_materno := sp_delimitador(rec2.emp_nomemp,'/',2);
ls_nombres := sp_delimitador(rec2.emp_nomemp,'/',3);
li_calcanual := rec2.calculoanual;
ld_ingasimasdos := rec2.ingasimasdos;
ld_isrretenido := rec2.isrretenido;
ld_isrconftaranual := rec2.isrconftaranual;
ld_mtosubacred := rec2.mtosubacred;
ld_imptoingacum := rec2.imptoingacum;
ls_empstatus := rec2.emp_status;
select pam_cvesec areageosmg, pam_folini claveentidad
into strict ls_aregeos, ls_cveentidad
from usrsiho.glcopams where pam_keypar = 'AEN' and pam_folfin = ls_cvesec;
------------------------------------------------------------
-- obtiene el dato de mes inicial y final de recibos
------------------------------------------------------------
begin
select min(extract(month from rec_feccob)), max(extract(month from rec_feccob))
into strict li_mesinirec, li_mesfinrec
from usrsiho.holoreci
where rec_ejerci = ps_ejercicio
and rec_keyemp = ls_codempl
and rec_keypro = ps_proceso
and rec_stsrec = 3;
exception when no_data_found then li_mesinirec := 0; li_mesfinrec := 0;
end;
-- obtiene el mes min y max de regimen fiscal del empleado
------------------------------------------------------------
begin
select min(extract(month from his_fecmov)), max(extract(month from his_fecmov))
into strict  li_mesinihis, li_mesfinhis
from usrsiho.nmlohism_cons, usrsiho.holoagcp
where agc_keyagr in (11,12,13,14,15,45)
and his_keycon=agc_keycon
and oracle.substr(his_ca1aux,1,3) in ('001','501')
and his_keynom not in (103,110)
and oracle.substr(his_ca1aux,4,1) in ('1','3')
and extract(year from his_fecmov) = ps_ejercicio
and his_keyemp = ls_codempl;
exception when no_data_found then li_mesinihis := 0; li_mesfinhis := 0;
end;
-- compara el mes inicial y final de recibos y regimenfiscal para una validacion
------------------------------------------------------------
if li_mesinirec = li_mesinihis and li_mesfinrec = li_mesfinhis then
li_mesini := li_mesinirec;
li_mesfin := li_mesfinrec;
else
select count(distinct oracle.substr(his_ca1aux,1,3))
into strict li_contregimen
from usrsiho.nmlohism_cons, usrsiho.holoagcp
where agc_keyagr in (11,12,13,14,15,45)
and his_keycon=agc_keycon
and his_keynom not in (103,110)
and oracle.substr(his_ca1aux,4,1) in ('1','3')
and his_keyemp = ls_codempl;
if li_contregimen > 1 then
li_mesini := li_mesinihis;
li_mesfin := li_mesfinhis;
else
li_mesini := li_mesinirec;
li_mesfin := li_mesfinrec;
end if;
end if;
-- inserta en la tabla glwkcrys para tabla de paso y seguir en visual el proceso
------------------------------------------------------------
insert into usrsiho.glwkcrys(cry_nomrep, cry_keyusu,
cry_chr001, cry_chr002, cry_dec006, cry_dec007, cry_chr003, cry_chr004, cry_chr005,
cry_chr006, cry_chr007, cry_chr008, cry_dec008, cry_dec009, cry_dec010,
cry_chr009, cry_chr040, cry_chr010, cry_chr011, cry_chr012,
cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr017, cry_chr018, cry_chr019, cry_chr020, cry_chr021,
cry_chr022, cry_chr023, cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_dec011, cry_dec012,
cry_chr029, cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
cry_dec013, cry_chr041, cry_chr035, cry_dec014, cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr042)
values (ps_programa, ps_keyusu,
ls_cvesec, ls_codempl, li_mesini, li_mesfin, ls_rfc, ls_curp, ls_paterno,
ls_materno, ls_nombres, ls_aregeos, li_calcanual, li_tarifautil, li_tarifa1991,
ls_propsub, li_sindicalizado, ls_siesasimsal, ls_cveentidad, ' ',
' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ls_vacio1, ls_vacio2, ls_vacio3,
ls_vacio4, ls_vacio5, ls_vacio6, ls_vacio7, ld_ingasimasdos, ld_isrretenido,
ls_vacio8, ls_vacio9, ls_vacio10, ls_vacio11, ls_vacio12, ls_vacio13,
ld_isrconftaranual, ld_mtosubacred, ls_vacio14, ld_imptoingacum, ls_vacio15,
ls_vacio16, ls_vacio17, ls_empstatus, ps_proceso);
------------------------------------------------------------
/* commit; */
end loop;
end if;
else   -- cuando la consulta es de constancias - word / txt
-- en caso que sea la consulta para todos los empleados-codigos
if ps_banempl = 0 then
if st_bansqlnotin = 0 then   -- caso de no aplicar filtro not in - empleado (impresion word)
-- genera un for de la consulta principal y hacer un insert del resultado
for rec3  in (select pam_cvesec, emp_keyemp codigo, emp_regrfc rfc, emp_recurp curp,
emp_nomemp,
case when dat_valpar='1' then '1'  else '2' end  calculoanual,
sum(case when agc_keyagr=11 then ((his_import)*1)  else 0 end ) ingasimasdos,
sum(case when agc_keyagr=15 then (his_import)*1  else 0 end ) isrretenido,
sum(case when agc_keyagr=15 then ((his_import)*1)  else 0 end )  isrconftaranual,
sum(case when agc_keyagr=79 then ((his_import)*1)  else 0 end )  mtosubacred,
sum(case when agc_keyagr=15 then (his_import)*1  else 0 end ) imptoingacum, emp_status
from usrsiho.nmlohism_cons h1
join usrsiho.nmloperi on per_keypro=h1.his_keypro and per_keyper = h1.his_keyper
join usrsiho.nmcoempl on h1.his_keyemp=emp_keyemp
join usrsiho.holoagcp on agc_keyagr in (11,12,13,14,15,45) and h1.his_keycon=agc_keycon
join usrsiho.glcopams g2 on g2.pam_keypar = 'H2' and g2.pam_cvesec = per_nu3aux
left join usrsiho.nmlodata on dat_keyemp=his_keyemp and dat_keypar=27
where per_keypro = ps_proceso
and extract(year from per_fecpag) = ps_ejercicio
and extract(month from per_fecpag) >= ps_mesini and extract(month from per_fecpag) <= ps_mesfin
and oracle.substr(h1.his_ca1aux,1,3) in ('001','501')
and agc_keyagr in (11,12,13,15) and h1.his_keynom not in (103,110)
and oracle.substr(h1.his_ca1aux,4,1) in ('1','3')
group by pam_cvesec, emp_keyemp, emp_regrfc, emp_recurp,
emp_nomemp, emp_status,dat_valpar
order by  curp) loop
-- area geografica / claveentidad
------------------------------------------------------------
ls_cvesec := rec3.pam_cvesec;
ls_codempl := rec3.codigo;
ls_rfc := rec3.rfc;
ls_curp := rec3.curp;
-- ls_paterno := rec3.paterno;
-- ls_materno := rec3.materno;
-- ls_nombres := rec3.nombres;
ls_paterno := sp_delimitador(rec3.emp_nomemp,'/',1);
ls_materno := sp_delimitador(rec3.emp_nomemp,'/',2);
ls_nombres := sp_delimitador(rec3.emp_nomemp,'/',3);
li_calcanual := rec3.calculoanual;
ld_ingasimasdos := rec3.ingasimasdos;
ld_isrretenido := rec3.isrretenido;
ld_isrconftaranual := rec3.isrconftaranual;
ld_mtosubacred := rec3.mtosubacred;
ld_imptoingacum := rec3.imptoingacum;
ls_empstatus := rec3.emp_status;
begin
select case when pam_cvesec = 1 then 'A'
when pam_cvesec = 2 then 'B'
when pam_cvesec = 3 then 'C'
end areageosmg,
pam_folini claveentidad
into strict ls_aregeos, ls_cveentidad
from usrsiho.glcopams
where pam_keypar = 'AEN'
and pam_folfin = ls_cvesec;
exception when no_data_found then ls_aregeos:= null; ls_cveentidad:= null;
end;
------------------------------------------------------------
-- obtiene el dato de mes inicial y final de recibos
------------------------------------------------------------
begin
select min(extract(month from rec_feccob)), max(extract(month from rec_feccob))
into strict li_mesinirec, li_mesfinrec
from usrsiho.holoreci
where rec_ejerci = ps_ejercicio
and rec_keyemp = ls_codempl
and rec_keypro = ps_proceso
and rec_stsrec = 3;
exception when no_data_found then li_mesinirec := 0; li_mesfinrec := 0;
end;
-- obtiene el mes min y max de regimen fiscal del empleado
------------------------------------------------------------
begin
select min(extract(month from his_fecmov)), max(extract(month from his_fecmov))
into strict  li_mesinihis, li_mesfinhis
from usrsiho.nmlohism_cons, usrsiho.holoagcp
where agc_keyagr in (11,12,13,14,15,45)
and his_keycon=agc_keycon
and oracle.substr(his_ca1aux,1,3) in ('001','501')
and his_keynom not in (103,110)
and oracle.substr(his_ca1aux,4,1) in ('1','3')
and extract(year from his_fecmov) = ps_ejercicio
and his_keyemp = ls_codempl;
exception when no_data_found then li_mesinihis := 0; li_mesfinhis := 0;
end;
-- compara el mes inicial y final de recibos y regimenfiscal para una validacion
------------------------------------------------------------
if li_mesinirec = li_mesinihis and li_mesfinrec = li_mesfinhis then
li_mesini := li_mesinirec;
li_mesfin := li_mesfinrec;
else
select count(distinct oracle.substr(his_ca1aux,1,3))
into strict li_contregimen
from usrsiho.nmlohism_cons, usrsiho.holoagcp
where agc_keyagr in (11,12,13,14,15,45)
and his_keycon=agc_keycon
and his_keynom not in (103,110)
and oracle.substr(his_ca1aux,4,1) in ('1','3')
and his_keyemp = ls_codempl;
if li_contregimen > 1 then
li_mesini := li_mesinihis;
li_mesfin := li_mesfinhis;
else
li_mesini := li_mesinirec;
li_mesfin := li_mesfinrec;
end if;
end if;
-- inserta en la tabla glwkcrys para tabla de paso y seguir en visual el proceso
------------------------------------------------------------
insert into usrsiho.glwkcrys(cry_nomrep, cry_keyusu,
cry_chr001, cry_chr002, cry_dec006, cry_dec007, cry_chr003, cry_chr004, cry_chr005,
cry_chr006, cry_chr007, cry_chr008, cry_dec008, cry_dec009, cry_dec010,
cry_chr009, cry_chr040, cry_chr010, cry_chr011, cry_chr012,
cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr017, cry_chr018, cry_chr019, cry_chr020, cry_chr021,
cry_chr022, cry_chr023, cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_dec011, cry_dec012,
cry_chr029, cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
cry_dec013, cry_chr041, cry_chr035, cry_dec014, cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr042)
values (ps_programa, ps_keyusu,
ls_cvesec, ls_codempl, li_mesini, li_mesfin, ls_rfc, ls_curp, ls_paterno,
ls_materno, ls_nombres, ls_aregeos, li_calcanual, li_tarifautil, li_tarifa1991,
ls_propsub, li_sindicalizado, ls_siesasimsal, ls_cveentidad, ' ',
' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ls_vacio1, ls_vacio2, ls_vacio3,
ls_vacio4, ls_vacio5, ls_vacio6, ls_vacio7, ld_ingasimasdos, ld_isrretenido,
ls_vacio8, ls_vacio9, ls_vacio10, ls_vacio11, ls_vacio12, ls_vacio13,
ld_isrconftaranual, ld_mtosubacred, ls_vacio14, ld_imptoingacum, ls_vacio15,
ls_vacio16, ls_vacio17, ls_empstatus, ps_proceso);
------------------------------------------------------------
/* commit; */
end loop;
else    --- caso de aplicar filtro de not in - empleados (impresion word)
-- genera un for de la consulta principal y hacer un insert del resultado
for rec4  in (select pam_cvesec, emp_keyemp codigo, emp_regrfc rfc, emp_recurp curp,
emp_nomemp,
case when dat_valpar='1' then '1'  else '2' end  calculoanual,
sum(case when agc_keyagr=11 then ((his_import)*1)  else 0 end ) ingasimasdos,
sum(case when agc_keyagr=15 then (his_import)*1  else 0 end ) isrretenido,
sum(case when agc_keyagr=15 then ((his_import)*1)  else 0 end )  isrconftaranual,
sum(case when agc_keyagr=79 then ((his_import)*1)  else 0 end )  mtosubacred,
sum(case when agc_keyagr=15 then (his_import)*1  else 0 end ) imptoingacum, emp_status
from usrsiho.nmlohism_cons h1
join usrsiho.nmloperi on per_keypro=h1.his_keypro and per_keyper = h1.his_keyper
join usrsiho.nmcoempl on h1.his_keyemp=emp_keyemp
join usrsiho.holoagcp on agc_keyagr in (11,12,13,14,15,45) and h1.his_keycon=agc_keycon
join usrsiho.glcopams g2 on g2.pam_keypar = 'H2' and g2.pam_cvesec = per_nu3aux
left join usrsiho.nmlodata on dat_keyemp=his_keyemp and dat_keypar=27
where per_keypro = ps_proceso
and extract(year from per_fecpag) = ps_ejercicio
and extract(month from per_fecpag) >= ps_mesini and extract(month from per_fecpag) <= ps_mesfin
and oracle.substr(h1.his_ca1aux,1,3) in ('001','501')
and agc_keyagr in (11,12,13,15) and h1.his_keynom not in (103,110)
and oracle.substr(h1.his_ca1aux,4,1) in ('1','3')
and emp_keyemp not in (select cry_dec006
from usrsiho.glwkcrys
where cry_nomrep = 'SqlNOTIN'
and cry_keyusu = ps_keyusu)
group by pam_cvesec, emp_keyemp , emp_regrfc , emp_recurp ,
emp_nomemp, emp_status,dat_valpar
order by  curp) loop
-- area geografica / claveentidad
------------------------------------------------------------
ls_cvesec := rec4.pam_cvesec;
ls_codempl := rec4.codigo;
ls_rfc := rec4.rfc;
ls_curp := rec4.curp;
--ls_paterno := rec4.paterno;
--ls_materno := rec4.materno;
--ls_nombres := rec4.nombres;
ls_paterno := sp_delimitador(rec4.emp_nomemp,'/',1);
ls_materno := sp_delimitador(rec4.emp_nomemp,'/',2);
ls_nombres := sp_delimitador(rec4.emp_nomemp,'/',3);
li_calcanual := rec4.calculoanual;
ld_ingasimasdos := rec4.ingasimasdos;
ld_isrretenido := rec4.isrretenido;
ld_isrconftaranual := rec4.isrconftaranual;
ld_mtosubacred := rec4.mtosubacred;
ld_imptoingacum := rec4.imptoingacum;
ls_empstatus := rec4.emp_status;
begin
select case when pam_cvesec = 1 then 'A'
when pam_cvesec = 2 then 'B'
when pam_cvesec = 3 then 'C'
end areageosmg,
pam_folini claveentidad
into strict ls_aregeos, ls_cveentidad
from usrsiho.glcopams
where pam_keypar = 'AEN'
and pam_folfin = ls_cvesec;
exception when no_data_found then ls_aregeos:= null; ls_cveentidad:= null;
end;
------------------------------------------------------------
-- obtiene el dato de mes inicial y final de recibos
------------------------------------------------------------
begin
select min(extract(month from rec_feccob)), max(extract(month from rec_feccob))
into strict li_mesinirec, li_mesfinrec
from usrsiho.holoreci
where rec_ejerci = ps_ejercicio
and rec_keyemp = ls_codempl
and rec_keypro = ps_proceso
and rec_stsrec = 3;
exception when no_data_found then li_mesinirec := 0; li_mesfinrec := 0;
end;
-- obtiene el mes min y max de regimen fiscal del empleado
------------------------------------------------------------
begin
select min(extract(month from his_fecmov)), max(extract(month from his_fecmov))
into strict  li_mesinihis, li_mesfinhis
from usrsiho.nmlohism_cons, usrsiho.holoagcp
where agc_keyagr in (11,12,13,14,15,45)
and his_keycon=agc_keycon
and oracle.substr(his_ca1aux,1,3) in ('001','501')
and his_keynom not in (103,110)
and oracle.substr(his_ca1aux,4,1) in ('1','3')
and extract(year from his_fecmov) = ps_ejercicio
and his_keyemp = ls_codempl;
exception when no_data_found then li_mesinihis := 0; li_mesfinhis := 0;
end;
-- compara el mes inicial y final de recibos y regimenfiscal para una validacion
------------------------------------------------------------
if li_mesinirec = li_mesinihis and li_mesfinrec = li_mesfinhis then
li_mesini := li_mesinirec;
li_mesfin := li_mesfinrec;
else
select count(distinct oracle.substr(his_ca1aux,1,3))
into strict li_contregimen
from usrsiho.nmlohism_cons, usrsiho.holoagcp
where agc_keyagr in (11,12,13,14,15,45)
and his_keycon=agc_keycon
and his_keynom not in (103,110)
and oracle.substr(his_ca1aux,4,1) in ('1','3')
and his_keyemp = ls_codempl;
if li_contregimen > 1 then
li_mesini := li_mesinihis;
li_mesfin := li_mesfinhis;
else
li_mesini := li_mesinirec;
li_mesfin := li_mesfinrec;
end if;
end if;
-- inserta en la tabla glwkcrys para tabla de paso y seguir en visual el proceso
------------------------------------------------------------
insert into usrsiho.glwkcrys(cry_nomrep, cry_keyusu,
cry_chr001, cry_chr002, cry_dec006, cry_dec007, cry_chr003, cry_chr004, cry_chr005,
cry_chr006, cry_chr007, cry_chr008, cry_dec008, cry_dec009, cry_dec010,
cry_chr009, cry_chr040, cry_chr010, cry_chr011, cry_chr012,
cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr017, cry_chr018, cry_chr019, cry_chr020, cry_chr021,
cry_chr022, cry_chr023, cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_dec011, cry_dec012,
cry_chr029, cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
cry_dec013, cry_chr041, cry_chr035, cry_dec014, cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr042)
values (ps_programa, ps_keyusu,
ls_cvesec, ls_codempl, li_mesini, li_mesfin, ls_rfc, ls_curp, ls_paterno,
ls_materno, ls_nombres, ls_aregeos, li_calcanual, li_tarifautil, li_tarifa1991,
ls_propsub, li_sindicalizado, ls_siesasimsal, ls_cveentidad, ' ',
' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ls_vacio1, ls_vacio2, ls_vacio3,
ls_vacio4, ls_vacio5, ls_vacio6, ls_vacio7, ld_ingasimasdos, ld_isrretenido,
ls_vacio8, ls_vacio9, ls_vacio10, ls_vacio11, ls_vacio12, ls_vacio13,
ld_isrconftaranual, ld_mtosubacred, ls_vacio14, ld_imptoingacum, ls_vacio15,
ls_vacio16, ls_vacio17, ls_empstatus, ps_proceso);
------------------------------------------------------------
/* commit; */
end loop;
end if;
-- en caso que se haya seleccionado consulta por codigos de las constancias
--limite de begin
else
if st_bansqlnotin = 0 then   -- caso de no aplicar filtro not in - empleado (impresion word)
-- genera un for de la consulta principal y hacer un insert del resultado
for rec5  in (select pam_cvesec, emp_keyemp codigo, emp_regrfc rfc, emp_recurp curp,
emp_nomemp,
case when dat_valpar='1' then '1'  else '2' end  calculoanual,
sum(case when agc_keyagr=11 then ((his_import)*1)  else 0 end ) ingasimasdos,
sum(case when agc_keyagr=15 then (his_import)*1  else 0 end ) isrretenido,
sum(case when agc_keyagr=15 then ((his_import)*1)  else 0 end )  isrconftaranual,
sum(case when agc_keyagr=79 then ((his_import)*1)  else 0 end )  mtosubacred,
sum(case when agc_keyagr=15 then (his_import)*1  else 0 end ) imptoingacum, emp_status
from usrsiho.nmlohism_cons h1
join usrsiho.nmloperi on per_keypro=h1.his_keypro and per_keyper = h1.his_keyper
join usrsiho.nmcoempl on h1.his_keyemp=emp_keyemp
join usrsiho.holoagcp on agc_keyagr in (11,12,13,14,15,45) and h1.his_keycon=agc_keycon
join usrsiho.glcopams g2 on g2.pam_keypar = 'H2' and g2.pam_cvesec = per_nu3aux
left join usrsiho.nmlodata on dat_keyemp=his_keyemp and dat_keypar=27
where per_keypro = ps_proceso
and extract(year from per_fecpag) = ps_ejercicio
and extract(month from per_fecpag) >= ps_mesini and extract(month from per_fecpag) <= ps_mesfin
and oracle.substr(h1.his_ca1aux,1,3) in ('001','501')
and agc_keyagr in (11,12,13,15) and h1.his_keynom not in (103,110)
and oracle.substr(h1.his_ca1aux,4,1) in ('1','3')
and emp_keyemp in (select cry_dec007
from usrsiho.glwkcrys
where cry_nomrep = 'SqlEmpIN'
and cry_keyusu = ps_keyusu)
group by pam_cvesec, emp_keyemp, emp_regrfc, emp_recurp,
emp_nomemp,emp_status,dat_valpar
order by  curp) loop
-- area geografica / claveentidad
------------------------------------------------------------
ls_cvesec := rec5.pam_cvesec;
ls_codempl := rec5.codigo;
ls_rfc := rec5.rfc;
ls_curp := rec5.curp;
--ls_paterno := rec5.paterno;
--ls_materno := rec5.materno;
--ls_nombres := rec5.nombres;
ls_paterno := sp_delimitador(rec5.emp_nomemp,'/',1);
ls_materno := sp_delimitador(rec5.emp_nomemp,'/',2);
ls_nombres := sp_delimitador(rec5.emp_nomemp,'/',3);
li_calcanual := rec5.calculoanual;
ld_ingasimasdos := rec5.ingasimasdos;
ld_isrretenido := rec5.isrretenido;
ld_isrconftaranual := rec5.isrconftaranual;
ld_mtosubacred := rec5.mtosubacred;
ld_imptoingacum := rec5.imptoingacum;
ls_empstatus := rec5.emp_status;
begin
select case when pam_cvesec = 1 then 'A'
when pam_cvesec = 2 then 'B'
when pam_cvesec = 3 then 'C'
end areageosmg,
pam_folini claveentidad
into strict ls_aregeos, ls_cveentidad
from usrsiho.glcopams
where pam_keypar = 'AEN'
and pam_folfin = ls_cvesec;
exception when no_data_found then ls_aregeos:= null; ls_cveentidad:= null;
end;
------------------------------------------------------------
-- obtiene el dato de mes inicial y final de recibos
------------------------------------------------------------
begin
select min(extract(month from rec_feccob)), max(extract(month from rec_feccob))
into strict li_mesinirec, li_mesfinrec
from usrsiho.holoreci
where rec_ejerci = ps_ejercicio
and rec_keyemp = ls_codempl
and rec_keypro = ps_proceso
and rec_stsrec = 3;
exception when no_data_found then li_mesinirec := 0; li_mesfinrec := 0;
end;
-- obtiene el mes min y max de regimen fiscal del empleado
------------------------------------------------------------
begin
select min(extract(month from his_fecmov)), max(extract(month from his_fecmov))
into strict  li_mesinihis, li_mesfinhis
from usrsiho.nmlohism_cons, usrsiho.holoagcp
where agc_keyagr in (11,12,13,14,15,45)
and his_keycon=agc_keycon
and oracle.substr(his_ca1aux,1,3) in ('001','501')
and his_keynom not in (103,110)
and oracle.substr(his_ca1aux,4,1) in ('1','3')
and extract(year from his_fecmov) = ps_ejercicio
and his_keyemp = ls_codempl;
exception when no_data_found then li_mesinihis := 0; li_mesfinhis := 0;
end;
-- compara el mes inicial y final de recibos y regimenfiscal para una validacion
------------------------------------------------------------
if li_mesinirec = li_mesinihis and li_mesfinrec = li_mesfinhis then
li_mesini := li_mesinirec;
li_mesfin := li_mesfinrec;
else
select count(distinct oracle.substr(his_ca1aux,1,3))
into strict li_contregimen
from usrsiho.nmlohism_cons, usrsiho.holoagcp
where agc_keyagr in (11,12,13,14,15,45)
and his_keycon=agc_keycon
and his_keynom not in (103,110)
and oracle.substr(his_ca1aux,4,1) in ('1','3')
and his_keyemp = ls_codempl;
if li_contregimen > 1 then
li_mesini := li_mesinihis;
li_mesfin := li_mesfinhis;
else
li_mesini := li_mesinirec;
li_mesfin := li_mesfinrec;
end if;
end if;
-- inserta en la tabla glwkcrys para tabla de paso y seguir en visual el proceso
------------------------------------------------------------
insert into usrsiho.glwkcrys(cry_nomrep, cry_keyusu,
cry_chr001, cry_chr002, cry_dec006, cry_dec007, cry_chr003, cry_chr004, cry_chr005,
cry_chr006, cry_chr007, cry_chr008, cry_dec008, cry_dec009, cry_dec010,
cry_chr009, cry_chr040, cry_chr010, cry_chr011, cry_chr012,
cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr017, cry_chr018, cry_chr019, cry_chr020, cry_chr021,
cry_chr022, cry_chr023, cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_dec011, cry_dec012,
cry_chr029, cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
cry_dec013, cry_chr041, cry_chr035, cry_dec014, cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr042)
values (ps_programa, ps_keyusu,
ls_cvesec, ls_codempl, li_mesini, li_mesfin, ls_rfc, ls_curp, ls_paterno,
ls_materno, ls_nombres, ls_aregeos, li_calcanual, li_tarifautil, li_tarifa1991,
ls_propsub, li_sindicalizado, ls_siesasimsal, ls_cveentidad, ' ',
' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ls_vacio1, ls_vacio2, ls_vacio3,
ls_vacio4, ls_vacio5, ls_vacio6, ls_vacio7, ld_ingasimasdos, ld_isrretenido,
ls_vacio8, ls_vacio9, ls_vacio10, ls_vacio11, ls_vacio12, ls_vacio13,
ld_isrconftaranual, ld_mtosubacred, ls_vacio14, ld_imptoingacum, ls_vacio15,
ls_vacio16, ls_vacio17, ls_empstatus, ps_proceso);
------------------------------------------------------------
/* commit; */
end loop;
else    --- caso de aplicar filtro de not in - empleados (impresion word)
-- genera un for de la consulta principal y hacer un insert del resultado
for rec6  in (select pam_cvesec, emp_keyemp codigo, emp_regrfc rfc, emp_recurp curp,
emp_nomemp,
case when dat_valpar='1' then '1'  else '2' end  calculoanual,
sum(case when agc_keyagr=11 then ((his_import)*1)  else 0 end ) ingasimasdos,
sum(case when agc_keyagr=15 then (his_import)*1  else 0 end ) isrretenido,
sum(case when agc_keyagr=15 then ((his_import)*1)  else 0 end )  isrconftaranual,
sum(case when agc_keyagr=79 then ((his_import)*1)  else 0 end )  mtosubacred,
sum(case when agc_keyagr=15 then (his_import)*1  else 0 end ) imptoingacum, emp_status
from usrsiho.nmlohism_cons h1
join usrsiho.nmloperi on per_keypro=h1.his_keypro and per_keyper = h1.his_keyper
join usrsiho.nmcoempl on h1.his_keyemp=emp_keyemp
join usrsiho.holoagcp on agc_keyagr in (11,12,13,14,15,45) and h1.his_keycon=agc_keycon
join usrsiho.glcopams g2 on g2.pam_keypar = 'H2' and g2.pam_cvesec = per_nu3aux
left join usrsiho.nmlodata on dat_keyemp=his_keyemp and dat_keypar=27
where per_keypro = ps_proceso
and extract(year from per_fecpag) = ps_ejercicio
and extract(month from per_fecpag) >= ps_mesini and extract(month from per_fecpag) <= ps_mesfin
and oracle.substr(h1.his_ca1aux,1,3) in ('001','501')
and agc_keyagr in (11,12,13,15) and h1.his_keynom not in (103,110)
and oracle.substr(h1.his_ca1aux,4,1) in ('1','3')
and emp_keyemp in (select cry_dec007
from usrsiho.glwkcrys
where cry_nomrep = 'SqlEmpIN'
and cry_keyusu = ps_keyusu)
and emp_keyemp not in (select cry_dec006
from usrsiho.glwkcrys
where cry_nomrep = 'SqlNOTIN'
and cry_keyusu = ps_keyusu)
group by pam_cvesec, emp_keyemp, emp_regrfc, emp_recurp,
emp_nomemp, emp_status,dat_valpar
order by  curp) loop
-- area geografica / claveentidad
------------------------------------------------------------
ls_cvesec := rec6.pam_cvesec;
ls_codempl := rec6.codigo;
ls_rfc := rec6.rfc;
ls_curp := rec6.curp;
--ls_paterno := rec6.paterno;
--ls_materno := rec6.materno;
--ls_nombres := rec6.nombres;
ls_paterno := sp_delimitador(rec6.emp_nomemp,'/',1);
ls_materno := sp_delimitador(rec6.emp_nomemp,'/',2);
ls_nombres := sp_delimitador(rec6.emp_nomemp,'/',3);
li_calcanual := rec6.calculoanual;
ld_ingasimasdos := rec6.ingasimasdos;
ld_isrretenido := rec6.isrretenido;
ld_isrconftaranual := rec6.isrconftaranual;
ld_mtosubacred := rec6.mtosubacred;
ld_imptoingacum := rec6.imptoingacum;
ls_empstatus := rec6.emp_status;
begin
select case when pam_cvesec = 1 then 'A'
when pam_cvesec = 2 then 'B'
when pam_cvesec = 3 then 'C'
end areageosmg,
pam_folini claveentidad
into strict ls_aregeos, ls_cveentidad
from usrsiho.glcopams
where pam_keypar = 'AEN'
and pam_folfin = ls_cvesec;
exception when no_data_found then ls_aregeos:= null; ls_cveentidad:= null;
end;
------------------------------------------------------------
-- obtiene el dato de mes inicial y final de recibos
------------------------------------------------------------
begin
select min(extract(month from rec_feccob)), max(extract(month from rec_feccob))
into strict li_mesinirec, li_mesfinrec
from usrsiho.holoreci
where rec_ejerci = ps_ejercicio
and rec_keyemp = ls_codempl
and rec_keypro = ps_proceso
and rec_stsrec = 3;
exception when no_data_found then li_mesinirec := 0; li_mesfinrec := 0;
end;
-- obtiene el mes min y max de regimen fiscal del empleado
------------------------------------------------------------
begin
select min(extract(month from his_fecmov)), max(extract(month from his_fecmov))
into strict  li_mesinihis, li_mesfinhis
from usrsiho.nmlohism_cons, usrsiho.holoagcp
where agc_keyagr in (11,12,13,14,15,45)
and his_keycon=agc_keycon
and oracle.substr(his_ca1aux,1,3) in ('001','501')
and his_keynom not in (103,110)
and oracle.substr(his_ca1aux,4,1) in ('1','3')
and extract(year from his_fecmov) = ps_ejercicio
and his_keyemp = ls_codempl;
exception when no_data_found then li_mesinihis := 0; li_mesfinhis := 0;
end;
-- compara el mes inicial y final de recibos y regimenfiscal para una validacion
------------------------------------------------------------
if li_mesinirec = li_mesinihis and li_mesfinrec = li_mesfinhis then
li_mesini := li_mesinirec;
li_mesfin := li_mesfinrec;
else
select count(distinct oracle.substr(his_ca1aux,1,3))
into strict li_contregimen
from usrsiho.nmlohism_cons, usrsiho.holoagcp
where agc_keyagr in (11,12,13,14,15,45)
and his_keycon=agc_keycon
and his_keynom not in (103,110)
and oracle.substr(his_ca1aux,4,1) in ('1','3')
and his_keyemp = ls_codempl;
if li_contregimen > 1 then
li_mesini := li_mesinihis;
li_mesfin := li_mesfinhis;
else
li_mesini := li_mesinirec;
li_mesfin := li_mesfinrec;
end if;
end if;
-- inserta en la tabla glwkcrys para tabla de paso y seguir en visual el proceso
------------------------------------------------------------
insert into usrsiho.glwkcrys(cry_nomrep, cry_keyusu,
cry_chr001, cry_chr002, cry_dec006, cry_dec007, cry_chr003, cry_chr004, cry_chr005,
cry_chr006, cry_chr007, cry_chr008, cry_dec008, cry_dec009, cry_dec010,
cry_chr009, cry_chr040, cry_chr010, cry_chr011, cry_chr012,
cry_chr013, cry_chr014, cry_chr015, cry_chr016, cry_chr017, cry_chr018, cry_chr019, cry_chr020, cry_chr021,
cry_chr022, cry_chr023, cry_chr024, cry_chr025, cry_chr026, cry_chr027, cry_chr028, cry_dec011, cry_dec012,
cry_chr029, cry_chr030, cry_chr031, cry_chr032, cry_chr033, cry_chr034,
cry_dec013, cry_chr041, cry_chr035, cry_dec014, cry_chr036, cry_chr037, cry_chr038, cry_chr039, cry_chr042)
values (ps_programa, ps_keyusu,
ls_cvesec, ls_codempl, li_mesini, li_mesfin, ls_rfc, ls_curp, ls_paterno,
ls_materno, ls_nombres, ls_aregeos, li_calcanual, li_tarifautil, li_tarifa1991,
ls_propsub, li_sindicalizado, ls_siesasimsal, ls_cveentidad, ' ',
' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ls_vacio1, ls_vacio2, ls_vacio3,
ls_vacio4, ls_vacio5, ls_vacio6, ls_vacio7, ld_ingasimasdos, ld_isrretenido,
ls_vacio8, ls_vacio9, ls_vacio10, ls_vacio11, ls_vacio12, ls_vacio13,
ld_isrconftaranual, ld_mtosubacred, ls_vacio14, ld_imptoingacum, ls_vacio15,
ls_vacio16, ls_vacio17, ls_empstatus, ps_proceso);
------------------------------------------------------------
/* commit; */
end loop;
end if;
end if;
end if;end;
$body$
language plpgsql
;
