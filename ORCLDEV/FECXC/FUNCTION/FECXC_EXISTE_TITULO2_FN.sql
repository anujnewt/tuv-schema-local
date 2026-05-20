create or replace  function  fecxc."fecxc_existe_titulo2_fn"  ( pst_titulo2 varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
lin_id numeric;
begin
select count(id_titulo)
into strict lin_id
from xxfecxc_tit_rep_comer_tab
where des_titulo     = pst_titulo2
and ind_elije_titulo = 2;
return lin_id;end;
--dmap converted function completed
$body$
language plpgsql
stable;
