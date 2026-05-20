CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABPROD"."TRIGGER_SIPS_PUES" 
before insert on LABPROD.com_orac_sips_pues
for each row
begin
select sips_pues.nextval into :new.ora_noctvo from dual;
end;




/
ALTER TRIGGER "LABPROD"."TRIGGER_SIPS_PUES" ENABLE;
