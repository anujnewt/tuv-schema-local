create or replace  function  fecxc."eul4_get_object_name"  (usekey varchar, typekey varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
oname varchar(2000);
--
-- type key is either 'F' for folder or 'I' for item.
--
--
startpt 	numeric :=1;
endpt		numeric :=length(usekey);
pos		numeric :=1;
ctr		numeric :=0;
chklgth		numeric;
objid		numeric;
aggtype		numeric;
objname	varchar(100);
--
--
folder cursor for
select obj_name
from eul4_objs
where obj_id = objid;
-- exception when others then objname := '*';
-- end;
--
--
item cursor for
select exp_name
from eul4_expressions
where exp_id = objid;
-- exception when others then objname := '*';
-- end;
--
begin
--
-- this bit works out the id's position in the string and moves down the string by looping
--
--
--
while pos <> 0 loop
aggtype:=0;
ctr:=ctr+1;
pos:=instr(usekey,'.',1,ctr);
if pos=0 then
if upper(typekey)='F' then
objid:= (oracle.substr(usekey,startpt,(endpt-startpt+1)))::numeric;
else
objid:= (oracle.substr(usekey,startpt,(endpt-startpt-1)))::numeric;
aggtype:=  (oracle.substr(usekey,endpt,1))::numeric;
end if;
else
if  upper(typekey)='F' then
objid:= (oracle.substr(usekey,startpt,(pos-startpt)))::numeric;
else
objid:= (oracle.substr(usekey,startpt,(pos-startpt-2)))::numeric;
aggtype:=  (oracle.substr(usekey,pos-1,1))::numeric;
end if;
startpt:=pos+1;
end if;
--
if upper(typekey) ='F' then
open folder;
fetch folder into objname;
-- exception when others then objname := '*';
-- end;
close folder;
end if;
--
--
if upper(typekey)='I' then
open item;
fetch item into objname;
close item;
-- exception when others then objname := '*';
-- end;
end if;
--
--
--
-- this bit builds up the string of folder names if it exceeds
-- 2000 chars it stops then places an '*' at the end.
--
if ctr=1 then
if aggtype=0 then
oname:=objname;/* dmap converted statement start */
elsif aggtype=1 then oname:= concat(objname, ' SUM') ;/* dmap converted statement end *//* dmap converted statement start */
elsif aggtype=2 then oname:= concat(objname, ' AVG') ;/* dmap converted statement end *//* dmap converted statement start */
elsif aggtype=3 then oname:= concat(objname, ' COUNT') ;/* dmap converted statement end *//* dmap converted statement start */
elsif aggtype=4 then oname:= concat(objname, ' MAX') ;/* dmap converted statement end *//* dmap converted statement start */
elsif aggtype=5 then oname:= concat(objname, ' MIN') ;/* dmap converted statement end */
else oname:=objname;
end if;
else
if aggtype=0 then
chklgth:= length(oname)+length(objname)+2;
elsif aggtype=1 then  chklgth:= length(oname)+length(objname)+6;
elsif aggtype=2 then  chklgth:= length(oname)+length(objname)+6;
elsif aggtype=3 then  chklgth:= length(oname)+length(objname)+8;
elsif aggtype=4 then  chklgth:= length(oname)+length(objname)+6;
elsif aggtype=5 then  chklgth:= length(oname)+length(objname)+6;
else chklgth:= length(oname)+length(objname)+2;
end if;/* dmap converted statement start */
if chklgth > 1999 then
oname:= concat(oname, '*') ;/* dmap converted statement end */
exit;/* dmap converted statement start */
else
if aggtype = 0 then
oname:= concat(oname, ', ', objname) ;/* dmap converted statement end *//* dmap converted statement start */
elsif aggtype=1 then oname:= concat(oname, ', ', objname, ' SUM') ;/* dmap converted statement end *//* dmap converted statement start */
elsif aggtype=2 then oname:= concat(oname, ', ', objname, ' AVG') ;/* dmap converted statement end *//* dmap converted statement start */
elsif aggtype=3 then oname:= concat(oname, ', ', objname, ' COUNT') ;/* dmap converted statement end *//* dmap converted statement start */
elsif aggtype=4 then oname:= concat(oname, ', ', objname, ' MAX') ;/* dmap converted statement end *//* dmap converted statement start */
elsif aggtype=5 then oname:= concat(oname, ', ', objname, ' MIN') ;/* dmap converted statement end *//* dmap converted statement start */
else oname:= concat(oname, ', ', objname) ;/* dmap converted statement end */
end if;
end if;
end if;
end loop;
--
--
return oname;
--
end;
--dmap converted function completed
$body$
language plpgsql
stable;
