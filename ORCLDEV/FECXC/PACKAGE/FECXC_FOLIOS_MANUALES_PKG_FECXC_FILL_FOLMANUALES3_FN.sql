create or replace  function  fecxc.fecxc_folios_manuales_pkg_fecxc_fill_folmanuales3_fn ( pistsegmento varchar, pistmoneda varchar, pistanio varchar, pistmesinicial varchar, pistmesfinal varchar, pinregistro numeric ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstposterrbuf       varchar(2000);
lstpostretcode      varchar(30);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
call fecxc_folios_manuales_pkg_fecxc_fill_folmanuales_pr(
pistsegmento,
pistmoneda,
pistanio,
pistmesinicial,
pistmesfinal,
pinregistro
);/* dmap converted statement start */
-- return nvl(lstposterrbuf, ok);
return to_char(pinregistro,00000000000);/* dmap converted statement end *//* dmap converted statement start */
exception
when others
then
return  concat('Error: ', sqlerrm) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
