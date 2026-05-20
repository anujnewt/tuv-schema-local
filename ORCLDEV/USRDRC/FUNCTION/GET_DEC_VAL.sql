CREATE OR REPLACE NONEDITIONABLE FUNCTION "USRDRC"."GET_DEC_VAL" (
       p_in_val      IN   VARCHAR2,
       p_key         IN   VARCHAR2:= '1234567890123456',
       p_algorithm   IN   VARCHAR2 := 'AES128',
       p_iv          IN   VARCHAR2 := NULL
    )
       RETURN VARCHAR2
    IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
       l_dec_val    RAW (4000);
       l_enc_algo   PLS_INTEGER;
       l_in         RAW (4000);
       l_iv         RAW (4000);
       l_key        RAW (4000);
       l_ret        VARCHAR2 (4000);
    BEGIN
       l_enc_algo :=
          CASE p_algorithm
             WHEN 'DES'
                THEN DBMS_CRYPTO.encrypt_des
             WHEN '3DES_2KEY'
                THEN DBMS_CRYPTO.encrypt_3des_2key
             WHEN '3DES'
                THEN DBMS_CRYPTO.encrypt_3des
             WHEN 'AES128'
                THEN DBMS_CRYPTO.encrypt_aes128
             WHEN 'AES192'
                THEN DBMS_CRYPTO.encrypt_aes192
             WHEN 'AES256'
                THEN DBMS_CRYPTO.encrypt_aes256
             WHEN 'RC4'
                THEN DBMS_CRYPTO.encrypt_rc4
          END;
       l_in := hextoraw(p_in_val);
       l_iv := utl_i18n.string_to_raw (p_iv, 'AL32UTF8');
       l_key := utl_i18n.string_to_raw (p_key, 'AL32UTF8');
       l_dec_val :=
          DBMS_CRYPTO.decrypt (src      => l_in,
                               KEY      => l_key,
                               iv       => l_iv,
                               typ      =>   l_enc_algo
                                           + DBMS_CRYPTO.chain_cbc
                                           + DBMS_CRYPTO.pad_pkcs5
                              );
       l_ret := utl_i18n.raw_to_char (l_dec_val, 'AL32UTF8');
       RETURN l_ret;
    END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "USRDRC"."GET_DEC_VAL" (
       p_in_val      IN   VARCHAR2,
       p_key         IN   VARCHAR2:= '1234567890123456',
       p_algorithm   IN   VARCHAR2 := 'AES128',
       p_iv          IN   VARCHAR2 := NULL
    )
       RETURN VARCHAR2
    IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
       l_dec_val    RAW (4000);
       l_enc_algo   PLS_INTEGER;
       l_in         RAW (4000);
       l_iv         RAW (4000);
       l_key        RAW (4000);
       l_ret        VARCHAR2 (4000);
    BEGIN
       l_enc_algo :=
          CASE p_algorithm
             WHEN 'DES'
                THEN DBMS_CRYPTO.encrypt_des
             WHEN '3DES_2KEY'
                THEN DBMS_CRYPTO.encrypt_3des_2key
             WHEN '3DES'
                THEN DBMS_CRYPTO.encrypt_3des
             WHEN 'AES128'
                THEN DBMS_CRYPTO.encrypt_aes128
             WHEN 'AES192'
                THEN DBMS_CRYPTO.encrypt_aes192
             WHEN 'AES256'
                THEN DBMS_CRYPTO.encrypt_aes256
             WHEN 'RC4'
                THEN DBMS_CRYPTO.encrypt_rc4
          END;
       l_in := hextoraw(p_in_val);
       l_iv := utl_i18n.string_to_raw (p_iv, 'AL32UTF8');
       l_key := utl_i18n.string_to_raw (p_key, 'AL32UTF8');
       l_dec_val :=
          DBMS_CRYPTO.decrypt (src      => l_in,
                               KEY      => l_key,
                               iv       => l_iv,
                               typ      =>   l_enc_algo
                                           + DBMS_CRYPTO.chain_cbc
                                           + DBMS_CRYPTO.pad_pkcs5
                              );
       l_ret := utl_i18n.raw_to_char (l_dec_val, 'AL32UTF8');
       RETURN l_ret;
    END;
/
