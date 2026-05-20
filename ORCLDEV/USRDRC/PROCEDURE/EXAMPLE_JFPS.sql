create or replace procedure usrdrc."example_jfps"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
input_string varchar(200) := 'Lord of the ring';
output_str_md5 varchar(200);
output_str_sh1 varchar(200);
hash_raw_md5 bytea;
hash_raw_sh1 bytea;
hash_algo_type1 integer := demo_dbms_crypto.hash_md5;
hash_algo_type2 integer := demo_dbms_crypto.hash_sh1;
begin
/* dmap converted statement start */
perform dbms_output.put_line(  concat('Original string: ', input_string)) ;/* dmap converted statement end */
hash_raw_md5 := demo_dbms_crypto.hash(
src => utl_i18n.string_to_raw(input_string, null),
--src => input_string,
typ => hash_algo_type1
);
hash_raw_sh1 := demo_dbms_crypto.hash(
src => utl_i18n.string_to_raw(input_string, null),
--src => input_string,
typ => hash_algo_type2
);
output_str_md5 := utl_i18n.raw_to_char(hash_raw_md5,'US7ASCII');
output_str_sh1 := utl_i18n.raw_to_char(hash_raw_sh1,'US7ASCII');/* dmap converted statement start */
--output_str_md5 := hash_raw_md5;
--output_str_sh1 := hash_raw_sh1;
--dbms_output.put_line(hash_raw_md5);
--dbms_output.put_line(rawtohex(hash_raw_sh1));
perform dbms_output.put_line( concat('MD5 Hash: ', output_str_md5)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('SH1 Hash: ', output_str_sh1)) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
