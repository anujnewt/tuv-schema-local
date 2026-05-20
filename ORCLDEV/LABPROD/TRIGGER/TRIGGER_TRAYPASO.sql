CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABPROD"."TRIGGER_TRAYPASO" 
before insert on LABPROD.traypaso
for each row
begin
select sequ_traypaso.nextval into :new.ora_noctvo from dual;
end;




/
ALTER TRIGGER "LABPROD"."TRIGGER_TRAYPASO" ENABLE;
