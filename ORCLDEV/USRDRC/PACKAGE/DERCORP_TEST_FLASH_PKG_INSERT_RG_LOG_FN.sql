create or replace  function  usrdrc.dercorp_test_flash_pkg_insert_rg_log_fn (pist_nom_campo varchar, pistnewvalue varchar, pistoldvalue varchar, piniduser integer, pinidemp integer) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstmensaje  varchar(250) := 'OK';
linidreg    numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select  coalesce(max(id_reg) + 1,1) into strict linidreg
from dercorp_rg_log_tab;
begin
insert into dercorp_rg_log_tab(
id_reg,
nom_campo,
val_actual,
val_anterior,
num_created_by,
fec_creation_date,
atributo1
)
values (
linidreg,
pist_nom_campo,
pistnewvalue,
pistoldvalue,
piniduser,
clock_timestamp(),
pinidemp
);
exception
when others then
lstmensaje := 'ERROR AL INSERTAR EN LA TABLA DERCORP_RG_LOG_TAB';
end;
return lstmensaje;end;
$body$
language plpgsql
;
