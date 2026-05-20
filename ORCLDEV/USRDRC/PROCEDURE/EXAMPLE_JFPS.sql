CREATE OR REPLACE NONEDITIONABLE PROCEDURE "USRDRC"."EXAMPLE_JFPS" is
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
input_string VARCHAR2 (200) := 'Lord of the ring';
output_str_md5 VARCHAR2 (200);
output_str_sh1 VARCHAR2 (200);
hash_raw_md5 RAW(2000);
hash_raw_sh1 RAW(2000);
hash_algo_type1 PLS_INTEGER := DEMO_DBMS_CRYPTO.HASH_MD5;
hash_algo_type2 PLS_INTEGER := DEMO_DBMS_CRYPTO.HASH_SH1;
BEGIN
DBMS_OUTPUT.PUT_LINE ( 'Original string: ' || input_string);
hash_raw_md5 := DEMO_DBMS_CRYPTO.Hash
(
src => UTL_I18N.STRING_TO_RAW (input_string, NULL),
--src => input_string,
typ => hash_algo_type1
);
hash_raw_sh1 := DEMO_DBMS_CRYPTO.Hash
(
src => UTL_I18N.STRING_TO_RAW (input_string, NULL),
--src => input_string,
typ => hash_algo_type2
);
output_str_md5 := UTL_I18N.RAW_TO_CHAR (hash_raw_md5,'US7ASCII');
output_str_sh1 := UTL_I18N.RAW_TO_CHAR (hash_raw_sh1,'US7ASCII');
--output_str_md5 := hash_raw_md5;
--output_str_sh1 := hash_raw_sh1;
--dbms_output.put_line(hash_raw_md5);
--dbms_output.put_line(rawtohex(hash_raw_sh1));
DBMS_OUTPUT.PUT_LINE ('MD5 Hash: ' || output_str_md5);
DBMS_OUTPUT.PUT_LINE ('SH1 Hash: ' || output_str_sh1);
END;
/
