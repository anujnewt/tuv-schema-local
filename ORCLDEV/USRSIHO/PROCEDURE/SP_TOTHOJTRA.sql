create or replace procedure usrsiho."sp_tothojtra"  ( intnumhoja numeric, strusuario varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_ind_con varchar(2);
begin
delete from usrsiho.glwkcrys where cry_idepcc = 'totlla' and  cry_keyusu = strusuario and  cry_nomrep = 'tothollama';
insert into usrsiho.glwkcrys( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
--cuota de transito
select  'tothollama', 'totlla', strusuario, 0, 'Total Gral Cuota Transito:' , coalesce(det_noforo, '-'),
coalesce(
sum(
case when coalesce(oracle.substr(enc_descap,1,11),'') = 'RETROACTIVO' then
case
when(det_tipinc='N' or det_tipinc='LI') then
(
( select  tab_import
from    usrsiho.holotabs
where   tab_keytab = 3
and 	tab_keypro =  138
and 	tab_keypue = det_keypue
and 	tab_pertra = con_pertra
and 	tab_idioma = con_idioma
and 	tab_keynac = con_keynac
-- and det_fecgra between tab_fecini and tab_fecfin
and 	extract(year from tab_fecfin) = extract(year from det_fecgra)
+ 1
)
-
( select  	tab_import
from    usrsiho.holotabs
where   tab_keytab = 3
and tab_keypro =  138
and tab_keypue = det_keypue
and tab_pertra = con_pertra
and tab_idioma = con_idioma
and tab_keynac = con_keynac
--and det_fecgra between tab_fecini and tab_fecfin
and extract(year from tab_fecfin) = extract(year from det_fecgra)
)
)
else
0 	-- solo aplica para extranjeros (si existe el tabulador)
end
else
case
when(det_tipinc='N' or det_tipinc='LI' or det_tipinc='JV'  or det_tipinc='JE') and nullif(det_keyaut::text, '') is null  then ( 	select  tab_import
from    usrsiho.holotabs
where   tab_keytab = 3
and 	tab_keypro =  138
and 	tab_keypue = det_keypue
and 	tab_pertra = con_pertra
and 	tab_idioma = con_idioma
and 	tab_keynac = con_keynac
and 	det_fecgra between tab_fecini and tab_fecfin
)
else
0 	-- solo aplica para extranjeros (si existe el tabulador)
end
end
*
case when coalesce((oracle.substr(det_auxca2, 8, 1))::numeric , 0) = 1 then ( 	select 	case when count(*) > 0 then 3 else 1 end
from 	usrsiho.glcopams
where 	pam_keypar = 'CDF'
and 	pam_folfin = to_char(det_fecgra, 'DD/MM/YYYY')
)
+
case when coalesce((oracle.substr(det_auxca2, 6, 1))::numeric , 0) = 1 then 1 else 0 end
else
1
end
*
((det_capfin - det_capini) + 1) ), 0)
from 	usrsiho.holodettra
join usrsiho.holoenctra on enc_num_id = det_num_id
left join usrsiho.holocont on det_keyemp = con_keyemp and det_keyfol = con_keyfol
where   det_num_id  = intnumhoja
and 	det_keyemp not in ( select  pam_folini
from 	usrsiho.glcopams
where   pam_keypar = 'ACP'
and 	pam_folfin = 'CODIGO ANDA')
--and det_tipinc in ("n", "li")
and 	det_sindkto in ('ANDA', 'ANDA PENSIONADA')
and 	det_stsreg = 'V'
group by det_noforo; --6,5;
-- prevision social
-- ----------------
insert into usrsiho.glwkcrys( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
select  'tothollama', 'totlla', strusuario, 0, 'Total Gral Prevision Social:', coalesce(det_noforo, '-'),
round (
sum(
case when det_keytco = 2 then
(
case when(det_tipinc='N' or det_tipinc='LI') and nullif(det_keyaut::text, '') is null  then
( 	select 	tab_import
from 	usrsiho.holotabs
where 	tab_keypro = 138
and 	tab_keypue = con_keypue
and 	tab_pertra = con_pertra
and 	tab_idioma = con_idioma
and 	tab_keynac = con_keynac
and 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
and 	det_fecgra between tab_fecini and tab_fecfin
)
when(det_tipinc in ('DE', 'CM', 'CN','PA')) then
0
else
det_cosuni
end
*
case when coalesce((oracle.substr(det_auxca2, 8, 1))::numeric , 0) = 1 then ( 	select 	case when count(*) > 0 then 3 else 1 end
from 	usrsiho.glcopams
where 	pam_keypar = 'CDF'
and 	pam_folfin = to_char(det_fecgra, 'DD/MM/YYYY')
)
else
1
end
*
((coalesce(det_capfin,1) - coalesce(det_capini,1)) + 1)
*
case when coalesce((oracle.substr(det_auxca2, 6, 1))::numeric , 0) = 1 then
2
else
1
end
) * 0.18
+
(
case
when nullif(det_keyemp::text, '') is null or nullif(det_keyfol::text, '') is null then
0
else
usrsiho.sp_calimptiext( (coalesce(oracle.substr(det_hraent,1,2),0)*60 + coalesce(oracle.substr(det_hraent,4,2),0)),
(coalesce(oracle.substr(det_hrasal,1,2),0)*60 + coalesce(oracle.substr(det_hrasal,4,2),0)),
case
when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then 30
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then 0
else 0
end,
coalesce(det_capini,0),
coalesce(det_capfin,0),
det_keydep,
det_keyfol,
coalesce(con_keypue,'X'),
coalesce(case
when(det_tipinc='N' or det_tipinc='LI') and nullif(det_keyaut::text, '') is null  then
( 	select 	tab_import
from 	usrsiho.holotabs
where 	tab_keypro = 138
and 	tab_keypue = con_keypue
and 	tab_pertra = con_pertra
and 	tab_idioma = con_idioma
and 	tab_keynac = con_keynac
and 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
and 	det_fecgra between tab_fecini and tab_fecfin
)
else
det_cosuni
end, con_cosuni
),
det_keytco,
coalesce(det_keyemp,0),
det_fecgra,
det_serial,
intnumhoja) * 0.18
end
)
else
0
end
), 2)
from  	usrsiho.holodettra
join usrsiho.holoenctra on enc_num_id = det_num_id
left join usrsiho.holocont on det_keyemp = con_keyemp and con_keyfol = det_keyfol	and con_cosuni>= 0.01
left join usrsiho.nmcopues on pue_keypue = coalesce(con_keypue, det_keypue)
where   det_num_id  = intnumhoja
and 	det_keyemp not in ( select	pam_folini
from  	usrsiho.glcopams
where 	pam_keypar = 'ACP'
and 	pam_folfin = 'CODIGO ANDA'
)
and det_stsreg = 'V'
and oracle.substr(pue_ca4aux,2, 1) = 1
group by det_noforo;
-- fomento a la cultura
-- --------------------
-- eljm 07.10.2021 aplica condicion de busqueda
ws_ind_con := 'NO';
select pam_folini into strict ws_ind_con from usrsiho.glcopams where pam_keypar = 'ACP' and pam_cvesec = '99999';
insert into usrsiho.glwkcrys( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
select  'tothollama', 'totlla', strusuario, 0, 'Total Gral Fomento C:', coalesce(det_noforo, '-'),
round(
case when coalesce(oracle.substr(enc_descap,1,11),'') = 'RETROACTIVO' then
sum(
case
when det_keytco = 2 then
(
( 	case
when(det_tipinc='N' or det_tipinc='LI') then
( 	select 	tab_import
from   	usrsiho.holotabs
where  	tab_keypro = 138
and 	tab_keypue = con_keypue
and 	tab_pertra = con_pertra
and 	tab_idioma = con_idioma
and 	tab_keynac = con_keynac
and 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
and 	det_fecgra between tab_fecini and tab_fecfin
)
when(det_tipinc in ('DE', 'CM', 'CN','PA')) then
0
else
det_cosuni
end  * 0.0300)
-
( case
-- eljm 07.10.2021 aplica condicion de busqueda
-- when (det_tipinc='N' or det_tipinc='LI') then
when(det_tipinc='N' or det_tipinc='LI') and ws_ind_con = 'SI' then
( select  tab_import
from    usrsiho.holotabs
where   tab_keypro = 138
and tab_keypue = con_keypue
and tab_pertra = con_pertra
and tab_idioma = con_idioma
and tab_keynac = con_keynac
and tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
and det_fecgra > tab_fecfin
and (extract(year from det_fecgra)=extract(year from tab_fecfin))
and (extract(year from to_timestamp(det_fecgra,'MM/DD/YYYY'))=extract(year from tab_fecini))
)
when(det_tipinc='N' or det_tipinc='LI') then
( select  tab_import
from    usrsiho.holotabs
where   tab_keypro = 138
and tab_keypue = con_keypue
and tab_pertra = con_pertra
and tab_idioma = con_idioma
and tab_keynac = con_keynac
and tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
and det_fecgra > tab_fecfin
and (extract(year from det_fecgra)=extract(year from tab_fecfin))
)
else
0
end  * 0.0300 )
) * ((det_capfin - det_capini ) + 1)
else
0
end
)
else
sum(
case
when det_keytco = 2 then
round(
case
when(det_tipinc='N' or det_tipinc='LI') and nullif(det_keyaut::text, '') is null then
( 	select  tab_import
from    usrsiho.holotabs
where   tab_keypro = 138
and 	tab_keypue = con_keypue
and 	tab_pertra = con_pertra
and 	tab_idioma = con_idioma
and 	tab_keynac = con_keynac
and 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
and 	det_fecgra between tab_fecini and tab_fecfin
)
-- eljm 23.12.2021 te ajuste de tiempo extra no lleva fomentos
-- when (det_tipinc in ('DE', 'CM', 'CN','PA')) then
when(det_tipinc in ('TE', 'DE', 'CM', 'CN','PA')) then
0
else
det_cosuni
end
* 0.0300
*
case when coalesce((oracle.substr(det_auxca2, 8, 1))::numeric , 0) = 1 then ( 	select 	case when count(*) > 0 then 3 else 1 end
from 	usrsiho.glcopams
where 	pam_keypar = 'CDF'
and 	pam_folfin = to_char(det_fecgra, 'DD/MM/YYYY')
)
else
1
end
*  ((det_capfin - det_capini ) + 1)
*
case when coalesce((oracle.substr(det_auxca2, 6, 1))::numeric , 0) = 1 then
2
else
1
end
)
else
0
end
)
end
)
from 	usrsiho.holodettra
join usrsiho.holoenctra on enc_num_id = det_num_id
left join usrsiho.holocont on det_keyemp = con_keyemp and det_keyfol = con_keyfol
where 	det_num_id  = intnumhoja
and 	det_keyemp not in ( select pam_folini
from   usrsiho.glcopams
where  pam_keypar = 'ACP'
and    pam_folfin = 'CODIGO ANDA')
and det_stsreg = 'V'
group by det_noforo, enc_descap; --6,5, enc_descap;
-- total gral fomento eficiencia
-- -----------------------------
insert into usrsiho.glwkcrys( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
select  'tothollama', 'totlla', strusuario, 0, 'Total Gral Fomento E:', coalesce(det_noforo, '-'),
round(
case when coalesce(oracle.substr(enc_descap,1,11),'') = 'RETROACTIVO' then
sum(
case
when det_keytco = 2 then
(
( case
when(det_tipinc='N' or det_tipinc='LI')  then
( 	select	tab_import
from    usrsiho.holotabs
where   tab_keypro = 138
and 	tab_keypue = con_keypue
and 	tab_pertra = con_pertra
and 	tab_idioma = con_idioma
and 	tab_keynac = con_keynac
and 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
and 	det_fecgra between tab_fecini and tab_fecfin )
when(det_tipinc in ('DE', 'CM', 'CN','PA')) then
0
else
det_cosuni
end  * 0.0300)
-
( case
-- eljm 07.10.2021 aplica condicion de busqueda
-- when (det_tipinc='N' or det_tipinc='LI') then
when(det_tipinc='N' or det_tipinc='LI') and ws_ind_con = 'SI' then
( 	select	tab_import
from    usrsiho.holotabs
where   tab_keypro = 138
and 	tab_keypue = con_keypue
and 	tab_pertra = con_pertra
and 	tab_idioma = con_idioma
and 	tab_keynac = con_keynac
and 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
and 	det_fecgra > tab_fecfin
and (extract(year from det_fecgra)=extract(year from tab_fecfin))
and (extract(year from to_timestamp(det_fecgra,'MM/DD/YYYY'))=extract(year from tab_fecini))
)
when(det_tipinc='N' or det_tipinc='LI') then
( 	select  tab_import
from    usrsiho.holotabs
where   tab_keypro = 138
and 	tab_keypue = con_keypue
and 	tab_pertra = con_pertra
and 	tab_idioma = con_idioma
and 	tab_keynac = con_keynac
and 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
and 	det_fecgra > tab_fecfin
and (extract(year from det_fecgra)=extract(year from tab_fecfin))
)
else
0
end  * 0.0300 )
)
*
((det_capfin - det_capini ) + 1)
else
0
end
)
else
sum(
case
when det_keytco = 2 then
round(
case
when(det_tipinc='N' or det_tipinc='LI') and nullif(det_keyaut::text, '') is null then
( 	select  tab_import
from    usrsiho.holotabs
where   tab_keypro = 138
and 	tab_keypue = con_keypue
and 	tab_pertra = con_pertra
and 	tab_idioma = con_idioma
and 	tab_keynac = con_keynac
and 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
and 	det_fecgra between tab_fecini and tab_fecfin
)
-- eljm 23.12.2021 ajuste de tiempo extra no lleva fomentos
-- when (det_tipinc in ('DE', 'CM', 'CN','PA')) then
when(det_tipinc in ('TE', 'DE', 'CM', 'CN','PA')) then
0
else  det_cosuni
end
* 0.0300
*
case when coalesce((oracle.substr(det_auxca2, 8, 1))::numeric , 0) = 1 then ( 	select 	case when count(*) > 0 then 3 else 1 end
from 	usrsiho.glcopams
where 	pam_keypar = 'CDF'
and 	pam_folfin = to_char(det_fecgra, 'DD/MM/YYYY')
)
else
1
end
*  ((det_capfin - det_capini ) + 1)
*
case when coalesce((oracle.substr(det_auxca2, 6, 1))::numeric , 0) = 1 then
2
else
1
end
)
else
0
end
)
end
)
from 	usrsiho.holodettra
join usrsiho.holoenctra on enc_num_id = det_num_id
left join usrsiho.holocont on det_keyemp = con_keyemp and det_keyfol = con_keyfol
where   det_num_id  = intnumhoja
and 	det_keyemp not in ( select  pam_folini
from    usrsiho.glcopams
where   pam_keypar = 'ACP'
and pam_folfin = 'CODIGO ANDA')
and det_stsreg = 'V'
group by det_noforo,enc_descap; --6,5, enc_descap;
-- calculo de hora extras
-- ----------------------
insert into usrsiho.glwkcrys( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
select  'tothollama', 'totlla', strusuario, 0, 'Total Gral Tiempo Extra:', coalesce(det_noforo, '-'),
sum( round(
case when nullif(det_keyemp::text, '') is null or nullif(det_keyfol::text, '') is null then
0
when nullif(det_keyemp::text, '') is not null then
sp_calimptiext( (coalesce(oracle.substr(det_hraent,1,2),0)*60 + coalesce(oracle.substr(det_hraent,4,2),0)), --hora entrada
(coalesce(oracle.substr(det_hrasal,1,2),0)*60 + coalesce(oracle.substr(det_hrasal,4,2),0)), -- hora salida minutos
case
when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 1 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then ((coalesce(oracle.substr(holoenctra.enc_salcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_salcom,4,2),0))::numeric )::numeric  - ((coalesce(oracle.substr(holoenctra.enc_entcom,1,2),0))::numeric  * 60 + (coalesce(oracle.substr(holoenctra.enc_entcom,4,2),0))::numeric )::numeric
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 1 then 30
when (oracle.substr(det_auxca2,9,1))::numeric  = 0 and (oracle.substr(det_auxca2,10,1))::numeric  = 0 then 0
else 0
end,
coalesce(det_capini,0),
coalesce(det_capfin,0),
det_keydep,
det_keyfol,
coalesce(con_keypue,'X'),
coalesce(case
when(det_tipinc='N' or det_tipinc='LI') and nullif(det_keyaut::text, '') is null  then
( 	select 	tab_import
from	usrsiho.holotabs
where	tab_keypro = 138
and 	tab_keypue = con_keypue
and 	tab_pertra = con_pertra
and 	tab_idioma = con_idioma
and 	tab_keynac = con_keynac
and 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
and 	det_fecgra between tab_fecini and tab_fecfin
)
else
det_cosuni
end, con_cosuni) ,
det_keytco,
coalesce(det_keyemp,0),
det_fecgra,
det_serial,
intnumhoja)
end
, 2))
from 	usrsiho.holodettra
join usrsiho.holoenctra on enc_num_id = det_num_id
left join usrsiho.holocont on det_keyemp = con_keyemp and det_keyfol = con_keyfol
where   det_num_id  = intnumhoja
and 	det_stsreg = 'V'
group by det_noforo;
-- calculo de viaticos
-- -------------------
delete from usrsiho.tmp_viat;
insert into usrsiho.tmp_viat
select  *
from    usrsiho.glcopams
where   pam_keypar = 'ACP'
and pam_nompar in ('PASAJES','VIATICOS LOCACION','DESAYUNO','COMIDA','CENA');
insert into usrsiho.glwkcrys( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
select  'tothollama', 'totlla', strusuario, 0, 'Total Gral Vaticos:', coalesce(det_noforo, '-'),
case
when coalesce(oracle.substr(enc_descap,1,11), ' ') <> 'RETROACTIVO' then
sum
(
((case when coalesce(det_acomen,0) = 1 then 2 else 1 end) * coalesce(p.pam_folini,0))
+   ((case when coalesce(det_acomen,0) = 1 then 2 else 1 end) * coalesce(v.pam_folini,0))
+   ((case when coalesce(det_acomen,0) = 1 then 2 else 1 end) * coalesce(d.pam_folini,0))
+   ((case when coalesce(det_acomen,0) = 1 then 2 else 1 end) * coalesce(c.pam_folini,0))
+   ((case when coalesce(det_acomen,0) = 1 then 2 else 1 end) * coalesce(n.pam_folini,0))
+   ((case when coalesce(det_acomen,0) = 1 then 2 else 1 end) * coalesce(ip.pam_folini,0))
+   ((case when coalesce(det_acomen,0) = 1 then 2 else 1 end) * coalesce(id.pam_folini,0))
+   ((case when coalesce(det_acomen,0) = 1 then 2 else 1 end) * coalesce(ic.pam_folini,0))
+   ((case when coalesce(det_acomen,0) = 1 then 2 else 1 end) * coalesce(ni.pam_folini,0))
)
else
0
end
from   	usrsiho.holodettra
join usrsiho.holoenctra on enc_num_id = det_num_id
left join usrsiho.tmp_viat p on p.pam_nompar = case when oracle.substr(det_auxca2,1,1) = '1' and det_tipinc not in ('DE', 'CM', 'CN','PA') then 'PASAJES' else '' end
left join usrsiho.tmp_viat v on v.pam_nompar = case when oracle.substr(det_auxca2,2,1) = '1' then 'VIATICOS LOCACION' else '' end
left join usrsiho.tmp_viat d on d.pam_nompar = case when oracle.substr(det_auxca2,3,1) = '1' and det_tipinc not in ('DE', 'CM', 'CN','PA') then 'DESAYUNO' else '' end
left join usrsiho.tmp_viat c on c.pam_nompar = case when oracle.substr(det_auxca2,4,1) = '1' and det_tipinc not in ('DE', 'CM', 'CN','PA') then 'COMIDA' else '' end
left join usrsiho.tmp_viat n on n.pam_nompar = case when oracle.substr(det_auxca2,5,1) = '1' and det_tipinc not in ('DE', 'CM', 'CN','PA') then 'CENA' else '' end
left join usrsiho.tmp_viat ip on ip.pam_nompar = case when det_tipinc = 'PA' then 'PASAJES' else '' end
left join usrsiho.tmp_viat id on id.pam_nompar = case when det_tipinc = 'DE' then 'DESAYUNO' else '' end
left join usrsiho.tmp_viat ic on ic.pam_nompar = case when det_tipinc = 'CM' then 'COMIDA' else '' end
left join usrsiho.tmp_viat ni on ni.pam_nompar = case when det_tipinc = 'CN' then 'CENA' else '' end
where   det_num_id  = intnumhoja
and 	det_stsreg = 'V'
group by det_noforo,enc_descap; --6, 5, enc_descap;
--execute immediate 'TRUNCATE TABLE TMP_VIAT';
-- total gral costo unitario
-- -------------------------
insert into usrsiho.glwkcrys( cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_chr001, cry_chr002, cry_dec001)
--total de la hoja
select  'tothollama', 'totlla', strusuario, 0, 'Total Gral Costo Unitario:', coalesce(det_noforo, '-'),
sum (
case when(det_tipinc='N' or det_tipinc='LI') and nullif(det_keyaut::text, '') is null  then
( 	select 	tab_import
from 	usrsiho.holotabs
where 	tab_keypro = 138
and 	tab_keypue = con_keypue
and 	tab_pertra = con_pertra
and 	tab_idioma = con_idioma
and 	tab_keynac = con_keynac
and 	tab_keytab = (case when con_keytco = 519 then 3 else con_keytco end -1)
and 	det_fecgra between tab_fecini and tab_fecfin
)
when(det_tipinc in ('DE', 'CM', 'CN','PA')) then
0
else
det_cosuni
end
*
case when coalesce((oracle.substr(det_auxca2, 8, 1))::numeric , 0) = 1 then ( 	select 	case when count(*) > 0 then 3 else 1 end
from 	usrsiho.glcopams
where 	pam_keypar = 'CDF'
and 	pam_folfin = to_char(det_fecgra, 'DD/MM/YYYY')
)
else
1
end
*
((coalesce(det_capfin,1) - coalesce(det_capini,1)) + 1)
*
case when coalesce((oracle.substr(det_auxca2, 6, 1))::numeric , 0) = 1 then
2
else
1
end
)
from    usrsiho.holodettra
left join usrsiho.holocont on det_keyemp = con_keyemp and det_keyfol = con_keyfol
left join usrsiho.nmcopues on pue_keypue = con_keypue
where   det_num_id  = intnumhoja
and 	det_stsreg = 'V'
-- and con_cosuni >= 0.01
group by det_noforo; --6,5;
delete from usrsiho.glwkcrys
where   cry_nomrep = 'tothollama'
and 	cry_idepcc = 'totlla'
and 	cry_keyusu = strusuario
and 	coalesce(cry_dec001, 0) = 0;
/* commit; */
end;
$body$
language plpgsql
;
