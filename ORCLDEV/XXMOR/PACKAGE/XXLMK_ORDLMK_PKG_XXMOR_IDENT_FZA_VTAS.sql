create or replace  function  xxmor.xxlmk_ordlmk_pkg_xxmor_ident_fza_vtas ( p_id_solicitud numeric, p_usrchr varchar, p_sptchr varchar ) returns numeric as $body$
declare
-- pgv moved types start
--dmap moved type other package xxmor_funcional_pkg;
-- pgv moved types end
v_agrupador   varchar(10);
v_region      varchar(2);
v_sufijo      varchar(2);
v_cliente     varchar(15);
v_fza_ventas  numeric(5) := null;
v_accthdrid   varchar(15);
v_mcontid     varchar(20);
v_rtcrddscr   varchar(50);
v_email       varchar(50);
v_comentarios varchar(150);
p_solicitud   xxmor.XXMOR_FUNCIONAL_PKG_MOR_ENC_REC_TYPE;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--identificamos la fza de ventas
--obtenemos el master contract, agrupador, cliente, prefijo, sufijo
select trim(both des_agrupador)                                    agrupador,
trim(both cve_advid)                                        cliente,
oracle.substr(trim(both cve_mcontid),1,2)                          region,
oracle.substr(trim(both cve_mcontid),position('.' in trim(both cve_mcontid))-2,2) sufijo,
cve_accthdrid,
cve_mcontid,
des_rtcrd,
des_email
into strict   v_agrupador,
v_cliente,
v_region,
v_sufijo,
v_accthdrid,
v_mcontid,
v_rtcrddscr,
v_email
from   xxlmk_ordhdr_tab
where  id_ordhdr = p_id_solicitud;
--dbms_output.put_line(-> ||v_fza_ventas ||  -> || v_region || -> || v_agrupador  || -> || p_sptchr || -> || p_usrchr );   --decode(nvl(v.sufijo,*),*,*,v.sufijo)
begin
select id_fza_ventas
into strict   v_fza_ventas
from   (select distinct
v.id_fza_ventas
from   xxmor_fzas_ventas_ids_vw v
where  v.region                                            = v_region
and    v.agrupador                                         = v_agrupador
and    case when v.sptchr='*' then '*'  else v.sptchr end                    = case when v.sptchr='*' then '*'  else p_sptchr end
and    case when coalesce(v.usrchr,' ')='*' then '*'  else coalesce(v.usrchr,' ') end  = case when coalesce(v.usrchr,' ')='*' then '*'  else coalesce(p_usrchr,' ') end
and    case when coalesce(v.cliente,'*')='*' then '*'  else v.cliente end         = coalesce((select cve_accthdrid
from   xxlmk_ordhdr_tab
where  id_ordhdr = p_id_solicitud
and    cve_accthdrid    in (select cliente
from   xxmor_fzas_ventas_ids_vw
)
),'*')
and    coalesce(v.sufijo,'*')                                   = coalesce((select oracle.substr(cve_mcontid,position('.' in cve_mcontid)-2,2)
from   xxlmk_ordhdr_tab
where  id_ordhdr                           = p_id_solicitud
and    oracle.substr(cve_mcontid,position('.' in cve_mcontid)-2,2) in (select sufijo
from   xxmor_fzas_ventas_ids_vw
where  region    = v_region
and    agrupador = v_agrupador
)
),'*')
and    v.inclusion                                         = 1
union
select distinct
v.id_fza_ventas
from   xxmor_fzas_ventas_ids_vw v
where  v.region    = v_region
and    v.agrupador = v_agrupador
and    case when coalesce(v.cliente,'*')='*' then '*'  else v.cliente end  = coalesce((select cve_accthdrid
from   xxlmk_ordhdr_tab
where  id_ordhdr = p_id_solicitud
and    cve_accthdrid    in (select cliente
from xxmor_fzas_ventas_ids_vw
)
),'*')
and    v.inclusion                                  = 0
and    not exists (select 1
from   xxmor.xxmor_conf_tipo_srv_tab ts
where  v.id_seg_neg                         = ts.id_seg_neg
and    v.id_fza_ventas                      = ts.id_fza_ventas
and    v.inclusion                          = ts.inclusion
and    ts.sptchr                            = p_sptchr
and (case when ts.usrchr='*' then '*'  else ts.usrchr end  = case when ts.usrchr='*' then '*'  else p_usrchr end
or nullif(ts.usrchr::text, '') is null)
)
and (select count(1)
from   xxmor_fzas_ventas_ids_vw v
where  v.region    = v_region
and    v.agrupador = v_agrupador
and    v.inclusion = 0
)                                            = (select count(1)
from   xxmor_fzas_ventas_ids_vw v
where  v.region    = v_region
and    v.agrupador = v_agrupador
and    v.inclusion = 0
and    not exists (select 1
from   xxmor.xxmor_conf_tipo_srv_tab ts
where  v.id_seg_neg                        = ts.id_seg_neg
and    v.id_fza_ventas                     = ts.id_fza_ventas
and    v.inclusion                         = ts.inclusion
and    v.sptchr                            = ts.sptchr
and    v.usrchr                            = ts.usrchr
and    ts.sptchr                           = p_sptchr
and    case when ts.usrchr='*' then '*'  else ts.usrchr end  = case when ts.usrchr='*' then '*'  else p_usrchr end
)
)
) alias27;
exception
when no_data_found then
v_fza_ventas := 0;
when too_many_rows then
v_fza_ventas := 1;
end;
begin
--se revisa que la fza de ventas este activa
select id_fza_ventas
into strict   v_fza_ventas
from   xxmor_fzas_vtas_tab
where  id_fza_ventas = v_fza_ventas
and    activa        = 1;
exception
when no_data_found then
v_fza_ventas := (v_fza_ventas * -1);
end;
return coalesce(v_fza_ventas,0);end;
$body$
language plpgsql
stable;
