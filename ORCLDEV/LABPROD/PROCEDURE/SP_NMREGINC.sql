create or replace procedure labprod."sp_nmreginc"  (pn_key_emp numeric, ps_tip_inc varchar, pn_num_dias numeric, pd_fecha_inicial timestamp(0)) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wd_fec_fin timestamp(0);
wn_id numeric;
q_inicio record;
begin
wd_fec_fin := pd_fecha_inicial + pn_num_dias - 1;
wn_id := 0;
for q_inicio in (select id
from tvpbincc
where inc_keyemp = pn_key_emp
and inc_tipinc = ps_tip_inc
and ((inc_fecini::numeric - 1 <= pd_fecha_inicial and inc_fecfin + 1 >= pd_fecha_inicial)
or (inc_fecfin + 1 <= wd_fec_fin and inc_fecini::numeric - 1 >= wd_fec_fin))) loop
wn_id := q_inicio.id;
exit;
end loop;
if wn_id = 0 then
insert into tvpbincc(inc_keyemp,inc_diainc,inc_tipinc,inc_fecini,inc_fecfin,inc_fecmod)
values (pn_key_emp,pn_num_dias,ps_tip_inc,pd_fecha_inicial, pd_fecha_inicial + pn_num_dias -1,clock_timestamp());
else
update tvpbincc set inc_fecini = case when inc_fecini > pd_fecha_inicial then pd_fecha_inicial else inc_fecini end,
inc_fecfin = case when inc_fecfin < wd_fec_fin then wd_fec_fin else inc_fecini end,
inc_diainc = (case when inc_fecfin < wd_fec_fin then wd_fec_fin else inc_fecini end) -(case when inc_fecini::numeric > pd_fecha_inicial then pd_fecha_inicial else inc_fecini::numeric end)  + 1,
inc_fecmod = clock_timestamp()
where id = wn_id;
end if;end;
$body$
language plpgsql
;
