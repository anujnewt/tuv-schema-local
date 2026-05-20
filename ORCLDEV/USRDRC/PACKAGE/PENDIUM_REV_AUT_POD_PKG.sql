CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."PENDIUM_REV_AUT_POD_PKG" AS
        PROCEDURE CHANGE_STATUS_VIGENCIA_PR;
        PROCEDURE REPAIR_STATUS_VIGENCIA_PR;
END PENDIUM_REV_AUT_POD_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."PENDIUM_REV_AUT_POD_PKG" AS
  PROCEDURE CHANGE_STATUS_VIGENCIA_PR AS
  LFEC_FIN DATE;
  Max_Indice int;
  indice int;
  indiceAux int;
  desc_Apod_poder clob;
  desc_Apod_poder_temp clob;
  desc_Apod_esc clob;
  id_escritura_ant NUMBER := 0;
  des_podertipo_ant VARCHAR(2000);
  /******* Lista de apoderados a revocar *********/
  CURSOR PODERES_CUR
    IS
    select
      PODER.ID_OPODER_EP_PK
      ,PODER.ID_EP_FK
      ,poder.DESC_APODERADOS
      ,esc.DESC_APODERADOS AS DESC_APODERADOS_ESC
      ,PODER.DES_PODERTIPO
      ,PODER.DES_PODER
      ,esc.IND_TIPO_ESCRITURA
    from  pendium_otorgapoder_ep_tab PODER inner join PENDIUM_ESCRITURA_PODER_TAB esc on esc.ID_EP_PK = poder.ID_EP_FK
    WHERE PODER.ID_EP_FK IN
    ( select
      PODER.ID_EP_FK
      from  pendium_otorgapoder_ep_tab PODER inner join PENDIUM_ESCRITURA_PODER_TAB esc on esc.ID_EP_PK = poder.ID_EP_FK
      WHERE PODER.ID_OPODER_EP_PK
      IN ( select apod.ID_OPODER_EP_FK
           from pendium_apoderado_ep_tab apod
           inner join pendium_otorgapoder_ep_tab poder on apod.ID_OPODER_EP_FK = poder.ID_OPODER_EP_PK
           inner join PENDIUM_ESCRITURA_PODER_TAB esc on esc.ID_EP_PK = poder.ID_EP_FK
           WHERE poder.NUM_VIGENCIATIPO IN (1,2,3)
           and poder.IND_STATUS = 1
           and TO_DATE(poder.FEC_VIGENCIAFIN,'DD/MM/YYYY, HH24:MI:SS') < sysdate
           and apod.IND_STATUS in (2))
      )
      order by PODER.ID_OPODER_EP_PK
         ;
  CURSOR APODERADOS_CUR
    IS
      select
        apod.ID_APOD_EP_PK
        ,apod.ID_OPODER_EP_FK
        ,apod.ID_EP_FK
        ,apod.DESC_NOM_EMPL
        ,poder.FEC_VIGENCIAFIN
      from pendium_apoderado_ep_tab apod
        inner join pendium_otorgapoder_ep_tab poder on apod.ID_OPODER_EP_FK = poder.ID_OPODER_EP_PK
          inner join PENDIUM_ESCRITURA_PODER_TAB esc on esc.ID_EP_PK = poder.ID_EP_FK
        WHERE poder.NUM_VIGENCIATIPO IN (1,2,3)
          and poder.IND_STATUS = 1
          and TO_DATE(poder.FEC_VIGENCIAFIN,'DD/MM/YYYY, HH24:MI:SS') < sysdate
          and apod.IND_STATUS in (1,3)
          and IND_TIPOAPODERADO=1;
  BEGIN
     /******* Aplicar revocaciones *********/
      FOR i IN APODERADOS_CUR
      LOOP
          UPDATE pendium_apoderado_ep_tab
            SET IND_STATUS = 2
            ,DESC_REVOCA = '<label style="color:red;">V</label> Mandato Termino por Vigencia '||i.FEC_VIGENCIAFIN
            ,IND_APREVOCA = '1'
          WHERE ID_APOD_EP_PK = i.ID_APOD_EP_PK;
          commit;
          --DBMS_OUTPUT.PUT_LINE('ACTULIZAR APODERADO');
          INSERT INTO PENDIUM_REVOCA_EP_TAB
            (ID_OPODER_EP_FK
            ,ID_EP_FK
            ,ID_APOD_EP_FK
            ,IND_RAZONREVOCA
            ,DES_RAZONREVOCA
            ,FEC_REVOCA
            ,DES_TEXTOREVOCA
            ,DESC_APENDICEREVOCA
            ,IND_STATUS)
          values(
              i.ID_OPODER_EP_FK
              ,i.ID_EP_FK
              ,i.ID_APOD_EP_PK
              , 3
              ,'Vigencia'
              ,i.FEC_VIGENCIAFIN
              ,'Mandato Termino por Vigencia ' || i.FEC_VIGENCIAFIN
              ,1
              ,1
            );
           -- DBMS_OUTPUT.PUT_LINE('inserta revocacion');
            --Select Max(IND_APREVOCA) into Max_Indice from pendium_apoderado_ep_tab WHERE ID_OPODER_EP_FK = i.id_opoder_ep_fk and IND_STATUS = 2;
           select DESC_APODERADOS into desc_Apod_poder
           from pendium_otorgapoder_ep_tab
           where ID_OPODER_EP_PK = i.ID_OPODER_EP_FK;
            --desc_Apod_poder := REPLACE(desc_Apod_poder,i.DESC_NOM_EMPL,i.DESC_NOM_EMPL || ' <label style="color:red;">V</label>');
           desc_Apod_poder := REPLACE(desc_Apod_poder,TRIM(i.DESC_NOM_EMPL),TRIM(i.DESC_NOM_EMPL) || '<sup style=''font-size:8pt;''><label style="color:red;">V</label></sup>');
           update pendium_otorgapoder_ep_tab set DESC_APODERADOS = desc_Apod_poder where ID_OPODER_EP_PK = i.ID_OPODER_EP_FK;
           commit;
         DBMS_OUTPUT.PUT_LINE(i.DESC_NOM_EMPL);
      END LOOP;
     /******* Actualizar descripcion de apoderados en escritura y poder  *********/
  FOR e IN PODERES_CUR
      LOOP
          select DESC_APODERADOS into desc_Apod_poder
          from pendium_otorgapoder_ep_tab
          where ID_OPODER_EP_PK = e.ID_OPODER_EP_PK;
          select DESC_APODERADOS into desc_Apod_esc
          from PENDIUM_ESCRITURA_PODER_TAB
          where ID_EP_PK = e.ID_EP_FK;
          IF id_escritura_ant <> e.ID_EP_FK THEN
            IF e.IND_TIPO_ESCRITURA = 'PG' THEN
              desc_Apod_esc := '<div style="font-weight: bold;">' || e.DES_PODER || '</div>';
            ELSE
              desc_Apod_esc := '<div style="font-weight: bold;">' || e.DES_PODERTIPO || '</div><br>';
            END IF;
          ELSE
            desc_Apod_esc := desc_Apod_esc || '<br>';
          END IF;
          desc_Apod_poder_temp := desc_Apod_poder;
          desc_Apod_poder_temp := REPLACE(desc_Apod_poder_temp,'null');
          IF e.IND_TIPO_ESCRITURA = 'PG' THEN
              IF id_escritura_ant = e.ID_EP_FK  AND des_podertipo_ant <> e.DES_PODER THEN
                  desc_Apod_esc := desc_Apod_esc || '<div style="font-weight: bold;">' || e.DES_PODER || '</div>' || desc_Apod_poder_temp;
              ELSE
                desc_Apod_esc := desc_Apod_esc || desc_Apod_poder_temp;
              END IF;
              des_podertipo_ant := e.DES_PODER;
          ELSE
               IF id_escritura_ant = e.ID_EP_FK  AND des_podertipo_ant <> e.DES_PODERTIPO THEN
                  desc_Apod_esc := desc_Apod_esc || '<div style="font-weight: bold;">' || e.DES_PODERTIPO || '</div><br>' || desc_Apod_poder_temp;
               ELSE
                  desc_Apod_esc := desc_Apod_esc || desc_Apod_poder_temp;
              END IF;
              des_podertipo_ant := e.DES_PODERTIPO;
          END IF;
          id_escritura_ant := e.ID_EP_FK;
          update PENDIUM_ESCRITURA_PODER_TAB set DESC_APODERADOS = desc_Apod_esc  where ID_EP_PK = e.ID_EP_FK;
          commit;
      END LOOP;
  END CHANGE_STATUS_VIGENCIA_PR;
  PROCEDURE REPAIR_STATUS_VIGENCIA_PR
  AS
  LFEC_FIN DATE;
  Max_Indice int;
  indice int;
  indiceAux int;
  desc_Apod_poder clob;
  desc_Apod_esc clob;
  CURSOR APODERADOS_CUR
    IS
      select
        apod.ID_APOD_EP_PK
        ,apod.ID_OPODER_EP_FK
        ,apod.ID_EP_FK
        ,apod.DESC_NOM_EMPL
        ,poder.FEC_VIGENCIAFIN
      from pendium_apoderado_ep_tab apod
        inner join pendium_otorgapoder_ep_tab poder on apod.ID_OPODER_EP_FK = poder.ID_OPODER_EP_PK
          inner join PENDIUM_ESCRITURA_PODER_TAB esc on esc.ID_EP_PK = poder.ID_EP_FK
        WHERE poder.NUM_VIGENCIATIPO IN (1,2,3)
          and poder.IND_STATUS = 1
          and TO_DATE(poder.FEC_VIGENCIAFIN,'DD/MM/YYYY, HH24:MI:SS') < sysdate
          and apod.IND_STATUS in (2)
          and apod.DESC_REVOCA like '<label style="color:red;">V</label> Mandato Termino por Vigencia%';
  BEGIN
     /******* Aplicar revocaciones *********/
      FOR i IN APODERADOS_CUR
      LOOP
         select DESC_APODERADOS into desc_Apod_esc
            from PENDIUM_ESCRITURA_PODER_TAB
              where ID_EP_PK = i.ID_EP_FK;
                desc_Apod_esc := REPLACE(desc_Apod_esc ,i.DESC_NOM_EMPL || '<br /> <br />',i.DESC_NOM_EMPL || ' <label style="color:red;">V</label><br /> <br />');
                desc_Apod_esc := REPLACE(desc_Apod_esc ,i.DESC_NOM_EMPL || '<br />',i.DESC_NOM_EMPL || ' <label style="color:red;">V</label><br />');
                update PENDIUM_ESCRITURA_PODER_TAB set DESC_APODERADOS = desc_Apod_esc  where ID_EP_PK = i.ID_EP_FK;
                commit;
  END LOOP;
    END REPAIR_STATUS_VIGENCIA_PR;
END PENDIUM_REV_AUT_POD_PKG;
/;
