create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_matloc_fun ( p_id_solicitud integer, p_linea integer ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_matloc         varchar(3);
v_mat_from       varchar(3);
v_mat_canal      varchar(3);
v_mat_default    varchar(3);
v_mat_count      integer;
v_mat_null       varchar(3);
v_fza_ventas     varchar(10);
v_advid          varchar(15);
v_version        varchar(30);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select ident_fza_ventas,
coalesce(matloc_null,'0'),
matloc_busqueda,
case matloc_busqueda
when 'FV' then matloc
else oracle.substr(d.stnid,1,2)
end,
matloc,
e.advid,
d.version
into strict   v_fza_ventas,
v_mat_null,
v_mat_from,
v_mat_canal,
v_mat_default,
v_advid,
v_version
from   xxmor_solicitudes_enc_tab e,
xxmor_solicitudes_det_tab d,
xxmor_fzas_vtas_tab       f
where  e.id_solicitud  = p_id_solicitud
and    d.linea         = p_linea
and    e.id_solicitud  = d.id_solicitud
and    e.id_fza_ventas = f.id_fza_ventas;/* dmap converted statement start */
if v_fza_ventas in ('PNAL', 'JC', 'NL') then
perform dbms_output.put_line( concat(' --V_FZA_VENTAS: ', v_fza_ventas)  );/* dmap converted statement end */
--revisamos que el matloc por canal exista
select count(1)
into strict   v_mat_count
from   paradb.matasn__ordunidb2
where  advid     = v_advid
and    extcpynum = v_version
and    matloc    = v_mat_canal;/* dmap converted statement start */
--si el matloc por canal no existe entonces matloc = default
-- if v_mat_count = 0 and v_mat_canal != jc and v_mat_canal != nl then cambio 28may2013 manejo matloc null pnal
if v_mat_count = 0 then
perform dbms_output.put_line( concat(' --mat_count=0: ', v_fza_ventas)  );/* dmap converted statement end */
if v_mat_canal not in ('JC','NL') then
select count(1)
into strict   v_mat_count
from   paradb.matasn__ordunidb2
where  advid     = v_advid
and    extcpynum = v_version
and    matloc    = v_mat_default;
if v_mat_count = 0 then
v_matloc := null;
else
v_matloc := v_mat_default;
end if;
else -- es jc o nl
if v_mat_null = '1' then
v_matloc := null;
else
--  este -1 debe interpretarse como un error
v_matloc := '-1';
end if;
end if;
--si matloc por canal existe, se pone el matloc_canal
else
v_matloc := v_mat_canal;
end if;/* dmap converted statement start */
--no es de provincia y matloc canal y default son iguales
elsif v_mat_canal = v_mat_default then
perform dbms_output.put_line( concat(' --Matloc default y canal iguales: ', v_mat_canal , ' - ' , v_mat_default)  );/* dmap converted statement end */
v_matloc := v_mat_default;
--solo para ver si existe
select count(1)
into strict   v_mat_count
from   paradb.matasn__ordunidb2
where  advid     = v_advid
and    extcpynum = v_version
and    matloc    = v_mat_default;/* dmap converted statement start */
else
perform dbms_output.put_line( concat(' --Matloc default  canal diferentes: ', v_mat_canal , ' - ' , v_mat_default)  );/* dmap converted statement end */
--revisamos que el matloc por canal exista
select count(1)
into strict   v_mat_count
from   paradb.matasn__ordunidb2
where  advid     = v_advid      -- del encabezado de la orden
and    extcpynum = v_version    -- de la linea
and    matloc    = v_mat_canal; -- de la configuracion de fv
/* dmap converted statement start */
--si el matloc por canal no existe tomamos el matloc default
if v_mat_count = 0 then
perform dbms_output.put_line( concat(' --Matloc count (matloc por canal no existe): ', v_mat_count)  );/* dmap converted statement end */
select count(1)
into strict   v_mat_count
from   paradb.matasn__ordunidb2
where  advid     = v_advid        -- del encabezado de la orden
and    extcpynum = v_version      -- de la linea
and    matloc    = v_mat_default; -- de la configuracion de fv
/* dmap converted statement start */
if v_mat_count > 0 then
perform dbms_output.put_line( concat(' --Matloc count (matloc por default  existe): ', v_mat_count)  );/* dmap converted statement end */
v_matloc := v_mat_default;/* dmap converted statement start */
else
perform dbms_output.put_line( concat(' --Matloc count (matloc por default  NO existe): ', v_mat_count)  );/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat(' --fv permite matloc null): ', v_mat_null)  );/* dmap converted statement end */
if v_mat_null = '1' then
v_matloc := null;
else
--  este -1 debe interpretarse como un error
v_matloc := '-1';
end if;
end if;/* dmap converted statement start */
else
--si matloc por canal existe, se pone el mismo
perform dbms_output.put_line( concat(' --Matloc canal si existe: ', v_mat_count)  );/* dmap converted statement end */
v_matloc := v_mat_canal;
end if;
end if;
return v_matloc;end;
$body$
language plpgsql
;
