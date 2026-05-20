create or replace  function  labconf.utils_get_format_from_style (p_style numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_format varchar(50);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
if dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'UTILS', 'DATABASE_TYPE', 'VARCHAR2', 'Y')::varchar = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'UTILS', 'SYBASE', 'VARCHAR2', 'Y')::varchar then
v_format := case
when p_style = 0   then  'Mon DD YYYY HH12:MI AM'
when p_style = 100 then  'Mon DD YYYY HH12:MI AM'
when p_style = 1   then  'MM/DD/YY'
when p_style = 101 then  'MM/DD/YYYY'
when p_style = 2   then  'YY.MM.DD'
when p_style = 102 then  'YYYY.MM.DD'
when p_style = 3   then  'DD/MM/YY'
when p_style = 103 then  'DD/MM/YYYY'
when p_style = 4   then  'DD.MM.YY'
when p_style = 104 then  'DD.MM.YYYY'
when p_style = 5   then  'DD-MM-YY'
when p_style = 105 then  'DD-MM-YYYY'
when p_style = 6   then  'DD Mon YY'
when p_style = 106 then  'DD Mon YYYY'
when p_style = 7   then  'Mon DD, YY'
when p_style = 107 then  'Mon DD, YYYY'
when p_style = 8   then  'HH24:MI:SS'
when p_style = 108 then  'HH24:MI:SS'
when p_style = 9   then  'FMMon  DD YYYY  HH12:MI:SS:FF3AM'
when p_style = 109 then  'FMMon  DD YYYY  HH12:MI:SS:FF3AM'
when p_style = 10  then  'MM-DD-YY'
when p_style = 110 then  'MM-DD-YYYY'
when p_style = 11  then  'YY/MM/DD'
when p_style = 111 then  'YYYY/MM/DD'
when p_style = 12  then  'YYMMDD'
when p_style = 112 then  'YYYYMMDD'
when p_style = 13  then  'YY/DD/MM'
when p_style = 113 then  'YYYY/DD/MM'
when p_style = 14  then  'MM/YY/DD'
when p_style = 114 then  'MM/YYYY/DD'
when p_style = 15  then  'DD/YY/MM'
when p_style = 115 then  'DD/YYYY/MM'
when p_style = 16  then  'Mon  fmDDfm YYYY HH24:MI:SS'
when p_style = 116 then  'Mon  fmDDfm YYYY HH24:MI:SS'
when p_style = 17  then  'FMHH12:MIAM'
when p_style = 117 then  'YYYY/MM/DD HH:MI:SS'
when p_style = 18  then  'HH24:MI'
when p_style = 118 then  'YYYY/MM/DD FMHH12:MIAM'
when p_style = 19  then  'FMHH12:MI:SS:FF3AM'
when p_style = 119 then  'FMHH12:MI:SS:FF3AM'
when p_style = 20  then  'HH24:MI:SS:FF3'
when p_style = 120 then  'HH24:MI:SS:FF3'
when p_style = 21  then  'YY/MM/DD HH:MI:SS'
when p_style = 121 then  'YYYY/MM/DD HH:MI:SS'
when p_style = 22  then  'YY/MM/DD  fmHH:MIAM'
when p_style = 122 then  'YYYY/MM/DD  fmHH:MIAM'
when p_style = 23  then  'YYYY-MM-DD"T"HH12:MI:SS'
when p_style = 123 then  'YYYY-MM-DD"T"HH12:MI:SS'
end;
end if;
if dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'UTILS', 'DATABASE_TYPE', 'VARCHAR2', 'Y')::varchar = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'UTILS', 'SQLSERVER', 'VARCHAR2', 'Y')::varchar then
v_format := case
when p_style = 0   then  'MON DD YYYY HH12:MIAM'
when p_style = 100 then  'MON DD YYYY HH12:MIAM'
when p_style = 1   then  'MM/DD/YY'
when p_style = 101 then  'MM/DD/YYYY'
when p_style = 2   then  'YY.MM.DD'
when p_style = 102 then  'YYYY.MM.DD'
when p_style = 3   then  'DD/MM/YY'
when p_style = 103 then  'DD/MM/YYYY'
when p_style = 4   then  'DD.MM.YY'
when p_style = 104 then  'DD.MM.YYYY'
when p_style = 5   then  'DD-MM-YY'
when p_style = 105 then  'DD-MM-YYYY'
when p_style = 6   then  'DD Mon YY'
when p_style = 106 then  'DD Mon YYYY'
when p_style = 7   then  'Mon DD, YY'
when p_style = 107 then  'Mon DD, YYYY'
when p_style = 8   then  'HH24:MI:SS'
when p_style = 108 then  'HH24:MI:SS'
when p_style = 9   then  'FMMon  DD YYYY  HH12:MI:SS:FF3AM'
when p_style = 109 then  'FMMon  DD YYYY  HH12:MI:SS:FF3AM'
when p_style = 10  then  'MM-DD-YY'
when p_style = 110 then  'MM-DD-YYYY'
when p_style = 11  then  'YY/MM/DD'
when p_style = 111 then  'YYYY/MM/DD'
when p_style = 12  then  'YYMMDD'
when p_style = 112 then  'YYYYMMDD'
when p_style = 13  then  'DD Mon YYYY HH24:MI:SS:FF3'
when p_style = 113 then  'DD Mon YYYY HH24:MI:SS:FF3'
when p_style = 14  then  'HH24:MI:SS:FF3'
when p_style = 114 then  'HH24:MI:SS:FF3'
when p_style = 20  then  'YYYY-MM-DD HH24:MI:SS'
when p_style = 120 then  'MM/DD/YY  HH12:MI:SS AM'
when p_style = 21  then  'YYYY-MM-DD HH24:MI:SS.FF3'
when p_style = 22  then  'MM/DD/YY  FMHH12:MI:SS AM'
when p_style = 122 then  'MM/DD/YY  FMHH12:MI:SS AM'
when p_style = 23  then  'YYYY-MM-DD'
when p_style = 123 then  'YYYY-MM-DD'
when p_style = 121 then  'YYYY-MM-DD HH24:MI:SS.FF3'
when p_style = 126 then  'YYYY-MM-DD HH12:MI:SS.FF3'
when p_style = 127 then  'YYYY-MM-DD HH12:MI:SS.FF3'
when p_style = 130 then  'DD Mon YYYY HH12:MI:SS:FF3AM'
when p_style = 131 then  'DD/MM/YY HH12:MI:SS:FF3AM'
end;
end if;
return v_format;end;
$body$
language plpgsql
;
