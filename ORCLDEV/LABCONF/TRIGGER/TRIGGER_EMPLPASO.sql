CREATE OR REPLACE EDITIONABLE TRIGGER "LABCONF"."TRIGGER_EMPLPASO" 
before insert on LABCONF.emplpaso
for each row
begin
select sequ_emplpaso.nextval into :new.ora_noctvo from dual;
end;




/
ALTER TRIGGER "LABCONF"."TRIGGER_EMPLPASO" ENABLE;
