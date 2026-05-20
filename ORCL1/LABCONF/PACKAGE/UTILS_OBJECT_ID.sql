create or replace  function  labconf.utils_object_id (objectref varchar) returns integer as $body$
declare
ownername  varchar(128);
objectname varchar(128);
objectid   integer;
begin 

if ( position('.' in objectref) = 0 )then
ownername             := null;
objectname            := objectref;
else
ownername  := oracle.substr(objectref,0,position('.' in objectref)-1);
objectname := oracle.substr(objectref,position('.' in objectref)  +1);
end if;
begin
select object_id
into strict objectid
from dmap_all_objects
where upper(owner)     = upper(coalesce(ownername,owner))
and  upper(object_name) = upper(objectname);
exception when others then objectid := null;
end;
return objectid;end;
$body$
language plpgsql
stable;
