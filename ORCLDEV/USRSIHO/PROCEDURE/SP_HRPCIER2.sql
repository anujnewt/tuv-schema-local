create or replace procedure usrsiho."sp_hrpcier2"  (pi_proceso numeric, ps_periodo varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
li_keyrph numeric(10);
li_keyfol numeric(10);
li_keyplz numeric(10);
li_capini numeric(10);
li_capfin numeric(10);
li_tipocontr numeric(10);
li_keysec numeric(10);
li_count  numeric(10);
li_numcap  numeric(10);
li_cntpag  numeric(10);
ls_keydep varchar(16);
ls_keypue varchar(16);
li_costo  decimal(16,2);
li_exipre numeric(10);
li_empleado numeric(10);
ls_tipfol varchar(1);
ls_sindic varchar(1);
ls_regfis varchar(6);
ls_activi varchar(6);
ls_concep varchar(6);
ld_fecpag timestamp(0);
vn_keytco numeric(3);
vn_keyfol numeric(6);
vn_numcap numeric(5);
vn_sumcap numeric(5);
li_keydep varchar(8);
li_keyemp numeric(09);
li_keytco numeric(03);
li_ctvplz numeric(09);
wn_ca2aux varchar(12);
li_nomina numeric(10);
rec record;
rec2 record;
rec3 record;
rec4 record;
rec5 record;
rec6 record;
rec7 record;
begin
--modificaciones de contratos capitulos
for rec in (select 	frp.frp_keyrph,gdp.gdp_keyfol,gdp.gdp_capini,gdp.gdp_capfin,gdp.gdp_keytco,con.con_keyplz,
frp.frp_keydep,gdp.gdp_keypue,gdp.gdp_numcap * gdp.gdp_cosuni total
from 	usrsiho.holofrph frp,usrsiho.hologdpr gdp,usrsiho.holocont con
where 	frp.frp_keypro = pi_proceso
and 	frp.frp_keyper = ps_periodo
and 	frp.frp_keyrph = gdp.gdp_keyrph
and 	con.con_keyfol = gdp.gdp_keyfol
and 	con.con_keytco = gdp.gdp_keytco
and 	con.con_stspag = 'V'
group by 	frp.frp_keyrph,	gdp.gdp_keyfol,	gdp.gdp_capini,	gdp.gdp_capfin,	gdp.gdp_keytco,	con.con_keyplz,
frp.frp_keydep, gdp.gdp_keypue, gdp.gdp_numcap, gdp.gdp_cosuni) loop
--actualizacion por cada uno del los registros
li_keyrph := rec.frp_keyrph;
li_keyfol := rec.gdp_keyfol;
li_capini := rec.gdp_capini;
li_capfin := rec.gdp_capfin;
li_tipocontr := rec.gdp_keytco;
li_keyplz := rec.con_keyplz;
ls_keydep := rec.frp_keydep;
ls_keypue := rec.gdp_keypue;
li_costo := rec.total;
update usrsiho.holococa
set coc_stspag = 'E'
where coc_keyplz = li_keyplz and coc_keycap between li_capini and li_capfin;
-- 		      --si el registro existe => actualiza de lo contrario, inserta el registro
--            select count(*)
--            into 	li_exipre
--            from 	holopres
--            where 	pre_keydep=ls_keydep
--            and	pre_keypue=ls_keypue;
-- si el tipo de folio es normal => realiza la actualizacion
begin
select	trim(both per_nu5aux)
into strict 	ls_tipfol
from 	usrsiho.nmloperi
where 	per_keypro = pi_proceso
and 	per_keyper = ps_periodo;
exception when no_data_found then ls_tipfol:= null;
end;
--            if li_exipre > 0 then
--            	  --ajuste del presupuesto solo si el tipo de folio es normal
--                if ls_tipfol = 'N' then
--              	  update	holopres
--                    set 		pre_pagado=pre_pagado+li_costo
--                    where 	pre_keydep=ls_keydep
--                    and 		pre_keypue=ls_keypue;
--                end if
--        	  else
--            	  insert into holopres(pre_keydep,pre_keypue,pre_presup,pre_ejerci,pre_pagado)
--            	  values(ls_keydep,ls_keypue,0,0,li_costo);
--         	  end if
end loop;
--insertado en la tabla temporal
li_keyrph := 0;
li_keyfol := 0;
insert into cierre2_tmp
select 	gdp.gdp_keyfol tem_keyfol,gdp.gdp_keytco tem_keytco
from	usrsiho.holofrph frp,usrsiho.hologdpr gdp,usrsiho.holocont con
where 	frp.frp_keypro = pi_proceso
and 	frp.frp_keyper = ps_periodo
and 	frp.frp_keyrph = gdp.gdp_keyrph
and 	con.con_keyfol = gdp.gdp_keyfol
and 	con.con_keytco = gdp.gdp_keytco
group by 	gdp.gdp_keyfol,gdp.gdp_keytco
;
--actualizacion de contratos
--phm 20161018 se agrega el con_numcap al select y al into el li_numcap
for rec2	in (select	con.con_keyplz, con.con_keytva, con_keydep, con_keyemp, con_keytco, con_ctvplz, con_numcap
from 	usrsiho.holocont con, usrsiho.cierre2_tmp tem
where 	con.con_keyfol = tem.gdp_keyfol
and 	con_keytco = gdp_keytco) loop
li_keyplz := rec2.con_keyplz;
li_tipocontr := rec2.con_keytva;
li_keydep := rec2.con_keydep;
li_keyemp := rec2.con_keyemp;
li_keytco := rec2.con_keytco;
li_ctvplz := rec2.con_ctvplz;
li_numcap := rec2.con_numcap;
if li_tipocontr = 1 then
--select count(*) into li_count from holococa
--where coc_keyplz = li_keyplz and coc_stspag <> 'E';
--if  li_count = 0 then
--phm 20161018 se comentan las 3 lineas anteriores y se agregan las 2 siguientes
begin
select count(*)
into strict li_cntpag
from usrsiho.holococa
where coc_keyplz = li_keyplz
and nullif(coc_keyrph::text, '') is not null;
exception when no_data_found then li_cntpag := 0;
end;
if li_cntpag = li_numcap then
update  usrsiho.holocont
set     con_stspag = 'E'
where   con_keyplz = li_keyplz;
update usrsiho.holoplza
set plz_status = 0, plz_keyfol  = null
where plz_ctvplz = li_ctvplz
and plz_keydep = li_keydep
and plz_keyemp = li_keyemp
and plz_keytco = li_keytco;
end if;
end if;
if li_tipocontr = 2 then
--phm 20161018 se agrega el con_numcap al select y al into el li_numcap
for rec3 in (select con_numcdi, con_numcap from usrsiho.holocont where con_keyplz = li_keyplz) loop
li_count := rec3.con_numcdi;
li_numcap := rec3.con_numcap;
if  li_count = 0 then
--phm 20161018 se agrega el select y el if de las siguientes 2 lineas
select count(*) into strict li_cntpag from usrsiho.holococa where coc_keyplz = li_keyplz and nullif(coc_keyrph::text, '') is not null;
if li_cntpag = li_numcap then
update  usrsiho.holocont
set     con_stspag = 'E'
where   con_keyplz = li_keyplz;
end if;
end if;
end loop;
end if;
end loop;
--traspaso de gastos de produccion a historico de produccion.
insert into usrsiho.holohgdp(hgd_keysec,hgd_keydep,hgd_keyrph,hgd_fechag,hgd_keyemp,
hgd_keypue,hgd_capini,hgd_capfin,hgd_numcap,hgd_keycon,
hgd_marcon,hgd_marcos,hgd_costog,hgd_keysue,hgd_keytco,
hgd_keyfol,hgd_minleg,hgd_minsal,hgd_minext,hgd_mincom)
select gdp.gdp_keysec,gdp.gdp_keydep,frp.frp_keyrph,gdp.gdp_fechag,gdp.gdp_keyemp,
gdp.gdp_keypue,gdp.gdp_capini,gdp.gdp_capfin,gdp.gdp_numcap,gdp.gdp_keycon,
gdp.gdp_marcon,gdp.gdp_marcos,gdp.gdp_cosuni,gdp.gdp_keysue,gdp.gdp_keytco,
gdp.gdp_keyfol,gdp.gdp_minleg,gdp.gdp_minsal,gdp.gdp_minext,gdp.gdp_mincom
from   usrsiho.hologdpr gdp , usrsiho.holofrph frp
where  frp.frp_keypro = pi_proceso and
frp.frp_keyper = ps_periodo and
frp.frp_keyrph = gdp.gdp_keyrph;
--marcar los rph como historicos
update usrsiho.holofrph
set frp_stsfol = '2'
where frp_keypro = pi_proceso
and frp_keyper = ps_periodo;
--borrar los registros de la tabla de gastos de produccion
delete
from usrsiho.hologdpr
where  gdp_keyrph  in ( select frp.frp_keyrph  from usrsiho.holofrph frp
where frp.frp_keypro = pi_proceso and
frp.frp_keyper = ps_periodo);
--borrar la tabla temporal
--execute immediate 'TRUNCATE TABLE temporal';
-- cierre2_tmp
--    update nmlohism set his_ca1aux = nvl(his_ca1aux[1,3],'   ')||'0'
--     where his_keypro = pi_proceso
--and his_keyper = ps_periodo;
begin
select per_fecpag
into strict ld_fecpag
from usrsiho.nmloperi
where per_keypro = pi_proceso
and per_keyper = ps_periodo;
exception when no_data_found then ld_fecpag:= null;
end;/* dmap converted statement start */
perform dbms_output.put_line('coalesce(oracle.substr(his_ca1aux,1,3)');/* dmap converted statement end *//* dmap converted statement start */
update usrsiho.nmlohism
-- set his_ca1aux = coalesce(oracle.substr(his_ca1aux,1,3),'   ')||'0',
set his_ca1aux = pon_valor(his_ca1aux, 4, '0'),
his_fecmov = ld_fecpag
where his_keypro = pi_proceso
and his_keyper = ps_periodo;/* dmap converted statement end */
------------     actualiza el regimen fiscal  ------------------
for rec4
in (select his_keyemp,pam_cvesec
from usrsiho.nmlohism,usrsiho.glcopams
where his_keypro = pi_proceso
and his_keyper = ps_periodo
and his_keycon = 'H87'
and pam_keypar = 'TC2'
and (pam_cvesec)::numeric  = his_import) loop
li_empleado := rec4.his_keyemp;
ls_regfis := rec4.pam_cvesec;/* dmap converted statement start */
perform dbms_output.put_line( concat('ls_regfis ', to_char(ls_regfis))) ;/* dmap converted statement end */
update usrsiho.nmlohism set his_ca1aux = ls_regfis
where his_keypro = pi_proceso
and his_keyper = ps_periodo
and his_keyemp = li_empleado;
end loop;
------------     actualiza las cuotas sindicales ------------------
for rec5
in (select distinct pue_keypue,pue_ca5aux,case when oracle.substr(pue_ca3aux,1,2)='10' then '7' when oracle.substr(pue_ca3aux,1,2)='12' then '8' when oracle.substr(pue_ca3aux,1,2)='8' then '9'  else oracle.substr(pue_ca3aux,1,1) end  valor
from usrsiho.nmlohism,usrsiho.nmcopues
where his_keypro = pi_proceso
and his_keyper = ps_periodo
and his_keypue = pue_keypue
and his_keypue != 'H01'
and nullif(pue_ca3aux::text, '') is not null) loop
ls_activi := rec5.pue_keypue;
ls_concep := rec5.pue_ca5aux;
ls_sindic := rec5.valor;/* dmap converted statement start */
perform dbms_output.put_line( concat('oracle.substr(his_ca1aux,1,4 ', to_char(ls_sindic))) ;/* dmap converted statement end */
-- corregir sentencia eljm
-- update usrsiho.nmlohism set his_ca1aux = nvl(oracle.substr(his_ca1aux,1,4),'    ')||ls_sindic
update usrsiho.nmlohism set his_ca1aux = pon_valor(his_ca1aux, 5, ls_sindic)
where his_keypro = pi_proceso
and his_keyper = ps_periodo
and his_keypue = ls_activi
and his_keycon = ls_concep;
end loop;
--actualizar los movimientos de anda y andi como pagados
begin
select per_fecpag, per_keynom
into strict ld_fecpag, li_nomina
from usrsiho.nmloperi
where per_keypro = pi_proceso
and per_keyper = ps_periodo;
exception when no_data_found then ld_fecpag:= null; li_nomina := 0;
end;
perform dbms_output.put_line('002 oracle.substr(his_ca1aux,4,lentgh ');/* dmap converted statement start */
update usrsiho.nmlohism
set his_ca1aux =  concat('002', oracle.substr(his_ca1aux, 4, length(his_ca1aux))) ,
his_fecmov = ld_fecpag
where his_keypro = pi_proceso
and his_keyper = ps_periodo
--      and his_keynom in (109,110)  --   linea original
and his_keynom in (109,110,103); --   linea nueva  }  ---se comento todo el update 23/01/2007
/* dmap converted statement end */
--      and exists(select emp_keyemp
--                 from nmcoempl
--                where emp_keyemp = his_keyemp
--                  and emp_ca2aux < 100); } --se comento esto por que no es necesario y estaba tronando conversion character
/*update nmlohism
set his_ca1aux = '1021',his_fecmov = ld_fecpag
where his_keypro = pi_proceso
and his_keyper = ps_periodo
--and his_keynom in (109,110)  --   linea original
and his_keynom in (109,110,103); --   linea nueva */
---se comento todo el update 23/01/2007
/*      and exists(select emp_keyemp
from nmcoempl
where emp_keyemp = his_keyemp
and emp_ca2aux > 99); */
--se comento esto por que no es necesario y estaba tronando conversion character
if li_nomina = 113 then
begin
select  emp_ca2aux
into strict wn_ca2aux
from usrsiho.nmcoempl
where emp_keyemp = 490195711;
exception when no_data_found then wn_ca2aux:= null;
end;
end if;
li_nomina := 0;/* dmap converted statement start */
perform dbms_output.put_line( concat('wn_ca2aux ', to_char(wn_ca2aux))) ;/* dmap converted statement end *//* dmap converted statement start */
update usrsiho.nmlohism
--set his_ca1aux[1,3] = wn_ca2aux
set his_ca1aux =  concat(wn_ca2aux, oracle.substr(his_ca1aux, 4, length(his_ca1aux))) ,
his_fecmov = ld_fecpag
where his_keypro = pi_proceso
and his_keyper = ps_periodo
and his_keynom in (113)
and his_keyemp = 490195711;/* dmap converted statement end */
perform dbms_output.put_line('008 ');/* dmap converted statement start */
update usrsiho.nmlohism
--set his_ca1aux[1,3] = '008'
set his_ca1aux =  concat('008', oracle.substr(his_ca1aux, 4, length(his_ca1aux))) ,
his_fecmov = ld_fecpag
where his_keypro = pi_proceso
and his_keyper = ps_periodo
and his_keynom in (113)
and his_keyemp <> 490195711;/* dmap converted statement end */
---aedo 30/08/07 se comento el filtro
----      and exists(select emp_keyemp
----                 from nmcoempl
----                where emp_keyemp = his_keyemp
----                  and emp_ca2aux not in ('104','107'));
--------------------------------------------------------------------------------
for rec6
in (select his_keyemp,emp_ca2aux
from usrsiho.nmlohism,usrsiho.nmcoempl
where  his_keypro = pi_proceso
and his_keyper = ps_periodo
and his_keyemp = emp_keyemp
and emp_ca2aux  in ('104','107')) loop
li_empleado := rec6.his_keyemp;
ls_regfis := rec6.emp_ca2aux;/* dmap converted statement start */
perform dbms_output.put_line( concat('ls_regfis 2 ', to_char(ls_regfis))) ;/* dmap converted statement end */
update usrsiho.nmlohism set his_ca1aux = ls_regfis
where his_keypro = pi_proceso
and his_keyper = ps_periodo
and his_keyemp = li_empleado
and his_keynom <> 113;
---aedo 30/08/07  se agrego el filtro de la nomina 113
end loop;
---------------------------------------------------------------------------------
--aedo 30/08/07  se quito el envio del valor 1
---   set his_ca1aux = '008'||'1',his_fecmov = ld_fecpag
perform dbms_output.put_line('008');
update usrsiho.nmlohism
set his_ca1aux = '008',his_fecmov = ld_fecpag
where his_keypro = pi_proceso
and his_keyper = ps_periodo
and (his_keycon = 'H42' or his_keyemp = 1);
--aedo 30/08/07  se quito el envio del valor 1
---   set his_ca1aux = '0081',his_fecmov = ld_fecpag
perform dbms_output.put_line('008 2 ');
update usrsiho.nmlohism
set his_ca1aux = '008',
his_fecmov = ld_fecpag
where his_keypro = pi_proceso
and his_keyper = ps_periodo
and his_keycon = 'H20';
---se adicionaron estas lineas al store procedure jdcm 23/feb/2005
--- primero es un foreach
for rec7  in (select hgd_keytco,hgd_keyfol,con_numcap
from usrsiho.holofrph,
usrsiho.holohgdp,
usrsiho.holocont
where frp_keypro=pi_proceso
and frp_keyper=ps_periodo
and frp_keyrph=hgd_keyrph
and con_keytco=hgd_keytco
and con_keyfol=hgd_keyfol
and con_stspag='V') loop
--- segundo, sumatoria de capitulos realmente pagados
vn_keytco := rec7.hgd_keytco;
vn_keyfol := rec7.hgd_keyfol;
vn_numcap := rec7.con_numcap;
select sum(hgd_numcap)
into strict vn_sumcap
from usrsiho.holohgdp,usrsiho.holofrph,usrsiho.nmloperi,usrsiho.nmlohism,usrsiho.holoenctra,usrsiho.holodettra
where hgd_keytco=vn_keytco
and hgd_keyfol=vn_keyfol
and frp_keypro=pi_proceso
and frp_keyrph=hgd_keyrph
and frp_keypro=per_keypro
and frp_keyper=per_keyper
and per_keypro=his_keypro
and per_keyper=his_keyper
and per_keynom=his_keynom
and his_keyemp=hgd_keyemp
and his_keypue=hgd_keypue
and his_keycon=hgd_keycon
and his_keydep=frp_keydep      ---cig---27/04/2005---
and oracle.substr(his_ca1aux,4, 1)!='2'
--phm 2017 se le anexan las siguientes 6 lineas y las tablas holoenctra y holodettra
and frp_keyrph=det_keyrph
and hgd_keyfol=det_keyfol
and hgd_keyemp=det_keyemp
and det_num_id=enc_num_id
and det_stsreg='V'
and enc_descap not like 'RETROACTIVO%';
-- en caso de con_numcap = a la sumatoria del segundo
if vn_sumcap = vn_numcap then
/* insert into borra(campo1) values(vn_keyfol);
insert into borra(campo1) values(vn_keytco);
insert into borra(campo1) values(vn_numcap);
insert into borra(campo1) values(vn_sumcap);*/
update usrsiho.holocont
set con_numcdi=0,
con_stspag='E'
where con_keytco=vn_keytco
and con_keyfol=vn_keyfol;
end if;
end loop;
---jdcm termina lineas extras
---jcro proceso para actualizar el estatus de las hojas de trabajo a cerradas.
update usrsiho.holoenctra
set enc_stsrep = '4'
where enc_num_id in (select distinct det_num_id
from usrsiho.holodettra,usrsiho.holofrph
where det_keyrph = frp_keyrph
and frp_keypro = pi_proceso
and frp_keyper = ps_periodo
);
---jcro
end;
$body$
language plpgsql
;
