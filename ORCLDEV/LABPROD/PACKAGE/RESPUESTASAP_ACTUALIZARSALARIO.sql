create or replace procedure labprod.respuestasap_actualizarsalario ( emp_keyemp numeric, new_salmes numeric, new_salint numeric, new_salivc numeric, new_salinf numeric, new_intsin numeric, new_infsin numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
dia numeric;
hora numeric;
diaant numeric;
horaant numeric;
mesant numeric;
emp_salivc numeric;
emp_salinf numeric;
emp_intsin numeric;
emp_infsin numeric;
emp_tipmov varchar(2);
unijor numeric;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
dia :=  (new_salmes / 30);
select emp_salmes,emp_unijor
into strict   mesant,unijor
from nmcoempl where nmcoempl.emp_keyemp = actualizarsalario.emp_keyemp;/* dmap converted statement start */
perform dbms_output.put_line( concat('MESANT', mesant)) ;/* dmap converted statement end */
if mesant != new_salmes then
update labprod.nmcoempl set
emp_antmes = emp_salmes , emp_salmes = new_salmes,
emp_antint = emp_salint, emp_salint = new_salint,
emp_antivc = emp_salivc, emp_salivc = new_salivc,
emp_antinf = emp_salinf, emp_salinf = new_salinf,
emp_antits = emp_intsin, emp_intsin = new_intsin,
emp_antifs = emp_infsin, emp_infsin = new_infsin,
emp_antdia = round((emp_saldia)::numeric,4), emp_saldia = round((dia)::numeric,4),
emp_anthor = (emp_salhor), emp_salhor = round((dia/emp_unijor)::numeric,4)
where emp_keyemp = actualizarsalario.emp_keyemp;
/* commit; */
end if;end;
$body$
language plpgsql
;
