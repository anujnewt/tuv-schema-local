create or replace  function  xxmor."xxmor_existe_fza_vtas_array_fn"  ( p_i_id_fza_vtas numeric, ap_i_agrupador array_tvch2, top_agrupador numeric, ap_i_region array_tvch2, top_region numeric, ap_i_sufijo array_tvch2, top_sufjo numeric, ap_i_accthdrid array_tvch2, top_accthdrid numeric, ap_i_tipo_serv array_tvch2, top_tipo_serv numeric, p_i_inclusion numeric ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
userchar varchar(5);
spotchar varchar(5);
response numeric;
resultado varchar(10000);
valfzaventas  varchar(10000);
begin
resultado := null;
for i in 1..top_agrupador loop
for j in 1..top_region loop
for k in 1..top_sufjo loop
for l in 1..top_accthdrid loop
for m in 1..top_tipo_serv loop
userchar := xxmor_get_userspot_fn(ap_i_tipo_serv(m),1,'|');
spotchar := xxmor_get_userspot_fn(ap_i_tipo_serv(m),2,'|');
select xxmor_existe_fza_vtas_fn(p_i_id_fza_vtas,
ap_i_agrupador(i),
ap_i_region(j),
ap_i_sufijo(k),
ap_i_accthdrid(l),
userchar,
spotchar,
p_i_inclusion)
into strict response
;
if (response <> 0) then
if (response <> p_i_id_fza_vtas) then
select trim(both nombre_fza_ventas)
into strict valfzaventas
from xxmor_fzas_vtas_tab
where id_fza_ventas=response;/* dmap converted statement start */
resultado :=   concat(resultado, 'Fuerza de Ventas [', valfzaventas, ']# Agrupador[', ap_i_agrupador(i), ']# Prefijo[', ap_i_region(j), ']# Sufijo[', ap_i_sufijo(k), ']# AccHdr[', ap_i_accthdrid(l), ']# UserChar[', userchar, ']# SpotChar[', spotchar, ']# Inclusion[', p_i_inclusion, ']|') ;/* dmap converted statement end */
end if;
end if;
end loop;
end loop;
end loop;
end loop;
end loop;
return resultado;
exception
when no_data_found then
return null;end;
--dmap converted function completed
$body$
language plpgsql
stable;
