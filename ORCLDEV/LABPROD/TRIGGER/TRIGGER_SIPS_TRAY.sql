CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABPROD"."TRIGGER_SIPS_TRAY" 
before insert on LABPROD.com_orac_sips_tray
for each row
begin
select sips_tray.nextval into :new.ora_noctvo from dual;
end;




/
ALTER TRIGGER "LABPROD"."TRIGGER_SIPS_TRAY" ENABLE;
