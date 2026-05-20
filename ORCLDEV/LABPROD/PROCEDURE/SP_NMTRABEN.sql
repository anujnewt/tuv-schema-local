create or replace procedure labprod."sp_nmtraben"  (vs_tab_ben varchar,vs_tip_pre varchar,vn_key_usu numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_fec_mov numeric(10);
wn_hor_mov numeric(10);
wn_min_mov numeric(10);
wn_seg_mov numeric(10);
wn_tot_mov decimal(16,6);
ws_tmp_mov varchar(2);
--variables para el traspaso de beneficiarios hacia prestamos
ws_pre_tmp nmlopres.pre_tippre%type;
wn_key_emp nmlobebe.beb_keyemp%type;
ws_key_con nmlobebe.beb_keycon%type;
ws_tip_ben nmlobebe.beb_tipben%type;
wn_tip_ben numeric(5);
wn_key_ben nmlobebe.beb_keyben%type;
wn_por_par nmlobebe.beb_porpar%type;
wn_imp_fij decimal(12,2);
wn_com_fam nmlobebe.beb_comfam%type;
ws_per_ini nmlobebe.beb_perini%type;
ws_per_fin nmlobebe.beb_perfin%type;
wd_fec_ven nmlobebe.beb_fecven%type;
ws_for_pag nmlobebe.beb_forpag%type;
wn_key_pro nmcoempl.emp_keypro%type;
wn_pla_zop numeric(5);
wn_imp_pre decimal(12,2);
wn_per_ini numeric(10);
wn_per_fin numeric(10);
wn_mov_ant decimal(16,6);
wn_mov_an1 decimal(16,6);
wn_num_sec numeric(5);
wd_fec_ini timestamp(0);
ws_hor_tem varchar(8);
c_tipben record;
c_bene record;
begin
for c_tipben in (
select pam_folfin, pam_cvesec
from glcopams
where pam_keypar = vs_tab_ben
and  nullif(pam_folfin::text, '') is not null
and  pam_folfin <> '    ' ) loop
ws_key_con := oracle.substr(c_tipben.pam_folfin,1,3);
ws_tip_ben := oracle.substr(c_tipben.pam_cvesec,1,2);
wn_mov_ant := 0;
wn_mov_an1 := 0;
for c_bene in (
select beb_keyemp, beb_tipben, beb_keyben, beb_porpar,
beb_comfam, beb_perini, beb_fecven, beb_forpag,
emp_keypro, beb_perfin,beb_impfij,beb_fecini
from nmlobebe, nmcoempl
where beb_tipben = ws_tip_ben
and beb_keyemp = emp_keyemp
and ( nullif(beb_status::text, '') is null or beb_status = ' ' )) loop
wn_key_emp := c_bene.beb_keyemp;
ws_tip_ben := c_bene.beb_tipben;
wn_key_ben := c_bene.beb_keyben;
wn_por_par := c_bene.beb_porpar;
wn_com_fam := c_bene.beb_comfam;
ws_per_ini := c_bene.beb_perini;
wd_fec_ven := c_bene.beb_fecven;
ws_for_pag := c_bene.beb_forpag;
wn_key_pro := c_bene.emp_keypro;
ws_per_fin := c_bene.beb_perfin;
wn_imp_fij := c_bene.beb_impfij;
wd_fec_ini := c_bene.beb_fecini;
-- obtener la clave unica del prestamo
call sp_glfechor (wn_fec_mov,ws_hor_tem);
ws_tmp_mov := to_char(clock_timestamp(),'HH24');
wn_hor_mov := ws_tmp_mov;
ws_tmp_mov := to_char(clock_timestamp(),'MI');
wn_min_mov := ws_tmp_mov;
ws_tmp_mov := to_char(clock_timestamp(),'SS');
wn_seg_mov := ws_tmp_mov;
wn_tot_mov := ((wn_hor_mov*3600) +
(wn_min_mov*60) + wn_seg_mov)/100000;
wn_tot_mov := wn_fec_mov + wn_tot_mov;
wn_per_ini := ws_per_ini;
wn_per_fin := ws_per_fin;
--        wn_pla_zop := wn_per_fin - wn_per_ini;
wn_pla_zop := 1;
wn_imp_pre := wn_por_par * wn_pla_zop;
if wn_mov_ant = wn_tot_mov then
wn_tot_mov := wn_tot_mov + .000010;
end if;
if wn_mov_ant > wn_tot_mov then
wn_tot_mov := wn_tot_mov + .000020;
end if;
wn_mov_ant := wn_tot_mov;
wn_tip_ben := ws_tip_ben;
insert into nmlopres( pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
pre_tippre,
pre_unipre, pre_imppre, pre_gastos, pre_plazop, pre_unides,
pre_porint, pre_impdes, pre_perini, pre_fecini, pre_fecaut,
pre_cveaut, pre_fechab, pre_uniamo, pre_impamo, pre_unisal,
pre_impsal, pre_uniult, pre_impult, pre_numpag, pre_intpag,
pre_status, pre_ultact, pre_refcon, pre_ctreve, pre_fe1aux,
pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux, pre_ca4aux,
pre_uniope, pre_keypro )
values ( wn_key_emp, ws_key_con , wn_tot_mov, ws_tip_ben, to_timestamp(wn_fec_mov),
vs_tip_pre,
wn_key_ben, wn_com_fam , 0 		 , wn_tip_ben , 0            ,
wn_por_par, wn_imp_fij , ws_per_ini, wd_fec_ini, to_timestamp(wn_fec_mov)   ,
vn_key_usu, null       , 0         , 0          , wn_key_ben   ,
wn_com_fam, 0          , 0         , 0          , 0            ,
2         , to_timestamp(wn_fec_mov),null       , null       , wd_fec_ven   ,
null      , null       ,null       , ws_per_ini , null         ,
0         , wn_key_pro );
end loop;
update nmlobebe set beb_status = 'T'
where beb_tipben = ws_tip_ben
and (nullif(beb_status::text, '') is null or beb_status = ' ');
/* commit; */
end loop;end;
$body$
language plpgsql
;
