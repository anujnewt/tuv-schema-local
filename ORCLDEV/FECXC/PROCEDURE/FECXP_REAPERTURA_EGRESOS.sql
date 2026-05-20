create or replace procedure fecxc."fecxp_reapertura_egresos"  ( v_fecha_ini datedefault sysdate-12, v_fecha_fin datedefault sysdate ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
/*script para reaperturar los folios*/
begin 

insert into fecxp_folios_reaperturables(folio_set, e_codigo)
select be.folio_set,be.e_codigo
from fecxp_enc_pagos_erp be,
(
select  e.folio_set, e.e_codigo,e.importe as importe_set,sum(d.importe_linea) as importe_cxp
from fecxp_det_pagos_procesados d,
fecxp_enc_pagos_erp e
where  d.secuencia_pagos_erp = e.secuencia_pagos_erp
and e.fecha_aplicacion >= v_fecha_ini
and e.fecha_aplicacion <= v_fecha_fin
group by e.folio_set, e.e_codigo, e.importe
having sum(d.importe_linea) <> e.importe
)  folios
where be.folio_set = folios.folio_set
and be.e_codigo = folios.e_codigo;
/* commit; */
--== marca reaperturacion ==--
update	fecxp_enc_pagos_erp e
set procesado = 0
where	exists (
select 1
from fecxp_folios_reaperturables ff
where ff.folio_set = e.folio_set
and ff.e_codigo = e.e_codigo
);
/* commit; */
delete	from fecxp_det_pagos_procesados d
where	exists (
select	1
from	fecxp_enc_pagos_erp e,
fecxp_folios_reaperturables ff
where	e.folio_set = ff.folio_set
and 	e.e_codigo= ff.e_codigo
and		e.secuencia_pagos_erp = d.secuencia_pagos_erp);
delete	from fecxp_bit_cont_din_folios_ap d
where	exists (
select	1
from	fecxp_enc_pagos_erp e,
fecxp_folios_reaperturables ff
where	e.folio_set = ff.folio_set
and 	e.e_codigo= ff.e_codigo
and		e.secuencia_pagos_erp = d.secuencia_pagos_erp);
delete	from fecxp_bit_cont_din_aper_det d
where	exists (
select	1
from	fecxp_enc_pagos_erp e,
fecxp_folios_reaperturables ff
where	e.folio_set = ff.folio_set
and 	e.e_codigo= ff.e_codigo
and		e.secuencia_pagos_erp = d.secuencia_pagos_erp);
delete	from fecxp_bit_cont_din_aper_enc d
where	exists (
select	1
from	fecxp_enc_pagos_erp e,
fecxp_folios_reaperturables ff
where	e.folio_set = ff.folio_set
and 	e.e_codigo= ff.e_codigo
and		e.secuencia_pagos_erp = d.secuencia_pagos_erp);
/* commit; */
/*fecxp_llena_pagos_set_erp; */
end;
$body$
language plpgsql
;
