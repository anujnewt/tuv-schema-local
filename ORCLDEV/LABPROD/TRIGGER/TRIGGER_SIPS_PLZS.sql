CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABPROD"."TRIGGER_SIPS_PLZS" 
before insert on LABPROD.com_orac_sips_plzs
for each row
begin
select sips_plzs.nextval into :new.ora_noctvo from dual;
end;




/
ALTER TRIGGER "LABPROD"."TRIGGER_SIPS_PLZS" ENABLE;
