create or replace procedure usrsiho."sp_transf_actores"  (pi_hoja_trab numeric,ps_seriales varchar,pi_anda_pens numeric, ps_numreg inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- creacion:                    comentario:                                                              fecha:
-- juan carlos reyes olivera    sp_transf_actores: este stored procedure es el que utiliza para
--                              la tranferencia de registros de una hoja de trabajo a otra.
--                              recibe en numero de la hoja de trabajo origen y sus registros a mover,
--                              con el detalle de los registros crea la nueva hoja de trabajo.
--
-- modifico:                    comentario:                                                              fecha:
-- juan carlos reyes olivera    se agrego la cancelaci??n de los registros del control de capitulos       15/05/2011
--                              para que al generar la nueva hoja permita volverlos a asignarlos a la
--                              nueva hoja de trabajo.
-- -----------------------------------------------------------------
ps_det_sindkto varchar(15);
pi_enc_num_id numeric(10);
pi_lencad numeric(10);
ps_caracter varchar(1);
pi_inicial numeric(10);
pi_final numeric(10);
pi_capini numeric(10);
pi_auxiliar numeric(10);
pi_continuos numeric(10);
pi_numcap numeric(10);
-- //inicio cons-0530 mejoras sai juan carlos reyes olivera 15/05/2011
--variables para la acualizaci??n de la holococa
li_reg_min numeric(10);
li_reg_max numeric(10);
li_orig_ser numeric(10);
li_dest_ser numeric(10);
begin
-- //fin cons-0530 mejoras sai juan carlos reyes olivera 15/05/2011
pi_lencad := 0;
ps_caracter:= null;
pi_inicial := 1;
pi_final := 1;
pi_capini := 1;
pi_auxiliar := 1;
pi_continuos := 1;
pi_numcap := 1;
ps_det_sindkto := 'ANDA PENSIONADA';
pi_enc_num_id := 0;
-- //inicio cons-0530 mejoras sai juan carlos reyes olivera 15/05/2011
--inicializaci??n de las variables para actualizar la holococa
li_reg_min := 0;
li_reg_max := 0;
li_orig_ser := 0;
li_dest_ser := 0;
-- //fin cons-0530 mejoras sai juan carlos reyes olivera 15/05/2011
--
pi_lencad := length(trim(both ps_seriales));
while pi_final <= pi_lencad loop
ps_caracter := oracle.substr(ps_seriales , pi_final , 1);
if ps_caracter = ',' or pi_final = pi_lencad then
if pi_lencad = pi_final then pi_auxiliar := pi_final + 1; else pi_auxiliar := pi_final; end if;
pi_capini := (oracle.substr(ps_seriales , pi_inicial , pi_auxiliar - pi_inicial))::numeric;
--se ingresan los datos a la tabla temporal
insert into usrsiho.tmp_auxiliar values (pi_capini);
pi_inicial := pi_final + 1;
end if;
pi_final := pi_final + 1;
end loop;
--crea tabla temporal del encabezado de la hoja de trabajo
insert into usrsiho.tmp_holoenctra
select
enc_keydep, enc_fecgra, enc_fecpag, enc_keytpr, enc_nomprd, enc_feccap,
enc_horcom, enc_keypro, enc_usuori, enc_stsrep, enc_feclib, enc_horlib,
enc_gcxxii, enc_entcom, enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc,
enc_numlla, enc_conlla, 'descap'
from usrsiho.holoenctra
where   enc_num_id = pi_hoja_trab
;
--crea tabla temporal del detalle de la hoja de trabajo
insert into usrsiho.tmp_holodettra
select
det_num_id,det_keydep, det_fecgra, det_keytco, det_sindkto,
det_keyfol, det_keyemp, det_nomcor, det_person, det_keypue, det_keycon,
det_noforo, det_hralla, det_hraent, det_hrasal, det_hrstra, det_capgra,
det_stsreg, det_stspag, det_keyaut, det_inanda, det_ultact, det_fecpag,
det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin, det_auxnu1,
det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
det_fecfin, det_tipinc, det_cosuni, det_numlla
from  usrsiho.holodettra
where   det_num_id = pi_hoja_trab and
det_serial in (select det_serial from usrsiho.tmp_auxiliar)
;
--inserta encabezado de la hoja de trabajo
insert into usrsiho.holoenctra(enc_keydep, enc_fecgra, enc_fecpag, enc_keytpr, enc_nomprd, enc_feccap,
enc_horcom, enc_keypro, enc_usuori, enc_stsrep, enc_feclib, enc_horlib,
enc_gcxxii, enc_entcom, enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc,
enc_numlla, enc_conlla)
select
enc_keydep, enc_fecgra, enc_fecpag, enc_keytpr, enc_nomprd, enc_feccap,
enc_horcom, enc_keypro, enc_usuori, enc_stsrep, enc_feclib, enc_horlib,
enc_gcxxii, enc_entcom, enc_salcom, enc_auxnu1, enc_auxca1, enc_desscc,
enc_numlla, enc_conlla
from usrsiho.tmp_holoenctra;
-- --------------------------------------------
-- lectura del secuencial de la hoja de trabajo
-- --------------------------------------------
select currval('holoenctra_seq') into strict pi_enc_num_id;
ps_numreg:=pi_enc_num_id;
--inserta detalle de la hoja de trabajo
insert into usrsiho.holodettra(det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto,
det_keyfol, det_keyemp, det_nomcor, det_person, det_keypue, det_keycon,
det_noforo, det_hralla, det_hraent, det_hrasal, det_hrstra, det_capgra,
det_stsreg, det_stspag, det_keyaut, det_inanda, det_ultact, det_fecpag,
det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin, det_auxnu1,
det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
det_fecfin, det_tipinc, det_cosuni, det_numlla)
select
pi_enc_num_id, det_keydep, det_fecgra, det_keytco, case when pi_anda_pens = 1 then ps_det_sindkto else det_sindkto end,
det_keyfol, det_keyemp, det_nomcor, det_person, det_keypue, det_keycon,
det_noforo, det_hralla, det_hraent, det_hrasal, det_hrstra, det_capgra,
det_stsreg, det_stspag, det_keyaut, det_inanda, det_ultact, det_fecpag,
det_keyrph, det_keynom, det_cdilla, det_capini, det_capfin, det_auxnu1,
det_auxnu2, det_auxca1, det_auxca2, det_usuori, det_fecori, det_usufin,
det_fecfin, det_tipinc, det_cosuni, det_numlla
from  usrsiho.tmp_holodettra;
--actualiza los registros que se transfirieron a otra hoja como 'E' eliminados
update usrsiho.holodettra
set det_stsreg = 'E'
where   det_num_id = pi_hoja_trab and
det_serial in (select det_serial from usrsiho.tmp_auxiliar);
-- //inicio cons-0530 mejoras sai juan carlos reyes olivera 15/05/2011
--actualiza los registros de la holococa para asignarles su nueva hoja
insert into usrsiho.tmp_act_coc
select orig.det_serial,dest.det_serial
from usrsiho.holodettra orig,usrsiho.holodettra dest
where orig.det_keydep = dest.det_keydep
and orig.det_keyfol = dest.det_keyfol
and orig.det_keyemp = dest.det_keyemp
and orig.det_capgra = dest.det_capgra
and orig.det_keydep = dest.det_keydep
and orig.det_fecgra = dest.det_fecgra
and orig.det_nomcor = dest.det_nomcor
and orig.det_num_id = pi_hoja_trab
and dest.det_num_id = pi_enc_num_id
and orig.det_serial in (select det_serial from usrsiho.tmp_auxiliar);
-- orig.det_sindkto = dest.det_sindkto
select min(orig_serial),max(orig_serial)
into strict li_reg_min,li_reg_max
from usrsiho.tmp_act_coc;
while li_reg_min <= li_reg_max loop
select orig_serial,dest_serial
into strict li_orig_ser,li_dest_ser
from usrsiho.tmp_act_coc
where orig_serial = li_reg_min;
update usrsiho.holococa
set coc_hjatra = pi_enc_num_id,
coc_reghja = li_dest_ser
where coc_hjatra = pi_hoja_trab
and coc_reghja = li_orig_ser;
select min(orig_serial)
into strict li_reg_min
from usrsiho.tmp_act_coc
where orig_serial > li_reg_min;
end loop;
-- //inicio cons-0530 mejoras sai juan carlos reyes olivera 15/05/2011
--borra la tabla temporal
--drop table tmp_auxiliar;
--execute immediate 'TRUNCATE TABLE TMP_HOLOENCTRA';
--execute immediate 'TRUNCATE TABLE TMP_HOLODETTRA';-
--drop table tmp_act_coc;  --//cons-0530 mejoras sai juan carlos reyes olivera 15/05/2011
end;
$body$
language plpgsql
;
