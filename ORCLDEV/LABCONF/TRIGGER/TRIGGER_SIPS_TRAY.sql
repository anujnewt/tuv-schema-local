CREATE OR REPLACE EDITIONABLE TRIGGER "LABCONF"."TRIGGER_SIPS_TRAY" 
before insert on LABCONF.com_orac_sips_tray
for each row
begin
select sips_tray.nextval into :new.ora_noctvo from dual;
end;




/
ALTER TRIGGER "LABCONF"."TRIGGER_SIPS_TRAY" ENABLE;
