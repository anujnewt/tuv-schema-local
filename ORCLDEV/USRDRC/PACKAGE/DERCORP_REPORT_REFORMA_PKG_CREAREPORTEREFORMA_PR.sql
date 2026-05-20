create or replace procedure usrdrc.dercorp_report_reforma_pkg_creareportereforma_pr () as $body$
declare
-- pgv moved types start
-- pgv moved types end
linsecuencia      numeric := 0;
lststatus         varchar(150);
lstfecstatus      varchar(150);
lstfolloup        varchar(150);
lstresponsable    varchar(150);
lstdescripcion    varchar(4000);
reformas_total_cur cursor for
select
/* (select nom_empresa
from dercorp_empresa_tab
where id_empresa = meta.id_empresa) as empresa,*/
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = meta.id_empresa
and id_add_campo = 500))as empresa ,
case flex.id_flex_tbl
when 30 then meta.val_c4
when 27 then meta.val_c18
else meta.val_c3 end          as fecha_solicitud,    --fecha
case flex.id_flex_tbl
when 17 then dercorp_catalogs_pkg_get_element_descrip_fn(meta.val_c1)
when 18 then dercorp_catalogs_pkg_get_element_descrip_fn(meta.val_c1)
when 30 then dercorp_catalogs_pkg_get_element_descrip_fn(meta.val_c3)
else dercorp_catalogs_pkg_get_element_descrip_fn(meta.val_c2) end          as tipo_reunion,    -- tipo de reunion (tipo contrato)
meta.val_c149                   as asunto,                      --asunto
case flex.id_flex_tbl
when 17 then meta.val_c16
when 18 then meta.val_c16
else meta.val_c150 end         as semaforo,    -- semaforo
case flex.id_flex_tbl
when 17 then meta.val_c8
when 18 then meta.val_c8
when 23 then meta.val_c106
else meta.val_c86 end         as escritura,    -- escritura
case flex.id_flex_tbl
when 17 then meta.val_c9
when 18 then meta.val_c9
when 23 then meta.val_c107
else meta.val_c87 end         as fecha_escritura,    -- fecha escritura
case flex.id_flex_tbl
when 17 then meta.val_c5
when 18 then meta.val_c5
when 23 then meta.val_c107
else meta.val_c82 end         as rrpc,    -- rppc
case flex.id_flex_tbl
when 17 then meta.val_c19
when 18 then meta.val_c19
when 23 then meta.val_c115
else meta.val_c95 end         as fecha_rrpc,    -- fecha rppc
case flex.id_flex_tbl
when 17 then meta.val_c150
when 18 then meta.val_c150
when 23 then meta.val_c103
else meta.val_c83 end         as semaforo2,    -- semaforo
meta.*
from
dercorp_metatbl_tab meta
left join dercorp_add_campo_cat_val_tab cat on cat.id_catalogo_valor = meta.val_c2
left join dercorp_flex_tbls_tab flex on flex.id_flex_tbl = meta.id_flex_tbl
where
flex.atributo15 like '%HIST_CORP%';
--and id_empresa in (numempresa);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from usrdrc.dercorp_rep_reformas_tmp;
for i in reformas_total_cur
loop
select max(id_rep_reforma) into strict linsecuencia
from dercorp_rep_reformas_tmp;
if nullif(linsecuencia::text, '') is null or nullif(linsecuencia::text, '') is null
then
linsecuencia := 1;
else
linsecuencia := linsecuencia + 1;
end if;
--inicializacion
lststatus       := null;
lstfecstatus    := null;
lstfolloup      := null;
lstresponsable  := null;
lstdescripcion  := null;
--entrara solo aquellas que tienen el checkbox de status activo
if (i.id_flex_tbl = 20 and i.val_c59 = 'Si') or (i.id_flex_tbl = 21 and i.val_c49 = 'Si')or (i.id_flex_tbl = 22 and i.val_c55 = 'Si') or (i.id_flex_tbl = 23 and i.val_c98 = 'Si') or (i.id_flex_tbl = 28 and i.val_c26 = 'Si') or (i.id_flex_tbl = 29 and i.val_c45 = 'Si') or (i.id_flex_tbl = 31 and i.val_c25 = 'Si') or (i.id_flex_tbl = 32 and i.val_c45 = 'Si') or (i.id_flex_tbl = 33 and i.val_c47 = 'Si') or (i.id_flex_tbl = 34 and i.val_c68 = 'Si') or (i.id_flex_tbl = 35 and i.val_c25 = 'Si') or (i.id_flex_tbl = 41 and i.val_c25 = 'Si')
then
--redactada
if (i.id_flex_tbl = 20 and i.val_c38 = 'Si') or (i.id_flex_tbl = 21 and i.val_c29 = 'Si')   or (i.id_flex_tbl = 22 and i.val_c36 = 'Si') or (i.id_flex_tbl = 23 and i.val_c68 = 'Si')   or (i.id_flex_tbl = 28 and i.val_c123 = 'Si') or (i.id_flex_tbl = 29 and i.val_c123 = 'Si') or (i.id_flex_tbl = 31 and i.val_c123 = 'Si') or (i.id_flex_tbl = 32 and i.val_c123 = 'Si') or (i.id_flex_tbl = 33 and i.val_c123 = 'Si') or (i.id_flex_tbl = 34 and i.val_c123 = 'Si') or (i.id_flex_tbl = 35 and i.val_c123 = 'Si') or (i.id_flex_tbl = 41 and i.val_c123 = 'Si')
then
lststatus := 'Redactada';
if i.id_flex_tbl = 20 and i.val_c38 = 'Si'
then
lstfecstatus    := i.val_c38;
lstfolloup      := i.val_c37;
lstresponsable  := i.val_c39;
lstdescripcion  := i.val_c6;
end if;
if i.id_flex_tbl = 21 and i.val_c29 = 'Si'
then
lstfecstatus    := i.val_c31;
lstfolloup      := i.val_c28;
lstresponsable  := i.val_c30;
lstdescripcion  := i.val_c8;
end if;
if i.id_flex_tbl = 22 and i.val_c36 = 'Si'
then
lstfecstatus    := i.val_c38;
lstfolloup      := i.val_c35;
lstresponsable  := i.val_c37;
lstdescripcion  := i.val_c7;
end if;
if i.id_flex_tbl = 23 and i.val_c68 = 'Si'
then
lstfecstatus    := i.val_c70;
lstfolloup      := i.val_c67;
lstresponsable  := i.val_c69;
lstdescripcion  := i.val_c32;
end if;
end if;
--jjaq 25/04/2017 se agregan porque se estandarizo status y referencia documentum
if i.id_flex_tbl = 28 and i.val_c26 = 'Si'
then
lstfecstatus    := i.val_c125;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c124;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 29 and i.val_c26 = 'Si'
then
lstfecstatus    := i.val_c125;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c124;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 31 and i.val_c26 = 'Si'
then
lstfecstatus    := i.val_c125;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c124;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 32 and i.val_c26 = 'Si'
then
lstfecstatus    := i.val_c125;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c124;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 33 and i.val_c26 = 'Si'
then
lstfecstatus    := i.val_c125;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c124;
-- lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 34 and i.val_c26 = 'Si'
then
lstfecstatus    := i.val_c125;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c124;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 35 and i.val_c26 = 'Si'
then
lstfecstatus    := i.val_c125;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c124;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 41 and i.val_c26 = 'Si'
then
lstfecstatus    := i.val_c125;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c124;
--lstdescripcion  := i.;
end if;
if (i.id_flex_tbl = 20 and i.val_c47 = 'Si') or (i.id_flex_tbl = 21 and i.val_c32 = 'Si')or (i.id_flex_tbl = 22 and i.val_c39 = 'Si') or (i.id_flex_tbl = 23 and i.val_c71 = 'Si')or (i.id_flex_tbl = 28 and i.val_c126 = 'Si') or (i.id_flex_tbl = 29 and i.val_c126 = 'Si') or (i.id_flex_tbl = 31 and i.val_c126 = 'Si') or (i.id_flex_tbl = 32 and i.val_c126 = 'Si') or (i.id_flex_tbl = 33 and i.val_c126 = 'Si') or (i.id_flex_tbl = 34 and i.val_c126 = 'Si') or (i.id_flex_tbl = 35 and i.val_c126 = 'Si') or (i.id_flex_tbl = 41 and i.val_c126 = 'Si')
then
lststatus  := 'Revisin Gerente';
if i.id_flex_tbl = 20 and i.val_c47 = 'Si'
then
lstfecstatus    := i.val_c49;
lstfolloup      := i.val_c37;
lstresponsable  := i.val_c48;
lstdescripcion  := i.val_c6;
end if;
if i.id_flex_tbl = 21 and i.val_c32 = 'Si'
then
lstfecstatus    := i.val_c34;
lstfolloup      := i.val_c28;
lstresponsable  := i.val_c33;
lstdescripcion  := i.val_c8;
end if;
if i.id_flex_tbl = 22 and i.val_c39 = 'Si'
then
lstfecstatus    := i.val_c41;
lstfolloup      := i.val_c35;
lstresponsable  := i.val_c40;
lstdescripcion  := i.val_c7;
end if;
if i.id_flex_tbl = 23 and i.val_c71 = 'Si'
then
lstfecstatus    := i.val_c73;
lstfolloup      := i.val_c67;
lstresponsable  := i.val_c72;
lstdescripcion  := i.val_c32;
end if;
--jjaq 25/04/2017 se agregan porque se estandarizo status y referencia documentum
if i.id_flex_tbl = 28 and i.val_c126 = 'Si'
then
lstfecstatus    := i.val_c8;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c127;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 29 and i.val_c126 = 'Si'
then
lstfecstatus    := i.val_c20;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c127;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 31 and i.val_c126 = 'Si'
then
lstfecstatus    := i.val_c10;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c127;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 32 and i.val_c126 = 'Si'
then
lstfecstatus    := i.val_c20;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c127;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 33 and i.val_c126 = 'Si'
then
lstfecstatus    := i.val_c22;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c127;
-- lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 34 and i.val_c126 = 'Si'
then
lstfecstatus    := i.val_c24;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c127;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 35 and i.val_c126 = 'Si'
then
lstfecstatus    := i.val_c9;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c127;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 41 and i.val_c126 = 'Si'
then
lstfecstatus    := i.val_c9;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c127;
--lstdescripcion  := i.;
end if;
end if;
if (i.id_flex_tbl = 20 and i.val_c41 = 'Si') or (i.id_flex_tbl = 21 and i.val_c35 = 'Si')or (i.id_flex_tbl = 22 and i.val_c42 = 'Si') or (i.id_flex_tbl = 23 and i.val_c74 = 'Si') or (i.id_flex_tbl = 28 and i.val_c128 = 'Si') or (i.id_flex_tbl = 29 and i.val_c128 = 'Si') or (i.id_flex_tbl = 31 and i.val_c128 = 'Si') or (i.id_flex_tbl = 32 and i.val_c128 = 'Si') or (i.id_flex_tbl = 33 and i.val_c128 = 'Si') or (i.id_flex_tbl = 34 and i.val_c128 = 'Si') or (i.id_flex_tbl = 35 and i.val_c128 = 'Si') or (i.id_flex_tbl = 41 and i.val_c128 = 'Si')
then
lststatus := 'Correcciones';
if i.id_flex_tbl = 20 and i.val_c41 = 'Si'
then
lstfecstatus    := i.val_c43;
lstfolloup      := i.val_c37;
lstresponsable  := i.val_c42;
lstdescripcion  := i.val_c6;
end if;
if i.id_flex_tbl = 21 and i.val_c35 = 'Si'
then
lstfecstatus    := i.val_c37;
lstfolloup      := i.val_c28;
lstresponsable  := i.val_c36;
lstdescripcion  := i.val_c8;
end if;
if i.id_flex_tbl = 22 and i.val_c42 = 'Si'
then
lstfecstatus    := i.val_c44;
lstfolloup      := i.val_c35;
lstresponsable  := i.val_c43;
lstdescripcion  := i.val_c7;
end if;
if i.id_flex_tbl = 23 and i.val_c74 = 'Si'
then
lstfecstatus    := i.val_c76;
lstfolloup      := i.val_c67;
lstresponsable  := i.val_c75;
lstdescripcion  := i.val_c32;
end if;
--jjaq 25/04/2017 se agregan porque se estandarizo status y referencia documentum
if i.id_flex_tbl = 28 and i.val_c128 = 'Si'
then
lstfecstatus    := i.val_c130;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c129;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 29 and i.val_c128 = 'Si'
then
lstfecstatus    := i.val_c130;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c129;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 31 and i.val_c128 = 'Si'
then
lstfecstatus    := i.val_c130;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c129;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 32 and i.val_c128 = 'Si'
then
lstfecstatus    := i.val_c130;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c129;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 33 and i.val_c128 = 'Si'
then
lstfecstatus    := i.val_c130;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c129;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 34 and i.val_c128 = 'Si'
then
lstfecstatus    := i.val_c130;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c129;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 35 and i.val_c128 = 'Si'
then
lstfecstatus    := i.val_c130;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c129;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 41 and i.val_c128 = 'Si'
then
lstfecstatus    := i.val_c130;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c129;
--lstdescripcion  := i.;
end if;
end if;
if (i.id_flex_tbl = 20 and i.val_c50 = 'Si') or (i.id_flex_tbl = 21 and i.val_c38 = 'Si')or (i.id_flex_tbl = 22 and i.val_c45 = 'Si') or (i.id_flex_tbl = 23 and i.val_c77 = 'Si') or (i.id_flex_tbl = 28 and i.val_c131 = 'Si') or (i.id_flex_tbl = 29 and i.val_c131 = 'Si') or (i.id_flex_tbl = 31 and i.val_c131 = 'Si') or (i.id_flex_tbl = 32 and i.val_c131 = 'Si') or (i.id_flex_tbl = 33 and i.val_c131 = 'Si') or (i.id_flex_tbl = 34 and i.val_c131 = 'Si') or (i.id_flex_tbl = 35 and i.val_c131 = 'Si') or (i.id_flex_tbl = 41 and i.val_c131 = 'Si')
then
lststatus := 'Aut. Direccin';
if i.id_flex_tbl = 20 and i.val_c50 = 'Si'
then
lstfecstatus    := i.val_c52;
lstfolloup      := i.val_c37;
lstresponsable  := i.val_c51;
lstdescripcion  := i.val_c6;
end if;
if i.id_flex_tbl = 21 and i.val_c38 = 'Si'
then
lstfecstatus    := i.val_c40;
lstfolloup      := i.val_c28;
lstresponsable  := i.val_c39;
lstdescripcion  := i.val_c8;
end if;
if i.id_flex_tbl = 22 and i.val_c45 = 'Si'
then
lstfecstatus    := i.val_c47;
lstfolloup      := i.val_c35;
lstresponsable  := i.val_c46;
lstdescripcion  := i.val_c7;
end if;
if i.id_flex_tbl = 23 and i.val_c77 = 'Si'
then
lstfecstatus    := i.val_c79;
lstfolloup      := i.val_c67;
lstresponsable  := i.val_c78;
lstdescripcion  := i.val_c32;
end if;
--jjaq 25/04/2017 se agregan porque se estandarizo status y referencia documentum
if i.id_flex_tbl = 28 and i.val_c131 = 'Si'
then
lstfecstatus    := i.val_c9;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c132;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 29 and i.val_c131 = 'Si'
then
lstfecstatus    := i.val_c21;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c132;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 31 and i.val_c131 = 'Si'
then
lstfecstatus    := i.val_c11;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c132;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 32 and i.val_c131 = 'Si'
then
lstfecstatus    := i.val_c21;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c132;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 33 and i.val_c131 = 'Si'
then
lstfecstatus    := i.val_c23;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c132;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 34 and i.val_c131 = 'Si'
then
lstfecstatus    := i.val_c25;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c132;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 35 and i.val_c131 = 'Si'
then
lstfecstatus    := i.val_c10;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c132;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 41 and i.val_c131 = 'Si'
then
lstfecstatus    := i.val_c10;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c132;
--lstdescripcion  := i.;
end if;
end if;
if (i.id_flex_tbl = 20 and i.val_c44 = 'Si') or (i.id_flex_tbl = 21 and i.val_c41 = 'Si')   or (i.id_flex_tbl = 22 and i.val_c48 = 'Si') or (i.id_flex_tbl = 23 and i.val_c80 = 'Si')   or (i.id_flex_tbl = 28 and i.val_c134 = 'Si') or (i.id_flex_tbl = 29 and i.val_c134 = 'Si') or (i.id_flex_tbl = 31 and i.val_c134 = 'Si') or (i.id_flex_tbl = 32 and i.val_c134 = 'Si') or (i.id_flex_tbl = 33 and i.val_c134 = 'Si') or (i.id_flex_tbl = 34 and i.val_c134 = 'Si') or (i.id_flex_tbl = 35 and i.val_c134 = 'Si') or (i.id_flex_tbl = 41 and i.val_c134 = 'Si')
then
lststatus := 'En firmas';
lstfolloup := i.val_c37;
if i.id_flex_tbl = 20 and i.val_c44 = 'Si'
then
lstfecstatus    := i.val_c46;
lstfolloup      := i.val_c37;
lstresponsable  := i.val_c45;
lstdescripcion  := i.val_c6;
end if;
if i.id_flex_tbl = 21 and i.val_c41 = 'Si'
then
lstfecstatus    := i.val_c43;
lstfolloup      := i.val_c28;
lstresponsable  := i.val_c42;
lstdescripcion  := i.val_c8;
end if;
if i.id_flex_tbl = 22 and i.val_c48 = 'Si'
then
lstfecstatus    := i.val_c50;
lstfolloup      := i.val_c35;
lstresponsable  := i.val_c49;
lstdescripcion  := i.val_c7;
end if;
if i.id_flex_tbl = 23 and i.val_c80 = 'Si'
then
lstfecstatus    := i.val_c82;
lstfolloup      := i.val_c67;
lstresponsable  := i.val_c81;
lstdescripcion  := i.val_c32;
end if;
--jjaq 25/04/2017 se agregan porque se estandarizo status y referencia documentum
if i.id_flex_tbl = 28 and i.val_c134 = 'Si'
then
lstfecstatus    := i.val_c10;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c135;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 29 and i.val_c134 = 'Si'
then
lstfecstatus    := i.val_c22;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c135;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 31 and i.val_c134 = 'Si'
then
lstfecstatus    := i.val_c12;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c135;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 32 and i.val_c134 = 'Si'
then
lstfecstatus    := i.val_c22;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c135;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 33 and i.val_c134 = 'Si'
then
lstfecstatus    := i.val_c24;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c135;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 34 and i.val_c134 = 'Si'
then
lstfecstatus    := i.val_c26;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c135;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 35 and i.val_c134 = 'Si'
then
lstfecstatus    := i.val_c11;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c135;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 41 and i.val_c134 = 'Si'
then
lstfecstatus    := i.val_c11;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c135;
--lstdescripcion  := i.;
end if;
end if;
if (i.id_flex_tbl = 20 and i.val_c53 = 'Si') or (i.id_flex_tbl = 21 and i.val_c44 = 'Si')or (i.id_flex_tbl = 22 and i.val_c51 = 'Si') or (i.id_flex_tbl = 23 and i.val_c83 = 'Si')or (i.id_flex_tbl = 28 and i.val_c136 = 'Si') or (i.id_flex_tbl = 29 and i.val_c136 = 'Si') or (i.id_flex_tbl = 31 and i.val_c136 = 'Si') or (i.id_flex_tbl = 32 and i.val_c136 = 'Si') or (i.id_flex_tbl = 33 and i.val_c136 = 'Si') or (i.id_flex_tbl = 34 and i.val_c136 = 'Si') or (i.id_flex_tbl = 35 and i.val_c136 = 'Si') or (i.id_flex_tbl = 41 and i.val_c136 = 'Si')
then
lststatus := 'Entregada';
if i.id_flex_tbl = 20 and i.val_c53 = 'Si'
then
lstfecstatus    := i.val_c55;
lstfolloup      := i.val_c37;
lstresponsable  := i.val_c54;
lstdescripcion  := i.val_c6;
end if;
if i.id_flex_tbl = 21 and i.val_c44 = 'Si'
then
lstfecstatus    := i.val_c46;
lstfolloup      := i.val_c28;
lstresponsable  := i.val_c45;
lstdescripcion  := i.val_c8;
end if;
if i.id_flex_tbl = 22 and i.val_c51 = 'Si'
then
lstfecstatus     := i.val_c53;
lstfolloup      := i.val_c35;
lstresponsable  := i.val_c52;
lstdescripcion  := i.val_c7;
end if;
if i.id_flex_tbl = 23 and i.val_c83 = 'Si'
then
lstfecstatus    := i.val_c85;
lstfolloup      := i.val_c67;
lstresponsable  := i.val_c84;
lstdescripcion  := i.val_c32;
end if;
--jjaq 25/04/2017 se agregan porque se estandarizo status y referencia documentum
if i.id_flex_tbl = 28 and i.val_c136 = 'Si'
then
lstfecstatus    := i.val_c11;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c137;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 29 and i.val_c136 = 'Si'
then
lstfecstatus    := i.val_c23;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c137;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 31 and i.val_c136 = 'Si'
then
lstfecstatus    := i.val_c13;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c137;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 32 and i.val_c136 = 'Si'
then
lstfecstatus    := i.val_c23;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c137;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 33 and i.val_c136 = 'Si'
then
lstfecstatus    := i.val_c25;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c137;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 34 and i.val_c136 = 'Si'
then
lstfecstatus    := i.val_c27;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c137;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 35 and i.val_c136 = 'Si'
then
lstfecstatus    := i.val_c12;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c137;
--lstdescripcion  := i.;
end if;
if i.id_flex_tbl = 41 and i.val_c136 = 'Si'
then
lstfecstatus    := i.val_c12;
lstfolloup      := i.val_c122;
lstresponsable  := i.val_c137;
--lstdescripcion  := i.;
end if;
end if;
end if;
--para las pestanas que son diferentes que no tienen estatus con check box si no con fechas
/*           if (i.id_flex_tbl = 28 and i.val_c26 = si or i.id_flex_tbl = 29 and i.val_c45 = si or
i.id_flex_tbl = 31 and i.val_c25 = si or i.id_flex_tbl = 32 and i.val_c45 = si or
i.id_flex_tbl = 33 and i.val_c47 = si or i.id_flex_tbl = 34 and i.val_c68 = si or
i.id_flex_tbl = 35 and i.val_c25 = si)
then
--redactada
if(i.id_flex_tbl  = 28 and nullif(i.val_c7::text, '') is not null)
or (i.id_flex_tbl = 29 and nullif(i.val_c19::text, '') is not null)
or (i.id_flex_tbl = 31 and nullif(i.val_c9::text, '') is not null)
or (i.id_flex_tbl = 32 and nullif(i.val_c19::text, '') is not null)
or (i.id_flex_tbl = 33 and nullif(i.val_c21::text, '') is not null)
or (i.id_flex_tbl = 34 and nullif(i.val_c23::text, '') is not null)
or (i.id_flex_tbl = 35 and nullif(i.val_c8::text, '') is not null)
then
lststatus := redactada;
if i.id_flex_tbl  = 28 and nullif(i.val_c7::text, '') is not null
then
lstfecstatus := i.val_c7;
end if;
if i.id_flex_tbl = 29 and nullif(i.val_c19::text, '') is not null
then
lstfecstatus := i.val_c19;
end if;
if i.id_flex_tbl = 31 and nullif(i.val_c9::text, '') is not null
then
lstfecstatus := i.val_c9;
end if;
if i.id_flex_tbl = 32 and nullif(i.val_c19::text, '') is not null
then
lstfecstatus := i.val_c19;
end if;
if i.id_flex_tbl = 33 and nullif(i.val_c21::text, '') is not null
then
lstfecstatus := i.val_c21;
end if;
if i.id_flex_tbl = 34 and nullif(i.val_c23::text, '') is not null
then
lstfecstatus := i.val_c23;
end if;
if i.id_flex_tbl = 35 and nullif(i.val_c8::text, '') is not null
then
lstfecstatus := i.val_c8;
end if;
end if;
--revisada
if    (i.id_flex_tbl = 28 and nullif(i.val_c8::text, '') is not null)
or (i.id_flex_tbl = 29 and nullif(i.val_c20::text, '') is not null)
or (i.id_flex_tbl = 31 and nullif(i.val_c10::text, '') is not null)
or (i.id_flex_tbl = 32 and nullif(i.val_c20::text, '') is not null)
or (i.id_flex_tbl = 33 and nullif(i.val_c22::text, '') is not null)
or (i.id_flex_tbl = 34 and nullif(i.val_c24::text, '') is not null)
or (i.id_flex_tbl = 35 and nullif(i.val_c9::text, '') is not null)
then
lststatus := revisada;
if i.id_flex_tbl = 28 and nullif(i.val_c8::text, '') is not null
then
lstfecstatus := i.val_c8;
end if;
if i.id_flex_tbl = 29 and nullif(i.val_c20::text, '') is not null
then
lstfecstatus := i.val_c20;
end if;
if i.id_flex_tbl = 31 and nullif(i.val_c10::text, '') is not null
then
lstfecstatus := i.val_c10;
end if;
if i.id_flex_tbl = 32 and nullif(i.val_c20::text, '') is not null
then
lstfecstatus := i.val_c20;
end if;
if i.id_flex_tbl = 33 and nullif(i.val_c22::text, '') is not null
then
lstfecstatus := i.val_c22;
end if;
if i.id_flex_tbl = 34 and nullif(i.val_c24::text, '') is not null
then
lstfecstatus := i.val_c24;
end if;
if i.id_flex_tbl = 35 and nullif(i.val_c9::text, '') is not null
then
lstfecstatus := i.val_c9;
end if;
end if;
--autorizacion dir
if    (i.id_flex_tbl = 28 and nullif(i.val_c9::text, '') is not null)
or (i.id_flex_tbl = 29 and nullif(i.val_c21::text, '') is not null)
or (i.id_flex_tbl = 31 and nullif(i.val_c11::text, '') is not null)
or (i.id_flex_tbl = 32 and nullif(i.val_c21::text, '') is not null)
or (i.id_flex_tbl = 33 and nullif(i.val_c23::text, '') is not null)
or (i.id_flex_tbl = 34 and nullif(i.val_c24::text, '') is not null)
or (i.id_flex_tbl = 35 and nullif(i.val_c10::text, '') is not null)
then
lststatus := autorizacin dir;
if i.id_flex_tbl = 28 and nullif(i.val_c9::text, '') is not null
then
lstfecstatus := i.val_c9;
end if;
if i.id_flex_tbl = 29 and nullif(i.val_c21::text, '') is not null
then
lstfecstatus := i.val_c21;
end if;
if i.id_flex_tbl = 31 and nullif(i.val_c11::text, '') is not null
then
lstfecstatus := i.val_c11;
end if;
if i.id_flex_tbl = 32 and nullif(i.val_c21::text, '') is not null
then
lstfecstatus := i.val_c21;
end if;
if i.id_flex_tbl = 33 and nullif(i.val_c23::text, '') is not null
then
lstfecstatus := i.val_c23;
end if;
if i.id_flex_tbl = 34 and nullif(i.val_c24::text, '') is not null
then
lstfecstatus := i.val_c24;
end if;
if i.id_flex_tbl = 35 and nullif(i.val_c10::text, '') is not null
then
lstfecstatus := i.val_c10;
end if;
end if;
--firmas
if(     i.id_flex_tbl = 28 and nullif(i.val_c10::text, '') is not null)
or (i.id_flex_tbl = 29 and nullif(i.val_c22::text, '') is not null)
or (i.id_flex_tbl = 31 and nullif(i.val_c12::text, '') is not null)
or (i.id_flex_tbl = 32 and nullif(i.val_c22::text, '') is not null)
or (i.id_flex_tbl = 33 and nullif(i.val_c24::text, '') is not null)
or (i.id_flex_tbl = 34 and nullif(i.val_c26::text, '') is not null)
or (i.id_flex_tbl = 35 and nullif(i.val_c11::text, '') is not null)
then
lststatus := en firmas;
if i.id_flex_tbl = 28 and nullif(i.val_c10::text, '') is not null
then
lstfecstatus := i.val_c10;
end if;
if i.id_flex_tbl = 29 and nullif(i.val_c22::text, '') is not null
then
lstfecstatus := i.val_c22;
end if;
if i.id_flex_tbl = 31 and nullif(i.val_c12::text, '') is not null
then
lstfecstatus := i.val_c12;
end if;
if i.id_flex_tbl = 32 and nullif(i.val_c22::text, '') is not null
then
lstfecstatus := i.val_c22;
end if;
if i.id_flex_tbl = 33 and nullif(i.val_c24::text, '') is not null
then
lstfecstatus := i.val_c24;
end if;
if i.id_flex_tbl = 34 and nullif(i.val_c26::text, '') is not null
then
lstfecstatus := i.val_c26;
end if;
if i.id_flex_tbl = 35 and nullif(i.val_c11::text, '') is not null
then
lstfecstatus := i.val_c11;
end if;
end if;
--entregada
if    (i.id_flex_tbl = 28 and nullif(i.val_c11::text, '') is not null)
or (i.id_flex_tbl = 29 and nullif(i.val_c23::text, '') is not null)
or (i.id_flex_tbl = 31 and nullif(i.val_c13::text, '') is not null)
or (i.id_flex_tbl = 32 and nullif(i.val_c23::text, '') is not null)
or (i.id_flex_tbl = 33 and nullif(i.val_c25::text, '') is not null)
or (i.id_flex_tbl = 34 and nullif(i.val_c27::text, '') is not null)
or (i.id_flex_tbl = 35 and nullif(i.val_c12::text, '') is not null)
then
lststatus := entregada;
if i.id_flex_tbl = 28 and nullif(i.val_c11::text, '') is not null
then
lstfecstatus := i.val_c11;
end if;
if i.id_flex_tbl = 29 and nullif(i.val_c23::text, '') is not null
then
lstfecstatus := i.val_c23;
end if;
if i.id_flex_tbl = 31 and nullif(i.val_c13::text, '') is not null
then
lstfecstatus := i.val_c13;
end if;
if i.id_flex_tbl = 32 and nullif(i.val_c23::text, '') is not null
then
lstfecstatus := i.val_c23;
end if;
if i.id_flex_tbl = 33 and nullif(i.val_c25::text, '') is not null
then
lstfecstatus := i.val_c25;
end if;
if i.id_flex_tbl = 34 and nullif(i.val_c27::text, '') is not null
then
lstfecstatus := i.val_c27;
end if;
if i.id_flex_tbl = 35 and nullif(i.val_c12::text, '') is not null
then
lstfecstatus := i.val_c12;
end if;
end if;
end if;
*/
begin
insert into usrdrc.dercorp_rep_reformas_tmp(  id_rep_reforma,
id_empresa,
nom_empresa,
des_asunto,
fec_solicitud,
des_status,
fec_status,
des_follow_up,
nom_responsable,
des_descripcion)
values( linsecuencia,
i.id_empresa,
i.empresa,
i.asunto,
i.fecha_solicitud,
lststatus,
lstfecstatus,
lstfolloup,
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where 1=1
and id_catalogo = 59
and id_catalogo_valor = (
select atributo3
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and   id_catalogo_valor = (select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = i.id_empresa --jams
and id_add_campo = 500)
)),
lstdescripcion);/* dmap converted statement start */
exception when others
then
perform dbms_output.put_line( concat('Error Al insertar en la tabla ', sqlerrm)) ;/* dmap converted statement end */
end;
end loop;end;
$body$
language plpgsql
;
