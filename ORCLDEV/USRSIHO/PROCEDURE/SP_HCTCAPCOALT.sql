create or replace procedure usrsiho."sp_hctcapcoalt"  (pnkeytco numeric, pskeydep varchar, pskeypue varchar, pnctvplz numeric, pnkeyemp numeric, pnnumcap numeric, pdfecini timestamp(0), pdfecven timestamp(0), pnkeytab numeric, pspertra varchar, psidioma varchar, pskeynac varchar, pncosuni numeric,psdespev varchar, pnkeytva numeric, pskeytic varchar, psdiapag varchar, pstmpsal varchar, psaraesp varchar, psstsfir varchar, psstsplz varchar, psstspag varchar, pdfecfir timestamp(0), pdfeccan timestamp(0), pnnumcdi numeric, psdescap varchar, pnkeyusg numeric, psnumeje numeric, psscocap varchar, pshrsjor varchar, pdfeccap timestamp(0), psidepcc varchar, pscccont varchar, pntippag numeric, pspranio numeric, psobserv varchar, pscondes varchar, psnumlla numeric, --- aedo 12/06/2007 se agregaron dos parametros mas pscccont varchar(16),pntippag integer
--- mmq 26/02/2009 se agrego un parametro mas pspranio smallint
--- jcro 05/11/2009 se agrego un parametro mas psobserv varchar(80)
--- ig-cons-0823 se agrega argumento psnumlla para el almacenamiento del numero de llamados
lnkeyplz inout numeric, lnkeyfol inout numeric, lssigue inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--variables de retorno
--variables de trabajo
lsmarcco  varchar(1);
lsvalpres     varchar(1);
lnpresu holopres.pre_presup%type;
lnejeci holopres.pre_ejerci%type;
lnanio holopres.pre_anio%type;
lnini     numeric(10);
lnfin     numeric(10);
lnfolenc	numeric(10); --jcro
err_num		numeric(10);
num_fil numeric(10);
rec record;
rec3 record;
begin
--jcro
lssigue := 'S';
lnfolenc := 0; --jcro
err_num := 0; --jcro
--checo que exista presupuesto en holopres
--validaciones 1 y 2 exclusivamente
if ( pnkeytva = 1 or pnkeytva = 2 ) and pnkeytco <> 2 and pnkeytco <> 3 and pnkeytco <> 519 then
begin
select ald_marcco
into strict lsmarcco
from usrsiho.nmloalde
where ald_keydep = pskeydep;
exception when no_data_found then lsmarcco:= null;
end;
if nullif(lsmarcco::text, '') is null then
lsvalpres := 'S';
else
if lsmarcco = 'N' then
lsvalpres := 'S';
else
lsvalpres := 'N';
end if;
end if;
if lsvalpres = 'S' then
begin
select coalesce(pre_presup,0),coalesce(pre_ejerci,0),pre_anio
into strict lnpresu, lnejeci, lnanio
from usrsiho.holopres
where pre_keydep = pskeydep
and pre_keypue = pskeypue
and pre_status = 'A';
exception when no_data_found then lnpresu := 0;
lnejeci := 0;
lnanio := 0;
end;
if (lnpresu-lnejeci) < (pnnumcap*pncosuni) then
lssigue := 'N';
end if;
else
lnanio:=0;
end if;
else
lnanio := 0;
end if;
--se agrego linea para pasar el aqo mmq 26-02-09
--let lnanio = pspranio;
--  psnumeje := lnanio;
lnkeyfol := 0;
lnkeyplz := 0;
--si existe presupuesto prosedo a hacer las operaciones
if lssigue = 'S' then
-- calcula el maximo utilizando el bloqueo de tabla --------------------
-- jcro  set lock mode to wait;
-- jcro  lock table holocont in exclusive mode;
--	   select max(con_keyfol)
--	   into lnkeyfol
--	   from holocont
--	   where con_keytco = pnkeytco;
-- si es el primero se asigna cero
--	   if lnkeyfol is null then
--	      let lnkeyfol = 0;
--	   end if;
-- jcro -- busca el numero de folio
begin
select (pam_folini)::numeric
into strict lnkeyfol
from usrsiho.glcopams
where pam_cvesec = pnkeytco
and pam_keypar = 'FC';
exception when no_data_found then lnkeyfol := 0;
end;
-- jcro -- si no encuentra el numero de folio toma el valor de 0
-- jcro -- y lo inserta en la tabla de folios
if nullif(lnkeyfol::text, '') is null then
lnkeyfol := 0;
insert into usrsiho.glcopams
values ('FC',pnkeytco,'','0','');
else
-- jcro -- si lo encuentra le incrementa 1 y lo actualiza en la tabla de folios
lnkeyfol := lnkeyfol + 1;
update usrsiho.glcopams
set pam_folini = lnkeyfol
where pam_cvesec = pnkeytco
and pam_keypar = 'FC';
end if;
-- jcro -- busca si se encuentra en la tabla el folio obtenido
select coalesce(count(*), 0)
into strict lnfolenc
from usrsiho.holocont
where con_keytco = pnkeytco
and con_keyfol = lnkeyfol;
-- jcro -- si se encuentra el folio, vuelve a intentarlo hasta que encuentre un
-- jcro -- folio aceptado por la base de datos.
while lnfolenc <> 0 -- si se encuentra el registro ya grabado
loop
begin
select (pam_folini)::numeric
into strict lnkeyfol
from usrsiho.glcopams
where pam_cvesec = pnkeytco
and pam_keypar = 'FC';
exception when no_data_found then lnkeyfol := 0;
end;
if nullif(lnkeyfol::text, '') is null then
lnkeyfol := 0;
insert into usrsiho.glcopams
values ('FC',pnkeytco,'','0','');
else
lnkeyfol := lnkeyfol + 1;
update usrsiho.glcopams
set pam_folini = lnkeyfol
where pam_cvesec = pnkeytco
and pam_keypar = 'FC';
end if;
select coalesce(count(*),0)
into strict lnfolenc
from usrsiho.holocont
where con_keytco = pnkeytco
and con_keyfol = lnkeyfol;
end loop;
-- se incrementa el folio
-- jcro   let lnkeyfol = lnkeyfol + 1;
---aedo 12/06/2007 se agregaron los campos con_cccont, con_tippag al insert
---                y se asignaron los valores de las variables pscccont, pntippag
-- se realiza la inserccion
insert into usrsiho.holocont( con_keyfol, con_keytco, con_keydep,
con_keypue, con_ctvplz, con_keyemp, con_numcap,
con_fecoto, con_fecini, con_fecven, con_keytab,
con_pertra, con_idioma, con_keynac, con_cosuni,
con_despev, con_keytva, con_keytic, con_diapag,
con_tmpsal, con_araesp, con_stsfir, con_stsplz,
con_stspag, con_fecfir, con_feccan, con_numcdi,
con_recfis, con_descap, con_keyusg, con_preano,
con_contra, con_hrsjor, con_cccont, con_tippag,
con_observ, con_descan)
values (      lnkeyfol, pnkeytco, pskeydep, pskeypue, pnctvplz,
pnkeyemp, pnnumcap, pdfeccap, pdfecini, pdfecven, pnkeytab,
pspertra, psidioma, pskeynac, pncosuni, psdespev, pnkeytva,
pskeytic, psdiapag, pstmpsal, psaraesp, psstsfir, psstsplz,
psstspag, pdfecfir, pdfeccan, pnnumcdi,      'N', psdescap,
pnkeyusg, lnanio, psscocap, pshrsjor, pscccont, pntippag,
psobserv, pscondes)
returning con_keyplz into lnkeyplz;
-- psnumeje se cambio lnanio
-- lee el numero de folio insertado
--lnkeyplz := sp_lee_serial(); -- jcro
--         select max(con_keyplz)
--           into   lnkeyplz
--           from   usrsiho.holocont;
-- libera la tabla
-- jcro   unlock table holocont;
if pnkeytva = 1 then
for rec in (select cry_dec007,cry_dec008
from usrsiho.glwkcrys
where cry_nomrep='CAP_CTO'
and cry_idepcc=psidepcc
and cry_keyusu=pnkeyusg
) loop
lnini := rec.cry_dec007;
lnfin := rec.cry_dec008;
for num_fil in lnini .. lnfin loop
insert into usrsiho.holococa(coc_keyplz,coc_keycap,coc_numsec,coc_stspag,coc_keyrph,coc_keygdp)
values (lnkeyplz,num_fil,1,'V',null,null);
end loop;
end loop;
else
--el tipo de validacion 3 corresponde a multiactividad
if pnkeytva = 3 then
for rec3 in (select cry_dec007,cry_dec008
from usrsiho.glwkcrys
where cry_nomrep='CAP_CTO'
and cry_idepcc=psidepcc
and cry_keyusu=pnkeyusg) loop
lnini := rec3.cry_dec007;
lnfin := rec3.cry_dec008;
insert into usrsiho.holocoac(coa_keyplz,coa_keypue,coa_cosuni)
values (lnkeyplz,lnini,lnfin);
end loop;
--ig-cons-0823
--se agrega para el tipo de validacion 4 (llamados)
else
if  pnkeytva = 4 then
for num_fil in 1 ..psnumlla loop
--inserta en el detalle de contratos
insert into usrsiho.holococa(coc_keyplz,coc_keycap,coc_numsec,coc_stspag,coc_keyrph,coc_keygdp)
values (lnkeyplz,pnnumcap,num_fil,'V',null,null);
end loop;
end if;
--termina se agrega para el tipo de validacion 4 (llamados)
end if;
end if;
-- case when ( pnkeytva = 1 or pnkeytva = 2 ) and pnkeytco <> 2 and pnkeytco <> 3 and pnkeytco <> 519  then
-- case when pnkeytva in (1, 2) and pnkeytco not in (2, 3, 519)  then
if (pnkeytva = 1 or pnkeytva = 2)  and pnkeytco not in (2, 3, 519) then
-- if pnkeytco not in (2, 3, 519)  then
-- case when lsvalpres = 'S' then
if lsvalpres = 'S' then
--actualizo el presupuesto ejercido en holopres
update usrsiho.holopres
set pre_ejerci = pre_ejerci + ( pnnumcap * pncosuni )
where pre_keydep = pskeydep
and pre_keypue = pskeypue
and pre_anio   = lnanio;
end if;
-- end case;
-- end if;
-- end case;
end if;
end if;
------------------------------------------------------------------------
-- return lnkeyplz,lnkeyfol,lssigue;
end;
$body$
language plpgsql
;
