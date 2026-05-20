create or replace procedure usrsiho."sp_holotrarph"  (pd_fechapag timestamp(0), pd_fechaact timestamp(0), pi_keyusu numeric, ps_fechapagdf varchar, ps_ide_pcc varchar, ps_num_enc numeric, ps_typefolio varchar, ps_keyare numeric, li_secrph inout numeric, ps_mensaje inout varchar, ps_sindkto inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--define ps_noforo varchar(20);            --foro/locacion
ps_gcxxii varchar(1);               --clausula xxii
ps_keydep varchar(16);              --centro de costos
--ps_sindkto varchar(15);             --sindicato (anda, sitatyr, conductor art, anda pensionada)
ps_regrfc varchar(13);              --rfc del empleado
ps_recurp varchar(18);              --curp del empleado
ps_tipinc varchar(2);               --tipo de incidencia (n-normal, jv-jornada de viaje, etc)
ps_viaticos varchar(20);            --campo con el detalle de los viaticos (desayuno, comida, cena, etc)
pi_num_id numeric(10);pi_serial numeric(10);pi_keyemp numeric(10);pi_nomina numeric(10);
pd_totcos decimal(16,4); --total del costo del rph
pi_totemp decimal(18,2); --total de empleado
pd_fecgra timestamp(0);                  --fecha de grabacion
pi_pasaje numeric(5);pi_vialoc numeric(5);pi_desayu numeric(5);pi_comida numeric(5);pi_cena numeric(5);pi_auxdcc numeric(5);
pi_corcom numeric(5);pi_corcen numeric(5);ps_descvia varchar(20);                --descripcion de viatico
ps_keyconvia varchar(20);           --clave del concepto segun el viatico
i numeric(5);                      --contador
pd_costvia decimal(16,4);        --costo del viatico
pi_valconcep numeric(10);            --validacion del concepto
--define pi_keycap integer;             --capitulo para el rph de la clausala xxii
pi_hraent numeric(10);               --hora de entrada
pi_hrasal numeric(10);               --hora de salida
pi_mincom numeric(10);               --minutos de comida
pi_keypro numeric(5);              --clave del proceso
--define pi_numcap integer;             --numero de capitulos de la incidencia
ps_capgra varchar(60);              --detalle de los capitilos grabados
pi_keygdp numeric(10);               --llave del detalle del rph (tabla: hologdpr)
pi_keyfol numeric(10);               --numero de contrato
--variables para crear los capitulos cuando no son consecutivos
pi_lencad numeric(10);               --longitud de la cadena
ps_caracter varchar(1);             --caracter evaluado dentro de la cadena
pi_inicial numeric(10);              --posicion inicial de la cadena
pi_final numeric(10);                --posicion final de la cadena
pi_auxiliar numeric(10);             --variable auxialiar para los calculos de la longitud de la cadena a cortar
pi_capini numeric(10);               --capitulo inicial a comparar
pi_capfin numeric(10);               --capitulo segundo a comparar
pi_continuos numeric(5);           --variable que determina si los capitulos son continuos o no
pi_numcap numeric(5);              --numero consecutivo de capitulo para agregarlo a la tabla temporal
pi_valdiafest numeric(5);      --valida si se calculara la incidencia por concepto de dia festivo
--ig-cons-0823
pi_keytco numeric(10);
type numlist is table of numeric;
rec record;
rec2 record;
rec3 record;
begin
--substituye a tipo ps_sindkto
--let ps_noforo = '';
ps_gcxxii := null;
ps_keydep := null;
ps_sindkto := null;
ps_regrfc := null;
ps_recurp := null;
ps_tipinc := null;
ps_viaticos := null;
pi_num_id := 0;
pi_totemp := 0;
li_secrph := 0;
pi_serial := 0;
pi_keyemp := 0;
pi_nomina := 0;
pd_totcos := 0;
pd_fecgra := pd_fechaact;
pi_pasaje := 0;
pi_vialoc := 0;
pi_desayu := 0;
pi_comida := 0;
pi_cena := 0;
pi_corcom := 0;
pi_corcen := 0;
pi_auxdcc := 0;
ps_descvia := null;
ps_keyconvia := null;
i := 0;
pd_costvia := 0;
pi_valconcep := 0;
pi_hraent := 0;
pi_hrasal := 0;
pi_mincom := 0;
pi_keypro := 0;
ps_capgra := null;
pi_keygdp := 0;
pi_keyfol := 0;
pi_valdiafest := 0;
--variables para crear los capitulos cuando no son consecutivos
pi_lencad := 0;
ps_caracter := null;
pi_inicial := 0;
pi_final := 0;
pi_auxiliar := 0;
pi_capini := 0;
pi_capfin := 0;
pi_continuos := 0;
pi_numcap := 0;
ps_mensaje := null;
--dbms_output.put_line('inicio store');
-- se agrega condicion del num folio para realizar proceso por registro car 02-dic-09
for rec in (select distinct enc_num_id,enc_keydep,det_sindkto,enc_gcxxii, det_keytco
from usrsiho.holoenctra,usrsiho.holodettra
where enc_num_id = det_num_id and
enc_stsrep = '2' and
det_stsreg = 'V' and
det_stspag = 'P' and
det_keytco in (2,3,519) and
enc_fecpag = pd_fechapag and
enc_num_id not in
(select enc_num_id
from usrsiho.holoenctra,usrsiho.holodettra,usrsiho.holocont
where enc_num_id = det_num_id and
det_keyfol = con_keyfol and
det_keyemp = con_keyemp and
det_stspag = 'P' and
det_stsreg = 'V' and
enc_stsrep = '2' and
det_keytco in (2,3,519) and
--                                       det_sindkto in ('ANDA','SITATYR','CONDUCTOR ART','ANDA PENSIONADA') and --jcro 10/agosto/2011 cons-0530 se cambio por el campo det_keytco
enc_fecpag = pd_fechapag and
--((det_tipinc = 'N') and
(det_tipinc = 'N' and
--(con_stspag <> 'V' or
(trim(both det_hraent) = null or
trim(both det_hrasal) = null or
nullif(det_capfin::text, '') is null or
trim(both det_capgra) = null))
)
and enc_num_id = ps_num_enc
order by  enc_num_id,enc_keydep,det_sindkto,enc_gcxxii) loop
pi_num_id := rec.enc_num_id;
ps_keydep := rec.enc_keydep;
ps_sindkto := rec.det_sindkto;
ps_gcxxii := rec.enc_gcxxii;
pi_keytco := rec.det_keytco;
pd_totcos := 0;
pi_totemp := 0;
insert into usrsiho.tmp_hjatrab values (pi_num_id);
begin
select enc_fecgra,enc_keypro
into strict pd_fecgra, pi_keypro
from usrsiho.holoenctra
where enc_num_id = pi_num_id;
exception when no_data_found then pd_fecgra:= null; pi_keypro := 0;
end;
--  ----------------------------------------------------------------------------------------
--  dependiendo del sindicato es como graba el rph
--  ----------------------------------------------------------------------------------------
--ig-cons-0823
--comentado para validacion por llave
--if ps_sindkto = 'ANDA' or ps_sindkto ='ANDA PENSIONADA' then
--ig-cons-0823
--substituye para validacion por llave
if pi_keytco = 2 then
if ps_sindkto = 'ANDA' then
pi_nomina := 110;
else
pi_nomina := 210;
end if;
--  ----------------------------------------------------------------------------------------------
--  consulta para generar los diferentes tipos de rph con el tipo de sindicato anda
--  ----------------------------------------------------------------------------------------------
--  -------------------------------
--  inserta el encabezado del rph
--  -------------------------------}
-- se asigna variable ps_typefolio en uno de los campos a insertar car 02-dic-09
insert into usrsiho.holofrph(frp_keydep,frp_keyper,frp_fecact,frp_stsfol,frp_totcos,frp_keyusu,frp_keynom,
frp_repeti,frp_tiptra,frp_fecsol,frp_fecitr,frp_fectrab,frp_forpag,frp_tipcam,
frp_pertra,frp_tipfol,frp_totemp,frp_keypro,frp_unifor,frp_transp,frp_ident,frp_keyare)
select enc_keydep,'0',pd_fechaact,'0',pd_totcos,pi_keyusu,pi_nomina,
'N','G',pd_fechapag,enc_fecgra,enc_fecgra,1,1.0000,
1,ps_typefolio,pi_totemp,enc_keypro,0,0,case when enc_gcxxii = 'N' then 'P' else 'S' end,ps_keyare
from usrsiho.holoenctra
where enc_num_id = pi_num_id;
-- ---------------------------------
-- lectura del secuencial del rph
-- ---------------------------------
select currval('holofrph_seq') into strict li_secrph;
insert into usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001) values ('holotrarp2',ps_ide_pcc,pi_keyusu,li_secrph,'RPH ACTUAL');
--  ----------------------------------------------------------------------------------------------
--  consulta para insertar cada una de las insidencias de la hoja de trabajo (foreach del detalle)
--  ----------------------------------------------------------------------------------------------
for rec2 in (select det_serial,det_keyemp,det_num_id,det_auxca2,det_tipinc
from usrsiho.holoenctra,usrsiho.holodettra,usrsiho.holocont
where enc_num_id = det_num_id and
det_keyfol = con_keyfol and
det_keyemp = con_keyemp and
det_stspag = 'P' and
det_stsreg = 'V' and
enc_stsrep = '2' and
enc_fecpag = pd_fechapag and
enc_keydep = ps_keydep and
det_sindkto = ps_sindkto and
det_keyemp > 0 and
det_keyfol > 0 and
enc_num_id = pi_num_id
union
select det_serial,det_keyemp,det_num_id,det_auxca2,det_tipinc
from usrsiho.holoenctra,usrsiho.holodettra
where enc_num_id = det_num_id and
det_stspag = 'P' and
det_stsreg = 'V' and
enc_stsrep = '2' and
enc_fecpag = pd_fechapag and
enc_keydep = ps_keydep and
det_sindkto = ps_sindkto and
det_keyemp > 0 and
enc_num_id = pi_num_id
order by  1) loop
pi_serial := rec2.det_serial;
pi_keyemp := rec2.det_keyemp;
pi_num_id := rec2.det_num_id;
ps_viaticos := rec2.det_auxca2;
ps_tipinc := rec2.det_tipinc;
pi_valconcep := 0;
-- -------------------------------------------------
-- consulta para obtener el rfc y curp del empleado
-- -------------------------------------------------
begin
select emp_regrfc,emp_recurp
into strict ps_regrfc, ps_recurp
from usrsiho.nmcoempl
where emp_keyemp = pi_keyemp;
exception when no_data_found then ps_regrfc:= null; ps_recurp:= null;
end;
begin
select (oracle.substr(det_auxca2,1,1))::numeric ,(oracle.substr(det_auxca2,2,1))::numeric ,(oracle.substr(det_auxca2,3,1))::numeric ,(oracle.substr(det_auxca2,4,1))::numeric ,(oracle.substr(det_auxca2,5,1))::numeric ,(oracle.substr(det_auxca2,9,1))::numeric ,(oracle.substr(det_auxca2,10,1))::numeric ,(oracle.substr(det_auxca2,8,1))::numeric
into strict pi_pasaje, pi_vialoc, pi_desayu, pi_comida, pi_cena ,pi_corcom, pi_corcen, pi_valdiafest
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then pi_pasaje := 0; pi_vialoc := 0; pi_desayu := 0; pi_comida := 0; pi_cena := 0; pi_corcom := 0; pi_corcen := 0; pi_valdiafest := 0;
end;
-- --------------------------------------------------------------------------------------------------------
--si es una incidencia normal y tiene marcados viaticos (pasaje, viaticos locacion, desayuno, comida, cena)
-- --------------------------------------------------------------------------------------------------------
if ( ps_tipinc = 'N' or ps_tipinc = 'JV' or ps_tipinc = 'JE'  ) and (pi_pasaje+pi_vialoc+pi_desayu+pi_comida+pi_cena) > 0 then --ig-cons-0823 substituye
i := 1;
while i <= 5 loop
ps_descvia := case when i = 1 then 'PASAJES'
when i = 2 then 'VIATICOS LOCACION'
when i = 3 then 'DESAYUNO'
when i = 4 then 'COMIDA'
when i = 5 then 'CENA'
else ''
end;
pi_auxdcc := case when i = 1 then pi_pasaje
when i = 2 then pi_vialoc
when i = 3 then pi_desayu
when i = 4 then pi_comida
when i = 5 then pi_cena
else 0
end;
if pi_auxdcc > 0 then
-- -------------------------------------------------------
--ingresa un registro por cada concepto de viatico marcado
-- -------------------------------------------------------
-- ------------------------------
--obtenemos la clave del concepto
-- ------------------------------
begin
select pue_ca5aux
into strict ps_keyconvia
from usrsiho.nmcopues
where pue_keypue =
(select pam_cvesec
from usrsiho.glcopams
where pam_keypar = 'AJEV' and
pam_folini ='GM' and
pam_nompar = ps_descvia
);
exception when no_data_found then ps_keyconvia:= null;
end;/* dmap converted statement start */
ps_keyconvia := concat( trim(both ps_keyconvia), trim(both ps_descvia)) ;/* dmap converted statement end */
-- -----------------------------
--obtenemos el costo del viatico
-- -----------------------------
begin
select (pam_folini)::numeric
into strict pd_costvia
from usrsiho.glcopams
where pam_keypar = 'ACP' and
pam_nompar = ps_descvia;
exception when no_data_found then pd_costvia := 0;
end;
-- ------------------------------------
-- inserta el detalle del rph (viatico)
-- ------------------------------------
call usrsiho.sp_holoaltinc (pi_keyemp,1,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,1,1,0,0,0,0,0);
end if;
i := i::numeric + 1;
pi_auxdcc := 0;
end loop;
end if;
pi_pasaje := 0;
pi_vialoc := 0;
pi_desayu := 0;
pi_comida := 0;
pi_cena := 0;
pi_auxdcc := 0;
-- ------------------------------------------------
-- inserta el detalle del rph (viatico dia festivo)
-- ------------------------------------------------
if pi_valdiafest > 0 then
call usrsiho.sp_holotrarph_df (li_secrph,pd_fechaact,pd_fechapag,pi_keyemp,pi_num_id,pi_serial,pi_keyusu,ps_fechapagdf,pi_keypro);
pi_valdiafest := 0;
end if;
-- -----------------------------------------------
-- obtiene el numero de capitulos de la incidencia
-- -----------------------------------------------
begin
select coalesce(det_capfin,0), det_capgra, det_keyfol
into strict pi_numcap, ps_capgra, pi_keyfol
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then pi_numcap := 0; ps_capgra:= null; pi_keyfol:= null;
end;
if ((ps_tipinc = 'N'  and pi_valdiafest = 0) or ps_tipinc = 'LI') then --comentada 'IG-CONS-0823'
if pi_numcap > 1 then
pi_inicial := 1;
pi_final := 1;
pi_capini := 1;
pi_auxiliar := 1;
pi_continuos := 1;
pi_numcap := 1;
pi_lencad := length(trim(both ps_capgra));
while pi_final <= pi_lencad loop
ps_caracter := oracle.substr(ps_capgra , pi_final , 1);
if ps_caracter = ',' or pi_final = pi_lencad then
if pi_lencad = pi_final then pi_auxiliar := pi_final + 1; else pi_auxiliar := pi_final; end if;
if pi_inicial = 1 then
pi_capini := (oracle.substr(ps_capgra , pi_inicial , pi_auxiliar - pi_inicial))::numeric;
pi_capfin := 0;
else
pi_capfin := pi_capini;
pi_capini := (oracle.substr(ps_capgra , pi_inicial , pi_auxiliar - pi_inicial))::numeric;
end if;
insert into usrsiho.tmp_hologdpr values (pi_numcap,pi_capini);
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
if pi_continuos = 1 then
-- ------------------------------------------------------------------------
-- inserta el detalle del rph con el rango de todos los capitulos continuos
-- ------------------------------------------------------------------------
begin
select min(capitulo), max(capitulo)
into strict pi_capini, pi_capfin
from usrsiho.tmp_hologdpr;
exception when no_data_found then pi_capini := 0; pi_capfin := 0;
end;
if ps_tipinc <> 'N' then
pi_hraent := 0;
pi_hrasal := 0;
pi_mincom := 0;
else
begin
select (oracle.substr(det_hraent , 1 , 2))::numeric  * 60 + (oracle.substr(det_hraent::numeric , 4 , 2))::numeric ,(oracle.substr(det_hrasal , 1 , 2))::numeric  * 60 + (oracle.substr(det_hrasal::numeric , 4 , 2))::numeric ,
case when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then 30
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then 0
else 0
end
into strict pi_hraent, pi_hrasal, pi_mincom
from usrsiho.holoenctra, usrsiho.holodettra
where enc_num_id = det_num_id and
det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then pi_hraent := 0; pi_hrasal := 0; pi_mincom := 0;
end;
end if;
-- ---------------------
-- graba las incidencias
-- ---------------------
call usrsiho.sp_holoaltinc (pi_keyemp,2,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capfin,pi_hraent,pi_hrasal,pi_mincom,0,0);
else
begin
select min(keycapitulo),max(keycapitulo)
into strict pi_inicial,pi_final
from usrsiho.tmp_hologdpr;
exception when no_data_found then pi_inicial := 0; pi_final :=0;
end;
while pi_inicial <= pi_final loop
begin
select capitulo
into strict pi_capini
from usrsiho.tmp_hologdpr
where keycapitulo = pi_inicial;
exception when no_data_found then pi_capini := 0;
end;
if ps_tipinc <> 'N' then
pi_hraent := 0;
pi_hrasal := 0;
pi_mincom := 0;
else
begin
select (oracle.substr(det_hraent , 1 , 2))::numeric  * 60 + (oracle.substr(det_hraent::numeric , 4 , 2))::numeric ,(oracle.substr(det_hrasal , 1 , 2))::numeric  * 60 + (oracle.substr(det_hrasal::numeric , 4 , 2))::numeric ,
case when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then 30
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then 0
else 0
end
into strict pi_hraent,pi_hrasal,pi_mincom
from usrsiho.holoenctra, usrsiho.holodettra
where enc_num_id = det_num_id and
det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then pi_hraent := 0; pi_hrasal := 0; pi_mincom := 0;
end;
end if;
-- ---------------------
-- graba las incidencias
-- ---------------------
call usrsiho.sp_holoaltinc (pi_keyemp,2,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capini,pi_hraent,pi_hrasal,pi_mincom,pi_inicial,0);
pi_inicial := pi_inicial + 1;
end loop;
delete from usrsiho.tmp_hologdpr;
end if;
else
-- -----------------------------------------------------
-- inserta el detalle del rph cuando solo es un capitulo
-- -----------------------------------------------------
if ps_tipinc <> 'N' then
pi_hraent := 0;
pi_hrasal := 0;
pi_mincom := 0;
begin
select (det_capgra)::numeric
into strict pi_capini
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then pi_capini := 0;
end;
else
begin
select (oracle.substr(det_hraent , 1 , 2))::numeric  * 60 + (oracle.substr(det_hraent::numeric , 4 , 2))::numeric ,(oracle.substr(det_hrasal , 1 , 2))::numeric  * 60 + (oracle.substr(det_hrasal::numeric , 4 , 2))::numeric ,
case when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then 30
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then 0
else 0
end,(det_capgra)::numeric
into strict pi_hraent, pi_hrasal, pi_mincom, pi_capini
from usrsiho.holoenctra, usrsiho.holodettra
where enc_num_id = det_num_id and
det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then pi_hraent := 0; pi_hrasal := 0; pi_mincom := 0; pi_capini :=0;
end;
end if;
-- ---------------------
-- graba las incidencias
-- ---------------------
call usrsiho.sp_holoaltinc (pi_keyemp,2,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capini,pi_hraent,pi_hrasal,pi_mincom,ps_capgra,1);
end if;
else
-- ------------------------------------------------------------------
-- inserta el detalle del rph cuando la inidencia es diferente de 'N'
-- ------------------------------------------------------------------
call usrsiho.sp_holoaltinc (pi_keyemp,3,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capini,pi_hraent,pi_hrasal,pi_mincom,ps_capgra,0);
end if;
update usrsiho.holodettra
set det_stspag = 'T',
det_keyrph = li_secrph
where det_num_id = pi_num_id and
det_serial = pi_serial;
/* commit; */
end loop;
--  ----------------------------------------------------------------------------------
--  calcula el total del costo de la hoja de trabajo y la suma del numero de empleado
--  ----------------------------------------------------------------------------------
begin
select sum(gdp_numcap * gdp_cosuni::numeric), sum(gdp_keyemp)
into strict pd_totcos, pi_totemp
from usrsiho.hologdpr
where gdp_keyrph = li_secrph;
exception when no_data_found then pd_totcos := 0; pi_totemp := 0;
end;
update usrsiho.holofrph
set frp_totcos = pd_totcos,
frp_totemp = pi_totemp
where frp_keyrph = li_secrph;
--end foreach
else
--ig-cons-0823
--comentado para validacion por llave
--if ps_sindkto = 'SITATYR' then
--ig-cons-0823
--substituye para validacion por llave
if pi_keytco = 3 then
--let pi_nomina = 106;
begin
select  case when emp_tipemp = 'I' and nullif(ale_keyem2::text, '') is not null then 102 else 106 end
into strict    pi_nomina
from    usrsiho.holodettra, usrsiho.nmcoempl, usrsiho.holoalem
where   det_num_id = pi_num_id
and emp_keyemp = det_keyemp
and ale_keyemp = emp_keyemp
and det_serial = (select min(det_serial) from holodettra where det_num_id = pi_num_id );
exception when no_data_found then pi_nomina := 0;
end;
else
--let pi_nomina = 104;
begin
select  case when emp_tipemp = 'I' and nullif(ale_keyem2::text, '') is not null then 102 else 104 end
into strict    pi_nomina
from    usrsiho.holodettra, usrsiho.nmcoempl, usrsiho.holoalem
where   det_num_id = pi_num_id
and emp_keyemp = det_keyemp
and ale_keyemp = emp_keyemp
and det_serial = (select min(det_serial) from usrsiho.holodettra where det_num_id = pi_num_id );
exception when no_data_found then pi_nomina := 0;
end;
end if;
--insert into tmp_errores values(0,0,0,0,'OTRO SINDICATO','',ps_sindkto);
--  -------------------------------
--  inserta el encabezado del rph
--  -------------------------------
--insert into tmp_errores values(0,0,0,0,'INSERTA ENCABEZADO','','');
-- se asigna variable ps_typefolio en uno de los campos a insertar car 02-dic-09
-- dbms_output.put_line(pi_num_id);
insert into usrsiho.holofrph(frp_keydep,frp_keyper,frp_fecact,frp_stsfol,frp_totcos,frp_keyusu,frp_keynom,
frp_repeti,frp_tiptra,frp_fecsol,frp_fecitr,frp_fectrab,frp_forpag,frp_tipcam,
frp_pertra,frp_tipfol,frp_totemp,frp_keypro,frp_unifor,frp_transp,frp_ident,frp_keyare)
select enc_keydep,'0',pd_fechaact,'0',pd_totcos,pi_keyusu,pi_nomina,
'N','G',pd_fechapag,enc_fecgra,enc_fecgra,1,1.0000,
1,ps_typefolio,pi_totemp,enc_keypro,0,0,'P',ps_keyare
from usrsiho.holoenctra
where enc_num_id = pi_num_id;
-- ---------------------------------
-- lectura del secuencial del rph
-- ---------------------------------
select currval('holofrph_seq') into strict li_secrph;
insert into usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec,cry_chr001) values ('holotrarp2',ps_ide_pcc,pi_keyusu,li_secrph,'RPH ACTUAL');
--  ----------------------------------------------------------------------------------------------
--  consulta para insertar cada una de las insidencias de la hoja de trabajo (foreach del detalle)
--  ----------------------------------------------------------------------------------------------
for rec3 in (select det_serial,det_keyemp,det_auxca2,det_tipinc
from usrsiho.holoenctra,usrsiho.holodettra,usrsiho.holocont
where enc_num_id = det_num_id and
det_keyfol = con_keyfol and
det_keyemp = con_keyemp and
det_stspag = 'P' and
det_stsreg = 'V' and
enc_stsrep = '2' and
enc_fecpag = pd_fechapag and
enc_keydep = ps_keydep and
det_sindkto = ps_sindkto and
det_keyemp > 0 and
det_keyfol > 0 and
enc_num_id = pi_num_id
union all
select det_serial,det_keyemp,det_auxca2,det_tipinc
from usrsiho.holoenctra,usrsiho.holodettra
where enc_num_id = det_num_id and
det_stspag = 'P' and
det_stsreg = 'V' and
enc_stsrep = '2' and
enc_fecpag = pd_fechapag and
enc_keydep = ps_keydep and
det_sindkto = ps_sindkto and
det_keyemp > 0 and
enc_num_id = pi_num_id and
nullif(det_keyfol::text, '') is null and
det_tipinc <> 'N'
order by  1) loop
-- -------------------------------------------------
-- consulta para obtener el rfc y curp del empleado
-- -------------------------------------------------
pi_serial := rec3.det_serial;
pi_keyemp := rec3.det_keyemp;
ps_viaticos := rec3.det_auxca2;
ps_tipinc := rec3.det_tipinc;
select emp_regrfc,emp_recurp
into strict   ps_regrfc,ps_recurp
from usrsiho.nmcoempl
where emp_keyemp = pi_keyemp;
begin
select (oracle.substr(det_auxca2,1,1))::numeric ,(oracle.substr(det_auxca2,2,1))::numeric ,(oracle.substr(det_auxca2,3,1))::numeric ,(oracle.substr(det_auxca2,4,1))::numeric ,(oracle.substr(det_auxca2,5,1))::numeric ,(oracle.substr(det_auxca2,9,1))::numeric ,(oracle.substr(det_auxca2,10,1))::numeric ,(oracle.substr(det_auxca2,8,1))::numeric
into strict pi_pasaje, pi_vialoc, pi_desayu, pi_comida, pi_cena, pi_corcom, pi_corcen, pi_valdiafest
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then pi_pasaje := 0; pi_vialoc := 0; pi_desayu := 0;
pi_comida := 0; pi_cena := 0; pi_corcom := 0; pi_corcen := 0; pi_valdiafest :=0;
end;
-- --------------------------------------------------------------------------------------------------------
--si es una incidencia normal y tiene marcados viaticos (pasaje, viaticos locacion, desayuno, comida, cena)
-- --------------------------------------------------------------------------------------------------------
--if ps_tipinc = 'N' and (pi_pasaje+pi_vialoc+pi_desayu+pi_comida+pi_cena) > 0 then 'IG-CONS-0823 Comentado'
if (ps_tipinc = 'N' or ps_tipinc='JV' or ps_tipinc='JE') and (pi_pasaje+pi_vialoc+pi_desayu+pi_comida+pi_cena) > 0 then --ig-cons-0823 substituye
-- -------------------------------------------------------
--i = 1 pasajes, i = 2 viaticos locacion, i = 3  desayuno,
--i = 4 comida,  i = 5 cena
-- -------------------------------------------------------
i := 1;
while i <= 5 loop
ps_descvia := case when i = 1 then 'PASAJES'
when i = 2 then 'VIATICOS LOCACION'
when i = 3 then 'DESAYUNO'
when i = 4 then 'COMIDA'
when i = 5 then 'CENA'
else ''
end;
pi_auxdcc := case when i = 1 then pi_pasaje
when i = 2 then pi_vialoc
when i = 3 then pi_desayu
when i = 4 then pi_comida
when i = 5 then pi_cena
else 0
end;
if pi_auxdcc > 0 then
-- -------------------------------------------------------
--ingresa un registro por cada concepto de viatico marcado
-- -------------------------------------------------------
-- ------------------------------
--obtenemos la clave del concepto
-- ------------------------------
begin
select pue_ca5aux
into strict ps_keyconvia
from usrsiho.nmcopues
where pue_keypue =
(select pam_cvesec
from usrsiho.glcopams
where pam_keypar = 'AJEV' and
pam_folini ='GM' and
pam_nompar = ps_descvia
--(select det_keypue
-- from holodettra
-- where det_num_id = pi_num_id and
--       det_serial = pi_serial
--)
);
exception when no_data_found then ps_keyconvia:= null;
end;
-- -----------------------------
--obtenemos el costo del viatico
-- -----------------------------
begin
select (pam_folini)::numeric
into strict pd_costvia
from usrsiho.glcopams
where pam_keypar = 'ACP' and
pam_nompar = ps_descvia;/* dmap converted statement start */
ps_keyconvia := concat( trim(both ps_keyconvia), trim(both ps_descvia)) ;/* dmap converted statement end */
exception when no_data_found then pd_costvia := 0;
end;
-- ------------------------------------
-- inserta el detalle del rph (viatico)
-- ------------------------------------
--insert into tmp_errores values(0,0,0,0,'INSERTA VIATICOS <> ANDA','','');
--insert into tmp_errores values(0,pi_keyemp,li_secrph,pd_costvia,'pi_keyemp','li_secrph','pd_costvia');
--insert into tmp_errores values(0,pi_keyusu,pi_num_id,pi_serial,'pi_keyusu','pi_num_id','pi_serial');
--insert into tmp_errores values(0,pi_keypro,0,0,'pi_keypro','ps_keyconvia','');
call sp_holoaltinc (pi_keyemp,1,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,1,1,0,0,0,0,0);
end if;
i := i::numeric + 1;
pi_auxdcc := 0;
end loop;
end if;
pi_pasaje := 0;
pi_vialoc := 0;
pi_desayu := 0;
pi_comida := 0;
pi_cena := 0;
pi_auxdcc := 0;
-- ------------------------------------------------
-- inserta el detalle del rph (viatico dia festivo)
-- ------------------------------------------------
if pi_valdiafest > 0 then
if pi_keyemp = 490212363 then
pi_keyemp := 490212363;
end if;
call usrsiho.sp_holotrarph_df (li_secrph,pd_fechaact,pd_fechapag,pi_keyemp,pi_num_id,pi_serial,pi_keyusu,ps_fechapagdf,pi_keypro);
pi_valdiafest := 0;
end if;
-- -----------------------------------------------
-- obtiene el numero de capitulos de la incidencia
-- -----------------------------------------------
begin
select coalesce(det_capfin,0),det_capgra,det_keyfol
into strict pi_numcap, ps_capgra, pi_keyfol
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then pi_numcap := 0; ps_capgra:= null; pi_keyfol := 0;
end;
--                   if (ps_tipinc = 'N' or ps_tipinc = 'LI') then --condicion inhabilitada
--if ((ps_tipinc = 'N' and pi_valdiafest = 0) or ps_tipinc = 'LI') then 'IG-CONS-0823 Comentada'
if (((ps_tipinc = 'N' ) and pi_valdiafest = 0) or ps_tipinc = 'LI') then --ig-cons-0823 substituye
if pi_numcap > 1 then
--insert into tmp_errores values(0,pi_numcap,0,0,'NUM CAP > 1 NO ANDA',ps_tipinc,'');
pi_inicial := 1;
pi_final := 1;
pi_capini := 1;
pi_auxiliar := 1;
pi_continuos := 1;
pi_numcap := 1;
pi_lencad := length(trim(both ps_capgra));
while pi_final <= pi_lencad loop
ps_caracter := oracle.substr(ps_capgra , pi_final , 1);
if (ps_caracter = ',') or (pi_final = pi_lencad ) then
if pi_lencad = pi_final then pi_auxiliar := pi_final + 1; else pi_auxiliar := pi_final; end if;
if pi_inicial = 1 then
pi_capini := (oracle.substr(ps_capgra , pi_inicial , pi_auxiliar - pi_inicial))::numeric;
pi_capfin := 0;
else
pi_capfin := pi_capini;
pi_capini := (oracle.substr(ps_capgra , pi_inicial , pi_auxiliar - pi_inicial))::numeric;
end if;
insert into usrsiho.tmp_hologdpr values (pi_numcap,pi_capini);
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
--insert into tmp_errores values(0,pi_continuos,pi_numcap,pi_capini,'pi_continuos','pi_numcap','pi_capini');
if pi_continuos = 1 then
-- ------------------------------------------------------------------------
-- inserta el detalle del rph con el rango de todos los capitulos continuos
-- ------------------------------------------------------------------------
--insert into tmp_errores values(0,0,0,0,'SI ES CONTINUO','','');
select min(capitulo),max(capitulo)
into strict pi_capini,pi_capfin
from usrsiho.tmp_hologdpr;
if ps_tipinc <> 'N' then
pi_hraent := 0;
pi_hrasal := 0;
pi_mincom := 0;
else
begin
select (oracle.substr(det_hraent , 1 , 2))::numeric  * 60 + (oracle.substr(det_hraent::numeric , 4 , 2))::numeric ,(oracle.substr(det_hrasal , 1 , 2))::numeric  * 60 + (oracle.substr(det_hrasal::numeric , 4 , 2))::numeric ,
case when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then 30
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then 0
else 0
end
into strict pi_hraent,pi_hrasal,pi_mincom
from usrsiho.holoenctra, usrsiho.holodettra
where enc_num_id = det_num_id and
det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then pi_hraent := 0; pi_hrasal := 0; pi_mincom := 0;
end;
end if;
-- ---------------------
-- graba las incidencias
-- ---------------------
call sp_holoaltinc (pi_keyemp,2,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capfin,pi_hraent,pi_hrasal,pi_mincom,0,0);
else
select min(keycapitulo), max(keycapitulo)
into strict pi_inicial,  pi_final
from usrsiho.tmp_hologdpr;
while pi_inicial <= pi_final loop
begin
select capitulo
into strict pi_capini
from usrsiho.tmp_hologdpr
where keycapitulo = pi_inicial;
exception when no_data_found then pi_capini := 0;
end;
if ps_tipinc <> 'N' then
pi_hraent := 0;
pi_hrasal := 0;
pi_mincom := 0;
else
begin
select (oracle.substr(det_hraent , 1 , 2))::numeric  * 60 + (oracle.substr(det_hraent::numeric , 4 , 2))::numeric ,(oracle.substr(det_hrasal , 1 , 2))::numeric  * 60 + (oracle.substr(det_hrasal::numeric , 4 , 2))::numeric ,
case when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then 30
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then 0
else 0
end
into strict pi_hraent, pi_hrasal, pi_mincom
from usrsiho.holoenctra, usrsiho.holodettra
where enc_num_id = det_num_id and
det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then pi_hraent := 0; pi_hrasal := 0; pi_mincom := 0;
end;
end if;
-- ---------------------
-- graba las incidencias
-- ---------------------
--insert into tmp_errores values(0,0,0,0,'INSERT INCID <> ANDA UNO X UNO','','');
call usrsiho.sp_holoaltinc (pi_keyemp,2,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capini,pi_hraent,pi_hrasal,pi_mincom,pi_inicial,0);
pi_inicial := pi_inicial + 1;
end loop;
delete from usrsiho.tmp_hologdpr;
end if;
else
-- -----------------------------------------------------
-- inserta el detalle del rph cuando solo es un capitulo
-- -----------------------------------------------------
if ps_tipinc <> 'N' then
pi_hraent := 0;
pi_hrasal := 0;
pi_mincom := 0;
begin
select (det_capgra)::numeric
into strict pi_capini
from usrsiho.holodettra
where det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then pi_capini := 0;
end;
else
begin
select (oracle.substr(det_hraent , 1 , 2))::numeric  * 60 + (oracle.substr(det_hraent::numeric , 4 , 2))::numeric ,(oracle.substr(det_hrasal , 1 , 2))::numeric  * 60 + (oracle.substr(det_hrasal::numeric , 4 , 2))::numeric ,
case when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then 30
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then 0
else 0
end,(det_capgra)::numeric
into strict pi_hraent,pi_hrasal,pi_mincom,pi_capini
from usrsiho.holoenctra, usrsiho.holodettra
where enc_num_id = det_num_id and
det_num_id = pi_num_id and
det_serial = pi_serial;
exception when no_data_found then pi_hraent := 0; pi_hrasal := 0; pi_mincom := 0; pi_capini :=0;
end;
end if;
-- ---------------------
-- graba las incidencias
-- ---------------------
--insert into tmp_errores values(0,0,0,0,'INSERT INCID <> ANDA 1 SOLO CAP','','');
call usrsiho.sp_holoaltinc (pi_keyemp,2,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capini,pi_hraent,pi_hrasal,pi_mincom,ps_capgra,1);
end if;
else
-- ------------------------------------------------------------------
-- inserta el detalle del rph cuando la inidencia es diferente de 'N'
-- ------------------------------------------------------------------
--insert into tmp_errores values(0,0,0,0,'INSERTA INCID <> ANDA <> N','','');
call usrsiho.sp_holoaltinc (pi_keyemp,3,li_secrph,pd_fechaact,ps_keyconvia,pd_costvia,pi_keyusu,pi_num_id,pi_serial,pi_keypro,pi_capini,pi_capini,pi_hraent,pi_hrasal,pi_mincom,ps_capgra,0);
end if;
update usrsiho.holodettra
set det_stspag = 'T',
det_keyrph = li_secrph
where det_num_id = pi_num_id and
det_serial = pi_serial;
end loop;
end if;
--  ----------------------------------------------------------------------------------
--  calcula el total del costo de la hoja de trabajo y la suma del numero de empleado
--  ----------------------------------------------------------------------------------
begin
select sum(gdp_numcap * gdp_cosuni::numeric), sum(gdp_keyemp)
into strict pd_totcos, pi_totemp
from usrsiho.hologdpr
where gdp_keyrph = li_secrph;
exception when no_data_found then pd_totcos := 0; pi_totemp := 0;
end;
update usrsiho.holofrph
set frp_totcos = pd_totcos,
frp_totemp = pi_totemp
where frp_keyrph = li_secrph;
end loop;
--  -------------------------------------------------------
--  actualiza el estatus de las hojas de trabajo procesadas
--  -------------------------------------------------------
update usrsiho.holoenctra
set enc_stsrep = '3'
where enc_num_id in (select hja_num_id from tmp_hjatrab);
--  ----------------------------------------------------------------------------
--  ingresa a la tabla temporal las hojas de trabajo que tienen inconcistencias
--  ----------------------------------------------------------------------------
delete from usrsiho.tmp_hologdpr;
insert into usrsiho.tmp_hologdpr
select distinct 1,enc_num_id
from usrsiho.holoenctra,usrsiho.holodettra,usrsiho.holocont
where enc_num_id = det_num_id and
det_keyfol = con_keyfol and
det_keyemp = con_keyemp and
det_stspag = 'P' and
det_stsreg = 'V' and
enc_stsrep = '2' and
det_sindkto in ('ANDA','SITATYR','CONDUCTOR ART') and
enc_fecpag = pd_fechapag and
--((det_tipinc = 'N') and
(det_tipinc = 'N' and
--(con_stspag <> 'V' or
(trim(both det_hraent) = null or
trim(both det_hrasal) = null or
nullif(det_capfin::text, '') is null or
trim(both det_capgra) = null));
--  ----------------------------------------------------------------------------
--  actualiza el estatus de las hojas de trabajo que tienen inconcistencias.
--  nota: se utilizo la tabla temporal para poder hacer la actualizacion general
--        ya que no permite actualizar por medio de un subquery
--  ----------------------------------------------------------------------------
update usrsiho.holoenctra
set enc_stsrep = '5'
where enc_num_id in (select capitulo from usrsiho.tmp_hologdpr);
--drop table tmp_hologdpr;
--drop table tmp_hjatrab;
--drop table tmp_errores;
--drop table tmp_erroresdate;
end;
$body$
language plpgsql
;
