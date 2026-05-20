create or replace procedure feci."histfeci_procesa_catalogos_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
contador_empresa numeric;
contador_monedas numeric;
contador_pais numeric;
begin
--para catalogo empresas
select
count(distinct trim(both cod_empresa)) into strict contador_empresa
from histfeci_recibos_masivo_tab
where nullif(trim(both from cod_empresa::text), '') is not null
and trim(both cod_empresa) not in (select trim(both cod_empresa) from feci_empresa_cat);
if contador_empresa > 0 then
-- registra empresas que no estan en el catalogo feci_empresa_cat
insert into feci_empresa_cat(
cod_empresa,
des_empresa,
fec_creacion,
fec_ult_modificacion,
id_usuario_creacion,
id_usuario_ult_modif,
ind_estado
)
select distinct
trim(both cod_empresa) as cod_empresa,
trim(both des_empresa) as des_empresa,
clock_timestamp() as fec_creacion,
clock_timestamp() as fec_ult_modificacion,
0 as id_usuario_creacion,
0 as id_usuario_ult_modif,
1 as ind_estado
from histfeci_recibos_masivo_tab
where nullif(trim(both from cod_empresa::text), '') is not null
and trim(both cod_empresa) not in (select trim(both cod_empresa) from feci_empresa_cat);
end if;
---para catalogo monedas
select
count(distinct trim(both cod_moneda))  into strict contador_monedas
from histfeci_recibos_masivo_tab
where nullif(trim(both from cod_moneda::text), '') is not null
and trim(both cod_moneda) not in (select trim(both cod_moneda) from feci_moneda_cat);
if contador_monedas > 0 then
-- registra monedas que no estan en el catalogo feci_moneda_cat
insert into feci_moneda_cat(
cod_moneda,
des_moneda,
fec_creacion,
fec_ult_modificacion,
id_usuario_creacion,
id_usuario_ult_modif,
ind_estado
)
select distinct
trim(both cod_moneda) as moneda,
trim(both des_moneda) as des_moneda,
clock_timestamp() as fec_creacion,
clock_timestamp() as fec_ult_modificacion,
0 as id_usuario_creacion,
0 as id_usuario_ult_modif,
1 as ind_estado
from histfeci_recibos_masivo_tab
where nullif(trim(both from cod_moneda::text), '') is not null
and trim(both cod_moneda) not in (select trim(both cod_moneda) from feci_moneda_cat);
end if;
---para catalogo feci_pais_cat
select
count(distinct trim(both cod_pais))  into strict contador_pais
from histfeci_recibos_masivo_tab
where nullif(trim(both from cod_pais::text), '') is not null
and trim(both cod_pais) not in (select trim(both cod_pais) from feci_pais_cat);
if contador_pais > 0 then
-- registra monedas que no estan en el catalogo feci_pais_cat
insert into feci_pais_cat(
cod_pais,
des_pais,
fec_creacion,
fec_ult_modificacion,
id_usuario_creacion,
id_usuario_ult_modif,
ind_estado
)
select distinct
trim(both cod_pais) as cod_pais,
trim(both des_pais) as des_pais,
clock_timestamp() as fec_creacion,
clock_timestamp() as fec_ult_modificacion,
0 as id_usuario_creacion,
0 as id_usuario_ult_modif,
1 as ind_estado
from histfeci_recibos_masivo_tab
where nullif(trim(both from cod_pais::text), '') is not null
and trim(both cod_pais) not in (select trim(both cod_pais) from feci_pais_cat);
end if;end;
$body$
language plpgsql
;
