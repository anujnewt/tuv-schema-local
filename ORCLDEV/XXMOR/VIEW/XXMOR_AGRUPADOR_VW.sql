-- dmap_object_gen_tag : type : view name : xxmor_agrupador_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_"agrupador"_vw"  (agrupador) as select ident_fza_val as agrupador  from xxmor_fzas_vtas_ident_tab
where ident_fza_tipo = 'G'
group by ident_fza_val  order by  ident_fza_val
;/* dmap converted statement end */
-- estimed cost of view [ xxmor_agrupador_vw ]: 1.00;
