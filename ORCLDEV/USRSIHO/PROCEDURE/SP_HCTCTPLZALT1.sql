create or replace procedure usrsiho."sp_hctctplzalt1"  (pnkeytco numeric, pskeydep varchar, pskeypue varchar, pnctvplz numeric, pnkeyemp numeric, pnnumcap numeric, pdfecini timestamp(0), pdfecven timestamp(0), pnkeytab numeric, pspertra varchar, psidioma varchar, pskeynac varchar, pncosuni numeric, psdespev varchar, pnkeytva numeric, pskeytic varchar, psdiapag varchar, pstmpsal varchar, psaraesp varchar, psstsfir varchar, psstsplz varchar, psstspag varchar, pdfecfir timestamp(0), pdfeccan timestamp(0), pnnumcdi numeric, psdescap varchar, pnkeyusg numeric, psnumeje numeric, psscocap varchar, pshrsjor varchar, pdfeccap timestamp(0), psidepcc varchar, pnctvasig numeric, wn_val_ret_01 inout numeric, wn_val_ret_02 inout numeric, wv_val_ret_03 inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--variables de retorno
lnkeyplz 	numeric(10);
lnkeyfol 	numeric(10);
lssigue 	varchar(1);
--variables de trabajo
lsmarcco 	varchar(1);
lsvalpres 	varchar(1);
lnpresu    	usrsiho.hologlpr.glp_presup %type;
lnx       	numeric(5);
lnejeci  	usrsiho.hologlpr.glp_ejerci %type;
lnanioo 	numeric(5);
lnmtomax 	numeric(10);
lneje  		numeric(10);
lnexcep 	varchar(02);
lnini 		numeric(10);
lnfin 		numeric(10);
x 			numeric(10);
y 			numeric(10);
xy 			numeric(10);
a 			numeric(10);
b  			usrsiho.holoplza.plz_mtoeje %type;
ab 			numeric(10);
lnfolenc	numeric(10); --jcro
err_num		numeric(10);
psnumeje_var  numeric(10);
num_fil numeric(10);
-- ; cursor ;
rec record;
begin
--jcro
lnfolenc := 0; --jcro
err_num := 0; --jcro
---aedo 14/03/07
lssigue:= null;
lnkeyplz := 0;
lnkeyfol := 0;
lnanioo := 0;
-------------------------cig
--checo que exista presupuesto en hologlpr
--validaciones 1 y 2 exclusivamente
if ( pnkeytva = 1 or pnkeytva = 2 ) and pnkeytco <> 2 and pnkeytco <> 3 and pnkeytco <> 519 then
--insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',1,pskeydep);
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
select plz_mtomax,plz_mtoeje,plz_excep
into strict lnmtomax, lneje, lnexcep
from usrsiho.holoplza
where plz_ctvplz = pnctvplz
and plz_asig = pnctvasig;
exception when no_data_found then lnmtomax := 0;
lneje := 0;
lnexcep := 0;
end;
--         if lnexcep = 'O' then
x := lnmtomax;
y := lneje;
xy := lnmtomax;
a := pncosuni;
if xy < a then
lssigue := 'N';
else
lssigue := 'S';
end if;
--  insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',3,lnmtomax);
--insert into glwkcrys (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',4,lssigue);
if lssigue ='S' then
select count(glp_presup)
into strict lnx
from usrsiho.hologlpr
where glp_keydep = oracle.substr(pskeydep,1,6)
and glp_keypue = pskeypue
and glp_status = 'A';
---insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',50,lnpresu);
if lnx = 0 then
lssigue := 'N';
else
lssigue := 'S';
end if;
-- insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',6,lnanioo);
if lssigue = 'S' then
begin
select glp_presup, glp_ejerci, glp_anio
into strict lnpresu, lnejeci, lnanioo
from usrsiho.hologlpr
where glp_keydep = oracle.substr(pskeydep,1,6)
and glp_keypue = pskeypue
and glp_status = 'A';
exception when no_data_found then lnpresu := 0;
lnejeci := 0;
lnanioo := 0;
end;
if (lnpresu-lnejeci) < (pnnumcap*pncosuni) then
lssigue := 'N';
else
lssigue := 'S';
end if;
end if;
end if;
else
lnanioo := psnumeje;
end if;
else
lnanioo := psnumeje;
end if;
psnumeje_var := lnanioo;
lnkeyfol := 0;
lnkeyplz := 0;
--si existe presupuesto prosedo a hacer las operaciones
if lssigue = 'S' then
-- calcula el maximo utilizando el bloqueo de tabla --------------------
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
while not lnfolenc = 0  loop  -- si se encuentra el registro ya grabado
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
insert into usrsiho.glcopams values ('FC',pnkeytco,'','0','');
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
insert into usrsiho.holocont(con_keyplz, con_keyfol,con_keytco, con_keydep,
con_keypue, con_ctvplz,con_keyemp, con_numcap,
con_fecoto, con_fecini,con_fecven, con_keytab,
con_pertra, con_idioma,con_keynac, con_cosuni,
con_despev, con_keytva,con_keytic, con_diapag,
con_tmpsal, con_araesp,con_stsfir, con_stsplz,
con_stspag, con_fecfir,con_feccan, con_numcdi,
con_recfis, con_descap,con_keyusg, con_preano,
con_contra, con_hrsjor)
values (0,lnkeyfol,pnkeytco, pskeydep,pskeypue,pnctvplz,
pnkeyemp, pnnumcap,pdfeccap,pdfecini,pdfecven, pnkeytab,
pspertra, psidioma,pskeynac, pncosuni,psdespev, pnkeytva,
pskeytic, psdiapag,pstmpsal, psaraesp,psstsfir, psstsplz,
psstspag, pdfecfir,pdfeccan, pnnumcdi,'N',psdescap,
pnkeyusg, psnumeje_var,psscocap,pshrsjor)
returning con_keyplz into lnkeyplz;
end if;
-- lee el numero de plaza insertado
--lnkeyplz := sp_lee_serial();
-- libera la tabla
-- jcro --unlock table holocont;
--insert into glwkcrys (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',20,lnkeyplz);
-- end if;
if pnkeytva = 1 then
if lssigue = 'S' then
for rec in (select cry_dec007, cry_dec008
from usrsiho.glwkcrys
where cry_nomrep = 'CAP_CTO'
and cry_idepcc = psidepcc
and cry_keyusu = pnkeyusg)
-- 	for) loop
loop
lnini := rec.cry_dec007;
lnfin := rec.cry_dec008;
-- lnini = lnini to lnfin
for num_fil in lnini .. lnfin loop
insert into usrsiho.holococa(coc_keyplz,coc_keycap,coc_numsec,coc_stspag,coc_keyrph,coc_keygdp)
values (lnkeyplz,num_fil,1,'V',null,null);
end loop;
end loop;
-- end for rec2in ; loop
end if;
end if;
-- case when ( pnkeytva = 1 or pnkeytva = 2 ) and pnkeytco <> 2 and pnkeytco <> 3 and pnkeytco <> 519  then
if ( pnkeytva = 1 or pnkeytva = 2 ) and pnkeytco <> 2 and pnkeytco <> 3 and pnkeytco <> 519  then
-- case when lssigue = 'S' then
if lssigue = 'S' then
--actualizo el presupuesto ejercido en hologlpr
update usrsiho.hologlpr
set glp_ejerci = glp_ejerci + ( pnnumcap * pncosuni )
where glp_keydep = oracle.substr(pskeydep,1,6)
and glp_keypue = pskeypue
and glp_anio   = lnanioo;
b := 0;
b := pnnumcap * pncosuni;
b := lneje + b;
update usrsiho.holoplza
set plz_mtoeje = b
where plz_ctvplz=pnctvplz
and plz_asig=pnctvasig;
--   insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',15,b);
--   insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',12,pncosuni);
--   insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',13,pnnumcap);
end if;
end if;
-- case when ( pnkeytva = 1 or pnkeytva = 2 ) and pnkeytco <> 2 and pnkeytco <> 3 and pnkeytco <> 519  then
if ( pnkeytva = 1 or pnkeytva = 2 ) and pnkeytco <> 2 and pnkeytco <> 3 and pnkeytco <> 519  then
-- case when lssigue = 'S' then
if lssigue = 'S' then
update usrsiho.holoplza set plz_status=2, plz_keyfol=lnkeyfol, plz_keytco=pnkeytco ,plz_keyemp=pnkeyemp, plz_keytab=pnkeytab
where plz_ctvplz=pnctvplz and plz_asig =pnctvasig;
end if;
end if;
--  end if;
------------------------------------------------------------------------
-- cig--return lnkeyplz,lnkeyfol,lssigue;
--  insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',6,lssigue);
--      insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',7,lnkeyplz);
--  insert into glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',8,lnkeyfol);
-- return 0,0,lssigue;
-- wn_val_ret_01 := 0;
-- wn_val_ret_02 := 0;
-- wv_val_ret_03 := lssigue;
wn_val_ret_01 := lnkeyplz;
wn_val_ret_02 := lnkeyfol;
wv_val_ret_03 := lssigue;end;
$body$
language plpgsql
;
