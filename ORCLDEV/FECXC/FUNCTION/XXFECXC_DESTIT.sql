create or replace  function  fecxc."xxfecxc_destit"  (pintipo integer) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstdestitulo    fecxc.xxfecxc_tit_rep_comer_tab.des_titulo%type;
begin
-- pintipo = 0      titulo
-- pintipo = 1      subtitulo
if pintipo = 0
then
select    des_titulo
into strict    lstdestitulo
from    xxfecxc_tit_rep_comer_tab
where    ind_elije_titulo = 1
and ind_titulo_activo = 1;
else
select    des_titulo
into strict    lstdestitulo
from    xxfecxc_tit_rep_comer_tab
where    ind_elije_titulo = 2
and ind_titulo_activo = 1;
end if;
return lstdestitulo;end;
--dmap converted function completed
$body$
language plpgsql
stable;
