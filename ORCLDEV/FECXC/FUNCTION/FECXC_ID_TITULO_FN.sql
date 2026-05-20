create or replace  function  fecxc."fecxc_id_titulo_fn"  ( pst_nom_titulo varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
pii_id_titulo numeric;
begin
select id_titulo
into strict pii_id_titulo
from fecxc.xxfecxc_tit_rep_comer_tab
where des_titulo = pst_nom_titulo;
return pii_id_titulo;end;
--dmap converted function completed
$body$
language plpgsql
stable;
