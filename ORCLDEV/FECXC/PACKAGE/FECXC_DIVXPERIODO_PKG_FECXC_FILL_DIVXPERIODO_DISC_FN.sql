create or replace  function  fecxc.fecxc_divxperiodo_pkg_fecxc_fill_divxperiodo_disc_fn ( piinidagrup numeric, piinformat numeric, pistuser varchar, piinsegment numeric ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstposterrbuf       varchar(2000);
lstpostretcode      varchar(30);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
call fecxc_divxperiodo_pkg_fecxc_fill_divxperiodo_disc_pr(
lstposterrbuf,
lstpostretcode,
piinidagrup,
piinformat,
pistuser,
piinsegment
);
return coalesce(lstposterrbuf, 'OK');/* dmap converted statement start */
exception
when others
then
return  concat('Error: ', sqlerrm) ;/* dmap converted statement end */end;
$body$
language plpgsql
stable;
