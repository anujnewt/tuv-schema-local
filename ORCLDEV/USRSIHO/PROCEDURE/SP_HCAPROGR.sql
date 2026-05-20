CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HCAPROGR" (vs_ide_pcc VARCHAR2,  -- Identif. PC
                             vn_key_usu NUMBER,   -- Clave de usuario
                             vs_log_usu VARCHAR2,  -- Login del usuario
                             vs_key_men VARCHAR2,  -- Nombre del menu
                             vn_ran_ini NUMBER,   -- Rango inicial
                             vn_ran_fin NUMBER,   -- Rango final
                             vs_key_dep VARCHAR2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start

-- PGV moved types end
   -- Clave de departamento

  -- SIPROS, S. A. DE C. V.
  --
  -- Sistema  : RH-2000  C/S
  -- Modulo   : Nomina de Honorarios(ho)
  -- Programa : sp_hcaprogr
  --            Insercion de capitulos  por rangos
  -- Autor    : Veronica Vazquez Rodriguez
  -- Fecha    : 09 de Septiembre de 1999

   vn_con_001    NUMBER(5);
BEGIN  -- Contador de registros

-- CLICLO DE INSECION DE CAPITULOS

   FOR vn_con_001 IN vn_ran_ini .. vn_ran_fin LOOP     
      UPDATE USRSIHO.holocapi SET cap_keydep =  vs_key_dep
       WHERE cap_keydep = vs_key_dep
         AND cap_keycap = vn_con_001;

-- VALIDA SI EXISTE EL CAPITULO
      IF sql%rowcount  = 0 THEN
         INSERT INTO USRSIHO.holocapi(cap_keydep,cap_keycap,cap_ca1aux)
                       VALUES(vs_key_dep,vn_con_001,'V');

          USRSIHO.sp_bitacora( vn_key_usu,
                                        vs_log_usu,
                                        vs_ide_pcc,
                                        'IN',
                                        'cap_keydep',
                                        'cap_keycap',
                                        ' ',
                                        vs_key_dep,
                                        vn_con_001,
                                        ' ','hcaprogr');

      END IF;
   END LOOP;
END;
/
