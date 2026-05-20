CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABPROD"."TRIGGER_SIPS_DEPS" 
before insert on LABPROD.com_orac_sips_deps
for each row
begin
select sips_deps.nextval into :new.ora_noctvo from dual;
end;




/
ALTER TRIGGER "LABPROD"."TRIGGER_SIPS_DEPS" ENABLE;
