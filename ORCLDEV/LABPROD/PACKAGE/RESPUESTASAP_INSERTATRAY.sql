create or replace procedure labprod.respuestasap_insertatray ( emp_keyemp numeric, fecha_mov timestamp(0), emp_tipmov varchar, emp_keydep varchar , emp_keypue varchar, emp_keycen varchar, emp_keyloc varchar, emp_apepat varchar, emp_apemat varchar, emp_nombre varchar, emp_domemp varchar, emp_numext varchar, emp_numint varchar, emp_colemp varchar, emp_cidemp varchar, emp_munemp varchar, emp_entemp varchar, emp_codemp varchar, emp_telemp varchar, emp_regrfc varchar, emp_recurp varchar, emp_regims varchar, emp_cvesex varchar, emp_keyims varchar, emp_cvezon numeric, emp_keypro numeric, emp_tipemp varchar, emp_tipsal varchar, emp_status numeric, emp_salhor numeric, emp_saldia numeric, emp_salmes numeric, emp_forpag varchar, emp_ctaban varchar, emp_cvebaj varchar, emp_fecaux timestamp(0), emp_jorlab varchar, emp_unijor numeric, emp_ca2aux varchar, emp_fecven timestamp(0), emp_fecpla timestamp(0), emp_ca1aux varchar, emp_fecha_imss timestamp(0), emp_submov varchar, emp_salint numeric, keyper varchar, emp_salivc numeric, emp_salinf numeric, emp_intsin numeric, emp_infsin numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
band numeric;
dia numeric;
hora numeric;
periodo varchar(7);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
dia  :=  (emp_salmes / 30);
hora := (dia / insertatray.emp_unijor);
select count(*) into strict band from labprod.nmlotray where nmlotray.tra_keyemp = insertatray.emp_keyemp  and
to_timestamp(nmlotray.tra_fecmov,'DD/MM/YY') = to_timestamp(insertatray.fecha_mov,'DD/MM/YY')  and insertatray.emp_tipmov =tra_tipmov;
if  emp_tipmov = '4' or emp_tipmov = '20' then
select min(per_keyper) into strict periodo from labprod.nmloperi where per_keypro = emp_keypro and per_keynom = 1 and nullif(per_fecact::text, '') is null;
else
periodo := keyper;
end if;
if band = 0 then
insert into labprod.nmlotray(tra_keyemp,tra_fecmov,tra_tipmov,tra_keydep,tra_keypue,
tra_keycen,tra_saldia,tra_salmes,tra_salint,
tra_salivc,tra_salinf,tra_intsin,tra_infsin,tra_keyims,
tra_keyper,tra_codloc,tra_keypro,tra_jorlab,
tra_unijor,tra_submov,
tra_fecmod,tra_hormod)
values (emp_keyemp ,fecha_mov ,emp_tipmov ,emp_keydep ,emp_keypue ,
emp_keycen ,emp_saldia,emp_salmes,emp_salint,
emp_salint,emp_salint,emp_salint,emp_salint,emp_keyims,
periodo,emp_keyloc,emp_keypro,emp_jorlab,
emp_unijor,emp_submov,to_date(to_char(clock_timestamp(), 'MM/DD/YYYY'), 'MM/DD/YYYY'),
to_char(clock_timestamp(), 'hh24:mi:ss'));
/* commit; */
end if;
if band >= 1 then
update labprod.nmlotray set
nmlotray.tra_fecmov = insertatray.fecha_mov,
nmlotray.tra_tipmov = insertatray.emp_tipmov,
nmlotray.tra_keydep = insertatray.emp_keydep,
nmlotray.tra_keypue = insertatray.emp_keypue,
nmlotray.tra_keycen = insertatray.emp_keycen,
nmlotray.tra_saldia = round((insertatray.emp_saldia )::numeric,4),
nmlotray.tra_salmes = insertatray.emp_salmes,
nmlotray.tra_salint = insertatray.emp_salint,
nmlotray.tra_salivc = insertatray.emp_salint,
nmlotray.tra_salinf = insertatray.emp_salint,
nmlotray.tra_intsin = insertatray.emp_salint,
nmlotray.tra_infsin = insertatray.emp_salint,
nmlotray.tra_keyims = insertatray.emp_keyims,
nmlotray.tra_keyper = periodo,
nmlotray.tra_codloc = insertatray.emp_keyloc,
nmlotray.tra_keypro = insertatray.emp_keypro,
nmlotray.tra_jorlab = insertatray.emp_jorlab,
nmlotray.tra_unijor = insertatray.emp_unijor,
nmlotray.tra_submov = insertatray.emp_submov,
nmlotray.tra_fecmod = to_date(to_char(clock_timestamp(), 'MM/DD/YYYY'), 'MM/DD/YYYY'),
nmlotray.tra_hormod = to_char(clock_timestamp(), 'hh24:mi:ss')
where nmlotray.tra_keyemp = insertatray.emp_keyemp
and to_timestamp(tra_fecmov,'DD/MM/YY') = to_timestamp(insertatray.fecha_mov,'DD/MM/YY')
and insertatray.emp_tipmov = nmlotray.tra_tipmov;
/* commit; */
end if;end;
$body$
language plpgsql
;
