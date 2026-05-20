create or replace  function  usrdrc.ss_crypto_pkg_encrypt_fn ( pstvalue varchar, p_key varchar default '1234567890123456', p_algorithm varchar default 'AES128', p_iv varchar default null) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
l_enc_val    bytea;
l_enc_algo   integer;
l_in         bytea;
l_iv         bytea;
l_key        bytea;
l_ret        varchar(4000);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
l_enc_algo :=
case p_algorithm
when 'DES'
then dbms_crypto.encrypt_des
when '3DES_2KEY'
then dbms_crypto.encrypt_3des_2key
when '3DES'
then dbms_crypto.encrypt_3des
when 'AES128'
then dbms_crypto.encrypt_aes128
when 'AES192'
then dbms_crypto.encrypt_aes192
when 'AES256'
then dbms_crypto.encrypt_aes256
when 'RC4'
then dbms_crypto.encrypt_rc4
end;
l_in := utl_i18n.string_to_raw(pstvalue, 'AL32UTF8');
l_iv := utl_i18n.string_to_raw(p_iv, 'AL32UTF8');
l_key := utl_i18n.string_to_raw(p_key, 'AL32UTF8');
l_enc_val :=
dbms_crypto.encrypt(src      => l_in,
key      => l_key,
iv       => l_iv,
typ      =>   l_enc_algo
+ dbms_crypto.chain_cbc
+ dbms_crypto.pad_pkcs5
);
l_ret := rawtohex(l_enc_val);
return l_ret;end;
$body$
language plpgsql
stable;
