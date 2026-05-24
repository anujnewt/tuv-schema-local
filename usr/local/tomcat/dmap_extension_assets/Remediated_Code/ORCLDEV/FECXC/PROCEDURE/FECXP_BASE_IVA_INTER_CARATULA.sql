create or replace procedure fecxc."fecxp_base_iva_inter_caratula"  (v_mes integer, periodo varchar) as $body$
declare

    rec_t_c1_d_tmp_del_temp fecxc.fecxp_ingresos_caratula_d_tmp[];
-- pgv moved types start
-- pgv moved types end
c_ingresos_ar cursor for select folio_set, sum(aplicado) aplicado, sum(base) base, sum(iva) iva, id_status_mov
from (select   acra.receipt_number as folio_set,
coalesce(sum(araa.amount_applied), 0) aplicado,
coalesce(sum(araa.line_applied), 0) base,
coalesce(sum(araa.tax_applied), 0) iva, fde.id_status_mov
from ar.ar_cash_receipts_all__erp_prod acra,
apps.ar_receivable_applications_all__erp_prod araa,
(select distinct folio_set, id_status_mov
from fecxc.fecxp_ingresos_caratula_d_tmp fde
where fde.tipo_operacion in (3700, 3701, 3705, 3706, 3708, 3715,
4102, 4103)
and to_char(fecha, 'YYYY') =periodo
and (to_char(fecha, 'MM'))::numeric  >=
v_mes) fde
where 1 = 1
and to_char(fde.folio_set) = acra.receipt_number
and acra.cash_receipt_id = araa.cash_receipt_id
and acra.org_id = araa.org_id
and araa.status != 'UNAPP'
and araa.display = 'Y'
group by acra.receipt_number, fde.id_status_mov
union all
select   acra.receipt_number as folio_set,
coalesce(sum(araa.amount_applied), 0) aplicado,
coalesce(sum(araa.line_applied), 0) base,
coalesce(sum(araa.tax_applied), 0) iva, fde.id_status_mov
from ar.ar_cash_receipts_all__erp_prod acra,
apps.ar_receivable_applications_all__erp_prod araa,
(select distinct folio_set, id_status_mov
from fecxc.fecxp_ingresos_caratula_d_tmp fde
where fde.tipo_operacion in (3700, 3701, 3705, 3706, 3708, 3715,
4102, 4103)
and to_char(fecha, 'YYYY') = periodo
and (to_char(fecha, 'MM'))::numeric  >=
v_mes) fde
where 1 = 1
and to_char(fde.folio_set) = acra.receipt_number
and acra.cash_receipt_id = araa.cash_receipt_id
and acra.org_id = araa.org_id
and araa.status = 'UNAPP'
group by acra.receipt_number, fde.id_status_mov) alias27
group by folio_set,id_status_mov
order by folio_set;
c_ingresos_flujo cursor(v_folio_cur integer,v_id_estatus varchar) for
select oid as numlinea,importe,importe_linea from fecxp_ingresos_caratula_d_tmp where folio_set=v_folio_cur and id_status_mov=v_id_estatus;
--v_folio           varchar (20);
v_importe         decimal(20,2); ---almacena el importe original
-- variables para el iva
v_cla_fe_id  varchar(25);
v_cla_fe_des varchar(50);
v_cia        varchar(25);
v_neg        varchar(25);
v_cta        varchar(25);
v_scta       varchar(25);
v_cc         varchar(25);
v_icia       varchar(25);
v_top        varchar(25);
total numeric;
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
--  variables para el manejo de errores
err_num text;
err_msg varchar(100);
/*  */
rec_t_c1_d_tmp fecxc.fecxp_ingresos_caratula_d_tmp[];
lin_aux integer:=0;
begin 

select cla_fe_id, cla_fe_des, cia, neg, cta, scta, cc, icia, top
into strict v_cla_fe_id, v_cla_fe_des, v_cia, v_neg, v_cta, v_scta, v_cc, v_icia, v_top
from fecxc.fecxp_iva_interempresas_tbl;
select cla_fe_id, cla_fe_des, cia, neg, cta, scta, cc, icia, top
into strict v_cla_fe_id2, v_cla_fe_des2, v_cia2, v_neg2, v_cta2, v_scta2, v_cc2, v_icia2, v_top2
from fecxc.fecxp_iva_inter_activity_tbl;
--buscar en ar los folios que se encuentren en flujo
lin_aux :=0;
for cont in c_ingresos_ar
loop
begin
--se busca el importe en flujo, ojo: tiene que ser el importe exactamente igual y el mismo id de estatus
select importe into strict v_importe from fecxc.fecxc_dep_especiales fde where fde.id_status_mov=cont.id_status_mov and no_folio_det =  cont.folio_set;
total:=abs(v_importe);
/*---------------------------------------------------------------------------------------------------------------------*/
--si vienen montos negativos dejar el folio tal como esta
if (cont.aplicado<0) or (cont.base<0) or (cont.iva <0) then
null;--no se hace nada
else
--revisa que flujo cuadre contra ar
if ((abs(v_importe) - abs(cont.aplicado)) between -0.10 and 0.10) or ((abs(v_importe) - abs(cont.iva+cont.base)) between -0.10 and 0.10)then
--dbms_output.put_line ('FOLIO:'||cont.folio_set);
--dbms_output.put_line ('Importe del Folio:$ '||v_importe||'Base:$ '|| cont.base||' IVA:$ '||cont.iva ||' Activity:$ '||(abs(cont.aplicado)-(abs(cont.base)+abs(cont.iva))));
--dbms_output.put_line (','||cont.receipt_number);
--revisar en flujo  si existe base, iva u otro
if ((abs(v_importe) - abs(cont.base)) between -0.10 and 0.10) then
--el registro existente es la base
--dbms_output.put_line ('Actualiza la Base por'||cont.base);
null;
elsif ((abs(v_importe) - abs(cont.iva)) between -0.10 and 0.10) then
--el registro existente es el iva
update  fecxc.fecxp_ingresos_caratula_d_tmp f
set  cla_fe_id=v_cla_fe_id,
ora_soin_segmento1= case when v_cia  ='$' then ora_soin_segmento1 else v_cia end,
ora_soin_segmento2= case when v_neg  ='$' then ora_soin_segmento2 else v_neg end,
ora_soin_segmento3= case when v_cta  ='$' then ora_soin_segmento3 else v_cta end,
oracle_segmento4=   case when v_scta ='$' then oracle_segmento4   else v_scta end,
oracle_segmento5=   case when v_cc   ='$' then oracle_segmento5   else v_cc end,
oracle_segmento6=   case when v_icia ='$' then oracle_segmento6   else v_icia end,
oracle_segmento7=   case when v_top  ='$' then oracle_segmento7   else v_top end
where f.folio_set =cont.folio_set
and f.id_status_mov=cont.id_status_mov;
total:=total-abs(cont.iva);
--dbms_output.put_line ('Actualiza el IVA por'||cont.iva);
elsif ((abs(v_importe) - (abs(cont.aplicado)-(abs(cont.iva)+abs(cont.base)))) between -0.10 and 0.10) then
--el registro existente es el activity
update  fecxc.fecxp_ingresos_caratula_d_tmp f
set  cla_fe_id=v_cla_fe_id2,
ora_soin_segmento1= case when v_cia2  ='$' then ora_soin_segmento1 else v_cia2 end,
ora_soin_segmento2= case when v_neg2  ='$' then ora_soin_segmento2 else v_neg2 end,
ora_soin_segmento3= case when v_cta2  ='$' then ora_soin_segmento3 else v_cta2 end,
oracle_segmento4  = case when v_scta2 ='$' then oracle_segmento4   else v_scta2 end,
oracle_segmento5  = case when v_cc2   ='$' then oracle_segmento5   else v_cc2 end,
oracle_segmento6  = case when v_icia2 ='$' then oracle_segmento6   else v_icia2 end,
oracle_segmento7  = case when v_top2  ='$' then oracle_segmento7   else v_top2 end
where f.folio_set =cont.folio_set
and f.id_status_mov=cont.id_status_mov;
total:=total-abs(cont.aplicado);
--dbms_output.put_line ('Actualiza el ACTIVITY por'||cont.aplicado);
end if;
--si el registro en flujo es igual que la suma de ar aperturar
if (((abs(v_importe) - (abs(cont.iva)+abs(cont.base))) between -0.10 and 0.10) or ((abs(v_importe) - (abs(cont.aplicado))) between -0.10 and 0.10)) and total !=0 then
--si existe registro de base actualizar el existente
if  cont.base!=0 then
update  fecxc.fecxp_ingresos_caratula_d_tmp f
set  importe_linea=case when upper(f.id_status_mov) = 'X' then ((cont.base)*(-1)) else cont.base end
,    tipo_clasificacion='APERTURA ING ICIAS'
where f.folio_set =cont.folio_set
and f.id_status_mov=cont.id_status_mov;
end if;
--si existe el iva crear la linea
if cont.iva != 0 then
select array_append(rec_t_c1_d_tmp, null) into rec_t_c1_d_tmp;
lin_aux := lin_aux+1;
select     v_cla_fe_id, f.e_codigo,
f.folio_set,
f.tipo_operacion,
f.fecha, f.moneda,
case when upper(f.id_status_mov) = 'X' then ((-1)*(cont.iva)) else cont.iva end, f.id_banco,
f.id_chequera,
f.referencia,
cont.iva,
case when v_cia  ='$' then f.ora_soin_segmento1  else v_cia  end,
case when v_neg  ='$' then f.ora_soin_segmento2  else v_neg  end,
case when v_cta  ='$' then f.ora_soin_segmento3  else v_cta  end,
case when v_scta ='$' then f.oracle_segmento4    else v_scta end,
case when v_cc   ='$' then f.oracle_segmento5    else v_cc   end,
case when v_icia ='$' then f.oracle_segmento6    else v_icia end,
case when v_top  ='$' then f.oracle_segmento7    else v_top  end,
f.cual_erp,
'APERTURA ING ICIAS',
f.id_status_mov
into strict rec_t_c1_d_tmp[lin_aux].cla_fe_id, rec_t_c1_d_tmp[lin_aux].e_codigo,
rec_t_c1_d_tmp[lin_aux].folio_set,
rec_t_c1_d_tmp[lin_aux].tipo_operacion,
rec_t_c1_d_tmp[lin_aux].fecha, rec_t_c1_d_tmp[lin_aux].moneda,
rec_t_c1_d_tmp[lin_aux].importe, rec_t_c1_d_tmp[lin_aux].id_banco,
rec_t_c1_d_tmp[lin_aux].id_chequera,
rec_t_c1_d_tmp[lin_aux].referencia,
rec_t_c1_d_tmp[lin_aux].importe_linea,
rec_t_c1_d_tmp[lin_aux].ora_soin_segmento1,
rec_t_c1_d_tmp[lin_aux].ora_soin_segmento2,
rec_t_c1_d_tmp[lin_aux].ora_soin_segmento3,
rec_t_c1_d_tmp[lin_aux].oracle_segmento4,
rec_t_c1_d_tmp[lin_aux].oracle_segmento5,
rec_t_c1_d_tmp[lin_aux].oracle_segmento6,
rec_t_c1_d_tmp[lin_aux].oracle_segmento7,
rec_t_c1_d_tmp[lin_aux].cual_erp,
rec_t_c1_d_tmp[lin_aux].tipo_clasificacion,
rec_t_c1_d_tmp[lin_aux].id_status_mov
from fecxc.fecxp_ingresos_caratula_d_tmp f
where folio_set = cont.folio_set
and f.id_status_mov=cont.id_status_mov;
total:=total-abs(cont.iva);
--dbms_output.put_line ('Crea Iva por'||cont.iva);
end if;
--si existe el activity crear la linea
if abs(cont.aplicado)-(abs(cont.base)+abs(cont.iva)) != 0 then
select array_append(rec_t_c1_d_tmp, null) into rec_t_c1_d_tmp;
lin_aux := lin_aux+1;
select  v_cla_fe_id2, f.e_codigo, f.folio_set,   f.tipo_operacion, f.fecha, f.moneda, cont.iva, f.id_banco, f.id_chequera,
f.referencia, case when upper(f.id_status_mov) = 'X' then ((-1)*((abs(cont.aplicado) - (abs(cont.iva)+abs(cont.base))))) else (abs(cont.aplicado) - (abs(cont.iva)+abs(cont.base))) end,
case when v_cia2 ='$' then f.ora_soin_segmento1  else v_cia2 end,
case when v_neg2  ='$' then f.ora_soin_segmento2 else v_neg2 end,
case when v_cta2  ='$' then f.ora_soin_segmento3 else v_cta2 end,
case when v_scta2 ='$' then f.oracle_segmento4   else v_scta2 end,
case when v_cc2   ='$' then f.oracle_segmento5   else v_cc2 end,
case when v_icia2 ='$' then f.oracle_segmento6   else v_icia2 end,
case when v_top2  ='$' then f.oracle_segmento7   else v_top2 end,
f.cual_erp, f.tipo_clasificacion, f.id_status_mov
into strict rec_t_c1_d_tmp[lin_aux].cla_fe_id, rec_t_c1_d_tmp[lin_aux].e_codigo, rec_t_c1_d_tmp[lin_aux].folio_set,   rec_t_c1_d_tmp[lin_aux].tipo_operacion, rec_t_c1_d_tmp[lin_aux].fecha, rec_t_c1_d_tmp[lin_aux].moneda, rec_t_c1_d_tmp[lin_aux].importe, rec_t_c1_d_tmp[lin_aux].id_banco, rec_t_c1_d_tmp[lin_aux].id_chequera,
rec_t_c1_d_tmp[lin_aux].referencia, rec_t_c1_d_tmp[lin_aux].importe_linea, rec_t_c1_d_tmp[lin_aux].ora_soin_segmento1, rec_t_c1_d_tmp[lin_aux].ora_soin_segmento2, rec_t_c1_d_tmp[lin_aux].ora_soin_segmento3, rec_t_c1_d_tmp[lin_aux].oracle_segmento4,
rec_t_c1_d_tmp[lin_aux].oracle_segmento5, rec_t_c1_d_tmp[lin_aux].oracle_segmento6, rec_t_c1_d_tmp[lin_aux].oracle_segmento7, rec_t_c1_d_tmp[lin_aux].cual_erp, rec_t_c1_d_tmp[lin_aux].tipo_clasificacion, rec_t_c1_d_tmp[lin_aux].id_status_mov
from fecxc.fecxp_ingresos_caratula_d_tmp f
where folio_set=cont.folio_set
and f.id_status_mov=cont.id_status_mov;
--dbms_output.put_line ('Crea Activity por'|| (abs(cont.aplicado) - (abs(cont.iva)+abs(cont.base))));
total:=total-(abs(cont.aplicado) - (abs(cont.iva)+abs(cont.base)));
end if;
end if;
else
--dbms_output.put_line ('Folio: '|| cont.receipt_number ||' DIFERENTE, FLUJO->'||v_importe ||' AR->'||(cont.base+cont.iva));
null;
end if;
end if;
--|--dbms_output.put_line ('Termina Correctamente '|| cont.receipt_number);
--eliminar linea original si activyty + iva suman el total
if total=0 then
delete from fecxc.fecxp_ingresos_caratula_d_tmp f
where f.folio_set=cont.folio_set
and f.id_status_mov=cont.id_status_mov
and f.cla_fe_id='ING01';
end if;
exception
when no_data_found then
--dbms_output.put_line ('Folio: '|| cont.receipt_number ||' No Existe');
null;
when others then
--dbms_output.put_line ('->'|| cont.receipt_number ||'<-'||sqlerrm);
null;
end;
perform dbms_output.put_line('No se le hizo nada el folio');
end loop;
if COALESCE(array_length(rec_t_c1_d_tmp, 1), 0) != 0 then
FOR z IN array_lower(rec_t_c1_d_tmp, 1) .. array_upper(rec_t_c1_d_tmp, 1)
LOOP
insert into fecxc.fecxp_ingresos_caratula_d_tmp
values (rec_t_c1_d_tmp[z]);
END LOOP;
rec_t_c1_d_tmp := rec_t_c1_d_tmp_del_temp;
--/* commit; */
end if;
lin_aux := 0;
--dbms_output.put_line ('Termina Correctamente ');
exception
when others then
err_num := sqlstate;
err_msg := substring(sqlerrm from 1 for 100);/* dmap converted statement start */
raise exception '%',  concat('', err_num, ' ', err_msg)  using errcode = '45000';/* dmap converted statement end */end;
$body$
language plpgsql
;
