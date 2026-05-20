create or replace procedure labprod."sp_cons_empl"  (pw_keyemp nmcoempl.emp_keyemp%type, pw_nomemp inout varchar, pw_appemp inout varchar, pw_apmemp inout varchar, pw_status inout varchar, pw_despue inout varchar, pw_descia inout varchar, pw_desdep inout varchar, pw_pol_cc inout varchar, pw_error inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lw_nomemp    datosgenerales.gen_nomemp%type;
lw_apepat    datosgenerales.gen_apepat%type;
lw_apemat    datosgenerales.gen_apemat%type;
begin
--   --extraemos el nombre del empleado de la tabla datosgenerales
--   begin
--      select  gen_nomemp,
--              gen_apepat,
--              gen_apemat
--      into    lw_nomemp,
--              lw_apepat,
--              lw_apemat
--      from    datosgenerales
--      where   gen_keyemp    = pw_keyemp
--      and     rownum = 1;
--   exception
--      when no_data_found then
--         pw_error := 'NO EXISTE EL NUMERO DEL EMPLEADO [' || pw_keyemp || '] EN DATOS GENERALES';
--      when others then
--         if sqlcode = -54 then
--            pw_error := 'ERROR: EL FOLIO DEL EMPLEADO [' || pw_keyemp || '] ESTA SIENDO UTILIZADO EN OTRA SECION DE DATOSGENERALES';
--         else
--            pw_error := 'ERROR: '||sqlerrm;
--         end if;
--      return;
--   end;
--   pw_nomemp := lw_apepat || '/' || lw_apemat || '/' || lw_nomemp;
--se extraen los datos generales del empleado
begin
select replace(em.emp_nomemp, '/', '-'),
em.emp_status,
pu.pue_despue,
ci.cia_descia,
dp.dep_desdep,
--inicia mod 24-07-2017
oracle.substr(dp.dep_refcon,15,8)
--termina mod 24-07-2017
into strict   lw_nomemp,
pw_status,
pw_despue,
pw_descia,
pw_desdep,
--inicia mod 24-07-2017
pw_pol_cc
--termina mod 24-07-2017
from   labprod.nmcoempl em,
labprod.nmcopues pu,
labprod.nmloproc pr,
labprod.nmlocias ci,
labprod.nmcodeps dp
where emp_keyemp    = pw_keyemp
and   em.emp_keypue = pu.pue_keypue
and   em.emp_keypro = pr.pro_keypro
and   pr.pro_keycia = ci.cia_keycia
and   em.emp_keydep = dp.dep_keydep;
pw_appemp := oracle.substr(lw_nomemp,1,position('-' in lw_nomemp) - 1);
lw_nomemp := oracle.substr(lw_nomemp,position('-' in lw_nomemp) + 1);
pw_apmemp := oracle.substr(lw_nomemp,1,position('-' in lw_nomemp) - 1);
lw_nomemp := oracle.substr(lw_nomemp,position('-' in lw_nomemp) + 1);
pw_nomemp :=  lw_nomemp;/* dmap converted statement start */
exception
when no_data_found then
pw_error :=  concat('NO EXISTE EL NUMERO DEL EMPLEADO [', pw_keyemp , '] CON NOMBRE [' , pw_nomemp , ']') ;/* dmap converted statement end *//* dmap converted statement start */
when others then
if sqlstate = -54 then
pw_error :=  concat('ERROR: EL FOLIO DEL EMPLEADO [', pw_keyemp , '] ESTA SIENDO UTILIZADO EN OTRA SECION') ;/* dmap converted statement end *//* dmap converted statement start */
else
pw_error :=  concat('ERROR: ', sqlerrm) ;/* dmap converted statement end */
end if;
return;
end;
----se extrae el centro de costos
--inicia mod 24-07-2017
--   begin
--      select tv.pol_cc
--      into   pw_pol_cc
--      from   labprod.tvwkpoli tv
--      where  tv.pol_keyemp = pw_keyemp
--      and    tv.pol_fecmov = (
--                              select max(pol_fecmov)
--                              from   labprod.tvwkpoli tv
--                              where  tv.pol_keyemp = pw_keyemp
--                              and    tv.pol_cc <> '00000000')
--      and    tv.pol_cc <> '00000000'
--      and rownum = 1;
--   exception
--      when no_data_found then
--         pw_error := 'NO EXISTE NUMERO DE EMPLEADO [' || pw_keyemp || '], SI ERES COLABORADOR DE TELEVISA TALENTO, FAVOR DE CAPTURAR LOS DATOS.';
--      when others then
--         if sqlcode = -54 then
--            pw_error := 'ERROR: EL FOLIO DEL EMPLEADO [' || pw_keyemp || '] ESTA SIENDO UTILIZADO EN OTRA SECION';
--         else
--            pw_error := 'ERROR: '||sqlerrm;
--         end if;
--      return;
--   end;
--exception
--   when no_data_found then
--      pw_error := 'NO EXISTE NUMERO DE EMPLEADO [' || pw_keyemp || '], SI ERES COLABORADOR DE TELEVISA TALENTO, FAVOR DE CAPTURAR LOS DATOS.';
--   when others then
--      if sqlcode = -54 then
--         pw_error := 'ERROR: EL FOLIO DEL EMPLEADO [' || pw_keyemp || '] ESTA SIENDO UTILIZADO EN OTRA SECION';
--      else
--         pw_error := 'ERROR: '||sqlerrm;
--      end if;
--   return;
--termina mod 17-07-2017
end;
$body$
language plpgsql
;
