CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABPROD"."TRIGGER_PLZAPASO" 
before insert on LABPROD.plzapaso
for each row
begin
select sequ_plzapaso.nextval into :new.ora_noctvo from dual;
end;




/
ALTER TRIGGER "LABPROD"."TRIGGER_PLZAPASO" ENABLE;
