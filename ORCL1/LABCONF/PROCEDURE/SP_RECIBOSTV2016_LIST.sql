create or replace procedure labconf."sp_recibostv2016_list"  ( v_keybin varchar default 'nmgrec', v_idepro varchar default 'RECNOM2100', v_idepcc varchar default 'MIYISHOME', v_keyusu numeric default 990001, v_fecini timestamp(0) default '22/12/2016', v_horini varchar default '21:00', cv_emplist inout refcursor  default null) as $body$
declare
-- pgv moved types end
/*
�         idepro  (identificador del proceso, sirve para ir a buscar los par�metros y el resultado)
�         idepcc (nombre de la pc)
�         ideusu (clave de usuario)
�         fecha de ejecuci�n
�         hora de ejecuci�n
*/
v_keypro numeric(10) := null;
v_keynom numeric(10) := null;
v_keyper varchar(7)  := null;
begin
declare
-- pgv moved types start
v_missedpams numeric;
--obtener parametros
begin
begin
--obtener proceso de la glcoargu
select arg_pvalor
into strict v_keypro
from labconf.glcoargu
where arg_keycam = 'KEY_PRO'
and arg_idepro   = v_idepro
and arg_idepcc   = v_idepcc
and arg_keyusu   = v_keyusu
and arg_fecini   = v_fecini
and arg_horini   = v_horini;/* dmap converted statement start */
perform dbms_output.put_line( concat('wn_keypro = ', utils_convert_to_varchar2(v_keypro,4000))) ;/* dmap converted statement end */
--obtener nomina de la glcoargu
select arg_pvalor
into strict v_keynom
from labconf.glcoargu
where arg_keycam = 'KEY_NOM'
and arg_idepro   = v_idepro
and arg_idepcc   = v_idepcc
and arg_keyusu   = v_keyusu
and arg_fecini   = v_fecini
and arg_horini   = v_horini;/* dmap converted statement start */
perform dbms_output.put_line( concat('wn_keynom = ', utils_convert_to_varchar2(v_keynom,4000))) ;/* dmap converted statement end */
--obtener periodo de la glcoargu
select arg_pvalor
into strict v_keyper
from labconf.glcoargu
where arg_keycam = 'KEY_PER'
and arg_idepro   = v_idepro
and arg_idepcc   = v_idepcc
and arg_keyusu   = v_keyusu
and arg_fecini   = v_fecini
and arg_horini   = v_horini;/* dmap converted statement start */
perform dbms_output.put_line( concat('wn_keyper = ', v_keyper)) ;/* dmap converted statement end */
exception
when no_data_found then
v_missedpams :=1;
raise exception '%', 'No se encontraron los parametros' using errcode = '45101';
end;/* dmap converted statement start */
open cv_emplist for
select emp_keyemp ,
concat('RN_', utils_convert_to_varchar2(v_keypro,4000) , '_' , v_keyper , '_' , utils_convert_to_varchar2(emp_keyemp,4000) , '.PDF')  pdffilename
from labconf.nmloperi
join labconf.nmlohemp on ( hem_keypro = per_keypro and hem_keyper = per_keyper )
join labconf.nmcoempl on ( emp_keyemp = hem_keyemp )
where per_keypro = v_keypro and per_keyper = v_keyper
order by  emp_nomemp;/* dmap converted statement end */
end;
exception
when others then
--call utils_handleerror(sqlcode,sqlerrm);
return;end;
$body$
language plpgsql
;
