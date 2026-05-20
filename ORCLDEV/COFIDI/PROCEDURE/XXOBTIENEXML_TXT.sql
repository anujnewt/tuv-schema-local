CREATE OR REPLACE NONEDITIONABLE PROCEDURE "COFIDI"."XXOBTIENEXML_TXT" (puuid in varchar2 ,
                                              pxmltxt out clob,
                                              pcodigo out varchar2,
                                              pestatus out varchar2 --Exito o Error
                                              )
as
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
lon number:=0;
numen  number := 0;
iter  number;
init number:=0;
txt varchar2(3000);
begin
select  archivo  into  lon  from (
SELECT LENGTH (XDT_XML.ARCHIVO) archivo
       --utl_raw.cast_to_varchar2(dbms_lob.substr(XDT_XML.ARCHIVO,2000,2001)) FILES
FROM COFIDI.XXCOFIDI_FACTURA_TAB XFT ,
     COFIDI.XXCOFIDI_DOCUMENTO_TAB XDT_XML
WHERE 1 = 1
AND ID_DOCUMENTO_XML_FK = XDT_XML.ID_DOCUMENTO_PK
AND XFT.UUID = puuid --'726A582E-E23C-DD1B-3821-ECBD481DCCF0'
order by XFT.id_factura_pk  desc
)
where rownum = 1;
--AND folio = '1' ;
if lon > 0 then
iter := ceil(lon/2000);
init := 1;
for i  in 1 .. iter
loop
SELECT
       utl_raw.cast_to_varchar2(dbms_lob.substr(XDT_XML.ARCHIVO,2000,init)) into txt
FROM COFIDI.XXCOFIDI_FACTURA_TAB XFT ,
     COFIDI.XXCOFIDI_DOCUMENTO_TAB XDT_XML
WHERE 1 = 1
AND ID_DOCUMENTO_XML_FK = XDT_XML.ID_DOCUMENTO_PK
AND XFT.UUID = puuid
and rownum = 1;
pxmltxt :=pxmltxt||txt;
init:= init + 2000;
end loop;
pcodigo := 1;
pestatus := 'XML encontrado';
else
pcodigo := 0;
pestatus := 'XML no encontrado';
end if;
exception when others then
pcodigo := 0;
pestatus := 'Ocurrio un error al procesar : ->'||SQLERRM;
end;
/
