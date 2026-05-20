CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABPROD"."TRIGGER_SIPS_EMPL" 
before insert on LABPROD.com_orac_sips_empl
for each row
begin
select sips_empl.nextval into :new.ora_noctvo from dual;
end;




/
ALTER TRIGGER "LABPROD"."TRIGGER_SIPS_EMPL" ENABLE;
