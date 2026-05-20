create or replace procedure usrsiho."sp_hctcapcoaltglo"  (pnkeytco numeric,pskeydep varchar,pskeypue varchar, pnctvplz numeric,pnkeyemp numeric,pnnumcap numeric, pdfecini timestamp(0),pdfecven timestamp(0),pnkeytab numeric, pspertra varchar,psidioma varchar,pskeynac varchar, pncosuni numeric,psdespev varchar,pnkeytva numeric, pskeytic varchar,psdiapag varchar,pstmpsal varchar, psaraesp varchar,psstsfir varchar,psstsplz varchar, psstspag varchar,pdfecfir varchar,pdfeccan varchar, pnnumcdi numeric,psdescap varchar,pnkeyusg numeric, psnumeje numeric,psscocap varchar,pshrsjor varchar, pdfeccap timestamp(0), pspagouni varchar, psidepcc varchar, lnkeyplz inout numeric,lnkeyfol inout numeric, lssigue inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--lnkeyplz,lnkeyfol,lssigue;
--variables de retorno
--   lnkeyplz 	number(10);
--   lnkeyfol 	number(10);
--   lssigue 	varchar(1);
--variables de trabajo
lsmarcco 	varchar(1);
lsvalpres 	varchar(1);
--	define lnpresu like holopres.pre_presup;
lnpresu hologlpr.glp_presup%type;
--	define lnejeci like holopres.pre_ejerci;
lnejeci hologlpr.glp_ejerci%type;
--	define lnanio like holopres.pre_anio ;
lnanio hologlpr.glp_anio%type;
lnini 	numeric(10);
lnfin 	numeric(10);
conteo numeric;
lnfolenc	numeric(10); --jcro
err_num		numeric(10);
psnumejeins numeric(10);
rec record;
rec3 record;
begin
--jcro
lssigue := 'S';
lnfolenc := 0; --jcro
err_num := 0; --jcro
psnumejeins := psnumeje;
--checo que exista presupuesto en hologlpr antes holopres
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
select coalesce(glp_presup,0),coalesce(glp_ejerci,0),glp_anio
into strict lnpresu, lnejeci, lnanio
from usrsiho.hologlpr
where glp_keydep = oracle.substr(pskeydep,1,6)
and glp_keypue = pskeypue
and glp_status = 'A';
exception when no_data_found then lnpresu  := 0;
lnejeci := 0;
lnanio:= null;
end;
if (lnpresu-lnejeci) < (pnnumcap*pncosuni) then
lssigue := 'N';
end if;
else
lnanio:=psnumeje;
end if;
else
lnanio := psnumeje;
end if;
--psnumeje := lnanio; original
psnumejeins := lnanio;
lnkeyfol := 0;
lnkeyplz := 0;
--si existe presupuesto prosedo a hacer las operaciones
if lssigue = 'S' then
-- calcula el maximo utilizando el bloqueo de tabla --------------------
-- jcro --set lock mode to wait;
-- jcro --lock table holocont in exclusive mode;
-- jcro --select max(con_keyfol)
-- jcro --into lnkeyfol
-- jcro --from holocont
-- jcro --where con_keytco = pnkeytco;
-- si es el primero se asigna cero
-- jcro --if lnkeyfol is null then
-- jcro --   let lnkeyfol = 0;
-- jcro --end if;
-- se incrementa el folio
-- jcro --let lnkeyfol = lnkeyfol + 1;
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
select coalesce(count(*),0)
into strict lnfolenc
from usrsiho.holocont
where con_keytco = pnkeytco
and con_keyfol = lnkeyfol;
-- jcro -- si se encuentra el folio, vuelve a intentarlo hasta que encuentre un
-- jcro -- folio aceptado por la base de datos.
while not lnfolenc = 0 loop  -- si se encuentra el registro ya grabado
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
-- se realiza la inserccion
--   insert into glwkcrys  (cry_nomrep,cry_chr001,cry_numsec)
--   values ('clau',psnumeje,5);
--con_keyplz
insert into usrsiho.holocont( con_keyfol,con_keytco, con_keydep,
con_keypue, con_ctvplz,con_keyemp, con_numcap,
con_fecoto, con_fecini,con_fecven, con_keytab,
con_pertra, con_idioma,con_keynac, con_cosuni,
con_despev, con_keytva,con_keytic, con_diapag,
con_tmpsal, con_araesp,con_stsfir, con_stsplz,
con_stspag, con_fecfir,con_feccan, con_numcdi,
con_recfis, con_descap,con_keyusg, con_preano,
con_contra, con_hrsjor,con_regrfc)
values (lnkeyfol,pnkeytco, pskeydep,pskeypue,pnctvplz,
pnkeyemp, pnnumcap,pdfeccap,pdfecini,pdfecven, pnkeytab,
pspertra, psidioma,pskeynac, pncosuni,psdespev, pnkeytva,
pskeytic, psdiapag,pstmpsal, psaraesp,psstsfir, psstsplz,
psstspag, to_timestamp(pdfecfir,'MM/DD/YYYY'),to_timestamp(pdfeccan,'MM/DD/YYYY'), pnnumcdi,'N',psdescap,
pnkeyusg, psnumejeins,psscocap,pshrsjor,pspagouni)
returning con_keyplz into lnkeyplz;
-- lee el numero de folio insertado
--lnkeyplz := sp_lee_serial();
--select max(con_keyplz)+1 into lnkeyplz from holocont;
-- libera la tabla
-- jcro --unlock table holocont;
if pnkeytva = 1 then
for rec in (select cry_dec007, cry_dec008
from usrsiho.glwkcrys
where cry_nomrep = 'CAP_CTO'
and cry_idepcc = psidepcc
and cry_keyusu = pnkeyusg
) loop
lnini := rec.cry_dec007;
lnfin := rec.cry_dec008;
for conteo in lnini .. lnfin loop
insert into usrsiho.holococa(coc_keyplz,coc_keycap,coc_numsec,coc_stspag,coc_keyrph,coc_keygdp)
values (lnkeyplz,conteo,1,'V',null,null);
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
end if;
end if;
if ( pnkeytva = 1 or pnkeytva = 2 ) and pnkeytco <> 2 and pnkeytco <> 3 and pnkeytco <> 519 then
if  lsvalpres = 'S' then
--actualizo el presupuesto ejercido antes holopres ahora hologlpr --cig--
update usrsiho.hologlpr
set glp_ejerci = glp_ejerci + ( pnnumcap * pncosuni )
where glp_keydep = oracle.substr(pskeydep,1,6)
and glp_keypue = pskeypue
and glp_anio   = lnanio;
end if;
end if;
end if;
------------------------------------------------------------------------
-- return lnkeyplz,lnkeyfol,lssigue;
end;
$body$
language plpgsql
;
