create or replace procedure labconf."sp_eoestruc"  (ws_nvo_nom varchar,ws_nom_ant varchar,ws_sub_mov varchar,wf_fec_mov timestamp(0),ws_est_ant varchar,ws_est_act varchar,ws_est_ope varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_key_emp numeric(10);
ws_tip_mov varchar(2);
ws_key_dep varchar(16);
ws_key_pue varchar(16);
ws_key_cat varchar(16);
ws_key_cen varchar(16);
wn_sal_dia decimal(12,6);
wn_sal_mes decimal(12,6);
wn_sal_int decimal(12,6);
wn_sal_ivc decimal(12,6);
wn_sal_inf decimal(12,6);
wn_int_sin decimal(12,6);
wn_inf_sin decimal(12,6);
ws_key_ims varchar(5);
ws_key_loc varchar(4);
ws_key_per varchar(7);
wn_key_pla numeric(10);
wn_key_pro numeric(5);
wn_jor_lab varchar(1);
wn_uni_jor decimal(4,2);
ws_ca1_aux varchar(10);
ws_ca2_aux varchar(10);
ws_des_dep varchar(40);
ws_ref_con varchar(20);
ws_tip_dep varchar(1);
ws_nu1_aux varchar(10);
ws_nu2_aux varchar(10);
ws_nu3_aux varchar(10);
ws_nu4_aux varchar(10);
ws_nu5_aux varchar(10);
ws_ca3_aux varchar(10);
ws_ca4_aux varchar(10);
ws_ca5_aux varchar(10);
ws_ubi_cac varchar(20);
ws_sta_tus varchar(1);
ws_per_iod varchar(7);
ws_max_per varchar(7);
c_emple record;
c_keydep record;
begin
update eocorede set red_hijdep=ws_nvo_nom
where red_hijdep=ws_nom_ant; /* commit; */
update eocorede set red_paddep=ws_nvo_nom
where red_paddep=ws_nom_ant; /* commit; */
if (ws_est_ope='1' ) then
for c_emple in ( select emp_keyemp, emp_keypue, emp_keycat, emp_keycen, emp_saldia, emp_salmes, emp_salint, emp_salivc, emp_salinf, emp_intsin, emp_infsin, emp_keyims, emp_keyloc, emp_keypro, emp_jorlab, emp_unijor, emp_ca1aux, emp_ca2aux from nmcoempl
where emp_keydep=ws_nom_ant ) loop
wn_key_emp :=c_emple.emp_keyemp;
ws_key_pue :=c_emple.emp_keypue;
ws_key_cat :=c_emple.emp_keycat;
ws_key_cen :=c_emple.emp_keycen;
wn_sal_dia :=c_emple.emp_saldia;
wn_sal_mes :=c_emple.emp_salmes;
wn_sal_int :=c_emple.emp_salint;
wn_sal_ivc :=c_emple.emp_salivc;
wn_sal_inf :=c_emple.emp_salinf;
wn_int_sin :=c_emple.emp_intsin;
wn_inf_sin :=c_emple.emp_infsin;
ws_key_ims :=c_emple.emp_keyims;
ws_key_loc :=c_emple.emp_keyloc;
wn_key_pro :=c_emple.emp_keypro;
wn_jor_lab :=c_emple.emp_jorlab;
wn_uni_jor :=c_emple.emp_unijor;
ws_ca1_aux :=c_emple.emp_ca1aux;
ws_ca2_aux :=c_emple.emp_ca2aux;
if (nullif(wn_key_emp::text, '') is null ) then
wn_key_emp:=0;
end if;
if (nullif(ws_key_pue::text, '') is null ) then
ws_key_pue:=' ';
end if;
if (nullif(ws_key_cat::text, '') is null ) then
ws_key_cat:=' ';
end if;
if (nullif(ws_key_cen::text, '') is null ) then
ws_key_cen:=' ';
end if;
if (nullif(wn_sal_dia::text, '') is null ) then
wn_sal_dia:=0;
end if;
if (nullif(wn_sal_mes::text, '') is null ) then
wn_sal_mes:=0;
end if;
if (nullif(wn_sal_int::text, '') is null ) then
wn_sal_int:=0;
end if;
if (nullif(wn_sal_ivc::text, '') is null ) then
wn_sal_ivc:=0;
end if;
if (nullif(wn_sal_inf::text, '') is null ) then
wn_sal_inf:=0;
end if;
if (nullif(wn_int_sin::text, '') is null ) then
wn_int_sin:=0;
end if;
if (nullif(wn_inf_sin::text, '') is null ) then
wn_inf_sin:=0;
end if;
if (nullif(ws_key_ims::text, '') is null ) then
ws_key_ims:=' ';
end if;
if (nullif(ws_key_loc::text, '') is null ) then
ws_key_loc:=' ';
end if;
if (nullif(wn_key_pro::text, '') is null ) then
wn_key_pro:=0;
end if;
if (nullif(wn_jor_lab::text, '') is null ) then
wn_jor_lab:=0;
end if;
if (nullif(wn_uni_jor::text, '') is null ) then
wn_uni_jor:=0;
end if;
if (nullif(ws_ca1_aux::text, '') is null ) then
ws_ca1_aux:=' ';
end if;
if (nullif(ws_ca2_aux::text, '') is null ) then
ws_ca2_aux:=' ';
end if;
for c_keydep in ( select  min(per_keyper ) alias1 from nmloperi
where per_keypro=wn_key_pro
and per_keynom=1
and nullif(per_fecact::text, '') is null ) loop
ws_key_per :=c_keydep.alias1;
ws_key_per:=ws_key_per;
end loop;
if (nullif(ws_key_per::text, '') is null ) then
ws_key_per:='0';
end if;
insert into nmlotray( tra_fecmov,tra_tipmov,tra_keydep,tra_submov,tra_keyper,tra_keyemp,tra_keypue,tra_keycat,tra_keycen,tra_saldia,tra_salmes,tra_salint,tra_salivc,tra_salinf,tra_intsin,tra_infsin,tra_keyims,tra_codloc,tra_keypro,tra_jorlab,tra_unijor,tra_ca1aux,tra_ca2aux)
values (wf_fec_mov,'8',ws_nvo_nom,ws_sub_mov,ws_key_per,wn_key_emp,ws_key_pue,ws_key_cat,ws_key_cen,wn_sal_dia,wn_sal_mes,wn_sal_int,wn_sal_ivc,wn_sal_inf,wn_int_sin,wn_inf_sin,ws_key_ims,ws_key_loc,wn_key_pro,wn_jor_lab,wn_uni_jor,ws_ca1_aux,ws_ca2_aux); /* commit; */
end loop;
update nmcoempl set emp_keydep=ws_nvo_nom
where emp_keydep=ws_nom_ant; /* commit; */
update nmcoinci set inc_keydep=ws_nvo_nom
where inc_keydep=ws_nom_ant; /* commit; */
update nmlodfij set dfi_keydep=ws_nvo_nom
where dfi_keydep=ws_nom_ant; /* commit; */
update nmloamor set amo_keydep=ws_nvo_nom
where amo_keydep=ws_nom_ant; /* commit; */
end if;
update eocoplza set plz_keydep=ws_nvo_nom
where plz_keyest=ws_est_ant
and plz_keydep=ws_nom_ant; /* commit; */
update eolosolc set sol_keydep=ws_nvo_nom
where sol_keyest=ws_est_ant
and sol_keydep=ws_nom_ant; /* commit; */
end;
$body$
language plpgsql
;
