create or replace  function  labprod.tvcdesaf_local_existe_periodo ( empl TVCDESAF_LOCAL_empleado ) returns TVCDESAF_LOCAL_periodo as $body$
declare
-- pgv moved types start
--dmap moved type current package tvcdesaf_local;
--dmap moved type current package tvcdesaf_local;
v_periodo   TVCDESAF_LOCAL_periodo;
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
peract_temp varchar;
porcen_temp numeric;
cuofij_temp numeric;
totafi_temp numeric;
capdes_temp numeric;
fecini_temp timestamp(0);
keypre_temp numeric;
impdes_temp numeric;
total_temp numeric;
perini_temp varchar;
impdes_validado_temp numeric;
prueba_temp numeric;
--dmap conversion comment: declaration boundary ends
q_periodo record;
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVCDESAF_LOCAL');
--dmap conversion comment: gtt declaration added
select pro_diaper into strict v_periodo.diaper
from labprod.nmloproc where pro_keypro = empl.keypro;
if v_periodo.diaper = 7 then v_periodo.cvecal := 'CPS';
elsif v_periodo.diaper = 10 then v_periodo.cvecal := 'CPD';
elsif v_periodo.diaper = 15 then v_periodo.cvecal := 'CPQ';
end if;    --pasar??a algo distinto de 7,10,15?
for q_periodo in
(select pam_nompar, pam_folini, pam_folfin from labprod.glcopams where pam_keypar = v_periodo.cvecal
and pam_nompar = (select min(per_keyper) from labprod.nmloperi where per_keypro = empl.keypro and per_keynom in ( 1, 26 ) and nullif(per_fecact::text, '') is null))
loop
v_periodo.period := q_periodo.pam_nompar;
v_periodo.fecini := q_periodo.pam_folini;
v_periodo.fecfin := q_periodo.pam_folfin;
exit;
end loop;
return v_periodo;end;
$body$
language plpgsql
;
