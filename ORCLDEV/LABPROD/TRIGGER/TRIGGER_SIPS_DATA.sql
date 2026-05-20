CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABPROD"."TRIGGER_SIPS_DATA" 
before insert on LABPROD.com_orac_sips_data
for each row
begin
select sips_data.nextval into :new.ora_noctvo from dual;
end;




/
ALTER TRIGGER "LABPROD"."TRIGGER_SIPS_DATA" ENABLE;
