create or replace procedure usrsiho."sp_hpgimpre1"  (wn_keypro numeric, wn_keyusu numeric, wn_keynom numeric, ws_numemi varchar, wn_lstemp numeric, ws_keyapr varchar, wn_limite numeric, ws_idepcc varchar, resultado inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--resultado number(10);
wn_keyemp numeric(10);
wd_fecpag timestamp(0);
wn_import decimal(16,2);
wn_year   numeric(5);
wd_todate timestamp(0);
wn_sigreg numeric(10);
wn_minreg numeric(10);
wn_minreg2 numeric(10);
wn_regexi numeric(10);
wn_regnvo numeric(10);
wn_maxreg numeric(10);
wn_lugare numeric(10);
wn_estatu numeric(5);
wn_nomemi numeric(10);
ws_nomemp varchar(150);
wn_limstr numeric(5);
rec record;
begin
resultado:= -11;
-- si algun recibo perteneciente a la nomina y emisio, se le a asignado estatus <> 0  => cancela la nueva generacion
select count(*)
into strict wn_nomemi
from usrsiho.holoreci
where rec_keypro =  wn_keypro
and rec_keynom =  wn_keynom
and rec_numemi =  ws_numemi
and rec_keyapr =  ws_keyapr
and rec_stsrec <> 0;
if wn_nomemi>0 then
resultado:= -1;-- return /*-1*/
;
end if;
--lee el a??o de generacion del registro
wd_todate := trunc(clock_timestamp());
wn_year := 0;
--select nvl(extract(year from per_fecpag),extract(year from wd_todate))
begin
select coalesce(year(per_fecpag), year(clock_timestamp()))
into strict wn_year
from usrsiho.nmloperi
where per_keypro =  wn_keypro
and per_keynom =  wn_keynom
and per_nu3aux =  ws_keyapr
and per_nu4aux =  ws_numemi;
exception when no_data_found then wn_year := year(clock_timestamp());
end;
--let wn_year = year(wd_todate);
--bloqueo de la tabla
---   lock table holoreci in exclusive mode;
--lee la clave del recibo para iniciar la generacion si ya existen
begin
select min(rec_keyrec)
into strict wn_minreg
from usrsiho.holoreci
where rec_keypro=wn_keypro
and rec_keynom=wn_keynom
and rec_numemi=ws_numemi
and rec_keyapr=ws_keyapr;
exception when no_data_found then wn_minreg := 0;
end;
--siguiente consecutivo temporal si ya existen de lo contrario el definitivo
begin
select max(rec_keyrec)
into strict wn_sigreg
from usrsiho.holoreci
where rec_keypro=wn_keypro
and rec_ejerci=wn_year;
exception when no_data_found then wn_sigreg := 0;
end;
--keyrec de inicio
wn_maxreg:=wn_sigreg;
--si no hay registros > iniciar en 1
if nullif(wn_sigreg::text, '') is null then
wn_sigreg:=0;
end if;
--primer keyrec a insertar
wn_sigreg:=wn_sigreg+1;
--elimina los recibos (para este proceso,nomina,emision y ubicacion) en caso de existir
delete
from usrsiho.holoreci
where rec_keypro=wn_keypro
and rec_keynom=wn_keynom
and rec_numemi=ws_numemi
and rec_keyapr=ws_keyapr;
--numero de recibos eliminados
get diagnostics wn_regexi = row_count;
--inicializacion de la cuenta de registros
wn_regnvo:=0;
wn_minreg2:=wn_sigreg;
--sum(sp_decodenum(his_codimp,'01',his_import,his_import * -1))
-- sp_ordenrec(sum(sp_decodenum(his_codimp,'01',his_import,his_import * -1)),wn_limite,emp_cveban)
for rec in (select his_keyemp,per_fecpag,
sum(case when his_codimp='01' then his_import  else his_import * -1 end ) total,
emp_nomemp
from usrsiho.nmlohism,usrsiho.nmloperi,usrsiho.nmloconc,usrsiho.nmcoempl
where his_keypro = wn_keypro
and his_keypro = per_keypro
and his_keyper = per_keyper
and his_keycon = con_keycon
and his_keyemp = emp_keyemp
and his_codimp in ('01','02')
and per_keynom = wn_keynom
and per_nu4aux = ws_numemi
and per_nu3aux = ws_keyapr
and ( (wn_lstemp > 0 and his_keyemp in (select ran_keyemp
from glwkrang
where ran_nomrep = 'hpgimpre1'
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
)
) or
wn_lstemp = 0 )
group by his_keyemp, per_fecpag, emp_nomemp, emp_cveban
order by  emp_nomemp asc) loop
--  order by  limite desc,emp_nomemp asc) loop
--group by  his_keyemp,per_fecpag,emp_nomemp,emp_cveban
--order by limite desc,emp_nomemp asc
-- solo si el importe es mayor a cero => se genera el recibo
wn_keyemp := rec.his_keyemp;
wd_fecpag := rec.per_fecpag;
wn_import := rec.total;
ws_nomemp := rec.emp_nomemp;
--wn_limite := rec.limite;
if wn_import > 0 then
--convierte el valor a cadena
-- ws_keyapr := '' || ws_keyapr;
--estatus del recibo
wn_estatu := sp_hstsrec1(wn_keypro,ws_keyapr,wn_keynom,ws_numemi,wn_keyemp);
---inserccion de registros
insert into usrsiho.holoreci(rec_ejerci,rec_keypro,rec_keyrec,rec_keyemp,rec_keyapr,rec_keynom,
rec_numemi,rec_stsrec,rec_import,rec_fecpag,rec_feccob,rec_keyusg,
rec_fecact,rec_keyusc,rec_keypol,rec_stsfis,rec_fecfis,rec_remtra,
rec_stsfon,rec_stscon,rec_impiva,rec_impisr)
values (wn_year,wn_keypro,wn_sigreg,wn_keyemp,ws_keyapr,wn_keynom,
ws_numemi,'0',wn_import,wd_fecpag,null,wn_keyusu,
wd_todate,null,null,'0',null,null,0,wn_estatu,0,null);
--evaluar el siguente consecutivo
wn_sigreg := wn_sigreg + 1;
--incrementa el contador del numero de registros
wn_regnvo := wn_regnvo + 1;
end if;
end loop;
--si se eliminaron recibos y los insertados fueron un numero mayor o igual => actualizacion de rec_keyrec
if wn_regexi>0 then
--verifica si es posible insertar los recibos nuevos en el hueco generados por la eliminacion
select count(*)
into strict wn_lugare
from usrsiho.holoreci
where rec_keyrec between wn_minreg
and wn_minreg + wn_regnvo - 1
and rec_keypro = wn_keypro
and rec_ejerci = wn_year;
if wn_lugare=0 then
update holoreci
set rec_keyrec = wn_minreg + rec_keyrec::numeric - wn_minreg2
where rec_keypro=wn_keypro
and rec_keynom=wn_keynom
and rec_numemi=ws_numemi
and rec_keyapr=ws_keyapr;
end if;
end if;
--liberacion de la tabla
--   unlock table holoreci;
-- elimina rangos
delete
from usrsiho.glwkrang
where ran_nomrep = 'hpgimpre1'
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu;
--regresa el numero de registros insertados
resultado:= wn_regnvo;end;
$body$
language plpgsql
;
