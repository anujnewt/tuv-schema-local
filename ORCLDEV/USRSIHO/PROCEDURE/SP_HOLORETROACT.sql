create or replace procedure usrsiho."sp_holoretroact"  (ps_idepcc varchar,pi_keyusu numeric, pd_fechapag timestamp(0), pd_fechagen timestamp(0), pd_comidagm numeric, pd_cenagm numeric, pd_desayunogm numeric, pd_pasajesgm numeric, pd_viaticoslocgm numeric,pn_numgen inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- -----------------------------------------------------------------
-- creo:                                comentario:                                                             fecha:
-- juan carlos reyes olivera            este stored procedure se utiliza para realizar una copia de la          29 de junio de 2011
--                                      hoja de trabajo original calculando el porcentaje del
--                                      retroactivo en la hoja destino.
--
-- modifico:                            comentario:                                                             fecha:
-- juan carlos reyes olivera            se agrego condicion en los campos de sindicato y tipo de sindicato      16 de marzo del 2012
--                                      para corregir error de origen a la hora de copiar los registros.
--
-- juan carlos reyes olivera            se cambio la condicion de solo copiar unos datos del campo det_auxca2   16 de marzo del 2012
--                                      para copiar identicamente el registro. (solicito jose maria dolores cuellar)
-- -----------------------------------------------------------------
li_ht numeric(10);
li_secht numeric(10);
ld_ptje_retro decimal(5,2);
ls_cadena varchar(50);
ps_caracter varchar(2);
pi_inicial numeric(10);
pi_final numeric(10);
pi_nomina numeric(10);
pi_auxiliar numeric(10);
pi_lencad numeric(10);
rec record;
begin
li_ht := 0;
li_secht := 0;
ld_ptje_retro := 0;
pi_inicial := 1;
pi_final := 1;
pi_nomina := 1;
pi_auxiliar := 1;
pi_lencad := 0;
pn_numgen := 0;
delete
from usrsiho.glwkcrys
where cry_nomrep = 'retronomin'
and cry_idepcc = ps_idepcc
and cry_keyusu = pi_keyusu;
begin
select pam_folini
into strict ls_cadena
from usrsiho.glcopams
where pam_keypar in (select pam_folini
from usrsiho.glcopams
where pam_keypar='00'
and pam_cvesec='loretr')
and pam_nompar = 'NOMINAS';
exception when no_data_found then ls_cadena:= null;
end;
pi_lencad := length(trim(both ls_cadena));
while pi_final <= pi_lencad loop
ps_caracter := oracle.substr(ls_cadena , pi_final , 1);
if ps_caracter = ',' or pi_final = pi_lencad then
if pi_lencad = pi_final then pi_auxiliar := pi_final + 1; else pi_auxiliar := pi_final; end if;
if pi_inicial = 1 then
pi_nomina := (oracle.substr(ls_cadena , pi_inicial , pi_auxiliar - pi_inicial))::numeric;
else
pi_nomina := (oracle.substr(ls_cadena , pi_inicial , pi_auxiliar - pi_inicial))::numeric;
end if;
insert into usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,cry_numsec)
values ('retronomin',ps_idepcc,pi_keyusu,pi_nomina);
pi_inicial := pi_final + 1;
end if;
pi_final := pi_final + 1;
end loop;
begin
select coalesce(pam_folini,0)
into strict ld_ptje_retro
from usrsiho.glcopams
where pam_keypar in (select pam_folini
from usrsiho.glcopams
where pam_keypar='00'
and pam_cvesec='loretr')
and pam_cvesec = 'OPCI01';
exception when no_data_found then ld_ptje_retro := 0;
end;
for rec in (select cry_numsec
from usrsiho.glwkcrys
where cry_nomrep = 'GENRETRO' and
cry_idepcc = ps_idepcc and
cry_keyusu = pi_keyusu
order by  cry_numsec) loop
li_ht := rec.cry_numsec;/* dmap converted statement start */
insert into usrsiho.tmp_holoenctra(
enc_keydep, enc_fecgra, enc_fecpag, enc_keytpr, enc_nomprd, enc_feccap, enc_horcom,
enc_keypro, enc_usuori, enc_stsrep, enc_feclib, enc_horlib, enc_gcxxii, enc_entcom,
enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc, enc_numlla, enc_conlla, enc_descap
)
select enc_keydep, enc_fecgra, pd_fechapag, enc_keytpr, enc_nomprd, enc_feccap, enc_horcom,
enc_keypro, pi_keyusu , 2          , enc_feclib, enc_horlib, enc_gcxxii, enc_entcom,
enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc, enc_numlla, enc_conlla,  concat('RETROACTIVO DE LA HOJA ', li_ht
) from holoenctra
where enc_num_id = li_ht;/* dmap converted statement end */
insert into holoenctra(
enc_keydep, enc_fecgra, enc_fecpag, enc_keytpr, enc_nomprd, enc_feccap, enc_horcom,
enc_keypro, enc_usuori, enc_stsrep, enc_feclib, enc_horlib, enc_gcxxii, enc_entcom,
enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc, enc_numlla, enc_conlla, enc_descap
)
select enc_keydep, enc_fecgra, enc_fecpag, enc_keytpr, enc_nomprd, enc_feccap, enc_horcom,
enc_keypro, enc_usuori, enc_stsrep, enc_feclib, enc_horlib, enc_gcxxii, enc_entcom,
enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc, enc_numlla, enc_conlla, enc_descap
from tmp_holoenctra;
-- --------------------------------------------
-- lectura del secuencial de la hoja de trabajo
-- --------------------------------------------
select currval('usrsiho.holoenctra_seq') into strict li_secht;
delete from usrsiho.tmp_holoenctra;
insert into usrsiho.tmp_holodettra(
det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_hraent,
det_hrasal, det_hrstra, det_capgra, det_stsreg, det_stspag, det_keyaut, det_inanda,
det_ultact, det_fecpag, det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin,
det_auxnu1, det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
det_fecfin, det_tipinc, det_cosuni, det_numlla
)
-- jcro 16/03/2012    select li_secht  , det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
select li_secht  , det_keydep, det_fecgra, case when(nullif(det_keytco::text, '') is null or det_keytco = 0) and trim(both det_sindkto) = 'ANDA' or trim(both det_sindkto) = 'ANDA PENSIONADA' then 2
when(nullif(det_keytco::text, '') is null or det_keytco = 0) and trim(both det_sindkto) = 'SITATYR' then 3
when(nullif(det_keytco::text, '') is null or det_keytco = 0) and trim(both det_sindkto) = 'CONDUCTOR ART' or trim(both det_sindkto) = 'CONDUCTORES' then 519
else det_keytco
end, case when(nullif(det_sindkto::text, '') is null or trim(both det_sindkto) = null) and det_keytco = 2 then 'ANDA'
when(nullif(det_sindkto::text, '') is null or trim(both det_sindkto) = null) and det_keytco = 3 then 'SITATYR'
when(nullif(det_sindkto::text, '') is null or trim(both det_sindkto) = null) and det_keytco = 519 then 'CONDUCTOR ART'
else det_sindkto
end, det_keyfol, det_keyemp,
det_nomcor, det_person, det_keypue, det_keycon, det_noforo , det_hralla, det_hraent,
det_hrasal, det_hrstra, det_capgra, 'V'       , 'P'        , det_serial, det_inanda,
pd_fechagen,det_fecpag, 0         , det_keynom, 0          , det_capini, det_capfin,
-- jcro 16/03/2012           det_auxnu1, det_auxnu2, det_auxca1, det_auxca2[1,2] || "000" || det_auxca2[6,8] || "00" , pi_keyusu, pd_fechagen, pi_keyusu,
det_auxnu1, det_auxnu2, det_auxca1, det_auxca2, pi_keyusu, pd_fechagen, pi_keyusu,
pd_fechagen,det_tipinc, round(
case when holodettra.det_tipinc='N' or holodettra.det_tipinc='LI' then
case when con_cosuni > 0 or  nullif(con_cosuni::text, '') is not null then
con_cosuni
else
(select tab_import
from usrsiho.holotabs
where tab_keypro = emp_keypro
and tab_keypue = con_keypue
and tab_pertra = con_pertra
and tab_idioma = con_idioma
and tab_keynac = con_keynac
and tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
and tab_fecini <= det_fecgra
and tab_fecfin >= det_fecgra
and con_keyfol = det_keyfol
) end * ld_ptje_retro / 100
when holodettra.det_tipinc='CM' then pd_comidagm
when holodettra.det_tipinc='CN' then pd_cenagm
when holodettra.det_tipinc='DE' then pd_desayunogm
when holodettra.det_tipinc='PA' then pd_pasajesgm
when holodettra.det_tipinc='VL' then pd_viaticoslocgm
else
det_cosuni * ld_ptje_retro / 100
end
), det_numlla
from usrsiho.holoenctra, usrsiho.holodettra, usrsiho.holofrph, usrsiho.nmcoempl, usrsiho.holocont
where enc_num_id = det_num_id and
det_keyrph = frp_keyrph and
det_keyemp = emp_keyemp and
det_keyemp = con_keyemp and
det_keyfol = con_keyfol and
frp_keypro = 138 and
det_stsreg <> 'E' and
frp_keynom in (select cry_numsec from usrsiho.glwkcrys where cry_nomrep = 'retronomin' and cry_idepcc = ps_idepcc and cry_keyusu = pi_keyusu) and
enc_num_id = li_ht;
insert into usrsiho.tmp_holodettra(
det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_hraent,
det_hrasal, det_hrstra, det_capgra, det_stsreg, det_stspag, det_keyaut, det_inanda,
det_ultact, det_fecpag, det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin,
det_auxnu1, det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
det_fecfin, det_tipinc, det_cosuni, det_numlla
)
-- jcro 16/03/2012     select li_secht  , det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
select li_secht  , det_keydep, det_fecgra, case when(nullif(det_keytco::text, '') is null or det_keytco = 0) and trim(both det_sindkto) = 'ANDA' or trim(both det_sindkto) = 'ANDA PENSIONADA' then 2
when(nullif(det_keytco::text, '') is null or det_keytco = 0) and trim(both det_sindkto) = 'SITATYR' then 3
when(nullif(det_keytco::text, '') is null or det_keytco = 0) and trim(both det_sindkto) = 'CONDUCTOR ART' or trim(both det_sindkto) = 'CONDUCTORES' then 519
else det_keytco
end, case when(nullif(det_sindkto::text, '') is null or trim(both det_sindkto) = null) and det_keytco = 2 then 'ANDA'
when(nullif(det_sindkto::text, '') is null or trim(both det_sindkto) = null) and det_keytco = 3 then 'SITATYR'
when(nullif(det_sindkto::text, '') is null or trim(both det_sindkto) = null) and det_keytco = 519 then 'CONDUCTOR ART'
else det_sindkto
end, det_keyfol, det_keyemp,
det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_hraent,
det_hrasal, det_hrstra, det_capgra, 'V'       , 'P'       , det_serial, det_inanda,
pd_fechagen,det_fecpag, 0         , det_keynom, 0         , det_capini, det_capfin,
-- jcro 16/03/2012            det_auxnu1, det_auxnu2, det_auxca1, det_auxca2[1,2] || "000" || det_auxca2[6,8] || "00" , pi_keyusu, pd_fechagen, pi_keyusu,
det_auxnu1, det_auxnu2, det_auxca1, det_auxca2, pi_keyusu, pd_fechagen, pi_keyusu,
pd_fechagen,det_tipinc, round(det_cosuni * ld_ptje_retro / 100), det_numlla
from usrsiho.holoenctra, usrsiho.holodettra, usrsiho.holofrph, usrsiho.nmcoempl
where enc_num_id = det_num_id and
det_keyrph = frp_keyrph and
det_keyemp = emp_keyemp and
frp_keypro = 138 and
det_stsreg <> 'E' and
frp_keynom in (select cry_numsec from usrsiho.glwkcrys where cry_nomrep = 'retronomin' and cry_idepcc = ps_idepcc and cry_keyusu = pi_keyusu) and (nullif(det_keyfol::text, '') is null or det_keyfol = 0) and
enc_num_id = li_ht;
insert into usrsiho.holodettra(
det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_hraent,
det_hrasal, det_hrstra, det_capgra, det_stsreg, det_stspag, det_keyaut, det_inanda,
det_ultact, det_fecpag, det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin,
det_auxnu1, det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
det_fecfin, det_tipinc, det_cosuni, det_numlla
)
-- jcro 16/03/2012     select det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp,
select det_num_id, det_keydep, det_fecgra, case when(nullif(det_keytco::text, '') is null or det_keytco = 0) and trim(both det_sindkto) = 'ANDA' or trim(both det_sindkto) = 'ANDA PENSIONADA' then 2
when(nullif(det_keytco::text, '') is null or det_keytco = 0) and trim(both det_sindkto) = 'SITATYR' then 3
when(nullif(det_keytco::text, '') is null or det_keytco = 0) and trim(both det_sindkto) = 'CONDUCTOR ART' or trim(both det_sindkto) = 'CONDUCTORES' then 519
else det_keytco
end, case when(nullif(det_sindkto::text, '') is null or trim(both det_sindkto) = null) and det_keytco = 2 then 'ANDA'
when(nullif(det_sindkto::text, '') is null or trim(both det_sindkto) = null) and det_keytco = 3 then 'SITATYR'
when(nullif(det_sindkto::text, '') is null or trim(both det_sindkto) = null) and det_keytco = 519 then 'CONDUCTOR ART'
else det_sindkto
end, det_keyfol, det_keyemp,
det_nomcor, det_person, det_keypue, det_keycon, det_noforo, det_hralla, det_hraent,
det_hrasal, det_hrstra, det_capgra, det_stsreg, det_stspag, det_keyaut, det_inanda,
det_ultact, det_fecpag, det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin,
det_auxnu1, det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
det_fecfin, det_tipinc, det_cosuni,det_numlla
from usrsiho.tmp_holodettra;
delete from usrsiho.tmp_holodettra;
update usrsiho.holodettra
set det_keyrph  = null,
det_cdilla  = null
where det_num_id = li_secht;
pn_numgen := pn_numgen + 1;
end loop;end;
$body$
language plpgsql
;
