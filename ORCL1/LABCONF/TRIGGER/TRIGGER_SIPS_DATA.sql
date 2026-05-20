CREATE OR REPLACE NONEDITIONABLE TRIGGER "LABCONF"."TRIGGER_SIPS_DATA" 
before insert on LABCONF.com_orac_sips_data
for each row
begin
select sips_data.nextval into :new.ora_noctvo from dual;
end;



/
ALTER TRIGGER "LABCONF"."TRIGGER_SIPS_DATA" ENABLE;
