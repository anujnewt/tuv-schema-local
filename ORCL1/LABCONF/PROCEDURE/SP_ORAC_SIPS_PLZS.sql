create or replace procedure labconf."sp_orac_sips_plzs"  (noctvo integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
vg_noctvo    integer;
vg_keyest    varchar(3);
vg_keydep    varchar(16);
vg_keypue    varchar(16);
vg_keyplz    integer;
vg_keycat    varchar(16);
vg_keyloc    varchar(16);
vg_tippla    varchar(2);
vg_fecini    timestamp(0);
vg_fecfin    timestamp(0);
vg_diavig    smallint;
vg_turnop    smallint;
vg_keyhor    varchar(16);
vg_keyemp    integer;
vg_cveuoc    integer;
vg_cverem    integer;
vg_fecmov    timestamp(0);
vg_submov    varchar(2);
vg_cosplz    decimal(14,2);
vg_ca1aux    varchar(16);
vg_ca2aux    varchar(16);
vg_ca3aux    varchar(16);
vg_nu1aux    varchar(10);
vg_nu2aux    varchar(10);
vg_nu3aux    varchar(10);
vg_nu3aux_1   varchar(16);
vg_fe1aux    varchar(10);
vg_fe2aux    varchar(10);
vg_fe3aux    timestamp(0);
vg_co1aux    decimal(14,2);
vg_co2aux    decimal(14,2);
vg_co3aux    decimal(14,2);
vg_co4aux    decimal(14,2);
vg_co5aux    decimal(14,2);
vg_keysue    varchar(4);
vg_sueniv    integer;
vg_subniv    integer;
vg_cobert    varchar(2);
vg_keypro    smallint;
vg_keydpl    decimal(16,6);
vg_fecocu    timestamp(0);
vg_salplz    decimal(12,2);
vg_titula    integer;
vg_origen    varchar(2);
vg_valimp    varchar(2);
vg_limocu    timestamp(0);
vg_tiptab    varchar(2);
vn_existr    integer;
vs_activo    varchar(1);
begin
-- toma los campos que son de tipo catalogo para verificar que existan --
select plz_keyest, plz_keydep, plz_keypue, plz_keyplz, plz_keycat,
plz_keyloc, plz_tippla, plz_fecini, plz_fecfin, plz_diavig,
plz_turnop, plz_keyhor, plz_keyemp, plz_cveuoc, plz_cverem,
plz_fecmov, plz_submov, plz_cosplz, plz_ca1aux, plz_ca2aux,
plz_ca3aux, plz_nu1aux, plz_nu2aux, plz_nu3aux, plz_fe1aux,
plz_fe2aux, plz_fe3aux, plz_co1aux, plz_co2aux, plz_co3aux,
plz_co4aux, plz_co5aux, plz_keysue, plz_sueniv, plz_subniv,
plz_cobert, plz_keypro, plz_keydpl, plz_fecocu, plz_salplz,
plz_titula, plz_origen, plz_valimp, plz_limocu, plz_tiptab
into strict  vg_keyest, vg_keydep, vg_keypue, vg_keyplz, vg_keycat,
vg_keyloc, vg_tippla, vg_fecini, vg_fecfin, vg_diavig,
vg_turnop, vg_keyhor, vg_keyemp, vg_cveuoc, vg_cverem,
vg_fecmov, vg_submov, vg_cosplz, vg_ca1aux, vg_ca2aux,
vg_ca3aux, vg_nu1aux, vg_nu2aux, vg_nu3aux, vg_fe1aux,
vg_fe2aux, vg_fe3aux, vg_co1aux, vg_co2aux, vg_co3aux,
vg_co4aux, vg_co5aux, vg_keysue, vg_sueniv, vg_subniv,
vg_cobert, vg_keypro, vg_keydpl, vg_fecocu, vg_salplz,
vg_titula, vg_origen, vg_valimp, vg_limocu, vg_tiptab
from com_orac_sips_plzs
where ora_noctvo = noctvo;
--pregunta si existe si la plaza
begin
select count(*)
into strict vn_existr
from plzapaso
where plz_keyplz = vg_keyplz;
exception
when no_data_found then
null;
end;
begin
select cam_activo
into strict vs_activo
from com_orac_sips_camp
where cam_tablas='nmloplzs'
and cam_campos='plz_keyplz';
exception
when no_data_found then
null;
end;
if vn_existr = 0  and vs_activo = 'S' then
insert into com_orac_sips_bita
values (noctvo,'2','com_orac_sips_plzs',
'clave de la plaza es incorrecta',
to_char(trunc(clock_timestamp(), 'YYYY')));
end if;
select plz_keyest, plz_keydep, plz_keypue, plz_keyplz, plz_keycat,
plz_keyloc, plz_tippla, plz_fecini, plz_fecfin, plz_diavig,
plz_turnop, plz_keyhor, plz_keyemp, plz_cveuoc, plz_cverem,
plz_fecmov, plz_submov, plz_cosplz, plz_ca1aux, plz_ca2aux,
plz_ca3aux, plz_nu1aux, plz_nu2aux, plz_nu3aux, plz_fe1aux,
plz_fe2aux, plz_fe3aux, plz_co1aux, plz_co2aux, plz_co3aux,
plz_co4aux, plz_co5aux, plz_keysue, plz_sueniv, plz_subniv,
plz_cobert, plz_keypro, plz_keydpl, plz_fecocu, plz_salplz,
plz_titula, plz_origen, plz_valimp, plz_limocu, plz_tiptab
into strict  vg_keyest, vg_keydep, vg_keypue, vg_keyplz, vg_keycat,
vg_keyloc, vg_tippla, vg_fecini, vg_fecfin, vg_diavig,
vg_turnop, vg_keyhor, vg_keyemp, vg_cveuoc, vg_cverem,
vg_fecmov, vg_submov, vg_cosplz, vg_ca1aux, vg_ca2aux,
vg_ca3aux, vg_nu1aux, vg_nu2aux, vg_nu3aux, vg_fe1aux,
vg_fe2aux, vg_fe3aux, vg_co1aux, vg_co2aux, vg_co3aux,
vg_co4aux, vg_co5aux, vg_keysue, vg_sueniv, vg_subniv,
vg_cobert, vg_keypro, vg_keydpl, vg_fecocu, vg_salplz,
vg_titula, vg_origen, vg_valimp, vg_limocu, vg_tiptab
from com_orac_sips_plzs
where ora_noctvo = noctvo;
begin
select pam_cvesec
into strict vg_nu3aux_1
from glcopams
where pam_keypar='PC3'
and pam_nompar=vg_nu3aux;
exception
when no_data_found then
null;
end;
if vn_existr = 0 then
insert into plzapaso(plz_keyest, plz_keydep, plz_keypue, plz_keyplz, plz_keycat,
plz_keyloc, plz_tippla, plz_fecini, plz_fecfin, plz_diavig,
plz_turnop, plz_keyhor, plz_keyemp, plz_cveuoc, plz_cverem,
plz_fecmov, plz_submov, plz_cosplz, plz_ca1aux, plz_ca2aux,
plz_ca3aux, plz_nu1aux, plz_nu2aux, plz_nu3aux, plz_fe1aux,
plz_fe2aux, plz_fe3aux, plz_co1aux, plz_co2aux, plz_co3aux,
plz_co4aux, plz_co5aux, plz_keysue, plz_sueniv, plz_subniv,
plz_cobert, plz_keypro, plz_keydpl, plz_fecocu, plz_salplz,
plz_titula, plz_origen, plz_valimp, plz_limocu, plz_tiptab )
values (vg_keyest, vg_keydep, vg_keypue, vg_keyplz, 'SC',
vg_keyloc, vg_tippla, vg_fecini, vg_fecfin, vg_diavig,
vg_turnop, vg_keyhor, vg_keyemp, vg_cveuoc, vg_cverem,
vg_fecmov, vg_submov, vg_cosplz, vg_ca1aux, vg_ca2aux,
vg_ca3aux, vg_nu1aux, vg_nu2aux, vg_nu3aux_1, vg_fe1aux,
vg_fe2aux, vg_fe3aux, vg_co1aux, vg_co2aux, vg_co3aux,
vg_co4aux, vg_co5aux, vg_keysue, vg_sueniv, vg_subniv,
vg_cobert, vg_keypro, vg_keydpl, vg_fecocu, vg_salplz,
vg_titula, vg_origen, vg_valimp, vg_limocu, vg_tiptab);
else
update plzapaso set
plz_keyest = vg_keyest,  plz_keydep = vg_keydep,
plz_keypue = vg_keypue,  plz_keycat = 'SC',
plz_keyloc = vg_keyloc,  plz_tippla = vg_tippla,
plz_fecini = vg_fecini,  plz_fecfin = vg_fecfin,
plz_diavig = vg_diavig,  plz_turnop = vg_turnop,
plz_keyhor = vg_keyhor,  plz_keyemp = vg_keyemp,
plz_cveuoc = vg_cveuoc,  plz_cverem = vg_cverem,
plz_fecmov = vg_fecmov,  plz_submov = vg_submov,
plz_cosplz = vg_cosplz,  plz_ca1aux = vg_ca1aux,
plz_ca2aux = vg_ca2aux,  plz_ca3aux = vg_ca3aux,
plz_nu1aux = vg_nu1aux,  plz_nu2aux = vg_nu2aux,
plz_nu3aux = vg_nu3aux_1,  plz_fe1aux = vg_fe1aux,
plz_fe2aux = vg_fe2aux,  plz_fe3aux = vg_fe3aux,
plz_co1aux = vg_co1aux,  plz_co2aux = vg_co2aux,
plz_co3aux = vg_co3aux,  plz_co4aux = vg_co4aux,
plz_co5aux = vg_co5aux,  plz_keysue = vg_keysue,
plz_sueniv = vg_sueniv,  plz_subniv = vg_subniv,
plz_cobert = vg_cobert,  plz_keypro = vg_keypro,
plz_keydpl = vg_keydpl,  plz_fecocu = vg_fecocu,
plz_salplz = vg_salplz,  plz_titula = vg_titula,
plz_origen = vg_origen,  plz_valimp = vg_valimp,
plz_limocu = vg_limocu,  plz_tiptab = vg_tiptab
where plz_keyplz = vg_keyplz;
end if;end;
$body$
language plpgsql
;
