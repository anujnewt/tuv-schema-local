create or replace  function  usrdrc."denom_anteriores_fn"  (pistempresa numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstdenimonaciones varchar(11200);
/******************************************************************************
name:       denom_anteriores_fn
purpose:
revisions:
ver        date        author           description
---------  ----------  ---------------  ------------------------------------
1.0        14/07/2015   jesus argumedo       1. created this function.
******************************************************************************/
denom record;
begin
/* dmap converted statement start */
for denom in (select val_c1
from dercorp_metatbl_tab
where id_flex_tbl = 2
and   id_empresa  = pistempresa)
loop
lstdenimonaciones :=  concat(lstdenimonaciones, denom.val_c1 , '|') ;/* dmap converted statement end */
end loop;
return lstdenimonaciones;
exception
when no_data_found then
lstdenimonaciones := sqlerrm;
when others then
lstdenimonaciones := sqlerrm;end;
--dmap converted function completed
$body$
language plpgsql
stable;
