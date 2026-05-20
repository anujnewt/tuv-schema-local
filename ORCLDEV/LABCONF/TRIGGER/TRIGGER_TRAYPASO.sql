CREATE OR REPLACE EDITIONABLE TRIGGER "LABCONF"."TRIGGER_TRAYPASO" 
before insert on LABCONF.traypaso
for each row
begin
select sequ_traypaso.nextval into :new.ora_noctvo from dual;
end;




/
ALTER TRIGGER "LABCONF"."TRIGGER_TRAYPASO" ENABLE;
