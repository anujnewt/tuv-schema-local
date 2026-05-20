create or replace  function  xxmor."xxmor_insert_iden_fza_vtas_fn"  ( id_seg_neg numeric, id_fza_vtas numeric, ap_i_agrupador array_tvch2, top_agrupador numeric, ap_i_region array_tvch2, top_region numeric, ap_i_sufijo array_tvch2, top_sufijo numeric, ap_i_complem array_tvch2, top_complem numeric, ap_i_accthdrid array_tvch2, top_accthdrid numeric, ap_i_tipo_serv array_tvch2, top_tipo_serv numeric, p_i_inclusion numeric ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
userchar varchar(2);
spotchar varchar(2);
resultado numeric;
begin
resultado := 1;
delete from xxmor_fzas_vtas_ident_tab where id_fza_ventas = id_fza_vtas;
/* commit; */
-- insertar agrupador --------
if (top_agrupador>0) then
for i in 1..top_agrupador loop
if (nullif(ap_i_agrupador(i)::text, '') is not null) then
insert into xxmor_fzas_vtas_ident_tab values (id_seg_neg,id_fza_vtas, 'G' ,ap_i_agrupador(i));
end if;
end loop;
/* commit; */
end if;
-- insertar prefijos --------
if (top_region>0) then
for i in 1..top_region loop
if (nullif(ap_i_region(i)::text, '') is not null) then
insert into xxmor_fzas_vtas_ident_tab values (id_seg_neg,id_fza_vtas, 'P' ,ap_i_region(i));
end if;
end loop;
/* commit; */
end if;
-- insertar sufijos --------
if (top_sufijo>0) then
for i in 1..top_sufijo loop
if (nullif(ap_i_sufijo(i)::text, '') is not null) then
insert into xxmor_fzas_vtas_ident_tab values (id_seg_neg,id_fza_vtas, 'S' ,ap_i_sufijo(i));
end if;
end loop;
/* commit; */
end if;
-- insertar complementos --------
if (top_complem>0) then
for i in 1..top_complem loop
if (nullif(ap_i_complem(i)::text, '') is not null) then
insert into xxmor_fzas_vtas_ident_tab values (id_seg_neg,id_fza_vtas, 'C' ,ap_i_complem(i));
end if;
end loop;
/* commit; */
end if;
-- insertar account --------
if (top_accthdrid>0) then
for i in 1..top_accthdrid loop
if (nullif(ap_i_accthdrid(i)::text, '') is not null) then
insert into xxmor_fzas_vtas_ident_tab values (id_seg_neg,id_fza_vtas, 'A' ,ap_i_accthdrid(i));
end if;
end loop;
/* commit; */
end if;
-- insertar tipo servicio --------
delete from xxmor_conf_tipo_srv_tab where id_fza_ventas = id_fza_vtas;
/* commit; */
if (top_tipo_serv>0) then
for i in 1..top_tipo_serv loop
if (nullif(ap_i_tipo_serv(i)::text, '') is not null) then
userchar := xxmor_get_userspot_fn(ap_i_tipo_serv(i),1,'|');
spotchar := xxmor_get_userspot_fn(ap_i_tipo_serv(i),2,'|');
insert into xxmor_conf_tipo_srv_tab values (id_seg_neg,id_fza_vtas, nextval('xxmor_id_tiposervicio_sq'), p_i_inclusion,spotchar,userchar);
end if;
end loop;
/* commit; */
end if;
return resultado;
exception
when others then
return 0;end;
--dmap converted function completed
$body$
language plpgsql
;
