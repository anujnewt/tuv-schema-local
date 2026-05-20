create or replace procedure usrsiho."sp_hplreppl"  (pi_usuario numeric, ps_terminal varchar, contipcon varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
li_keyfol      numeric(10);
li_keypue      numeric(10);
li_keyemp      numeric(10);
li_keytva      numeric(10);
li_numcap      numeric(10);
li_numcdi      numeric(10);
li_ctvplz      numeric(10);
li_keyplz      numeric(10);
ls_keydep      varchar(16);
ls_keypue      varchar(16);
ls_keycia      varchar(16);
ls_keyapr      varchar(16);
ls_desdep      varchar(40);
ls_despue      varchar(40);
ls_descia      varchar(40);
ls_desapr      varchar(40);
ls_capitulos   varchar(100);
ls_nomemp      varchar(60);
ln_costot      decimal(16,2);
ln_cosuni      decimal(16,2);
ld_fechasys    timestamp(0);
rec record;
rec2 record;
rec3 record;
rec4 record;
begin
-- borra los registros de la tabla de paso.
delete from usrsiho.glwkcrys
where cry_nomrep = 'HPLREPPL'
and cry_keyusu = pi_usuario
and cry_idepcc = ps_terminal;
-- lectura de la fecha del systema
ld_fechasys := trunc(clock_timestamp());
-- lectura de datos
if contipcon = 's' then
for rec
in (select con_keyplz,con_keyfol,con_keydep, dep_desdep,con_keypue,pue_despue, con_keyemp,emp_nomemp,con_keytva,
con_numcap,con_numcdi,cia_keycia,   cia_descia,pam_cvesec,pam_nompar,
con_cosuni,(con_cosuni * con_numcap) costot, con_ctvplz
from usrsiho.holocont
left join usrsiho.nmcoempl on  emp_keyemp = con_keyemp
join usrsiho.nmcopues on  pue_keypue = con_keypue
join usrsiho.nmcodeps on  dep_keydep = con_keydep
join usrsiho.nmloalde on  ald_keydep      = dep_keydep
join usrsiho.holodear on  ald_keydep      = dea_keydep
join usrsiho.glcoacar on glcoacar.aca_keyapr = dea_keyapr
join usrsiho.nmloproc on glcoacar.aca_keypro = pro_keypro
join usrsiho.nmlocias on pro_keycia      = cia_keycia
join usrsiho.glcoacac on  glcoacac.aca_keyusu = pi_usuario and glcoacac.aca_keypue = con_keypue
join usrsiho.glcopams on dea_keyapr      = pam_cvesec and pam_keypar      = 'H2'
join usrsiho.glwkrang tco on tco.ran_nomrep  = 'HPLREPPL' and tco.ran_keyusu  = pi_usuario
and tco.ran_idepcc  = ps_terminal and tco.ran_keypro  = 2 and tco.ran_keydep  = con_keytco
join usrsiho.glwkrang dep on dep.ran_nomrep  = 'HPLREPPL'  and dep.ran_keyusu  = pi_usuario
and dep.ran_idepcc  = ps_terminal and dep.ran_keypro  = 1 and dep.ran_keydep  = con_keydep
join usrsiho.glwkrang sts on sts.ran_nomrep  = 'HPLREPPL' and sts.ran_keyusu  = pi_usuario
and sts.ran_idepcc  = ps_terminal and sts.ran_keypro  = 3 and sts.ran_keydep  = con_stspag
join usrsiho.glwkrang stp on stp.ran_nomrep  = 'HPLREPPL' and stp.ran_keyusu  = pi_usuario
and stp.ran_idepcc  = ps_terminal and stp.ran_keypro  = 4 and stp.ran_keydep  = con_stsplz
where  glcoacar.aca_keypro = ald_keypro
and glcoacar.aca_keyusu = pi_usuario
and glcoacar.aca_actual = 'S'
) loop
--   obtiene los capitulos que estan en el cotrato y los guarda en una
--   variable llamada ls_capitulos
li_keyplz := rec.con_keyplz;
li_keyfol := rec.con_keyfol;
ls_keydep := rec.con_keydep;
ls_desdep := rec.dep_desdep;
ls_keypue := rec.con_keypue;
ls_despue := rec.pue_despue;
li_keyemp := rec.con_keyemp;
ls_nomemp := rec.emp_nomemp;
li_keytva := rec.con_keytva;
li_numcap := rec.con_numcap;
li_numcdi := rec.con_numcdi;
ls_keycia := rec.cia_keycia;
ls_descia := rec.cia_descia;
ls_keyapr := rec.pam_cvesec;
ls_desapr := rec.pam_nompar;
ln_cosuni := rec.con_cosuni;
ln_costot := rec.costot;
li_ctvplz := rec.con_ctvplz;
ls_capitulos := ' ';
if li_keytva = 1 then
for rec2 in (select coc_keycap
from usrsiho.holococa
where coc_keyplz = li_keyplz) loop
li_numcap := rec2.coc_keycap;/* dmap converted statement start */
ls_capitulos :=  concat(ls_capitulos, to_char(li_numcap) , ',') ;/* dmap converted statement end */
end loop;
end if;
---- insercion por cada registro obtenido
insert into usrsiho.glwkcrys(cry_nomrep,cry_keyusu,cry_idepcc,cry_numsec,
cry_chr008,cry_chr004,cry_chr009,cry_chr003,
cry_dec006,cry_chr001,cry_chr017,cry_dec007,
cry_dec008,cry_chr018,cry_chr002,cry_chr019,
cry_chr005,cry_chr006,cry_dec001,cry_dec002,
cry_dec009)
values ('HPLREPPL',pi_usuario,ps_terminal,li_keyfol,
ls_keydep,ls_desdep,ls_keypue,ls_despue,
li_keyemp,ls_nomemp,li_keytva,li_numcap,
li_numcdi,ls_keycia,ls_descia,ls_keyapr,
ls_desapr,ls_capitulos,ln_cosuni,
ln_costot,li_ctvplz);
end loop;
else
for rec3 in (select con_keyplz,con_keyfol,con_keydep, dep_desdep,con_keypue,pue_despue,
con_keyemp,emp_nomemp,con_keytva, con_numcap,con_numcdi,cia_keycia,
cia_descia,pam_cvesec,pam_nompar,con_cosuni,(con_cosuni*con_numcap) costot, con_ctvplz
from usrsiho.holocont
left join usrsiho.nmcoempl on emp_keyemp      = con_keyemp
join usrsiho.nmcopues on pue_keypue      = con_keypue
join usrsiho.nmcodeps on dep_keydep      = con_keydep
join usrsiho.nmloalde on ald_keydep      = dep_keydep
join usrsiho.holodear on ald_keydep      = dea_keydep
join usrsiho.glcoacar on glcoacar.aca_keypro = ald_keypro
join usrsiho.nmloproc on glcoacar.aca_keypro = pro_keypro
join usrsiho.nmlocias on pro_keycia      = cia_keycia
join usrsiho.glcoacac on glcoacac.aca_keyusu = pi_usuario and glcoacac.aca_keypue = con_keypue
join usrsiho.glcopams on dea_keyapr      = pam_cvesec and pam_keypar      = 'H2'
left join usrsiho.glwkrang tco on tco.ran_nomrep  = 'HPLREPPL' and tco.ran_keyusu  = pi_usuario
and tco.ran_idepcc  = ps_terminal and tco.ran_keypro  = 2  and tco.ran_keydep  = con_keytco
join usrsiho.glwkrang dep on dep.ran_nomrep  = 'HPLREPPL' and dep.ran_keyusu  = pi_usuario
and dep.ran_idepcc  = ps_terminal and dep.ran_keypro  = 1 and dep.ran_keydep  = con_keydep
join usrsiho.glwkrang sts on  sts.ran_nomrep  = 'HPLREPPL' and sts.ran_keyusu  = pi_usuario
and sts.ran_idepcc  = ps_terminal and sts.ran_keypro  = 3 and sts.ran_keydep  = con_stspag
join usrsiho.glwkrang stp on stp.ran_nomrep  = 'HPLREPPL' and stp.ran_keyusu  = pi_usuario
and stp.ran_idepcc  = ps_terminal and stp.ran_keypro  = 4 and stp.ran_keydep  = con_stsplz
where glcoacar.aca_keyapr = dea_keyapr
and glcoacar.aca_keyusu = pi_usuario
and glcoacar.aca_actual = 'S'
) loop
li_keyplz := rec3.con_keyplz;
li_keyfol := rec3.con_keyfol;
ls_keydep := rec3.con_keydep;
ls_desdep := rec3.dep_desdep;
ls_keypue := rec3.con_keypue;
ls_despue := rec3.pue_despue;
li_keyemp := rec3.con_keyemp;
ls_nomemp := rec3.emp_nomemp;
li_keytva := rec3.con_keytva;
li_numcap := rec3.con_numcap;
li_numcdi := rec3.con_numcdi;
ls_keycia := rec3.cia_keycia;
ls_descia := rec3.cia_descia;
ls_keyapr := rec3.pam_cvesec;
ls_desapr := rec3.pam_nompar;
ln_cosuni := rec3.con_cosuni;
ln_costot := rec3.costot;
li_ctvplz := rec3.con_ctvplz;
--   obtiene los capitulos que estan en el cotrato y los guarda en una
--   variable llamada ls_capitulos
ls_capitulos := ' ';
if li_keytva = 1 then
--  dbms_output.put_line('li_keyplz '||to_char(li_keyplz));
for rec4 in (select coc_keycap
from   usrsiho.holococa
where   coc_keyplz = li_keyplz)
loop
li_numcap := rec4.coc_keycap;/* dmap converted statement start */
--       dbms_output.put_line('ls_capitulos '||ls_capitulos);
if length(ls_capitulos) < 41 then
ls_capitulos :=  concat(ls_capitulos, to_char(li_numcap) , ',') ;/* dmap converted statement end */
-- ls_capitulos := 'AB' || 'CD' || ',';
end if;
end loop;
end if;
---- insercion por cada registro obtenido
insert into usrsiho.glwkcrys(cry_nomrep, cry_keyusu, cry_idepcc,
cry_numsec, cry_chr008, cry_chr004,
cry_chr009, cry_chr003, cry_dec006,
cry_chr001, cry_chr017, cry_dec007,
cry_dec008, cry_chr018, cry_chr002,
cry_chr019, cry_chr005, cry_chr006,
cry_dec001, cry_dec002, cry_dec009)
values ('HPLREPPL',pi_usuario,ps_terminal,
li_keyfol, ls_keydep, ls_desdep,
ls_keypue, ls_despue, li_keyemp,
ls_nomemp, li_keytva, li_numcap,
li_numcdi, ls_keycia, ls_descia,
ls_keyapr, ls_desapr, oracle.substr(ls_capitulos,1,40),
ln_cosuni, ln_costot, li_ctvplz);
end loop;
end if;
-- borrar los registros recibidos para armar el query
delete from usrsiho.glwkrang
where ran_nomrep  = 'HPLREPPL'
and ran_keyusu  = pi_usuario
and ran_idepcc  = ps_terminal;end;
$body$
language plpgsql
;
