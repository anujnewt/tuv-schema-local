create or replace procedure labprod.calculoisn_sp_parametros (ws_nom_rep varchar, ws_key_per inout varchar, wn_anio inout integer, wn_mes inout integer, wn_key_nom inout smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
select arg_pvalor into strict ws_key_per
from labprod.glcoargu
where arg_idepro = ws_nom_rep
and arg_keycam = 'KEY_PER';
select (arg_pvalor)::numeric  into strict wn_anio
from labprod.glcoargu
where arg_idepro = ws_nom_rep
and arg_keycam = 'ANIO';
select (arg_pvalor)::numeric  into strict wn_mes
from labprod.glcoargu
where arg_idepro = ws_nom_rep
and arg_keycam = 'MES';
select (pam_folini)::numeric  into strict wn_key_nom
from labprod.glcopams
where pam_keypar = (select pam_folini from labprod.glcopams where pam_keypar = '00' and pam_cvesec = 'calisn')
and pam_cvesec = 'OPCI01';end;
$body$
language plpgsql
;
