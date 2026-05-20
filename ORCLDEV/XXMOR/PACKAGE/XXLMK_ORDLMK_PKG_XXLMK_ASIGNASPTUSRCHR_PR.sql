create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxlmk_asignasptusrchr_pr ( p_id numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_mcontid             varchar(30);
v_mcontid_ci          varchar(30);
v_mul_fzas            numeric(2);
v_cutin               numeric(2);
v_facturable          varchar(12);
v_agrupador           varchar(30);
v_region              varchar(2);
v_sufijo              varchar(2);
v_segneg              numeric(2);
v_request_aux         integer;
p_id_request          integer;
v_id_solicitud_temp   integer;
v_temp                numeric(30);
v_agrupa              integer;
v_existe              integer;
v_usrchr              varchar(5);
v_sptchr              varchar(5);
v_desc_t_serv         varchar(50);
v_tipo_servicio       varchar(100);
v_aux                 varchar(100);
v_mc_ing_cutin        varchar(30);      --<-- el mastercontract de la derecha
v_spt_5               integer:=0;
v_spt_1               integer:=0;
v_prefijo_stnid       varchar(5);       --<hasta ac? con mcontid de la derecha
v_rtcrd               varchar(50);      --> para gen aut tarifa manual sin rtcrd
--v_ord_mkt               pls_integer;
v_id_solicitud_nal    numeric;
v_id_solicitud_prov   numeric;
lst_nom_archivo       varchar(150);
lst_inserta           varchar(1);
lst_orden_mcing       varchar(1);
lst_orden_mc          varchar(1);
lin_numregs_orig      numeric := 0;
lin_numregs_det       numeric := 0;
lineas cursor for
select  id_ordhdr, id_linea, des_tipo_servicio
from    xxlmk_ordln_tab
where   id_ordhdr = p_id;
ordenes cursor for
select id_ordhdr
from   xxlmk_ordhdr_tab
where  id_ordhdr = p_id;
cur_prefijos cursor(p_i_id_request integer) for
select prefijo_canal,
agrupador_multiple
from   xxmor.xxmor_cat_agrupador_mult_tab
where  agrupador_multiple = (select trim(both des_plat_canal)
from   xxlmk_ordhdr_tab
where  id_ordhdr = p_id
);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open ordenes;
loop
fetch ordenes into p_id_request;
exit when not found; /* apply on ordenes */
select trim(both oe.cve_mcontid),
trim(both oe.cve_mcont_cutin),
trim(both oe.des_plat_canal),
trim(both oe.id_seg_neg)
into strict   v_mcontid,
v_mcontid_ci,
v_agrupador,
v_segneg
from   xxlmk_ordhdr_tab oe
where  oe.id_ordhdr = p_id;
lst_inserta := null;/* dmap converted statement start */
begin
--para identificar la fza de ventas, solo se utiliza el tipo de servicio de la primera orden
select rtrim(des_tipo_servicio::text)
into strict   v_tipo_servicio
from   xxlmk_ordln_tab
where  id_ordhdr    = p_id
and    num_linea = 1;/* dmap converted statement end */
exception
when no_data_found then
lst_inserta := 'N';
v_tipo_servicio := null;
when others then
v_tipo_servicio := 'NA';
end;
if length(v_tipo_servicio) = 2 then
lst_inserta := 'Y';
begin
select usr_chr,
spt_chr,
desc_tipo_servicio
into strict   v_usrchr,
v_sptchr,
v_tipo_servicio
from   xxmor.xxmor_cat_tipo_serv_tab
where  coalesce(usr_chr,' ') = oracle.substr(v_tipo_servicio,1,1)
and    spt_chr          = oracle.substr(v_tipo_servicio,2,1);
exception
when others then
v_usrchr := 'XX';
v_sptchr := 'XX';
end;/* dmap converted statement start */
perform dbms_output.put_line( concat(' -> USR_CHR', ' ->', v_usrchr, '<-')  );/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat(' -> V_SPTCHR ', ' ->', v_sptchr, '<-')  );/* dmap converted statement end */
if v_usrchr != 'XX' and v_sptchr != 'XX' then
--ponemos la descripcion del servicio que representan spot-usr chr
select desc_tipo_servicio
into strict   v_desc_t_serv
from   xxmor_cat_tipo_serv_tab
where  coalesce(usr_chr,' ') = coalesce(v_usrchr,' ')
and    coalesce(spt_chr,' ') = v_sptchr;
end if;
elsif length(v_tipo_servicio) > 0 then
lst_inserta := 'Y';
begin
select spt_chr,
usr_chr
into strict   v_sptchr,
v_usrchr
from   xxmor.xxmor_cat_tipo_serv_tab
where  upper(desc_tipo_servicio) = upper(v_tipo_servicio);
exception
when others then
v_usrchr := 'XX';
v_sptchr := 'XX';
end;
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat(' -> ', p_id_request , ' -> ', v_agrupador)  );/* dmap converted statement end */
if lst_inserta = 'Y' then
-- si las ordenes ingresadas no son de television insertar como vienen
if v_segneg != 1 then
perform dbms_output.put_line('');
else -- v_segneg != 1
perform dbms_output.put_line('');
for ln in lineas
loop
update  xxlmk_ordln_tab     ol
set     des_usrchr =
case when length(ln.des_tipo_servicio) = 2 then
oracle.substr(ln.des_tipo_servicio,1,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  upper(replace(desc_tipo_servicio, ' ', '')) = upper(replace(ln.des_tipo_servicio, ' ', ''))
) > 0 then (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  upper(replace(desc_tipo_servicio, ' ', '')) = upper(replace(ln.des_tipo_servicio, ' ', ''))
)
else (select usr_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end,
des_sptchr =
case when length(ln.des_tipo_servicio) = 2 then
oracle.substr(ln.des_tipo_servicio,2,1)
else
case when(select count(1)
from   xxmor.xxmor_cat_tipo_serv_tab
where  upper(replace(desc_tipo_servicio, ' ', '')) = upper(replace(ln.des_tipo_servicio, ' ', ''))
) > 0 then (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  upper(replace(desc_tipo_servicio, ' ', '')) = upper(replace(ln.des_tipo_servicio, ' ', ''))
)
else (select spt_chr
from   xxmor.xxmor_cat_tipo_serv_tab
where  desc_tipo_servicio = 'NO APLICA'
)
end
end
where  ol.id_linea = ln.id_linea;
end loop;
end if; -- v_segneg != 1
perform dbms_output.put_line('');
elsif lst_inserta = 'N' then
perform dbms_output.put_line('');
end if;
end loop;
close ordenes;end;
$body$
language plpgsql
;
