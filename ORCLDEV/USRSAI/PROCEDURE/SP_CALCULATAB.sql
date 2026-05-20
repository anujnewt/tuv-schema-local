create or replace procedure usrsai."sp_calculatab"  ( keypro numeric, keypue numeric, pertra numeric, idioma varchar, keynac varchar, keytab numeric, dia numeric, mes numeric, ano numeric, tab inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
fecha char(10);
begin
tab := 0;/* dmap converted statement start */
fecha :=  concat(dia, '/' , mes , '/' , ano) ;/* dmap converted statement end */
select coalesce(max(tab_import), 0) into strict tab
from holotabs
where tab_keypro = keypro
and tab_keytab = keytab
and tab_keypue = keypue
and tab_pertra = pertra
and tab_idioma = idioma
and tab_keynac = keynac
and tab_fecini <= to_timestamp(trim(both fecha),'dd/mm/yyyy')
and tab_fecfin >= to_timestamp(trim(both fecha),'dd/mm/yyyy');end;
$body$
language plpgsql
;
