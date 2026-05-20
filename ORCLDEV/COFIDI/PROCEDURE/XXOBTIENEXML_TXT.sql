create or replace procedure cofidi."xxobtienexml_txt"  (puuid varchar , pxmltxt inout text, pcodigo inout varchar, pestatus inout varchar --exito o error
) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lon numeric:=0;
numen  numeric := 0;
iter  numeric;
init numeric:=0;
txt varchar(3000);
begin
/* dmap converted statement start */
select  archivo  into strict  lon  from (
select length(xdt_xml.archivo) archivo
--utl_raw.cast_to_varchar2(select dmap_extension.dmap_dbms_lob_substr(xdt_xml.archivo,2000,2001)) files
from cofidi.xxcofidi_factura_tab xft ,
cofidi.xxcofidi_documento_tab xdt_xml
where 1 = 1
and id_documento_xml_fk = xdt_xml.id_documento_pk
and xft.uuid = puuid --'726A582E-E23C-DD1B-3821-ECBD481DCCF0'
order by  xft.id_factura_pk  desc
) alias1 limit 1;/* dmap converted statement end */
--and folio = '1' ;
if lon > 0 then
iter := ceil(lon/2000);
init := 1;
for i  in 1 .. iter
loop
select
utl_raw.cast_to_varchar2(oracle.substr(xdt_xml.archivo, init, 2000)) into strict txt
from cofidi.xxcofidi_factura_tab xft ,
cofidi.xxcofidi_documento_tab xdt_xml
where 1 = 1
and id_documento_xml_fk = xdt_xml.id_documento_pk
and xft.uuid = puuid  limit 1;/* dmap converted statement start */
pxmltxt := concat(pxmltxt, txt) ;/* dmap converted statement end */
init:= init + 2000;
end loop;
pcodigo := 1;
pestatus := 'XML encontrado';
else
pcodigo := 0;
pestatus := 'XML no encontrado';
end if;
exception when others then
pcodigo := 0;/* dmap converted statement start */
pestatus :=  concat('Ocurrio un error al procesar : ->', sqlerrm) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
