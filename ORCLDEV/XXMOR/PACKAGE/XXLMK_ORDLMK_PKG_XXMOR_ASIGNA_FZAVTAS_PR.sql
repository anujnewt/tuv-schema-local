create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxmor_asigna_fzavtas_pr ( p_id integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_id_fza_ventas     integer;
v_id_solicitud      integer;
v_fza_vtas_mkt      integer;
v_coordina_mkt      integer;
v_count_coord       integer;
v_count_nulls       integer;
v_tot_lineas        integer;
v_gen_ver_vir       integer;
v_aut_x_correo      integer;
v_fza_vtas_ch       integer;
lst_agrupador        varchar(10);
lst_plataforma_canal varchar(70);
lst_usa_buyunit      varchar(1);
ordenes_cur cursor for
select id_ordhdr
from   xxlmk_ordhdr_tab
where  id_ordhdr = p_id;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
for orden in ordenes_cur loop
v_id_solicitud := orden.id_ordhdr;/* dmap converted statement start */
perform dbms_output.put_line( concat(' V_ID_SOLICITUD: ', v_id_solicitud)) ;/* dmap converted statement end */
select coalesce(trim(both des_plat_canal),'SIN PLATAFORMA')
into strict   lst_plataforma_canal
from   xxlmk_ordhdr_tab
where  id_ordhdr = v_id_solicitud;/* dmap converted statement start */
perform dbms_output.put_line( concat('lst_plataforma_canal: ', lst_plataforma_canal)) ;/* dmap converted statement end */
select xxlmk_ordlmk_pkg_xxmor_get_agrupador_fn(
lst_plataforma_canal,
v_id_solicitud
)
into strict   lst_agrupador
;/* dmap converted statement start */
perform dbms_output.put_line( concat('lst_agrupador: ', lst_agrupador)) ;/* dmap converted statement end */
update xxlmk_ordhdr_tab
set    des_agrupador  = lst_agrupador
where id_ordhdr = v_id_solicitud;
perform dbms_output.put_line('SE ACTUALIZO AGRUPADOR');
select xxlmk_ordlmk_pkg_xxmor_ident_fza_vtas(
v_id_solicitud,
(select des_usrchr
from   xxlmk_ordln_tab
where  id_ordhdr = v_id_solicitud
and    num_linea        = 1
),
(select des_sptchr
from   xxlmk_ordln_tab
where  id_ordhdr = v_id_solicitud
and    num_linea        = 1
)
)
into strict v_id_fza_ventas
;
if v_id_fza_ventas = 0 then
null;
elsif v_id_fza_ventas = 1 then
v_id_fza_ventas := 0;
elsif v_id_fza_ventas < 0 then
v_id_fza_ventas := (v_id_fza_ventas * -1);
v_id_fza_ventas := 0;
end if;
update xxlmk_ordhdr_tab e
set    id_fza_ventas = v_id_fza_ventas
where  id_ordhdr = v_id_solicitud;
select count(1)
into strict   v_fza_vtas_ch
from   xxmor_fzas_vtas_canales_tab
where  id_seg_neg    = 1
and    id_fza_ventas = v_id_fza_ventas;
end loop;end;
$body$
language plpgsql
;
