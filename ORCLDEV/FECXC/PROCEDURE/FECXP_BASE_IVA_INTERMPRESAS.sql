create or replace procedure fecxc."fecxp_base_iva_intermpresas"  ( v_fecha_ini timestamp(0), v_fecha_fin timestamp(0)) as $body$
declare

    rec_t_c2_d_tmp_del_temp FECXP_BASE_IVA_INTERMPRESAS_REC_FECXP_INGRESOS_CLASIF[];
-- pgv moved types start
-- pgv moved types end
v_no_empresa                integer;
v_no_folio_det              integer;
v_fec_valor                 timestamp(0);
v_referencia                varchar(30);
v_id_banco                  integer;
v_id_banco_benef            integer;
v_id_chequera               varchar(20);
v_concepto                  varchar(100);
v_tipo_cambio               numeric;
v_importe                   numeric;
v_no_cheque                 integer;
v_id_tipo_operacion_set     integer;
v_id_forma_pago             integer;
v_id_divisa                 varchar(3);
v_fec_valor_original        timestamp(0);
v_id_status_mov             varchar(1);
v_beneficiario              varchar(60);
v_descripcion               varchar(30);
v_secuencia_dep_especiales  integer;
v_no_cliente                varchar(15);
v_periodo                   integer;
v_cve_operacion             integer;
v_origen_movimiento         varchar(3);
v_id_chequera_benef         varchar(11);
v_lote_entrada              integer;
v_no_docto                  integer;
v_plataforma                varchar(1);
v_nom_empresa               varchar(100);
v_no_cuenta                 integer;
v_folio_ref                 integer;
v_fecha_actualizacion       timestamp(0);
v_nom_empresa_rel           varchar(100);
v_procesado                 integer;
--- variables para el iva
v_cla_fe_id  varchar(25);
v_cla_fe_des varchar(50);
v_cia        varchar(25);
v_neg        varchar(25);
v_cta        varchar(25);
v_scta       varchar(25);
v_cc         varchar(25);
v_icia       varchar(25);
v_top        varchar(25);
--- variables para el activity
v_cla_fe_id2  varchar(25);
v_cla_fe_des2 varchar(50);
v_cia2        varchar(25);
v_neg2        varchar(25);
v_cta2        varchar(25);
v_scta2       varchar(25);
v_cc2         varchar(25);
v_icia2       varchar(25);
v_top2        varchar(25);
v_importe2 decimal(20,2);
--  variables para el manejo de errores
err_num numeric;
err_msg varchar(100);
--este cursor sirve para encontrar los folios que no esten aperturados en flujo y ya se encuentren en ar
c_apertura_ingresos cursor for select receipt_number,sum(aplicado) aplicado,sum(base) base, sum(iva) iva, id_status_mov from (
select /*+ index (fecxc_dep_especiales fecxc_dep_especiales_03)  */ acra.receipt_number as receipt_number
,coalesce(sum(araa.amount_applied),0) aplicado
,coalesce(sum(araa.line_applied),0) base
,coalesce(sum(araa.tax_applied),0)  iva
,id_status_mov
from   ar.ar_cash_receipts_all__to_tvprod acra
,apps.ar_receivable_applications_all__to_tvprod araa
,fecxc.fecxc_dep_especiales fde
where 1=1
and to_char(fde.no_folio_det)=acra.receipt_number
and acra.cash_receipt_id = araa.cash_receipt_id
and acra.org_id = araa.org_id
and araa.status != 'UNAPP'
and araa.display = 'Y'
and fde.id_tipo_operacion_set  in (3700,3701,3705,3706,3708,3715,4102,4103)
and fde.aperturadoar = 0
and fec_valor_original>=v_fecha_ini
and fec_valor_original<= v_fecha_fin
--and fde.no_folio_det=32032109
group by  acra.receipt_number,id_status_mov
union all
select /*+ index (fecxc_dep_especiales fecxc_dep_especiales_03)  */ acra.receipt_number as receipt_number
,coalesce(sum(araa.amount_applied),0) aplicado
,coalesce(sum(araa.line_applied),0) base
,coalesce(sum(araa.tax_applied),0)  iva
,id_status_mov
from   ar.ar_cash_receipts_all__to_tvprod acra
,apps.ar_receivable_applications_all__to_tvprod araa
,fecxc.fecxc_dep_especiales fde
where 1=1
and to_char(fde.no_folio_det)=acra.receipt_number
and acra.cash_receipt_id = araa.cash_receipt_id
and acra.org_id = araa.org_id
and araa.status ='UNAPP'
and fde.id_tipo_operacion_set  in (3700,3701,3705,3706,3708,3715,4102,4103)
and fde.aperturadoar = 0
and fec_valor_original>=v_fecha_ini
and fec_valor_original<= v_fecha_fin
--and fde.no_folio_det=32032109
group by  acra.receipt_number,id_status_mov) alias19
group by receipt_number,id_status_mov;
existe_folio_ar integer:=0;
importe_b numeric;
total numeric;
/*  */
rec_t_c2_d_tmp FECXP_BASE_IVA_INTERMPRESAS_REC_FECXP_INGRESOS_CLASIF[];
lin_aux integer;
begin 

select cla_fe_id, cla_fe_des, cia, neg, cta, scta, cc, icia, top
into strict v_cla_fe_id, v_cla_fe_des, v_cia, v_neg, v_cta, v_scta, v_cc, v_icia, v_top
from fecxc.fecxp_iva_interempresas_tbl;
select cla_fe_id, cla_fe_des, cia, neg, cta, scta, cc, icia, top
into strict v_cla_fe_id2, v_cla_fe_des2, v_cia2, v_neg2, v_cta2, v_scta2, v_cc2, v_icia2, v_top2
from fecxc.fecxp_iva_inter_activity_tbl;
----ir a ar a buscar cada uno de los folios recien extraidos
----en caso de que exista se debera elminar de flujo de efectivo y reaperturar con las nuevas cuentas contables
----en caso de que no exista se deja en flujo tal y como esta
--aperturando los folios
lin_aux :=0;
for cont in c_apertura_ingresos
loop
existe_folio_ar :=0;
begin
--se busca el importe en flujo, ojo: tiene que ser el importe exactamente igual y el mismo id de estatus
select importe into strict importe_b from fecxc.fecxc_dep_especiales fde where fde.id_status_mov=cont.id_status_mov and no_folio_det = cont.receipt_number;
--dbms_output.put_line ('Importe del  Folio en FLujo: '|| importe_b||' resultado de la operacion '||(abs(importe_b) - (abs(cont.base)+abs(cont.iva)))||' '||cont.receipt_number );
total:=abs(importe_b);
--si vienen montos negativos dejar el folio tal como esta
if (cont.aplicado<0) or (cont.base<0) or (cont.iva <0) then
null;--no se hace nada
else
--revisa que flujo cuadre contra ar
if ((abs(importe_b) - abs(cont.aplicado)) between -0.10 and 0.10) or ((abs(importe_b) - abs(cont.iva+cont.base)) between -0.10 and 0.10)then
--dbms_output.put_line ('FOLIO:'||cont.receipt_number);
--dbms_output.put_line ('Importe del Folio:$ '||importe_b||'Base:$ '|| cont.base||' IVA:$ '||cont.iva ||' Activity:$ '||(abs(cont.aplicado)-(abs(cont.base)+abs(cont.iva))));
--dbms_output.put_line (','||cont.receipt_number);
--revisar en flujo  si existe base, iva u otro
if ((abs(importe_b) - abs(cont.base)) between -0.10 and 0.10) then
--el registro existente es la base
--marcar los folios procesados
update fecxc.fecxc_dep_especiales
set aperturadoar=1
where no_folio_det =cont.receipt_number
and id_status_mov=cont.id_status_mov;
--dbms_output.put_line ('Actualiza la Base por'||cont.base);
elsif  ((abs(importe_b) - abs(cont.iva)) between -0.10 and 0.10) then
--el registro existente es el iva
update  fecxc.fecxp_ingresos_clasif f
set  cla_fe_id=v_cla_fe_id,
ora_soin_segmento1= case when v_cia  ='$' then ora_soin_segmento1 else v_cia end,
ora_soin_segmento2= case when v_neg  ='$' then ora_soin_segmento2 else v_neg end,
ora_soin_segmento3= case when v_cta  ='$' then ora_soin_segmento3 else v_cta end,
oracle_segmento4=   case when v_scta ='$' then oracle_segmento4   else v_scta end,
oracle_segmento5=   case when v_cc   ='$' then oracle_segmento5   else v_cc end,
oracle_segmento6=   case when v_icia ='$' then oracle_segmento6   else v_icia end,
oracle_segmento7=   case when v_top  ='$' then oracle_segmento7   else v_top end
where f.folio_set =cont.receipt_number
and f.id_status_mov=cont.id_status_mov;
--marcar los folios procesados
update fecxc.fecxc_dep_especiales
set aperturadoar=1
where no_folio_det =cont.receipt_number
and id_status_mov=cont.id_status_mov;
total:=total-abs(cont.iva);
--dbms_output.put_line ('Actualiza el IVA por'||cont.iva);
elsif ((abs(importe_b) - (abs(cont.aplicado)-(abs(cont.iva)+abs(cont.base)))) between -0.10 and 0.10) then
--el registro existente es el activity
update  fecxc.fecxp_ingresos_clasif f
set  cla_fe_id=v_cla_fe_id2,
ora_soin_segmento1= case when v_cia2  ='$' then ora_soin_segmento1 else v_cia2 end,
ora_soin_segmento2= case when v_neg2  ='$' then ora_soin_segmento2 else v_neg2 end,
ora_soin_segmento3= case when v_cta2  ='$' then ora_soin_segmento3 else v_cta2 end,
oracle_segmento4  = case when v_scta2 ='$' then oracle_segmento4   else v_scta2 end,
oracle_segmento5  = case when v_cc2   ='$' then oracle_segmento5   else v_cc2 end,
oracle_segmento6  = case when v_icia2 ='$' then oracle_segmento6   else v_icia2 end,
oracle_segmento7  = case when v_top2  ='$' then oracle_segmento7   else v_top2 end
where f.folio_set =cont.receipt_number
and f.id_status_mov=cont.id_status_mov;
--marcar los folios procesados
update fecxc.fecxc_dep_especiales
set aperturadoar=1
where no_folio_det =cont.receipt_number
and id_status_mov=cont.id_status_mov;
total:=total-abs(cont.aplicado);
--dbms_output.put_line ('Actualiza el ACTIVITY por'||cont.aplicado);
end if;
--si el registro en flujo es igual que la suma de ar aperturar
if (((abs(importe_b) - (abs(cont.iva)+abs(cont.base))) between -0.10 and 0.10) or ((abs(importe_b) - (abs(cont.aplicado))) between -0.10 and 0.10)) and total !=0 then
--si existe registro de base actualizar el existente
if  cont.base!=0 then
update  fecxc.fecxp_ingresos_clasif f
set  importe_linea=case when upper(f.id_status_mov) = 'X' then ((cont.base)*(-1)) else cont.base end
,    tipo_clasificacion='APERTURA ING ICIAS'
where f.folio_set =cont.receipt_number
and f.id_status_mov=cont.id_status_mov;
end if;
--si existe el iva crear la linea
if cont.iva != 0 then
select array_append(rec_t_c2_d_tmp, null) into rec_t_c2_d_tmp;
lin_aux := lin_aux+1;
--v_cla_fe_id, v_cla_fe_des,
select v_cla_fe_id, f.e_codigo, f.folio_set, f.tipo_operacion, f.fecha, f.moneda, f.tipo_cambio, f.importe, f.concepto,
f.beneficiario, f.id_status_mov, f.id_chequera, f.id_banco, f.id_forma_pago, f.referencia, case when upper(f.id_status_mov) = 'X' then ((-1)*(cont.iva)) else cont.iva end,
case when v_cia  ='$' then ora_soin_segmento1 else v_cia end,
case when v_neg  ='$' then ora_soin_segmento2 else v_neg end,
case when v_cta  ='$' then ora_soin_segmento3 else v_cta end,
case when v_scta ='$' then oracle_segmento4   else v_scta end,
case when v_cc   ='$' then oracle_segmento5   else v_cc end,
case when v_icia ='$' then oracle_segmento6   else v_icia end,
case when v_top  ='$' then oracle_segmento7   else v_top end, f.cual_erp,
'APERTURA ING ICIAS', f.no_cliente, f.descripcion
into strict rec_t_c2_d_tmp[lin_aux].cla_fe_id, rec_t_c2_d_tmp[lin_aux].e_codigo, rec_t_c2_d_tmp[lin_aux].folio_set, rec_t_c2_d_tmp[lin_aux].tipo_operacion, rec_t_c2_d_tmp[lin_aux].fecha, rec_t_c2_d_tmp[lin_aux].moneda, rec_t_c2_d_tmp[lin_aux].tipo_cambio, rec_t_c2_d_tmp[lin_aux].importe, rec_t_c2_d_tmp[lin_aux].concepto,
rec_t_c2_d_tmp[lin_aux].beneficiario, rec_t_c2_d_tmp[lin_aux].id_status_mov, rec_t_c2_d_tmp[lin_aux].id_chequera, rec_t_c2_d_tmp[lin_aux].id_banco, rec_t_c2_d_tmp[lin_aux].id_forma_pago, rec_t_c2_d_tmp[lin_aux].referencia, rec_t_c2_d_tmp[lin_aux].importe_linea , rec_t_c2_d_tmp[lin_aux].ora_soin_segmento1, rec_t_c2_d_tmp[lin_aux].ora_soin_segmento2,
rec_t_c2_d_tmp[lin_aux].ora_soin_segmento3, rec_t_c2_d_tmp[lin_aux].oracle_segmento4, rec_t_c2_d_tmp[lin_aux].oracle_segmento5,rec_t_c2_d_tmp[lin_aux].oracle_segmento6, rec_t_c2_d_tmp[lin_aux].oracle_segmento7, rec_t_c2_d_tmp[lin_aux].cual_erp,
rec_t_c2_d_tmp[lin_aux].tipo_clasificacion, rec_t_c2_d_tmp[lin_aux].no_cliente, rec_t_c2_d_tmp[lin_aux].descripcion
from fecxc.fecxp_ingresos_clasif f
where f.folio_set =cont.receipt_number
and f.id_status_mov=cont.id_status_mov;
total:=total-abs(cont.iva);
--dbms_output.put_line ('Crea Iva por'||cont.iva);
end if;
--si existe el activity crear la linea
if abs(cont.aplicado)-(abs(cont.base)+abs(cont.iva)) != 0 then
select array_append(rec_t_c2_d_tmp, null) into rec_t_c2_d_tmp;
lin_aux := lin_aux+1;
select v_cla_fe_id2, f.e_codigo, f.folio_set, f.tipo_operacion, f.fecha, f.moneda, f.tipo_cambio, f.importe, f.concepto,
f.beneficiario, f.id_status_mov, f.id_chequera, f.id_banco, f.id_forma_pago, f.referencia, case when upper(f.id_status_mov) = 'X' then ((-1)*((abs(cont.aplicado) - (abs(cont.iva)+abs(cont.base))))) else (abs(cont.aplicado) - (abs(cont.iva)+abs(cont.base))) end,
case when v_cia2  ='$' then ora_soin_segmento1 else v_cia2 end,
case when v_neg2  ='$' then ora_soin_segmento2 else v_neg2 end,
case when v_cta2  ='$' then ora_soin_segmento3 else v_cta2 end,
case when v_scta2 ='$' then oracle_segmento4   else v_scta2 end,
case when v_cc2   ='$' then oracle_segmento5   else v_cc2 end,
case when v_icia2 ='$' then oracle_segmento6   else v_icia2 end,
case when v_top2  ='$' then oracle_segmento7   else v_top2 end, f.cual_erp,
'APERTURA ING ICIAS', f.no_cliente, f.descripcion
into strict rec_t_c2_d_tmp[lin_aux].cla_fe_id, rec_t_c2_d_tmp[lin_aux].e_codigo, rec_t_c2_d_tmp[lin_aux].folio_set, rec_t_c2_d_tmp[lin_aux].tipo_operacion, rec_t_c2_d_tmp[lin_aux].fecha, rec_t_c2_d_tmp[lin_aux].moneda, rec_t_c2_d_tmp[lin_aux].tipo_cambio, rec_t_c2_d_tmp[lin_aux].importe, rec_t_c2_d_tmp[lin_aux].concepto,
rec_t_c2_d_tmp[lin_aux].beneficiario, rec_t_c2_d_tmp[lin_aux].id_status_mov, rec_t_c2_d_tmp[lin_aux].id_chequera, rec_t_c2_d_tmp[lin_aux].id_banco, rec_t_c2_d_tmp[lin_aux].id_forma_pago, rec_t_c2_d_tmp[lin_aux].referencia, rec_t_c2_d_tmp[lin_aux].importe_linea , rec_t_c2_d_tmp[lin_aux].ora_soin_segmento1, rec_t_c2_d_tmp[lin_aux].ora_soin_segmento2,
rec_t_c2_d_tmp[lin_aux].ora_soin_segmento3, rec_t_c2_d_tmp[lin_aux].oracle_segmento4, rec_t_c2_d_tmp[lin_aux].oracle_segmento5,rec_t_c2_d_tmp[lin_aux].oracle_segmento6, rec_t_c2_d_tmp[lin_aux].oracle_segmento7, rec_t_c2_d_tmp[lin_aux].cual_erp,
rec_t_c2_d_tmp[lin_aux].tipo_clasificacion, rec_t_c2_d_tmp[lin_aux].no_cliente, rec_t_c2_d_tmp[lin_aux].descripcion
from fecxc.fecxp_ingresos_clasif f
where f.folio_set =cont.receipt_number
and f.id_status_mov=cont.id_status_mov;
--dbms_output.put_line ('Crea Activity por'|| (abs(cont.aplicado) - (abs(cont.iva)+abs(cont.base))));
total:=total- (abs(cont.aplicado) - (abs(cont.iva)+abs(cont.base)));
end if;
update fecxc.fecxc_dep_especiales
set aperturadoar=1
where no_folio_det =cont.receipt_number
and id_status_mov=cont.id_status_mov;
end if;
else
--dbms_output.put_line ('Folio: '|| cont.receipt_number ||' DIFERENTE, FLUJO->'||importe_b ||' AR->'||(cont.base+cont.iva));
null;
end if;
end if;
--eliminar linea original si activyty + iva suman el total
if total=0 then
delete from fecxc.fecxp_ingresos_clasif f
where f.folio_set =cont.receipt_number
and f.id_status_mov=cont.id_status_mov
and f.cla_fe_id='ING01';
end if;
--|--dbms_output.put_line ('Termina Correctamente '|| cont.receipt_number);
exception
when no_data_found then
--dbms_output.put_line ('Folio: '|| cont.receipt_number ||' No Existe');
null;
when others then
--dbms_output.put_line ('->'|| cont.receipt_number ||'<-'||sqlerrm);
null;
end;
--dbms_output.put_line ('No se le hizo nada el folio');
end loop;
if COALESCE(array_length(rec_t_c2_d_tmp, 1), 0) != 0 then
FOR z IN array_lower(rec_t_c2_d_tmp, 1) .. array_upper(rec_t_c2_d_tmp, 1)
LOOP
insert into fecxc.fecxp_ingresos_clasif
values rec_t_c2_d_tmp[z];
END LOOP;
rec_t_c2_d_tmp := rec_t_c2_d_tmp_del_temp;
--/* commit; */
end if;
lin_aux := 0;
/* commit; */
--dbms_output.put_line ('Termina Correctamente ');
exception
when others then
err_num := sqlstate;
err_msg := oracle.substr(sqlerrm, 1, 100);/* dmap converted statement start */
raise exception '%',  concat('', to_char(err_num), ' ', err_msg)  using errcode = '45000';/* dmap converted statement end */end;
$body$
language plpgsql
;
