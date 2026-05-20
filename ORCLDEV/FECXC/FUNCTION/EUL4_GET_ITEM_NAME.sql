create or replace  function  fecxc."eul4_get_item_name"  (qsid numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
itmid varchar(2000):=null;
--
startpt 		integer :=1;
bmp 		bytea;
pos		integer :=0;
ctr		integer :=0;
chklgth		integer;
hexstring	varchar(10);
hexid		integer :=0;
decnibble1	numeric;
decnibble2	integer;
decnibble3	integer;
decnibble4	integer;
decnibble5	integer;
decnibble6	integer;
decnibble7	integer;
decnibble8	integer;
decnibble9	integer;
decnibble10 	integer;
hexchar		varchar(1);
expid		integer;
aggtype		integer;
nibblezero	boolean;
--
-- occasionally, due to a bug, the first 5 bytes of the string are not always populated with id of
-- the item so rather than go all the way down the string looking a every 5 bytes until it reaches
-- the end (a slow process) i count the number of empy stings i have found so far and when it
-- reaches the the value held in 'noemptyblocks'  it moves on to the next string
--
noemptyblks  	integer:=10;
--
--
--
--
-- this cursor finds the dimension values
--
dbmp cursor for
select qs_dbmp0||qs_dbmp1||qs_dbmp2||qs_dbmp3||qs_dbmp4||qs_dbmp5||qs_dbmp6||qs_dbmp7 from eul4_qpp_stats
where qs_id = qsid;
--
--
-- this cursor finds the measure values
--
mbmp cursor for
select  qs_mbmp0||qs_mbmp1||qs_mbmp2||qs_mbmp3||qs_mbmp4||qs_mbmp5||qs_mbmp6||qs_mbmp7
from eul4_qpp_stats
where qs_id = qsid;
--
--
begin
--
-- loop twice first loop deals with the dimensions values the scond with the measure values
--
for itype in 1..2 loop
if itype = 1 then
open dbmp;
else
open mbmp;
end if;
hexid:=0;
--
--
--this bit takes a five byte chunk in the string.
-- it then loops until it reaches the end of the string or it find no more values
--
while hexid <> noemptyblks loop
if itype = 1 then
fetch  dbmp into bmp;
else
fetch mbmp into bmp;
end if;
ctr:=ctr+1;
pos:=pos+10;
if pos=4090 then
hexid:= noemptyblks;
startpt:=1;
pos:=0;
else
hexstring:=coalesce(oracle.substr(rawtohex(bmp),startpt,10),'0000000000');
if
hexstring = '0000000000' then
hexid:=hexid + 1;
decnibble1:=0;
decnibble2:=0;
decnibble3:=0;
decnibble4:=0;
decnibble5:=0;
decnibble6:=0;
decnibble7:=0;
decnibble8:=0;
decnibble9:=0;
decnibble10:=0;
nibblezero:= true;
if hexid = noemptyblks then
startpt:=1;
pos:=0;
end if;
--
--
-- converts hex nibble into decimal value.
--
else
nibblezero:=false;
hexchar:=oracle.substr(rawtohex(bmp),startpt,1);
if hexchar = '0' then decnibble1:=0;
elsif hexchar ='A' then decnibble1:=10;
elsif hexchar ='B' then decnibble1:=11;
elsif hexchar ='C' then decnibble1:=12;
elsif hexchar ='D' then decnibble1:=13;
elsif hexchar ='E' then decnibble1:=14;
elsif hexchar ='F' then decnibble1:=15;
else decnibble1:=(hexchar)::numeric;
end if;
hexchar:=oracle.substr(rawtohex(bmp),startpt+1,1);
if hexchar = '0' then decnibble2:=0;
elsif hexchar ='A' then decnibble2:=10;
elsif hexchar ='B' then decnibble2:=11;
elsif hexchar ='C' then decnibble2:=12;
elsif hexchar ='D' then decnibble2:=13;
elsif hexchar ='E' then decnibble2:=14;
elsif hexchar ='F' then decnibble2:=15;
else decnibble2:=(hexchar)::numeric;
end if;
hexchar:=oracle.substr(rawtohex(bmp),startpt+2,1);
if hexchar = '0' then decnibble3:=0;
elsif hexchar ='A' then decnibble3:=10;
elsif hexchar ='B' then decnibble3:=11;
elsif hexchar ='C' then decnibble3:=12;
elsif hexchar ='D' then decnibble3:=13;
elsif hexchar ='E' then decnibble3:=14;
elsif hexchar ='F' then decnibble3:=15;
else decnibble3:=(hexchar)::numeric;
end if;
hexchar:= oracle.substr(rawtohex(bmp),startpt+3,1);
if hexchar = '0' then decnibble4:=0;
elsif  hexchar ='A' then decnibble4:=10;
elsif hexchar ='B' then decnibble4:=11;
elsif hexchar ='C' then decnibble4:=12;
elsif hexchar ='D' then decnibble4:=13;
elsif hexchar ='E' then decnibble4:=14;
elsif hexchar ='F' then decnibble4:=15;
else decnibble4:=(hexchar)::numeric;
end if;
hexchar :=oracle.substr(rawtohex(bmp),startpt+4,1);
if hexchar = '0' then decnibble5:=0;
elsif hexchar ='A' then decnibble5:=10;
elsif hexchar ='B' then decnibble5:=11;
elsif hexchar ='C' then decnibble5:=12;
elsif hexchar ='D' then decnibble5:=13;
elsif hexchar ='E' then decnibble5:=14;
elsif hexchar ='F' then decnibble5:=15;
else decnibble5:=(hexchar )::numeric;
end if;
hexchar := oracle.substr(rawtohex(bmp),startpt+5,1);
if hexchar = '0' then decnibble6:=0;
elsif hexchar ='A' then decnibble6:=10;
elsif hexchar='B' then decnibble6:=11;
elsif hexchar='C' then decnibble6:=12;
elsif hexchar='D' then decnibble6:=13;
elsif hexchar='E' then decnibble6:=14;
elsif hexchar='F' then decnibble6:=15;
else decnibble6:=(hexchar)::numeric;
end if;
hexchar := oracle.substr(rawtohex(bmp),startpt+6,1);
if hexchar = '0' then decnibble7:=0;
elsif hexchar ='A' then decnibble7:=10;
elsif hexchar='B' then decnibble7:=11;
elsif hexchar='C' then decnibble7:=12;
elsif hexchar='D' then decnibble7:=13;
elsif hexchar='E' then decnibble7:=14;
elsif hexchar='F' then decnibble7:=15;
else decnibble7:=(hexchar)::numeric;
end if;
hexchar :=oracle.substr(rawtohex(bmp),startpt+7,1);
if hexchar = '0' then decnibble8:=0;
elsif hexchar ='A' then decnibble8:=10;
elsif hexchar='B' then decnibble8:=11;
elsif hexchar='C' then decnibble8:=12;
elsif hexchar='D' then decnibble8:=13;
elsif hexchar='E' then decnibble8:=14;
elsif hexchar='F' then decnibble8:=15;
else decnibble8:=(hexchar)::numeric;
end if;
hexchar:= oracle.substr(rawtohex(bmp),startpt+8,1);
if hexchar = '0' then decnibble9:=0;
elsif hexchar ='A' then decnibble9:=10;
elsif hexchar='B' then decnibble9:=11;
elsif hexchar='C' then decnibble9:=12;
elsif hexchar='D' then decnibble9:=13;
elsif hexchar='E' then decnibble9:=14;
elsif hexchar='F' then decnibble9:=15;
else decnibble9:=(hexchar)::numeric;
end if;
if itype = 2 then
hexchar :=oracle.substr(rawtohex(bmp),startpt+9,1);
if hexchar = '0' then decnibble10:=0;
elsif hexchar ='A' then decnibble10:=10;
elsif hexchar='B' then decnibble10:=11;
elsif hexchar='C' then decnibble10:=12;
elsif hexchar='D' then decnibble10:=13;
elsif hexchar='E' then decnibble10:=14;
elsif hexchar='F' then decnibble10:=15;
else decnibble10:=(hexchar)::numeric;
end if;
end if;
--
--
-- off set the nibble by one byte
-- then calculate the item id
--
if nibblezero = false then
decnibble1:=decnibble1*2;
if decnibble2 > 7 then
decnibble1:=decnibble1+1;
decnibble2:=decnibble2-8;
end if;
decnibble1:=decnibble1 * 268435456;
decnibble2:=decnibble2 * 2;
if decnibble3 > 7 then
decnibble2:=decnibble2+1;
decnibble3:=decnibble3-8;
end if;
decnibble2:=decnibble2 * 16777216;
decnibble3:=decnibble3*2;
if decnibble4 > 7 then
decnibble3:=decnibble3+1;
decnibble4:=decnibble4-8;
end if;
decnibble3:=decnibble3 * 1048576;
decnibble4:=decnibble4*2;
if decnibble5 > 7 then
decnibble4:=decnibble4+1;
decnibble5:=decnibble5-8;
end if;
decnibble4:=decnibble4 * 65536;
decnibble5:=decnibble5*2;
if decnibble6 > 7 then
decnibble5:=decnibble5+1;
decnibble6:=decnibble6-8;
end if;
decnibble5:=decnibble5 * 4096;
decnibble6:=decnibble6*2;
if decnibble7 > 7 then
decnibble6:=decnibble6+1;
decnibble7:=decnibble7-8;
end if;
decnibble6:=decnibble6 * 256;
decnibble7:=decnibble7*2;
if decnibble8 > 7 then
decnibble7:=decnibble7+1;
decnibble8:=decnibble8-8;
end if;
decnibble7:=decnibble7 * 16;
decnibble8:=decnibble8*2;
if decnibble9 > 7 then
decnibble8:=decnibble8+1;
decnibble9:=decnibble9-8;
end if;
if itype=2 then
if decnibble9>0 then
decnibble9:=(decnibble9-2)*8;
end if;
decnibble10:=decnibble9+(decnibble10/2);
end if;
expid:= decnibble1 + decnibble2 + decnibble3 + decnibble4 + decnibble5 + decnibble6 + decnibble7 + decnibble8;
end if;
end if;
end if;
startpt:=pos+1;/* dmap converted statement start */
--
--
-- build up the string of item ids used in the query
--
if nibblezero = false then
if itype =1 then
if coalesce(length(itmid),0)=0 then
itmid:= concat(to_char(expid), ',0') ;/* dmap converted statement end */
else
chklgth:= length(itmid)+length(to_char(expid))+3;/* dmap converted statement start */
if chklgth > 1999 then
itmid:= concat(itmid, '*') ;/* dmap converted statement end */
exit;/* dmap converted statement start */
else
itmid:= concat(itmid, '.', to_char(expid), ',0') ;/* dmap converted statement end */
end if;
end if;
else
chklgth:= coalesce(length(itmid),0)+length(to_char(expid))+3;/* dmap converted statement start */
if chklgth > 1999 then
itmid:= concat(itmid, '*') ;/* dmap converted statement end */
exit;/* dmap converted statement start */
elsif chklgth =length(to_char(expid))+3 then
itmid:= concat(to_char(expid), ',', to_char(decnibble10)) ;/* dmap converted statement end *//* dmap converted statement start */
else
itmid:= concat(itmid, '.', to_char(expid), ',', to_char(decnibble10)) ;/* dmap converted statement end */
end if;
end if;
end if;
--
-- go get the next five bytes in the string
--
end loop;
--
--
--  close the cursor on the first loop for the dimensions
--  on the second for the measures
--
if itype = 1 then
close dbmp;
else
close mbmp;
end if;
--
end loop;
--
return itmid;
-- return hexstring;
--
end;
--dmap converted function completed
$body$
language plpgsql
stable;
