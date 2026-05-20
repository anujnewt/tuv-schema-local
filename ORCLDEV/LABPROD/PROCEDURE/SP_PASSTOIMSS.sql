CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_PASSTOIMSS" IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  insert into nmlopas
  select emp_keyemp, substr(emp_regims,8,4)
       from nmcoempl
          where emp_status = 1
            and emp_keypro <> 6
            and emp_keyemp not in (select pas_keyemp from nmlopas)
            and emp_keyemp not in (select pas_keyemp from pasexep);
end;
/
