create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_desc_ti_servicio_fun ( p_id_request integer, p_linea integer ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
--v_tipo_servicio
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
return '0';
/*begin
--para identificar la fza de ventas, solo se utiliza el tipo de servicio de la primera orden
select trim(tipo_servicio)
into   v_tipo_servicio
from   xxmor.xxmor_solicitudes_orig_det_tab
where  id_request = p_id_request
and    linea_request = 1;
exception
when others then
v_tipo_servicio :=  na;
end;
if length(v_tipo_servicio) = 2 then
v_usrchr := oracle.substr(v_tipo_servicio,1,1);
v_sptchr := oracle.substr(v_tipo_servicio,2,1);
select usr_chr, spt_chr, desc_tipo_servicio
into v_usrchr, v_sptchr, v_tipo_servicio
from xxmor.xxmor_cat_tipo_serv_tab
where nvl(usr_chr, ) = oracle.substr(v_tipo_servicio,1,1)
and   spt_chr = oracle.substr(v_tipo_servicio,2,1);
dbms_output.put_line( -> usr_chr || ->|| v_usrchr||<-  );
dbms_output.put_line( ->v_sptchr  || ->|| v_sptchr||<-  );
--ponemos la descripcion del servicio que representan spot-usr chr
select desc_tipo_servicio
into v_desc_t_serv
from xxmor_cat_tipo_serv_tab
where nvl(usr_chr, ) = nvl(v_usrchr, )
and nvl(spt_chr, ) = v_sptchr;
--end if;
elsif length(v_tipo_servicio) > 0 then
--if v_sptchr is null and v_usrchr is null then
select spt_chr, usr_chr
into v_sptchr, v_usrchr
from xxmor.xxmor_cat_tipo_serv_tab
where upper(desc_tipo_servicio) = upper(v_tipo_servicio);
end if;*/
end;
$body$
language plpgsql
;
