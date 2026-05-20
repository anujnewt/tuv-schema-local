create or replace  function  fecxc."fecxp_stringtokenizer"  ( pc$chaine varchar,         -- input string
pn$pos integer,         -- token number
pc$sep varchar default ',' -- separator character
) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lc$chaine varchar(32767) := pc$sep || pc$chaine;
li$i      integer;
li$i2     integer;
begin
li$i := instr( lc$chaine, pc$sep, 1, pn$pos );
if li$i > 0 then
li$i2 := instr( lc$chaine, pc$sep, 1, pn$pos + 1);
if li$i2 = 0 then li$i2 := length( lc$chaine ) + 1; end if;
return( oracle.substr( lc$chaine, li$i+1, li$i2 - li$i-1 ) );
else
return null;
end if;end;
--dmap converted function completed
$body$
language plpgsql
stable;
