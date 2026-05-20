create or replace  function  usrdrc."get_dec_val"  ( p_in_val varchar, p_key varchar2default '1234567890123456', p_algorithm varchar default 'AES128', p_iv varchar default null) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
l_dec_val    bytea;
l_enc_algo   integer;
l_in         bytea;
l_iv         bytea;
l_key        bytea;
l_ret        varchar(4000);
begin
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
l_in := hextoraw(p_in_val);
l_iv := utl_i18n.string_to_raw(p_iv, 'AL32UTF8');
l_key := utl_i18n.string_to_raw(p_key, 'AL32UTF8');
l_dec_val :=
dbms_crypto.decrypt(src      => l_in,
key      => l_key,
iv       => l_iv,
typ      =>   l_enc_algo
+ dbms_crypto.chain_cbc
+ dbms_crypto.pad_pkcs5
);
l_ret := utl_i18n.raw_to_char(l_dec_val, 'AL32UTF8');
return l_ret;end;
--dmap converted function completed
$body$
language plpgsql
stable;
