-- dmap_object_gen_tag : type : view name : xxmor_prefijo_mc_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxmor_prefijo_mc_vw"  ("region") as select ident_fza_val  from xxmor_fzas_vtas_ident_tab
where ident_fza_tipo = 'P'
group by ident_fza_val   order by  ident_fza_val
;/* dmap converted statement end */
-- estimed cost of view [ xxmor_prefijo_mc_vw ]: 1.00;
