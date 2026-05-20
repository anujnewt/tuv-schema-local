create or replace procedure labprod."sp_i_vacemp"  ( vb_keyemp integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
nkeyemp          integer;
ckeydep          varchar(16);
ckeypue          varchar(16);
ckeycon          varchar(3);
cpereje          varchar(7);
iexistecon       integer;
nagnostrab       integer;
nagnostrab2       integer;
nagnostrab3       integer;
cagnohoy         varchar(04);
cagnohoy2        varchar(04);
craya            varchar(01);
cagnosig         varchar(04);
cagnosig2        varchar(04);
cmes             varchar(02);
cdia             varchar(02);
cagno            varchar(04);
nkeypro          integer;
icontinuo        integer;
idiasvacacion    integer;
cfecha           varchar(10);
dfechaold        timestamp(0);
dfechanew        timestamp(0);
dfecha           timestamp(0);
cperiodo         varchar(10);
iexiste          integer;
idtomad          integer;
idia             integer;
ws_pva_stapas    varchar(30);
wd_vac_salper    decimal(10,2);
ireglei          integer;
iregins          integer;
iregupd          integer;
iregfijp         integer;
iregfijn         integer;
idiasvac         integer;
idias_xano       decimal(10,2);
ws_pva_plapre    decimal(10,2);
iagnohoy integer;
iagnosig integer;
ws_vac_status varchar(02);
ws_tab_keytab varchar(03);
wn_confianza  smallint;
p_future_date timestamp(0);
p_adj_days    smallint;
dfecini       timestamp(0);
dfecnow       timestamp(0);
wd_fecaux1    timestamp(0);
wd_fecnow1    timestamp(0);
ws_dia	     varchar(02);
ws_mes	     varchar(02);
ws_ano	     varchar(04);
ndagnostrab   decimal(12,6);
iconsec integer;
basura  varchar(40);
conta   integer;
begin
iconsec := 1;
conta := 1;
-- limpio variables
ireglei:= 0;
iregins:= 0;
iregupd:= 0;
iregfijp:= 0;
iregfijn:= 0;
idias_xano:= '365.25';
-- carsi
--delete from nmcorvac;
--delete from nmcocvac;
delete from borra;
--delete from borra2;
-- **** cursor ****
nkeyemp:=0;
nkeypro:=0;
select emp_keyemp,
emp_keypro,
emp_keydep,
emp_keypue
into strict nkeyemp,
nkeypro,
ckeydep,
ckeypue
from nmcoempl
where emp_status=1
and emp_keyemp=vb_keyemp;
wd_vac_salper:= '0.0';
-- actualizo la tabla de datos fijos
begin
select dat_valpar  into strict ws_pva_stapas
from   nmlodata
where  dat_keyemp = nkeyemp
and dat_keypar='28';
exception
when no_data_found then
ws_pva_stapas:='N';
end;
if ws_pva_stapas = 'S' then
select sum(vac_salper) into strict wd_vac_salper
from   nmcocvac
where  vac_status in ('V','A','P')
and    vac_keyemp = nkeyemp;
iregfijp:= iregfijp + 1;
else
select sum(vac_salper) into strict wd_vac_salper
from   nmcocvac
where  vac_status in ('V','A')
and    vac_keyemp = nkeyemp;
iregfijn:= iregfijn + 1;
end if;
iexistecon :=0;
select pva_connom
into strict ckeycon
from nmcopvac
where pva_keypro=nkeypro;
select pro_pereje
into strict cpereje
from nmloproc
where pro_keypro=nkeypro;
select dfi_keyemp
into strict iexistecon
from nmlodfij
where dfi_keycon=ckeycon
and dfi_keyemp=nkeyemp
and dfi_keypro=nkeypro;
if nullif(ckeycon::text, '') is not null then
if nullif(iexistecon::text, '') is null then
insert into nmlodfij
values (nkeyemp,ckeycon,nkeypro,cpereje,2020999,ckeydep,
ckeypue,clock_timestamp(),wd_vac_salper,0.0,'','');
else
update nmlodfij
set    dfi_cantid = wd_vac_salper
where  dfi_keyemp = nkeyemp
and    dfi_keycon =ckeycon
and    dfi_keypro = nkeypro;
end if;
end if;
end;
$body$
language plpgsql
;
