CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_PODERES_PKG" AS
      PROCEDURE INSERT_PODERES_PR(pinIdPoder       			            NUMBER
                                ,pinIdEmpresa                         NUMBER
                                ,pstIntTipoPoder  			              VARCHAR2
                                ,pinIndDelegadoPor   	                NUMBER
                                ,pstFecFecha                          VARCHAR2
                                ,pstFecHora                           VARCHAR2
                                ,pstIndTipoDocumento                  VARCHAR2
                                ,pstDescEscritura                     VARCHAR2
                                ,pstFecOtorgamientoInstr              VARCHAR2
                                ,pstNumDocumentumInstr                VARCHAR2
                                ,pstIndRequiereProto                  VARCHAR2
                                ,pstIndRequiereInscrRppc              VARCHAR2
                                ,pstNomSemaforo                       VARCHAR2
                                ,pinNumLicenciado                     NUMBER
                                ,pstNomNotarioPublico                 VARCHAR2
                                ,pinNumDe                             NUMBER
                                ,pstDesSuplenciaAsociado              VARCHAR2
                                ,pstNumInscritaRegistroPublico        VARCHAR2
                                ,pstFecRegistro                       VARCHAR2
                                ,pstNumFolioMec                       VARCHAR2
                                ,pstDesOtrosDatosRegistro             VARCHAR2
                                ,pstIndMemo                           VARCHAR2
                                ,pinNumSolicitadoPor                  NUMBER
                                ,pstFecDocumentoMemo                  VARCHAR2
                                ,pstFecRecibidoMemo                   VARCHAR2
                                ,pstNumFolio                          VARCHAR2
                                ,pstNumDocumentoMemo                  VARCHAR2
                                ,pstIndDocEntrega                     VARCHAR2
                                ,pstFecDocumentoEntrega               VARCHAR2
                                ,pstFecRecibidaEntrega                VARCHAR2
                                ,pstNumDocumentumEntrega              VARCHAR2
                                ,psIndOtros                           VARCHAR2
                                ,pstFecDocumentoOtros                 VARCHAR2
                                ,pstFecRecibidoOtros                  VARCHAR2
                                ,pstNumDocumentumOtros                VARCHAR2
                                ,pstIndAplicaEstatus                  VARCHAR2
                                ,pstNomSemaforoEstatus                VARCHAR2
                                ,pstFecProgEntregaEstatus             VARCHAR2
                                ,pstIndRedactada                      VARCHAR2
                                ,pinNumRespRedactada                  NUMBER
                                ,pstFecCumplimientoRedactada          VARCHAR2
                                ,pstIndRevisionGerente                VARCHAR2
                                ,pstNumRespGerente                    NUMBER
                                ,pstFecCumplimientoGerente            VARCHAR2
                                ,pstIndCorrecciones                   VARCHAR2
                                ,pinNumRespCorrecciones               NUMBER
                                ,pstFecCumplimientoCorrecciones       VARCHAR2
                                ,pstIndAutDireccion                   VARCHAR2
                                ,pinNumRespAut                        NUMBER
                                ,pstFecCumplimientoAut                VARCHAR2
                                ,pstIndFirmas                         VARCHAR2
                                ,pinNumRespFirmas                     NUMBER
                                ,pstFecCumplimientoFirmas             VARCHAR2
                                ,pstIndEntregada                      VARCHAR2
                                ,pinNumRespEntregada                  NUMBER
                                ,pstFecCumplimientoEntregada          VARCHAR2
                                ,pstNumEnviadaNotaria                 VARCHAR2
                                ,pstFecEnvioNotaria                   VARCHAR2
                                ,pstIndPoderAsunto                    VARCHAR2
                                ,pstIndTipoArmado                     VARCHAR2
                                ,pstOuterror   OUT VARCHAR2);
        PROCEDURE UPDATE_PODERES_PR(pinIdPoder       			            NUMBER
                                ,pinIdEmpresa                         NUMBER
                                ,pstIntTipoPoder  			              VARCHAR2
                                ,pinIndDelegadoPor   	                NUMBER
                                ,pstFecFecha                          VARCHAR2
                                ,pstFecHora                           VARCHAR2
                                ,pstIndTipoDocumento                  VARCHAR2
                                ,pstDescEscritura                     VARCHAR2
                                ,pstFecOtorgamientoInstr              VARCHAR2
                                ,pstNumDocumentumInstr                VARCHAR2
                                ,pstIndRequiereProto                  VARCHAR2
                                ,pstIndRequiereInscrRppc              VARCHAR2
                                ,pstNomSemaforo                       VARCHAR2
                                ,pinNumLicenciado                     NUMBER
                                ,pstNomNotarioPublico                 VARCHAR2
                                ,pinNumDe                             NUMBER
                                ,pstDesSuplenciaAsociado              VARCHAR2
                                ,pstNumInscritaRegistroPublico        VARCHAR2
                                ,pstFecRegistro                       VARCHAR2
                                ,pstNumFolioMec                       VARCHAR2
                                ,pstDesOtrosDatosRegistro             VARCHAR2
                                ,pstIndMemo                           VARCHAR2
                                ,pinNumSolicitadoPor                  NUMBER
                                ,pstFecDocumentoMemo                  VARCHAR2
                                ,pstFecRecibidoMemo                   VARCHAR2
                                ,pstNumFolio                          VARCHAR2
                                ,pstNumDocumentoMemo                  VARCHAR2
                                ,pstIndDocEntrega                     VARCHAR2
                                ,pstFecDocumentoEntrega               VARCHAR2
                                ,pstFecRecibidaEntrega                VARCHAR2
                                ,pstNumDocumentumEntrega              VARCHAR2
                                ,psIndOtros                           VARCHAR2
                                ,pstFecDocumentoOtros                 VARCHAR2
                                ,pstFecRecibidoOtros                  VARCHAR2
                                ,pstNumDocumentumOtros                VARCHAR2
                                ,pstIndAplicaEstatus                  VARCHAR2
                                ,pstNomSemaforoEstatus                VARCHAR2
                                ,pstFecProgEntregaEstatus             VARCHAR2
                                ,pstIndRedactada                      VARCHAR2
                                ,pinNumRespRedactada                  NUMBER
                                ,pstFecCumplimientoRedactada          VARCHAR2
                                ,pstIndRevisionGerente                VARCHAR2
                                ,pstNumRespGerente                    NUMBER
                                ,pstFecCumplimientoGerente            VARCHAR2
                                ,pstIndCorrecciones                   VARCHAR2
                                ,pinNumRespCorrecciones               NUMBER
                                ,pstFecCumplimientoCorrecciones       VARCHAR2
                                ,pstIndAutDireccion                   VARCHAR2
                                ,pinNumRespAut                        NUMBER
                                ,pstFecCumplimientoAut                VARCHAR2
                                ,pstIndFirmas                         VARCHAR2
                                ,pinNumRespFirmas                     NUMBER
                                ,pstFecCumplimientoFirmas             VARCHAR2
                                ,pstIndEntregada                      VARCHAR2
                                ,pinNumRespEntregada                  NUMBER
                                ,pstFecCumplimientoEntregada          VARCHAR2
                                ,pstNumEnviadaNotaria                 VARCHAR2
                                ,pstFecEnvioNotaria                   VARCHAR2
                                ,pstIndPoderAsunto                    VARCHAR2
                                ,pstIndTipoArmado                     VARCHAR2
                                ,pstOuterror   OUT VARCHAR2);
      PROCEDURE DELETE_PODERES_PR(pinIdPoder   NUMBER
                                ,pinIdEmpresa  NUMBER
                                ,pstOuterror   OUT VARCHAR2);
      PROCEDURE INSERT_CONTROL_PODERES_PR(pinIdPoder    NUMBER
                                         ,pinIdEmpresa  NUMBER
                                         ,idUser        NUMBER
                                         ,pstOuterror  OUT VARCHAR2);
      PROCEDURE QUERY_CATALOGOS_PR(porcRSResultado OUT SYS_REFCURSOR
                                  ,pinID_CATALOGO    NUMBER);
      PROCEDURE INSERT_ESCRITURA_PODER_PR(
                                   pinid_empresa NUMBER
                                  ,pstind_tipo_escritura varchar2
                                  ,pinnum_created_by number
                                  ,pinind_delegado_por NUMBER
                                  ,pstfec_fecha varchar2
                                  ,pstfec_hora varchar2
                                  ,pinind_requiere_proto NUMBER
                                  ,pinind_requiere_inscr_rppc NUMBER
                                  ,pstdes_escritura varchar2
                                  ,pstnum_documentum_instr varchar2
                                  ,pstfec_otorgamiento_instr varchar2
                                  ,pstnum_licenciado varchar2
                                  ,pstdes_suplencia_asociado varchar2
                                  ,pstfec_registro varchar2
                                  ,pstnum_folio_merc varchar2
                                  ,pstdes_otros_datos_registro varchar2
                                  ,pstdesc_apoderados varchar2
                                  ,pstdesc_asunto varchar2
                                  ,pstdes_revoca varchar2
                                  ,pinind_ok NUMBER
                                  ,pstfec_pe VARCHAR2
                                  ,pstind_status_ac VARCHAR2
                                  ,pinid_red_resp NUMBER
                                  ,pstdes_rep_resp VARCHAR2
                                  ,pstfec_rep VARCHAR2
                                  ,pinid_reg_resp NUMBER
                                  ,pstdes_reg_resp VARCHAR2
                                  ,pstfec_reg VARCHAR2
                                  ,pinid_cor_resp NUMBER
                                  ,pstdes_cor_resp VARCHAR2
                                  ,pstfec_cor VARCHAR2
                                  ,pinid_aut_resp NUMBER
                                  ,pstdes_aut_resp VARCHAR2
                                  ,pstfec_aut VARCHAR2
                                  ,pinid_fir_resp NUMBER
                                  ,pstdes_fir_resp VARCHAR2
                                  ,pstfec_fir VARCHAR2
                                  ,pinid_ent_resp NUMBER
                                  ,pstdes_ent_resp VARCHAR2
                                  ,pstfec_ent VARCHAR2
                                  ,pstid_sol_doc VARCHAR2
                                  ,pinid_sol_resp NUMBER
                                  ,pstdes_sol_resp VARCHAR2
                                  ,pstfec_sol VARCHAR2
                                  ,pstfec_sol_rec VARCHAR2
                                  ,pstdes_sol_folio VARCHAR2
                                  ,pstid_ent_doc VARCHAR2
                                  ,pstfec_ent_doc VARCHAR2
                                  ,pstfec_ent_rec VARCHAR2
                                  ,pinnum_insc_regpub VARCHAR2
                                  ,pstdes_insc_regpub VARCHAR2
                                  ,pstdes_caracteristicas VARCHAR2
                                  ,pinind_aplica_status NUMBER
                                  ,pinID_EP   OUT NUMBER
                                  ,pstOuterror OUT varchar2);
PROCEDURE UPDATE_ESCRITURA_PODER_PR(
                                   pinid_ep_pk NUMBER
                                  ,pstind_tipo_escritura varchar2
                                  ,pinnum_created_by number
                                  ,pinind_delegado_por NUMBER
                                  ,pstfec_fecha varchar2
                                  ,pstfec_hora varchar2
                                  ,pinind_requiere_proto NUMBER
                                  ,pinind_requiere_inscr_rppc NUMBER
                                  ,pstdes_escritura varchar2
                                  ,pstnum_documentum_instr varchar2
                                  ,pstfec_otorgamiento_instr varchar2
                                  ,pstnum_licenciado varchar2
                                  ,pstdes_suplencia_asociado varchar2
                                  ,pstfec_registro varchar2
                                  ,pstnum_folio_merc varchar2
                                  ,pstdes_otros_datos_registro varchar2
                                  ,pstind_status_esc VARCHAR2
                                  ,pstind_status_rppc VARCHAR2
                                  ,pstdesc_apoderados varchar2
                                  ,pstdesc_asunto varchar2
                                  ,pstdes_revoca varchar2
                                  ,pinind_ok NUMBER
                                  ,pstfec_pe VARCHAR2
                                  ,pstind_status_ac VARCHAR2
                                  ,pinid_red_resp NUMBER
                                  ,pstdes_rep_resp VARCHAR2
                                  ,pstfec_rep VARCHAR2
                                  ,pinid_reg_resp NUMBER
                                  ,pstdes_reg_resp VARCHAR2
                                  ,pstfec_reg VARCHAR2
                                  ,pinid_cor_resp NUMBER
                                  ,pstdes_cor_resp VARCHAR2
                                  ,pstfec_cor VARCHAR2
                                  ,pinid_aut_resp NUMBER
                                  ,pstdes_aut_resp VARCHAR2
                                  ,pstfec_aut VARCHAR2
                                  ,pinid_fir_resp NUMBER
                                  ,pstdes_fir_resp VARCHAR2
                                  ,pstfec_fir VARCHAR2
                                  ,pinid_ent_resp NUMBER
                                  ,pstdes_ent_resp VARCHAR2
                                  ,pstfec_ent VARCHAR2
                                  ,pstid_sol_doc VARCHAR2
                                  ,pinid_sol_resp NUMBER
                                  ,pstdes_sol_resp VARCHAR2
                                  ,pstfec_sol VARCHAR2
                                  ,pstfec_sol_rec VARCHAR2
                                  ,pstdes_sol_folio VARCHAR2
                                  ,pstid_ent_doc VARCHAR2
                                  ,pstfec_ent_doc VARCHAR2
                                  ,pstfec_ent_rec VARCHAR2
                                  ,pinnum_insc_regpub VARCHAR2
                                  ,pstdes_insc_regpub VARCHAR2
                                  ,pstdes_caracteristicas VARCHAR2
                                  ,pinind_aplica_status NUMBER
                                  ,pstOuterror OUT varchar2);
PROCEDURE DELETE_ESCRITURA_PODER_PR(pstResultado OUT VARCHAR2
                                    ,pinid_ep_pk NUMBER
                                    ,psinnum_last_updated_by NUMBER);
PROCEDURE QUERY_ESCRITURA_PODER_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_empresa NUMBER
                                    ,pstind_tipo_escritura varchar2);
PROCEDURE QUERY_ESCRITURA_PODER_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_empresa NUMBER
                                    ,pstind_tipo_escritura varchar2
                                    ,pstdesc_busqueda varchar2);
PROCEDURE QUERY_ESCRITURA_PODER_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_escritura NUMBER
                                    );
PROCEDURE INSERT_DOCUMENTUMS_EP_PR ( pinid_ep_fk NUMBER
                                    ,pstdesc_title VARCHAR2
                                    ,pstid_documentcve VARCHAR2
                                    ,pstfec_rec VARCHAR2
                                    ,pstfec_ent VARCHAR2
                                    ,pinID_EP OUT NUMBER
                                    ,pstOuterror OUT varchar2);
PROCEDURE UPDATE_DOCUMENTUMS_EP_PR ( pinid_doc_ep_fk NUMBER
                                    ,pstdesc_title VARCHAR2
                                    ,pstid_documentcve VARCHAR2
                                    ,psinnum_last_updated_by NUMBER
                                    ,pstfec_rec VARCHAR2
                                    ,pstfec_ent VARCHAR2
                                    ,pstOuterror OUT varchar2);
PROCEDURE DELETE_DOCUMENTUMS_EP_PR(  pinid_ep_fk NUMBER
                                    ,psinnum_last_updated_by NUMBER
                                    ,pstOuterror OUT varchar2);
PROCEDURE QUERY_DOCUMENTUMS_EP_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_ep_fk NUMBER);
PROCEDURE INSERT_OTORGAPODER_EP_PR (pinid_ep_fk NUMBER
                                    ,pinnum_podertipo NUMBER
                                    ,pstdes_podertipo VARCHAR2
                                    ,pinnum_vigenciatipo NUMBER
                                    ,pstdes_vigenciatipo VARCHAR2
                                    ,pinnum_vigenciatiempo NUMBER
                                    ,pstfec_vigenciainicio VARCHAR2
                                    ,pstfec_vigenciafin VARCHAR2
                                    ,pstdesc_caracteristicas VARCHAR2
                                    ,pstdesc_descripcion VARCHAR2
                                    ,pstdesc_apoderados CLOB
                                    ,pstdesc_actosdominio VARCHAR2
                                    ,pstdesc_actosadmon VARCHAR2
                                    ,pstdesc_pleitoscobranza VARCHAR2
                                    ,pstdesc_tituloscredito VARCHAR2
                                    ,pstdesc_revocados VARCHAR2
                                    ,pinnum_order NUMBER
                                    ,pstdesc_vigencia VARCHAR2
                                    ,pstdes_poder varchar2
                                    ,pinid_opoder_ep_pk OUT NUMBER
                                    ,pstOuterror OUT varchar2);
PROCEDURE UPDATE_OTORGAPODER_EP_PR ( pinid_opoder_ep_pk NUMBER
                                    ,pinnum_podertipo NUMBER
                                    ,pstdes_podertipo VARCHAR2
                                    ,pinnum_vigenciatipo NUMBER
                                    ,pstdes_vigenciatipo VARCHAR2
                                    ,pinnum_vigenciatiempo NUMBER
                                    ,pstfec_vigenciainicio VARCHAR2
                                    ,pstfec_vigenciafin VARCHAR2
                                    ,pstdesc_caracteristicas VARCHAR2
                                    ,pstdesc_apoderados CLOB
                                    ,pstdesc_actosdominio VARCHAR2
                                    ,pstdesc_actosadmon VARCHAR2
                                    ,pstdesc_pleitoscobranza VARCHAR2
                                    ,pstdesc_tituloscredito VARCHAR2
                                    ,pstdesc_revocados VARCHAR2
                                    ,pinnum_order NUMBER
                                    ,pstdesc_vigencia VARCHAR2
                                    ,pinnum_last_updated_by NUMBER
                                    ,pstOuterror OUT varchar2);
PROCEDURE DELETE_OTORGAPODER_EP_PR(pstResultado OUT varchar2
                                  ,pinid_ep_fk NUMBER
                                  ,psinnum_last_updated_by NUMBER);
PROCEDURE QUERY_OTORGAPODER_EP_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_ep_fk NUMBER);
PROCEDURE INSERT_APODERADO_EP_PR ( pinid_opoder_ep_fk NUMBER
                                  ,pinid_ep_fk NUMBER
                                  ,pinid_empl_fk NUMBER
                                  ,pstdesc_nom_empl VARCHAR2
                                  ,pinind_tipoapoderado NUMBER
                                  ,pstdesc_tipoapoderado VARCHAR2
                                  ,pinnum_created_by NUMBER
                                  ,pstdes_grupo VARCHAR2
                                  ,pinid_grupo_fk NUMBER
                                  ,pstind_aprevoca VARCHAR2
                                  ,pstdesc_revoca VARCHAR2
                                  ,pinind_status NUMBER
                                  ,pinid_apod_ep OUT NUMBER
                                  ,pstOuterror OUT varchar2);
PROCEDURE UPDATE_APODERADO_EP_PR ( pinid_apod_ep_pk NUMBER
                                  ,pinind_tipoapoderado NUMBER
                                  ,pstdesc_tipoapoderado VARCHAR2
                                  ,pstnum_last_updated_by VARCHAR2
                                  ,pstOuterror OUT varchar2);
PROCEDURE DELETE_APODERADO_EP_PR (pinid_ep_pk NUMBER
                                  ,psinnum_last_updated_by NUMBER
                                  ,pstOuterror OUT NUMBER);
PROCEDURE QUERY_APODERADO_EP_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_opoder_ep NUMBER);
PROCEDURE QUERY_APODERADO_EP_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinind_sonmancomunados NUMBER
                                    ,pinid_opoder_ep NUMBER);
PROCEDURE INSERT_FACULTADES_EP_PR ( pinid_opoder_ep_fk NUMBER
                                  ,pinid_ep_fk NUMBER
                                  ,pinind_tipo NUMBER
                                  ,pstdes_tipo VARCHAR2
                                  ,pinind_delegable VARCHAR2
                                  ,pinind_individual VARCHAR2
                                  ,pstCaracteristicas VARCHAR2
                                  ,pinMancomunado NUMBER
                                  ,pstdes_formae VARCHAR2
                                  ,pinid_fac_ep_pk OUT NUMBER
                                  ,pstOuterror OUT varchar2);
PROCEDURE UPDATE_FACULTADES_EP_PR (pind_fac_ep NUMBER
                                  ,pinind_tipo NUMBER
                                  ,pstdes_tipo VARCHAR2
                                  ,pinind_delegable VARCHAR2
                                  ,pinind_individual VARCHAR2
                                  ,pstCaracteristicas VARCHAR2
                                  ,pinMancomunado NUMBER
                                  ,pinnum_last_updated_by NUMBER
                                  ,pstOuterror OUT varchar2);
PROCEDURE DELETE_FACULTADES_EP_PR (pinid_fac_ep_pk NUMBER
                                    ,pstOuterror OUT NUMBER);
PROCEDURE QUERY_FACULTADES_EP_PR (porcRSResultado OUT SYS_REFCURSOR
                                  ,pinid_opoder_ep_fk NUMBER);
PROCEDURE INSERT_REVOCA_EP_PR ( pinid_opoder_ep_fk NUMBER
                                ,pinid_ep_fk NUMBER
                                ,pinid_apod_ep_fk NUMBER
                                ,pinind_razonrevoca NUMBER
                                ,pstdes_razonrevoca VARCHAR2
                                ,pinid_escriturarevoca_fk VARCHAR2
                                ,pinid_documentumrevoca VARCHAR2
                                ,pstfec_revoca VARCHAR2
                                ,pstdes_textorevoca VARCHAR2
                                ,pstdesc_apendicerevoca VARCHAR2
                                ,pinid_revoca_ep OUT NUMBER
                                ,pstOuterror OUT varchar2);
PROCEDURE UPDATE_REVOCA_EP_PR ( pinid_revoca_ep_pk NUMBER
                                ,pinind_razonrevoca NUMBER
                                ,pstdes_razonrevoca VARCHAR2
                                ,pinid_escriturarevoca_fk NUMBER
                                ,pinid_documentumrevoca NUMBER
                                ,pstfec_revoca VARCHAR2
                                ,pstdes_textorevoca VARCHAR2
                                ,pstdesc_apendicerevoca VARCHAR2
                                ,pinnum_last_updated_by NUMBER
                                ,pstOuterror OUT varchar2);
PROCEDURE DELETE_REVOCA_EP_PR (pinid_revoca_ep_pk NUMBER
                              ,pstOuterror OUT NUMBER);
PROCEDURE QUERY_REVOCA_EP_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_ep NUMBER);
PROCEDURE INSERT_CATALOGO_PODERES_PR ( pstdes_podertipo VARCHAR2
                                      ,pstind_podertipo VARCHAR2
                                      ,pstdes_descripcion VARCHAR2
                                      ,pinind_tiene_ad NUMBER
                                      ,pstind_ad_delegable VARCHAR2
                                      ,pstind_ad_individual VARCHAR2
                                      ,pstdes_ad_formaejercerlo VARCHAR2
                                      ,pstdes_ad_caracteristicas VARCHAR2
                                      ,pstdes_actosdominio VARCHAR2
                                      ,pinind_tiene_aa NUMBER
                                      ,pstind_aa_delegable VARCHAR2
                                      ,pstind_aa_individual VARCHAR2
                                      ,pstdes_aa_formaejercerlo VARCHAR2
                                      ,pstdes_aa_caracteristicas VARCHAR2
                                      ,pstdes_actosadmon VARCHAR2
                                      ,pinind_tiene_tc NUMBER
                                      ,pstind_tc_delegable VARCHAR2
                                      ,pstind_tc_individual VARCHAR2
                                      ,pstdes_tc_formaejercerlo VARCHAR2
                                      ,pstdes_tc_caracteristicas VARCHAR2
                                      ,pstdes_titulosdecreditos VARCHAR2
                                      ,pinind_tiene_pc NUMBER
                                      ,pstind_pc_delegable VARCHAR2
                                      ,pstind_pc_individual VARCHAR2
                                      ,pstdes_pc_formaejercerlo VARCHAR2
                                      ,pstdes_pc_caracteristicas VARCHAR2
                                      ,pstdes_pleitoscobranzas VARCHAR2
                                      ,pstind_pe_delegable VARCHAR2
                                      ,pstind_pe_individual VARCHAR2
                                      ,pstdes_pe_formaejercerlo VARCHAR2
                                      ,pstdes_pe_caracteristicas VARCHAR2
                                      ,pstdes_facultades VARCHAR2
                                      ,pinnum_created_by NUMBER
                                      ,pinid_poder_pk OUT NUMBER
                                      ,pinid_catalogo NUMBER
                                      ,pstOuterror OUT varchar2);
PROCEDURE UPDATE_CATALOGO_PODERES_PR ( pinid_poder_pk NUMBER
                                      ,pstdes_podertipo VARCHAR2
                                      ,pstind_podertipo VARCHAR2
                                      ,pstdes_descripcion VARCHAR2
                                      ,pinind_tiene_ad NUMBER
                                      ,pstind_ad_delegable VARCHAR2
                                      ,pstind_ad_individual VARCHAR2
                                      ,pstdes_ad_formaejercerlo VARCHAR2
                                      ,pstdes_ad_caracteristicas VARCHAR2
                                      ,pstdes_actosdominio VARCHAR2
                                      ,pinind_tiene_aa NUMBER
                                      ,pstind_aa_delegable VARCHAR2
                                      ,pstind_aa_individual VARCHAR2
                                      ,pstdes_aa_formaejercerlo VARCHAR2
                                      ,pstdes_aa_caracteristicas VARCHAR2
                                      ,pstdes_actosadmon VARCHAR2
                                      ,pinind_tiene_tc NUMBER
                                      ,pstind_tc_delegable VARCHAR2
                                      ,pstind_tc_individual VARCHAR2
                                      ,pstdes_tc_formaejercerlo VARCHAR2
                                      ,pstdes_tc_caracteristicas VARCHAR2
                                      ,pstdes_titulosdecreditos VARCHAR2
                                      ,pinind_tiene_pc NUMBER
                                      ,pstind_pc_delegable VARCHAR2
                                      ,pstind_pc_individual VARCHAR2
                                      ,pstdes_pc_formaejercerlo VARCHAR2
                                      ,pstdes_pc_caracteristicas VARCHAR2
                                      ,pstdes_pleitoscobranzas VARCHAR2
                                      ,pstind_pe_delegable VARCHAR2
                                      ,pstind_pe_individual VARCHAR2
                                      ,pstdes_pe_formaejercerlo VARCHAR2
                                      ,pstdes_pe_caracteristicas VARCHAR2
                                      ,pstdes_facultades VARCHAR2
                                      ,pinnum_last_updated_by NUMBER
                                      ,pstOuterror OUT varchar2);
PROCEDURE DELETE_CATALOGO_PODERES_PR (pinid_poder_pk NUMBER
                                      ,pinnum_last_updated_by NUMBER
                                      ,pstOuterror OUT NUMBER);
PROCEDURE QUERY_CATALOGO_PODERES_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_poder_pk NUMBER);
PROCEDURE QUERY_CATALOGO_PODERES_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pstind_podertipo VARCHAR2);
PROCEDURE QUERY_CATALOGO_PODERES_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pstind_podertipo VARCHAR2
                                    ,pstdes_podertipo VARCHAR2);
PROCEDURE QUERY_PODERES_ESPECIALES_PR(porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdesc_busqueda varchar2
                                  ,pinid_empresa NUMBER
                                  ,pstOuterror OUT varchar2);
 PROCEDURE QUERY_PODERES_CARTA_PODER_PR(porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdesc_busqueda varchar2
                                  ,pinid_empresa NUMBER
                                  ,pstOuterror OUT varchar2);
END DERCORP_PODERES_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_PODERES_PKG" AS
  PROCEDURE INSERT_PODERES_PR(  pinIdPoder       			                NUMBER
                                ,pinIdEmpresa                         NUMBER
                                ,pstIntTipoPoder  			              VARCHAR2
                                ,pinIndDelegadoPor   	                NUMBER
                                ,pstFecFecha                          VARCHAR2
                                ,pstFecHora                           VARCHAR2
                                ,pstIndTipoDocumento                  VARCHAR2
                                ,pstDescEscritura                     VARCHAR2
                                ,pstFecOtorgamientoInstr              VARCHAR2
                                ,pstNumDocumentumInstr                VARCHAR2
                                ,pstIndRequiereProto                  VARCHAR2
                                ,pstIndRequiereInscrRppc              VARCHAR2
                                ,pstNomSemaforo                       VARCHAR2
                                ,pinNumLicenciado                     NUMBER
                                ,pstNomNotarioPublico                 VARCHAR2
                                ,pinNumDe                             NUMBER
                                ,pstDesSuplenciaAsociado              VARCHAR2
                                ,pstNumInscritaRegistroPublico        VARCHAR2
                                ,pstFecRegistro                       VARCHAR2
                                ,pstNumFolioMec                       VARCHAR2
                                ,pstDesOtrosDatosRegistro             VARCHAR2
                                ,pstIndMemo                           VARCHAR2
                                ,pinNumSolicitadoPor                  NUMBER
                                ,pstFecDocumentoMemo                  VARCHAR2
                                ,pstFecRecibidoMemo                   VARCHAR2
                                ,pstNumFolio                          VARCHAR2
                                ,pstNumDocumentoMemo                  VARCHAR2
                                ,pstIndDocEntrega                     VARCHAR2
                                ,pstFecDocumentoEntrega               VARCHAR2
                                ,pstFecRecibidaEntrega                VARCHAR2
                                ,pstNumDocumentumEntrega              VARCHAR2
                                ,psIndOtros                           VARCHAR2
                                ,pstFecDocumentoOtros                 VARCHAR2
                                ,pstFecRecibidoOtros                  VARCHAR2
                                ,pstNumDocumentumOtros                VARCHAR2
                                ,pstIndAplicaEstatus                  VARCHAR2
                                ,pstNomSemaforoEstatus                VARCHAR2
                                ,pstFecProgEntregaEstatus             VARCHAR2
                                ,pstIndRedactada                      VARCHAR2
                                ,pinNumRespRedactada                  NUMBER
                                ,pstFecCumplimientoRedactada          VARCHAR2
                                ,pstIndRevisionGerente                VARCHAR2
                                ,pstNumRespGerente                    NUMBER
                                ,pstFecCumplimientoGerente            VARCHAR2
                                ,pstIndCorrecciones                   VARCHAR2
                                ,pinNumRespCorrecciones               NUMBER
                                ,pstFecCumplimientoCorrecciones       VARCHAR2
                                ,pstIndAutDireccion                   VARCHAR2
                                ,pinNumRespAut                        NUMBER
                                ,pstFecCumplimientoAut                VARCHAR2
                                ,pstIndFirmas                         VARCHAR2
                                ,pinNumRespFirmas                     NUMBER
                                ,pstFecCumplimientoFirmas             VARCHAR2
                                ,pstIndEntregada                      VARCHAR2
                                ,pinNumRespEntregada                  NUMBER
                                ,pstFecCumplimientoEntregada          VARCHAR2
                                ,pstNumEnviadaNotaria                 VARCHAR2
                                ,pstFecEnvioNotaria                   VARCHAR2
                                ,pstIndPoderAsunto                    VARCHAR2
                                ,pstIndTipoArmado                     VARCHAR2
                                ,pstOuterror   OUT VARCHAR2)
AS
BEGIN
    BEGIN
    INSERT INTO DERCORP_PODERES_TAB (ID_PODER,
                                ID_EMPRESA,
                                IN_TIPO_PODER,
                                IND_DELEGADO_POR,
                                FEC_FECHA,
                                FEC_HORA,
                                IND_TIPO_DOCUMENTO,
                                DES_ESCRITURA,
                                FEC_OTORGAMIENTO_INSTR,
                                NUM_DOCUMENTUM_INSTR,
                                IND_REQUIERE_PROTO,
                                IND_REQUIERE_INSCR_RPPC,
                                NOM_SEMAFORO,
                                NUM_LICENCIADO,
                                NOM_NOTARIO_PUBLICO,
                                NUM_DE,
                                DES_SUPLENCIA_ASOCIADO,
                                NUM_INSCRITA_REGISTRO_PUBLICO,
                                FEC_REGISTRO,
                                NUM_FOLIO_MERC,
                                DES_OTROS_DATOS_REGISTRO,
                                IND_MEMO,
                                NUM_SOLICITADO_POR,
                                FEC_DOCUMENTO_MEMO,
                                FEC_RECIBIDO_MEMO,
                                NUM_FOLIO,
                                NUM_DOCUMENTUM_MEMO,
                                IND_DOC_ENTREGA,
                                FEC_DOCUMENTO_ENTREGA,
                                FEC_RECIBIDO_ENTREGA,
                                NUM_DOCUMENTUM_ENTREGA,
                                IND_OTROS,
                                FEC_DOCUMENTO_OTROS,
                                FEC_RECIBIDO_OTROS,
                                NUM_DOCUMENTUM_OTROS,
                                IND_APLICA_STATUS,
                                NOM_SEMAFORO_STATUS,
                                FEC_PROG_ENTREGA_STATUS,
                                IND_REDACTADA,
                                NUM_RESP_REDACTADA,
                                FEC_CUMPLIMIENTO_REDACTADA,
                                IND_REVISION_GERENTE,
                                NUM_RESP_GERENTE,
                                FEC_CUMPLIMIENTO_GERENTE,
                                IND_CORRECCIONES,
                                NUM_RESP_CORRECCIONES,
                                FEC_CUMPLIMIENTO_CORRECCIONES,
                                IND_AUT_DIRECCION,
                                NUM_RESP_AUT,
                                FEC_CUMPLIMIENTO_AUT,
                                IND_FIRMAS,
                                NUM_RESP_FIRMAS,
                                FEC_CUMPLIMIENTO_FIRMAS,
                                IND_ENTREGADA,
                                NUM_RESP_ENTREGADA,
                                FEC_CUMPLIMIENTO_ENTREGADA,
                                NUM_ENVIADA_NOTARIA,
                                FEC_ENVIO_NOTARIA,
                                IND_PODER_ASUNTO,
                                IND_TIPO_ARMADO
                               )
               VALUES          ( USRDRC.DERCORP_PODERES_SEQ.NEXTVAL
                                ,pinIdEmpresa
                                ,pstIntTipoPoder
                                ,pinIndDelegadoPor
                                ,sysdate--pstFecFecha
																,pstFecHora
                                ,pstIndTipoDocumento
                                ,pstDescEscritura
                                ,pstFecOtorgamientoInstr
                                ,pstNumDocumentumInstr
                                ,pstIndRequiereProto
                                ,pstIndRequiereInscrRppc
                                ,pstNomSemaforo
                                ,pinNumLicenciado
                                ,pstNomNotarioPublico
                                ,pinNumDe
                                ,pstDesSuplenciaAsociado
                                ,pstNumInscritaRegistroPublico
                                ,pstFecRegistro
                                ,pstNumFolioMec
                                ,pstDesOtrosDatosRegistro
                                ,pstIndMemo
                                ,pinNumSolicitadoPor
                                ,pstFecDocumentoMemo
                                ,pstFecRecibidoMemo
                                ,pstNumFolio
                                ,pstNumDocumentoMemo
                                ,pstIndDocEntrega
                                ,pstFecDocumentoEntrega
                                ,pstFecRecibidaEntrega
                                ,pstNumDocumentumEntrega
                                ,psIndOtros
                                ,pstFecDocumentoOtros
                                ,pstFecRecibidoOtros
                                ,pstNumDocumentumOtros
                                ,pstIndAplicaEstatus
                                ,pstNomSemaforoEstatus
                                ,pstFecProgEntregaEstatus
                                ,pstIndRedactada
                                ,pinNumRespRedactada
                                ,pstFecCumplimientoRedactada
                                ,pstIndRevisionGerente
                                ,pstNumRespGerente
                                ,pstFecCumplimientoGerente
                                ,pstIndCorrecciones
                                ,pinNumRespCorrecciones
                                ,pstFecCumplimientoCorrecciones
                                ,pstIndAutDireccion
                                ,pinNumRespAut
                                ,pstFecCumplimientoAut
                                ,pstIndFirmas
                                ,pinNumRespFirmas
                                ,pstFecCumplimientoFirmas
                                ,pstIndEntregada
                                ,pinNumRespEntregada
                                ,pstFecCumplimientoEntregada
                                ,pstNumEnviadaNotaria
                                ,pstFecEnvioNotaria
                                ,pstIndPoderAsunto
                                ,pstIndTipoArmado
                          );
EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
  END;
  END INSERT_PODERES_PR;
PROCEDURE DELETE_PODERES_PR(   pinIdPoder   NUMBER
                              ,pinIdEmpresa  NUMBER
                              ,pstOuterror   OUT VARCHAR2)
AS
BEGIN
    BEGIN
        UPDATE  DERCORP_PODERES_TAB
        SET     ID_STATUS  = 0
        WHERE   ID_PODER = pinIdPoder
        AND     ID_EMPRESA = pinIdEmpresa;
        COMMIT;
    EXCEPTION WHEN OTHERS
    THEN
    pstOuterror := SQLERRM;
    END;
END DELETE_PODERES_PR;
PROCEDURE UPDATE_PODERES_PR( pinIdPoder       			              NUMBER
                            ,pinIdEmpresa                         NUMBER
                            ,pstIntTipoPoder  			              VARCHAR2
                            ,pinIndDelegadoPor   	                NUMBER
                            ,pstFecFecha                          VARCHAR2
                            ,pstFecHora                           VARCHAR2
                            ,pstIndTipoDocumento                  VARCHAR2
                            ,pstDescEscritura                     VARCHAR2
                            ,pstFecOtorgamientoInstr              VARCHAR2
                            ,pstNumDocumentumInstr                VARCHAR2
                            ,pstIndRequiereProto                  VARCHAR2
                            ,pstIndRequiereInscrRppc              VARCHAR2
                            ,pstNomSemaforo                       VARCHAR2
                            ,pinNumLicenciado                     NUMBER
                            ,pstNomNotarioPublico                 VARCHAR2
                            ,pinNumDe                             NUMBER
                            ,pstDesSuplenciaAsociado              VARCHAR2
                            ,pstNumInscritaRegistroPublico        VARCHAR2
                            ,pstFecRegistro                       VARCHAR2
                            ,pstNumFolioMec                       VARCHAR2
                            ,pstDesOtrosDatosRegistro             VARCHAR2
                            ,pstIndMemo                           VARCHAR2
                            ,pinNumSolicitadoPor                  NUMBER
                            ,pstFecDocumentoMemo                  VARCHAR2
                            ,pstFecRecibidoMemo                   VARCHAR2
                            ,pstNumFolio                          VARCHAR2
                            ,pstNumDocumentoMemo                  VARCHAR2
                            ,pstIndDocEntrega                     VARCHAR2
                            ,pstFecDocumentoEntrega               VARCHAR2
                            ,pstFecRecibidaEntrega                VARCHAR2
                            ,pstNumDocumentumEntrega              VARCHAR2
                            ,psIndOtros                           VARCHAR2
                            ,pstFecDocumentoOtros                 VARCHAR2
                            ,pstFecRecibidoOtros                  VARCHAR2
                            ,pstNumDocumentumOtros                VARCHAR2
                            ,pstIndAplicaEstatus                  VARCHAR2
                            ,pstNomSemaforoEstatus                VARCHAR2
                            ,pstFecProgEntregaEstatus             VARCHAR2
                            ,pstIndRedactada                      VARCHAR2
                            ,pinNumRespRedactada                  NUMBER
                            ,pstFecCumplimientoRedactada          VARCHAR2
                            ,pstIndRevisionGerente                VARCHAR2
                            ,pstNumRespGerente                    NUMBER
                            ,pstFecCumplimientoGerente            VARCHAR2
                            ,pstIndCorrecciones                   VARCHAR2
                            ,pinNumRespCorrecciones               NUMBER
                            ,pstFecCumplimientoCorrecciones       VARCHAR2
                            ,pstIndAutDireccion                   VARCHAR2
                            ,pinNumRespAut                        NUMBER
                            ,pstFecCumplimientoAut                VARCHAR2
                            ,pstIndFirmas                         VARCHAR2
                            ,pinNumRespFirmas                     NUMBER
                            ,pstFecCumplimientoFirmas             VARCHAR2
                            ,pstIndEntregada                      VARCHAR2
                            ,pinNumRespEntregada                  NUMBER
                            ,pstFecCumplimientoEntregada          VARCHAR2
                            ,pstNumEnviadaNotaria                 VARCHAR2
                            ,pstFecEnvioNotaria                   VARCHAR2
                            ,pstIndPoderAsunto                    VARCHAR2
                            ,pstIndTipoArmado                     VARCHAR2
                            ,pstOuterror   OUT VARCHAR2)
AS
BEGIN
     BEGIN
        UPDATE DERCORP_PODERES_TAB
        SET        IN_TIPO_PODER			              =	pstIntTipoPoder
                  ,IND_DELEGADO_POR                 =	pinIndDelegadoPor
                  ,FEC_FECHA  			                =	sysdate--pstFecFecha
                  ,FEC_HORA 			                  =	pstFecHora
                  ,IND_TIPO_DOCUMENTO			          =	pstIndTipoDocumento
                  ,DES_ESCRITURA 			              =	pstDescEscritura
                  ,FEC_OTORGAMIENTO_INSTR	          =	pstFecOtorgamientoInstr
                  ,NUM_DOCUMENTUM_INSTR		          =	pstNumDocumentumInstr
                  ,IND_REQUIERE_PROTO			          =	pstIndRequiereProto
                  ,IND_REQUIERE_INSCR_RPPC	        =	pstIndRequiereInscrRppc
                  ,NOM_SEMAFORO      			          =	pstNomSemaforo
                  ,NUM_LICENCIADO 			            =	pinNumLicenciado
                  ,NOM_NOTARIO_PUBLICO			        =	pstNomNotarioPublico
                  ,NUM_DE			                      =	pinNumDe
                  ,DES_SUPLENCIA_ASOCIADO	          =	pstDesSuplenciaAsociado
                  ,NUM_INSCRITA_REGISTRO_PUBLICO    =	pstNumInscritaRegistroPublico
                  ,FEC_REGISTRO                			=	pstFecRegistro
                  ,NUM_FOLIO_MERC              			=	pstNumFolioMec
                  ,DES_OTROS_DATOS_REGISTRO    			=	pstDesOtrosDatosRegistro
                  ,IND_MEMO                    			=	pstIndMemo
                  ,NUM_SOLICITADO_POR          			=	pinNumSolicitadoPor
                  ,FEC_DOCUMENTO_MEMO          			=	pstFecDocumentoMemo
                  ,FEC_RECIBIDO_MEMO           			=	pstFecRecibidoMemo
                  ,NUM_FOLIO			                  =	pstNumFolio
                  ,NUM_DOCUMENTUM_MEMO			        =	pstNumDocumentoMemo
                  ,IND_DOC_ENTREGA             			=	pstIndDocEntrega
                  ,FEC_DOCUMENTO_ENTREGA       			=	pstFecDocumentoEntrega
                  ,FEC_RECIBIDO_ENTREGA        			=	pstFecRecibidaEntrega
                  ,NUM_DOCUMENTUM_ENTREGA      			=	pstNumDocumentumEntrega
                  ,IND_OTROS                   			=	psIndOtros
                  ,FEC_DOCUMENTO_OTROS         			=	pstFecDocumentoOtros
                  ,FEC_RECIBIDO_OTROS          			=	pstFecRecibidoOtros
                  ,NUM_DOCUMENTUM_OTROS        			=	pstNumDocumentumOtros
                  ,IND_APLICA_STATUS           			=	pstIndAplicaEstatus
                  ,NOM_SEMAFORO_STATUS         			=	pstNomSemaforoEstatus
                  ,FEC_PROG_ENTREGA_STATUS 			    =	pstFecProgEntregaEstatus
                  ,IND_REDACTADA               			=	pstIndRedactada
                  ,NUM_RESP_REDACTADA            		=	pinNumRespRedactada
                  ,FEC_CUMPLIMIENTO_REDACTADA    		=	pstFecCumplimientoRedactada
                  ,IND_REVISION_GERENTE        			=	pstIndRevisionGerente
                  ,NUM_RESP_GERENTE            			=	pstNumRespGerente
                  ,FEC_CUMPLIMIENTO_GERENTE    			=	pstFecCumplimientoGerente
                  ,IND_CORRECCIONES            			=	pstIndCorrecciones
                  ,NUM_RESP_CORRECCIONES       			=	pinNumRespCorrecciones
                  ,FEC_CUMPLIMIENTO_CORRECCIONES		=	pstFecCumplimientoCorrecciones
                  ,IND_AUT_DIRECCION           			=	pstIndAutDireccion
                  ,NUM_RESP_AUT                			=	pinNumRespAut
                  ,FEC_CUMPLIMIENTO_AUT        			=	pstFecCumplimientoAut
                  ,IND_FIRMAS                  			=	pstIndFirmas
                  ,NUM_RESP_FIRMAS             			=	pinNumRespFirmas
                  ,FEC_CUMPLIMIENTO_FIRMAS     			=	pstFecCumplimientoFirmas
                  ,IND_ENTREGADA               			=	pstIndEntregada
                  ,NUM_RESP_ENTREGADA          			=	pinNumRespEntregada
                  ,FEC_CUMPLIMIENTO_ENTREGADA  			=	pstFecCumplimientoEntregada
                  ,NUM_ENVIADA_NOTARIA         			=	pstNumEnviadaNotaria
                  ,FEC_ENVIO_NOTARIA			          =	pstFecEnvioNotaria
                  ,IND_PODER_ASUNTO			            =	pstIndPoderAsunto
                  ,IND_TIPO_ARMADO			            =	pstIndTipoArmado
        WHERE 1=1
        AND  ID_PODER   = pinIdPoder
        AND  ID_EMPRESA =	pinIdEmpresa;
        COMMIT;
    EXCEPTION WHEN OTHERS
    THEN
    pstOuterror := SQLERRM;
    END;
END UPDATE_PODERES_PR;
 PROCEDURE INSERT_CONTROL_PODERES_PR(pinIdPoder    NUMBER
                                    ,pinIdEmpresa  NUMBER
                                    ,idUser        NUMBER
                                    ,pstOuterror   OUT VARCHAR2)
AS
    BEGIN
           INSERT INTO DERCORP_CONTROL_PODERES_ROW
                                      (ID_USER,
                                       ID_EMPRESA,
                                       ID_PODER)
           VALUES                     (idUser,
                                       pinIdEmpresa,
                                       pinIdPoder);
END;
  PROCEDURE QUERY_CATALOGOS_PR (porcRSResultado OUT SYS_REFCURSOR, pinID_CATALOGO NUMBER)
  AS
    BEGIN
           OPEN porcRSResultado FOR
            SELECT *
              FROM DERCORP_ADD_CAMPO_CAT_VAL_TAB
              WHERE ID_CATALOGO = pinID_CATALOGO
              ORDER BY UPPER(TRANSLATE(VAL_CAT_VAL,'AEIOUaeiou','AEIOUAEIOU'));
  END QUERY_CATALOGOS_PR;
 PROCEDURE INSERT_ESCRITURA_PODER_PR(
                                   pinid_empresa NUMBER
                                  ,pstind_tipo_escritura varchar2
                                  ,pinnum_created_by number
                                  ,pinind_delegado_por NUMBER
                                  ,pstfec_fecha varchar2
                                  ,pstfec_hora varchar2
                                  ,pinind_requiere_proto NUMBER
                                  ,pinind_requiere_inscr_rppc NUMBER
                                  ,pstdes_escritura varchar2
                                  ,pstnum_documentum_instr varchar2
                                  ,pstfec_otorgamiento_instr varchar2
                                  ,pstnum_licenciado varchar2
                                  ,pstdes_suplencia_asociado varchar2
                                  ,pstfec_registro varchar2
                                  ,pstnum_folio_merc varchar2
                                  ,pstdes_otros_datos_registro varchar2
                                  ,pstdesc_apoderados varchar2
                                  ,pstdesc_asunto varchar2
                                  ,pstdes_revoca varchar2
                                  ,pinind_ok NUMBER
                                  ,pstfec_pe VARCHAR2
                                  ,pstind_status_ac VARCHAR2
                                  ,pinid_red_resp NUMBER
                                  ,pstdes_rep_resp VARCHAR2
                                  ,pstfec_rep VARCHAR2
                                  ,pinid_reg_resp NUMBER
                                  ,pstdes_reg_resp VARCHAR2
                                  ,pstfec_reg VARCHAR2
                                  ,pinid_cor_resp NUMBER
                                  ,pstdes_cor_resp VARCHAR2
                                  ,pstfec_cor VARCHAR2
                                  ,pinid_aut_resp NUMBER
                                  ,pstdes_aut_resp VARCHAR2
                                  ,pstfec_aut VARCHAR2
                                  ,pinid_fir_resp NUMBER
                                  ,pstdes_fir_resp VARCHAR2
                                  ,pstfec_fir VARCHAR2
                                  ,pinid_ent_resp NUMBER
                                  ,pstdes_ent_resp VARCHAR2
                                  ,pstfec_ent VARCHAR2
                                  ,pstid_sol_doc VARCHAR2
                                  ,pinid_sol_resp NUMBER
                                  ,pstdes_sol_resp VARCHAR2
                                  ,pstfec_sol VARCHAR2
                                  ,pstfec_sol_rec VARCHAR2
                                  ,pstdes_sol_folio VARCHAR2
                                  ,pstid_ent_doc VARCHAR2
                                  ,pstfec_ent_doc VARCHAR2
                                  ,pstfec_ent_rec VARCHAR2
                                  ,pinnum_insc_regpub VARCHAR2
                                  ,pstdes_insc_regpub VARCHAR2
                                  ,pstdes_caracteristicas VARCHAR2
                                   ,pinind_aplica_status NUMBER
                                  ,pinID_EP   OUT NUMBER
                                  ,pstOuterror OUT varchar2
                                  )
                                  AS
BEGIN
    BEGIN
    IF ( pstind_tipo_escritura = 'CP' ) THEN
     INSERT INTO PENDIUM_ESCRITURA_PODER_TAB (
                                ID_EMPRESA
                                ,IND_TIPO_ESCRITURA
                                ,IND_DELEGADO_POR
                                ,FEC_FECHA
                                ,FEC_HORA
                                ,IND_REQUIERE_PROTO
                                ,IND_REQUIERE_INSCR_RPPC
                                ,DES_ESCRITURA
                                ,NUM_DOCUMENTUM_INSTR
                                ,FEC_OTORGAMIENTO_INSTR
                                ,NUM_LICENCIADO
                                ,DES_SUPLENCIA_ASOCIADO
                                ,FEC_REGISTRO
                                ,NUM_FOLIO_MERC
                                ,DES_OTROS_DATOS_REGISTRO
                                ,NUM_CREATED_BY
                                ,FEC_CREATION_DATE
                                ,DESC_APODERADOS
                                ,DESC_ASUNTO
                                ,IND_STATUS
                                ,DES_REVOCA
                                ,IND_OK
                                ,FEC_PE
                                ,IND_STATUS_AC
                                ,ID_RED_RESP
                                ,DES_REP_RESP
                                ,FEC_REP
                                ,ID_REG_RESP
                                ,DES_REG_RESP
                                ,FEC_REG
                                ,ID_COR_RESP
                                ,DES_COR_RESP
                                ,FEC_COR
                                ,ID_AUT_RESP
                                ,DES_AUT_RESP
                                ,FEC_AUT
                                ,ID_FIR_RESP
                                ,DES_FIR_RESP
                                ,FEC_FIR
                                ,ID_ENT_RESP
                                ,DES_ENT_RESP
                                ,FEC_ENT
                                ,ID_SOL_DOC
                                ,ID_SOL_RESP
                                ,DES_SOL_RESP
                                ,FEC_SOL
                                ,FEC_SOL_REC
                                ,DES_SOL_FOLIO
                                ,ID_ENT_DOC
                                ,FEC_ENT_DOC
                                ,FEC_ENT_REC
                                ,NUM_INSC_REGPUB
                                ,DES_INSC_REGPUB
                                ,DES_CARACTERISTICAS
                                ,IND_APLICA_STATUS)
               VALUES          (
                                pinid_empresa
                                ,pstind_tipo_escritura
                                ,pinind_delegado_por
                                ,pstfec_fecha
                                ,pstfec_hora
                                ,0
                                ,0
                                ,NULL
                                ,pstnum_documentum_instr
                                ,NULL
                                ,NULL
                                ,NULL
                                ,NULL
                                ,NULL
                                ,NULL
                                ,pinnum_created_by
                                ,SYSDATE
                                ,pstdesc_apoderados
                                ,pstdesc_asunto
                                ,1
                                ,pstdes_revoca
                                ,pinind_ok
                                ,pstfec_pe
                                ,pstind_status_ac
                                ,pinid_red_resp
                                ,pstdes_rep_resp
                                ,pstfec_rep
                                ,pinid_reg_resp
                                ,pstdes_reg_resp
                                ,pstfec_reg
                                ,pinid_cor_resp
                                ,pstdes_cor_resp
                                ,pstfec_cor
                                ,pinid_aut_resp
                                ,pstdes_aut_resp
                                ,pstfec_aut
                                ,pinid_fir_resp
                                ,pstdes_fir_resp
                                ,pstfec_fir
                                ,pinid_ent_resp
                                ,pstdes_ent_resp
                                ,pstfec_ent
                                ,pstid_sol_doc
                                ,pinid_sol_resp
                                ,pstdes_sol_resp
                                ,pstfec_sol
                                ,pstfec_sol_rec
                                ,pstdes_sol_folio
                                ,pstid_ent_doc
                                ,pstfec_ent_doc
                                ,pstfec_ent_rec
                                ,pinnum_insc_regpub
                                ,pstdes_insc_regpub
                                ,pstdes_caracteristicas
                                 ,pinind_aplica_status
                                )
      returning ID_EP_PK into pinID_EP;
    ELSE
      INSERT INTO PENDIUM_ESCRITURA_PODER_TAB (
                                ID_EMPRESA
                                ,IND_TIPO_ESCRITURA
                                ,IND_DELEGADO_POR
                                ,FEC_FECHA
                                ,FEC_HORA
                                ,IND_REQUIERE_PROTO
                                ,IND_REQUIERE_INSCR_RPPC
                                ,DES_ESCRITURA
                                ,NUM_DOCUMENTUM_INSTR
                                ,FEC_OTORGAMIENTO_INSTR
                                ,NUM_LICENCIADO
                                ,DES_SUPLENCIA_ASOCIADO
                                ,FEC_REGISTRO
                                ,NUM_FOLIO_MERC
                                ,DES_OTROS_DATOS_REGISTRO
                                ,NUM_CREATED_BY
                                ,FEC_CREATION_DATE
                                ,DESC_APODERADOS
                                ,DESC_ASUNTO
                                ,IND_STATUS
                                ,DES_REVOCA
                                ,IND_OK
                                ,FEC_PE
                                ,IND_STATUS_AC
                                ,ID_RED_RESP
                                ,DES_REP_RESP
                                ,FEC_REP
                                ,ID_REG_RESP
                                ,DES_REG_RESP
                                ,FEC_REG
                                ,ID_COR_RESP
                                ,DES_COR_RESP
                                ,FEC_COR
                                ,ID_AUT_RESP
                                ,DES_AUT_RESP
                                ,FEC_AUT
                                ,ID_FIR_RESP
                                ,DES_FIR_RESP
                                ,FEC_FIR
                                ,ID_ENT_RESP
                                ,DES_ENT_RESP
                                ,FEC_ENT
                                ,ID_SOL_DOC
                                ,ID_SOL_RESP
                                ,DES_SOL_RESP
                                ,FEC_SOL
                                ,FEC_SOL_REC
                                ,DES_SOL_FOLIO
                                ,ID_ENT_DOC
                                ,FEC_ENT_DOC
                                ,FEC_ENT_REC
                                ,NUM_INSC_REGPUB
                                ,DES_INSC_REGPUB
                                ,DES_CARACTERISTICAS
                                ,IND_APLICA_STATUS)
               VALUES          (
                                pinid_empresa
                                ,pstind_tipo_escritura
                                ,pinind_delegado_por
                                ,pstfec_fecha
                                ,pstfec_hora
                                ,pinind_requiere_proto
                                ,pinind_requiere_inscr_rppc
                                ,pstdes_escritura
                                ,pstnum_documentum_instr
                                ,pstfec_otorgamiento_instr
                                ,pstnum_licenciado
                                ,pstdes_suplencia_asociado
                                ,pstfec_registro
                                ,pstnum_folio_merc
                                ,pstdes_otros_datos_registro
                                ,pinnum_created_by
                                ,SYSDATE
                                ,pstdesc_apoderados
                                ,pstdesc_asunto
                                ,1
                                ,pstdes_revoca
                                ,pinind_ok
                                ,pstfec_pe
                                ,pstind_status_ac
                                ,pinid_red_resp
                                ,pstdes_rep_resp
                                ,pstfec_rep
                                ,pinid_reg_resp
                                ,pstdes_reg_resp
                                ,pstfec_reg
                                ,pinid_cor_resp
                                ,pstdes_cor_resp
                                ,pstfec_cor
                                ,pinid_aut_resp
                                ,pstdes_aut_resp
                                ,pstfec_aut
                                ,pinid_fir_resp
                                ,pstdes_fir_resp
                                ,pstfec_fir
                                ,pinid_ent_resp
                                ,pstdes_ent_resp
                                ,pstfec_ent
                                ,pstid_sol_doc
                                ,pinid_sol_resp
                                ,pstdes_sol_resp
                                ,pstfec_sol
                                ,pstfec_sol_rec
                                ,pstdes_sol_folio
                                ,pstid_ent_doc
                                ,pstfec_ent_doc
                                ,pstfec_ent_rec
                                ,pinnum_insc_regpub
                                ,pstdes_insc_regpub
                                ,pstdes_caracteristicas
                                 ,pinind_aplica_status
                                )
 returning ID_EP_PK into pinID_EP;
 END IF;
EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
  END;
  END INSERT_ESCRITURA_PODER_PR;
PROCEDURE UPDATE_ESCRITURA_PODER_PR(
                                   pinid_ep_pk NUMBER
                                  ,pstind_tipo_escritura varchar2
                                  ,pinnum_created_by number
                                  ,pinind_delegado_por NUMBER
                                  ,pstfec_fecha varchar2
                                  ,pstfec_hora varchar2
                                  ,pinind_requiere_proto NUMBER
                                  ,pinind_requiere_inscr_rppc NUMBER
                                  ,pstdes_escritura varchar2
                                  ,pstnum_documentum_instr varchar2
                                  ,pstfec_otorgamiento_instr varchar2
                                  ,pstnum_licenciado varchar2
                                  ,pstdes_suplencia_asociado varchar2
                                  ,pstfec_registro varchar2
                                  ,pstnum_folio_merc varchar2
                                  ,pstdes_otros_datos_registro varchar2
                                  ,pstind_status_esc VARCHAR2
                                  ,pstind_status_rppc VARCHAR2
                                  ,pstdesc_apoderados varchar2
                                  ,pstdesc_asunto varchar2
                                  ,pstdes_revoca varchar2
                                  ,pinind_ok NUMBER
                                  ,pstfec_pe VARCHAR2
                                  ,pstind_status_ac VARCHAR2
                                  ,pinid_red_resp NUMBER
                                  ,pstdes_rep_resp VARCHAR2
                                  ,pstfec_rep VARCHAR2
                                  ,pinid_reg_resp NUMBER
                                  ,pstdes_reg_resp VARCHAR2
                                  ,pstfec_reg VARCHAR2
                                  ,pinid_cor_resp NUMBER
                                  ,pstdes_cor_resp VARCHAR2
                                  ,pstfec_cor VARCHAR2
                                  ,pinid_aut_resp NUMBER
                                  ,pstdes_aut_resp VARCHAR2
                                  ,pstfec_aut VARCHAR2
                                  ,pinid_fir_resp NUMBER
                                  ,pstdes_fir_resp VARCHAR2
                                  ,pstfec_fir VARCHAR2
                                  ,pinid_ent_resp NUMBER
                                  ,pstdes_ent_resp VARCHAR2
                                  ,pstfec_ent VARCHAR2
                                  ,pstid_sol_doc VARCHAR2
                                  ,pinid_sol_resp NUMBER
                                  ,pstdes_sol_resp VARCHAR2
                                  ,pstfec_sol VARCHAR2
                                  ,pstfec_sol_rec VARCHAR2
                                  ,pstdes_sol_folio VARCHAR2
                                  ,pstid_ent_doc VARCHAR2
                                  ,pstfec_ent_doc VARCHAR2
                                  ,pstfec_ent_rec VARCHAR2
                                  ,pinnum_insc_regpub VARCHAR2
                                  ,pstdes_insc_regpub VARCHAR2
                                  ,pstdes_caracteristicas VARCHAR2
                                  ,pinind_aplica_status NUMBER
                                  ,pstOuterror OUT varchar2)
AS
  BEGIN
        UPDATE PENDIUM_ESCRITURA_PODER_TAB
          SET  IND_TIPO_ESCRITURA      =    pstind_tipo_escritura
              ,IND_DELEGADO_POR        =    pinind_delegado_por
              ,FEC_FECHA               =    pstfec_fecha
              ,FEC_HORA                =    pstfec_hora
              ,IND_REQUIERE_PROTO      =    pinind_requiere_proto
              ,IND_REQUIERE_INSCR_RPPC =    pinind_requiere_inscr_rppc
              ,DES_ESCRITURA           =    pstdes_escritura
              ,NUM_DOCUMENTUM_INSTR    =    pstnum_documentum_instr
              ,FEC_OTORGAMIENTO_INSTR  =    pstfec_otorgamiento_instr
              ,NUM_LICENCIADO          =    pstnum_licenciado
              ,DES_SUPLENCIA_ASOCIADO  =    pstdes_suplencia_asociado
              ,FEC_REGISTRO            =    pstfec_registro
              ,NUM_FOLIO_MERC          =    pstnum_folio_merc
              ,DES_OTROS_DATOS_REGISTRO=    pstdes_otros_datos_registro
              ,DESC_APODERADOS         =    pstdesc_apoderados
              ,DESC_ASUNTO             =    pstdesc_asunto
              ,IND_STATUS_ESC          =    pstind_status_esc
              ,IND_STATUS_RPPC         =    pstind_status_rppc
              ,DES_REVOCA              =    pstdes_revoca
              ,IND_OK=pinind_ok
              ,FEC_PE=pstfec_pe
              ,IND_STATUS_AC=pstind_status_ac
              ,ID_RED_RESP=pinid_red_resp
              ,DES_REP_RESP=pstdes_rep_resp
              ,FEC_REP=pstfec_rep
              ,ID_REG_RESP=pinid_reg_resp
              ,DES_REG_RESP=pstdes_reg_resp
              ,FEC_REG=pstfec_reg
              ,ID_COR_RESP=pinid_cor_resp
              ,DES_COR_RESP=pstdes_cor_resp
              ,FEC_COR=pstfec_cor
              ,ID_AUT_RESP=pinid_aut_resp
              ,DES_AUT_RESP=pstdes_aut_resp
              ,FEC_AUT=pstfec_aut
              ,ID_FIR_RESP=pinid_fir_resp
              ,DES_FIR_RESP=pstdes_fir_resp
              ,FEC_FIR=pstfec_fir
              ,ID_ENT_RESP=pinid_ent_resp
              ,DES_ENT_RESP=pstdes_ent_resp
              ,FEC_ENT=pstfec_ent
              ,ID_SOL_DOC=pstid_sol_doc
              ,ID_SOL_RESP=pinid_sol_resp
              ,DES_SOL_RESP=pstdes_sol_resp
              ,FEC_SOL=pstfec_sol
              ,FEC_SOL_REC=pstfec_sol_rec
              ,DES_SOL_FOLIO=pstdes_sol_folio
              ,ID_ENT_DOC=pstid_ent_doc
              ,FEC_ENT_DOC=pstfec_ent_doc
              ,FEC_ENT_REC=pstfec_ent_rec
              ,NUM_INSC_REGPUB=pinnum_insc_regpub
              ,DES_INSC_REGPUB=pstdes_insc_regpub
              ,DES_CARACTERISTICAS = pstdes_caracteristicas
              ,IND_APLICA_STATUS = pinind_aplica_status
              ,NUM_LAST_UPDATED_BY = pinnum_created_by
              ,FEC_LAST_UPDATE_DATE  = SYSDATE
        WHERE ID_EP_PK                 =    pinid_ep_pk;
        delete from PENDIUM_OTORGAPODER_EP_TAB where ID_EP_FK = pinid_ep_pk;
        delete from PENDIUM_APODERADO_EP_TAB where ID_EP_FK = pinid_ep_pk;
        delete from PENDIUM_DOCUMENTUMS_EP_TAB where ID_EP_FK = pinid_ep_pk;
        delete from PENDIUM_FACULTADES_EP_TAB where ID_EP_FK = pinid_ep_pk;
        delete from PENDIUM_REVOCA_EP_TAB where ID_EP_FK = pinid_ep_pk;
        COMMIT;
  EXCEPTION WHEN OTHERS
    THEN
    pstOuterror := SQLERRM;
END;
PROCEDURE DELETE_ESCRITURA_PODER_PR(pstResultado OUT VARCHAR2
                                    ,pinid_ep_pk NUMBER
                                    ,psinnum_last_updated_by NUMBER)
AS
  BEGIN
      UPDATE PENDIUM_ESCRITURA_PODER_TAB
      SET    IND_STATUS             =   0
            ,NUM_LAST_UPDATED_BY    =   psinnum_last_updated_by
            ,FEC_LAST_UPDATE_DATE   =   sysdate
      WHERE  ID_EP_PK               =   pinid_ep_pk;
      COMMIT;
EXCEPTION WHEN OTHERS
    THEN
    pstResultado := SQLERRM;
END;
PROCEDURE QUERY_ESCRITURA_PODER_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_empresa NUMBER
                                    ,pstind_tipo_escritura varchar2)
  AS
    BEGIN
          IF pstind_tipo_escritura = 'CP' THEN
              OPEN porcRSResultado FOR
                SELECT   ID_EP_PK,
                          ID_EMPRESA,
                          IND_TIPO_ESCRITURA,
                          IND_DELEGADO_POR,
                          FEC_FECHA,
                          FEC_HORA,
                          IND_REQUIERE_PROTO,
                          IND_REQUIERE_INSCR_RPPC,
                          DES_ESCRITURA,
                          NUM_DOCUMENTUM_INSTR,
                          FEC_OTORGAMIENTO_INSTR,
                          NUM_LICENCIADO,
                          DES_SUPLENCIA_ASOCIADO,
                          FEC_REGISTRO,
                          NUM_FOLIO_MERC,
                          DES_OTROS_DATOS_REGISTRO,
                          IND_STATUS_ESC,
                          IND_STATUS_RPPC,
                          NUM_CREATED_BY,
                          FEC_CREATION_DATE,
                          NUM_LAST_UPDATED_BY,
                          FEC_LAST_UPDATE_DATE,
                          NUM_LAST_UPDATE_LOGIN,
                          ATRIBUTO1,
                          ATRIBUTO2,
                          ATRIBUTO3,
                          ATRIBUTO4,
                          ATRIBUTO5,
                          ATRIBUTO6,
                          ATRIBUTO7,
                          ATRIBUTO8,
                          ATRIBUTO9,
                          ATRIBUTO10,
                          ATRIBUTO11,
                          ATRIBUTO12,
                          ATRIBUTO13,
                          ATRIBUTO14,
                          ATRIBUTO15,
                          ATTRIBUTE_CATEGORY,
                          DESC_ASUNTO,
                          IND_STATUS,
                          DES_REVOCA,
                          IND_OK,
                          FEC_PE,
                          IND_STATUS_AC,
                          ID_RED_RESP,
                          DES_REP_RESP,
                          FEC_REP,
                          ID_REG_RESP,
                          DES_REG_RESP,
                          FEC_REG,
                          ID_COR_RESP,
                          DES_COR_RESP,
                          FEC_COR,
                          ID_AUT_RESP,
                          DES_AUT_RESP,
                          FEC_AUT,
                          ID_FIR_RESP,
                          DES_FIR_RESP,
                          FEC_FIR,
                          ID_ENT_RESP,
                          DES_ENT_RESP,
                          FEC_ENT,
                          ID_SOL_DOC,
                          ID_SOL_RESP,
                          DES_SOL_RESP,
                          FEC_SOL,
                          FEC_SOL_REC,
                          DES_SOL_FOLIO,
                          ID_ENT_DOC,
                          FEC_ENT_DOC,
                          FEC_ENT_REC,
                          NUM_INSC_REGPUB,
                          DES_INSC_REGPUB,
                          DES_CARACTERISTICAS,
                          IND_APLICA_STATUS,
                          DESC_APODERADOS
                  FROM PENDIUM_ESCRITURA_PODER_TAB
                  WHERE
                    ID_EMPRESA          = pinid_empresa AND
                    IND_TIPO_ESCRITURA  = pstind_tipo_escritura AND
                    IND_STATUS           = 1
                ORDER BY CASE WHEN FEC_FECHA IS NULL THEN TO_DATE('31/12/2999','DD/MM/YYYY') ELSE TO_DATE(FEC_FECHA,'DD/MM/YYYY') END DESC;
          ELSE
              OPEN porcRSResultado FOR
                  SELECT ID_EP_PK,
                          ID_EMPRESA,
                          IND_TIPO_ESCRITURA,
                          IND_DELEGADO_POR,
                          FEC_FECHA,
                          FEC_HORA,
                          IND_REQUIERE_PROTO,
                          IND_REQUIERE_INSCR_RPPC,
                          (CASE WHEN IND_REQUIERE_PROTO=1 AND DES_ESCRITURA IS NOT NULL THEN
                          DES_ESCRITURA ELSE 'N/A' END) DES_ESCRITURA,
                          NUM_DOCUMENTUM_INSTR,
                          FEC_OTORGAMIENTO_INSTR,
                          (CASE WHEN IND_REQUIERE_PROTO=1 AND FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                          FEC_OTORGAMIENTO_INSTR ELSE FEC_FECHA END) FEC_FECHA_ESCRITURA,
                          NUM_LICENCIADO,
                          DES_SUPLENCIA_ASOCIADO,
                          FEC_REGISTRO,
                          NUM_FOLIO_MERC,
                          DES_OTROS_DATOS_REGISTRO,
                          IND_STATUS_ESC,
                          IND_STATUS_RPPC,
                          NUM_CREATED_BY,
                          FEC_CREATION_DATE,
                          NUM_LAST_UPDATED_BY,
                          FEC_LAST_UPDATE_DATE,
                          NUM_LAST_UPDATE_LOGIN,
                          ATRIBUTO1,
                          ATRIBUTO2,
                          ATRIBUTO3,
                          ATRIBUTO4,
                          ATRIBUTO5,
                          ATRIBUTO6,
                          ATRIBUTO7,
                          ATRIBUTO8,
                          ATRIBUTO9,
                          ATRIBUTO10,
                          ATRIBUTO11,
                          ATRIBUTO12,
                          ATRIBUTO13,
                          ATRIBUTO14,
                          ATRIBUTO15,
                          ATTRIBUTE_CATEGORY,
                          DESC_ASUNTO,
                          IND_STATUS,
                          DES_REVOCA,
                          IND_OK,
                          FEC_PE,
                          IND_STATUS_AC,
                          ID_RED_RESP,
                          DES_REP_RESP,
                          FEC_REP,
                          ID_REG_RESP,
                          DES_REG_RESP,
                          FEC_REG,
                          ID_COR_RESP,
                          DES_COR_RESP,
                          FEC_COR,
                          ID_AUT_RESP,
                          DES_AUT_RESP,
                          FEC_AUT,
                          ID_FIR_RESP,
                          DES_FIR_RESP,
                          FEC_FIR,
                          ID_ENT_RESP,
                          DES_ENT_RESP,
                          FEC_ENT,
                          ID_SOL_DOC,
                          ID_SOL_RESP,
                          DES_SOL_RESP,
                          FEC_SOL,
                          FEC_SOL_REC,
                          DES_SOL_FOLIO,
                          ID_ENT_DOC,
                          FEC_ENT_DOC,
                          FEC_ENT_REC,
                          NUM_INSC_REGPUB,
                          DES_INSC_REGPUB,
                          DES_CARACTERISTICAS,
                          IND_APLICA_STATUS,
                          DESC_APODERADOS
                  FROM PENDIUM_ESCRITURA_PODER_TAB
                  WHERE
                  ID_EMPRESA          = pinid_empresa AND
                  IND_TIPO_ESCRITURA  = pstind_tipo_escritura AND
                  IND_STATUS           = 1
                 ORDER BY CASE WHEN FEC_FECHA_ESCRITURA IS NOT NULL THEN TO_DATE(FEC_FECHA_ESCRITURA,'DD/MM/YYYY') ELSE TO_DATE('31/12/2999','DD/MM/YYYY') END DESC
                ,CASE WHEN DES_ESCRITURA IS NULL OR DES_ESCRITURA='N/A' THEN 99999999 ELSE TO_NUMBER(REPLACE(DES_ESCRITURA,',','')) END DESC;
        END IF;
END QUERY_ESCRITURA_PODER_PR;
PROCEDURE QUERY_ESCRITURA_PODER_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_empresa NUMBER
                                    ,pstind_tipo_escritura varchar2
                                    ,pstdesc_busqueda varchar2)
  AS
    BEGIN
          IF pstind_tipo_escritura = 'CP' THEN
              OPEN porcRSResultado FOR
                  SELECT ID_EP_PK,
                          ID_EMPRESA,
                          IND_TIPO_ESCRITURA,
                          IND_DELEGADO_POR,
                          FEC_FECHA,
                          FEC_HORA,
                          IND_REQUIERE_PROTO,
                          IND_REQUIERE_INSCR_RPPC,
                          DES_ESCRITURA,
                          NUM_DOCUMENTUM_INSTR,
                          FEC_OTORGAMIENTO_INSTR,
                          NUM_LICENCIADO,
                          DES_SUPLENCIA_ASOCIADO,
                          FEC_REGISTRO,
                          NUM_FOLIO_MERC,
                          DES_OTROS_DATOS_REGISTRO,
                          IND_STATUS_ESC,
                          IND_STATUS_RPPC,
                          NUM_CREATED_BY,
                          FEC_CREATION_DATE,
                          NUM_LAST_UPDATED_BY,
                          FEC_LAST_UPDATE_DATE,
                          NUM_LAST_UPDATE_LOGIN,
                          ATRIBUTO1,
                          ATRIBUTO2,
                          ATRIBUTO3,
                          ATRIBUTO4,
                          ATRIBUTO5,
                          ATRIBUTO6,
                          ATRIBUTO7,
                          ATRIBUTO8,
                          ATRIBUTO9,
                          ATRIBUTO10,
                          ATRIBUTO11,
                          ATRIBUTO12,
                          ATRIBUTO13,
                          ATRIBUTO14,
                          ATRIBUTO15,
                          ATTRIBUTE_CATEGORY,
                          DESC_ASUNTO,
                          IND_STATUS,
                          DES_REVOCA,
                          IND_OK,
                          FEC_PE,
                          IND_STATUS_AC,
                          ID_RED_RESP,
                          DES_REP_RESP,
                          FEC_REP,
                          ID_REG_RESP,
                          DES_REG_RESP,
                          FEC_REG,
                          ID_COR_RESP,
                          DES_COR_RESP,
                          FEC_COR,
                          ID_AUT_RESP,
                          DES_AUT_RESP,
                          FEC_AUT,
                          ID_FIR_RESP,
                          DES_FIR_RESP,
                          FEC_FIR,
                          ID_ENT_RESP,
                          DES_ENT_RESP,
                          FEC_ENT,
                          ID_SOL_DOC,
                          ID_SOL_RESP,
                          DES_SOL_RESP,
                          FEC_SOL,
                          FEC_SOL_REC,
                          DES_SOL_FOLIO,
                          ID_ENT_DOC,
                          FEC_ENT_DOC,
                          FEC_ENT_REC,
                          NUM_INSC_REGPUB,
                          DES_INSC_REGPUB,
                          DES_CARACTERISTICAS,
                          IND_APLICA_STATUS,
                          DESC_APODERADOS
                  FROM PENDIUM_ESCRITURA_PODER_TAB
                  WHERE
                      ID_EMPRESA                  = pinid_empresa AND
                      IND_TIPO_ESCRITURA          = pstind_tipo_escritura AND
                      IND_STATUS                  = 1 AND
                    (LOWER(DESC_ASUNTO)         LIKE  '%'||pstdesc_busqueda||'%' OR
                    LOWER(DESC_APODERADOS)      LIKE  '%' || LOWER(pstdesc_busqueda) || '%'
                    OR LOWER(DES_CARACTERISTICAS) LIKE  '%' || LOWER(pstdesc_busqueda) || '%'
                    )
                ORDER BY CASE WHEN FEC_FECHA IS NULL THEN TO_DATE('31/12/2999','DD/MM/YYYY') ELSE TO_DATE(FEC_FECHA,'DD/MM/YYYY') END DESC;
          ELSE
              OPEN porcRSResultado FOR
                  SELECT ID_EP_PK,
                          ID_EMPRESA,
                          IND_TIPO_ESCRITURA,
                          IND_DELEGADO_POR,
                          FEC_FECHA,
                          FEC_HORA,
                          IND_REQUIERE_PROTO,
                          IND_REQUIERE_INSCR_RPPC,
                          (CASE WHEN IND_REQUIERE_PROTO=1 AND DES_ESCRITURA IS NOT NULL THEN
                          DES_ESCRITURA ELSE 'N/A' END) DES_ESCRITURA,
                          NUM_DOCUMENTUM_INSTR,
                          FEC_OTORGAMIENTO_INSTR,
                          (CASE WHEN IND_REQUIERE_PROTO=1 AND FEC_OTORGAMIENTO_INSTR IS NOT NULL THEN
                          FEC_OTORGAMIENTO_INSTR ELSE FEC_FECHA END) FEC_FECHA_ESCRITURA,
                          NUM_LICENCIADO,
                          DES_SUPLENCIA_ASOCIADO,
                          FEC_REGISTRO,
                          NUM_FOLIO_MERC,
                          DES_OTROS_DATOS_REGISTRO,
                          IND_STATUS_ESC,
                          IND_STATUS_RPPC,
                          NUM_CREATED_BY,
                          FEC_CREATION_DATE,
                          NUM_LAST_UPDATED_BY,
                          FEC_LAST_UPDATE_DATE,
                          NUM_LAST_UPDATE_LOGIN,
                          ATRIBUTO1,
                          ATRIBUTO2,
                          ATRIBUTO3,
                          ATRIBUTO4,
                          ATRIBUTO5,
                          ATRIBUTO6,
                          ATRIBUTO7,
                          ATRIBUTO8,
                          ATRIBUTO9,
                          ATRIBUTO10,
                          ATRIBUTO11,
                          ATRIBUTO12,
                          ATRIBUTO13,
                          ATRIBUTO14,
                          ATRIBUTO15,
                          ATTRIBUTE_CATEGORY,
                          DESC_ASUNTO,
                          IND_STATUS,
                          DES_REVOCA,
                          IND_OK,
                          FEC_PE,
                          IND_STATUS_AC,
                          ID_RED_RESP,
                          DES_REP_RESP,
                          FEC_REP,
                          ID_REG_RESP,
                          DES_REG_RESP,
                          FEC_REG,
                          ID_COR_RESP,
                          DES_COR_RESP,
                          FEC_COR,
                          ID_AUT_RESP,
                          DES_AUT_RESP,
                          FEC_AUT,
                          ID_FIR_RESP,
                          DES_FIR_RESP,
                          FEC_FIR,
                          ID_ENT_RESP,
                          DES_ENT_RESP,
                          FEC_ENT,
                          ID_SOL_DOC,
                          ID_SOL_RESP,
                          DES_SOL_RESP,
                          FEC_SOL,
                          FEC_SOL_REC,
                          DES_SOL_FOLIO,
                          ID_ENT_DOC,
                          FEC_ENT_DOC,
                          FEC_ENT_REC,
                          NUM_INSC_REGPUB,
                          DES_INSC_REGPUB,
                          DES_CARACTERISTICAS,
                          IND_APLICA_STATUS,
                          DESC_APODERADOS
                  FROM PENDIUM_ESCRITURA_PODER_TAB
                  WHERE
                      ID_EMPRESA                 = pinid_empresa AND
                      IND_TIPO_ESCRITURA         = pstind_tipo_escritura AND
                      IND_STATUS                 = 1 AND
                      (DES_ESCRITURA             LIKE  '%' || pstdesc_busqueda || '%' OR
                      REGEXP_REPLACE(LOWER(DESC_APODERADOS),'([[:digit:]])','')      LIKE  '%' || LOWER(pstdesc_busqueda) || '%'
                      OR REGEXP_REPLACE(LOWER(DES_CARACTERISTICAS),'([[:digit:]])','')  LIKE  '%' || LOWER(pstdesc_busqueda) || '%'
                      )
                ORDER BY CASE WHEN FEC_FECHA_ESCRITURA IS NOT NULL THEN TO_DATE(FEC_FECHA_ESCRITURA,'DD/MM/YYYY') ELSE TO_DATE('31/12/2999','DD/MM/YYYY') END DESC
                , CASE WHEN DES_ESCRITURA IS NULL OR DES_ESCRITURA='N/A' THEN 99999999 ELSE TO_NUMBER(REPLACE(DES_ESCRITURA,',','')) END DESC;
        END IF;
END QUERY_ESCRITURA_PODER_PR;
PROCEDURE QUERY_ESCRITURA_PODER_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_escritura NUMBER
                                    )
AS
    BEGIN
              OPEN porcRSResultado FOR
                  SELECT ID_EP_PK,
                          ID_EMPRESA,
                          IND_TIPO_ESCRITURA,
                          IND_DELEGADO_POR,
                          FEC_FECHA,
                          FEC_HORA,
                          IND_REQUIERE_PROTO,
                          IND_REQUIERE_INSCR_RPPC,
                          DES_ESCRITURA,
                          NUM_DOCUMENTUM_INSTR,
                          FEC_OTORGAMIENTO_INSTR,
                          NUM_LICENCIADO,
                          DES_SUPLENCIA_ASOCIADO,
                          FEC_REGISTRO,
                          NUM_FOLIO_MERC,
                          DES_OTROS_DATOS_REGISTRO,
                          IND_STATUS_ESC,
                          IND_STATUS_RPPC,
                          NUM_CREATED_BY,
                          FEC_CREATION_DATE,
                          NUM_LAST_UPDATED_BY,
                          FEC_LAST_UPDATE_DATE,
                          NUM_LAST_UPDATE_LOGIN,
                          ATRIBUTO1,
                          ATRIBUTO2,
                          ATRIBUTO3,
                          ATRIBUTO4,
                          ATRIBUTO5,
                          ATRIBUTO6,
                          ATRIBUTO7,
                          ATRIBUTO8,
                          ATRIBUTO9,
                          ATRIBUTO10,
                          ATRIBUTO11,
                          ATRIBUTO12,
                          ATRIBUTO13,
                          ATRIBUTO14,
                          ATRIBUTO15,
                          ATTRIBUTE_CATEGORY,
                          DESC_ASUNTO,
                          IND_STATUS,
                          DES_REVOCA,
                          IND_OK,
                          FEC_PE,
                          IND_STATUS_AC,
                          ID_RED_RESP,
                          DES_REP_RESP,
                          FEC_REP,
                          ID_REG_RESP,
                          DES_REG_RESP,
                          FEC_REG,
                          ID_COR_RESP,
                          DES_COR_RESP,
                          FEC_COR,
                          ID_AUT_RESP,
                          DES_AUT_RESP,
                          FEC_AUT,
                          ID_FIR_RESP,
                          DES_FIR_RESP,
                          FEC_FIR,
                          ID_ENT_RESP,
                          DES_ENT_RESP,
                          FEC_ENT,
                          ID_SOL_DOC,
                          ID_SOL_RESP,
                          DES_SOL_RESP,
                          FEC_SOL,
                          FEC_SOL_REC,
                          DES_SOL_FOLIO,
                          ID_ENT_DOC,
                          FEC_ENT_DOC,
                          FEC_ENT_REC,
                          NUM_INSC_REGPUB,
                          DES_INSC_REGPUB,
                          DES_CARACTERISTICAS,
                          IND_APLICA_STATUS,
                          DESC_APODERADOS
                  FROM PENDIUM_ESCRITURA_PODER_TAB
                  WHERE
                  ID_EP_PK          =  pinid_escritura;
END   QUERY_ESCRITURA_PODER_PR;
PROCEDURE INSERT_DOCUMENTUMS_EP_PR (  pinid_ep_fk NUMBER
                                    ,pstdesc_title VARCHAR2
                                    ,pstid_documentcve VARCHAR2
                                    ,pstfec_rec VARCHAR2
                                    ,pstfec_ent VARCHAR2
                                    ,pinID_EP OUT NUMBER
                                    ,pstOuterror OUT varchar2)
AS
  pinnum_created_by NUMBER;
BEGIN
        select NUM_LAST_UPDATED_BY into pinnum_created_by from PENDIUM_ESCRITURA_PODER_TAB where ID_EP_PK = pinid_ep_fk;
        INSERT INTO PENDIUM_DOCUMENTUMS_EP_TAB (
                                                 ID_EP_FK
                                                ,DESC_TITLE
                                                ,ID_DOCUMENTCVE
                                                ,IND_STATUS
                                                ,FEC_REC
                                                ,FEC_ENT
                                                ,NUM_LAST_UPDATE_LOGIN
                                                ,FEC_CREATION_DATE
                                                ,NUM_LAST_UPDATED_BY
                                                ,FEC_LAST_UPDATE_DATE)
        VALUES(
                 pinid_ep_fk
                ,pstdesc_title
                ,pstid_documentcve
                ,1
                ,pstfec_rec
                ,pstfec_ent
                ,pinnum_created_by
                ,SYSDATE
                ,pinnum_created_by
                ,SYSDATE
              )
      returning ID_DOC_EP_PK into pinID_EP;
EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
  END;
PROCEDURE UPDATE_DOCUMENTUMS_EP_PR ( pinid_doc_ep_fk NUMBER
                                    ,pstdesc_title VARCHAR2
                                    ,pstid_documentcve VARCHAR2
                                    ,psinnum_last_updated_by NUMBER
                                    ,pstfec_rec VARCHAR2
                                    ,pstfec_ent VARCHAR2
                                    ,pstOuterror OUT varchar2)
AS
  BEGIN
        UPDATE PENDIUM_DOCUMENTUMS_EP_TAB
          SET   DESC_TITLE            =   pstdesc_title
               ,ID_DOCUMENTCVE        =   pstid_documentcve
               ,NUM_LAST_UPDATED_BY   =   psinnum_last_updated_by
               ,FEC_LAST_UPDATE_DATE  =   sysdate
               ,FEC_REC               =   pstfec_rec
               ,FEC_ENT               =   pstfec_ent
        WHERE   ID_DOC_EP_PK          =   pinid_doc_ep_fk;
        COMMIT;
EXCEPTION
          WHEN OTHERS THEN
          pstOuterror := SQLERRM;
END;
PROCEDURE DELETE_DOCUMENTUMS_EP_PR(
                                   pinid_ep_fk NUMBER
                                  ,psinnum_last_updated_by NUMBER
                                  ,pstOuterror OUT varchar2)
AS
  BEGIN
        UPDATE PENDIUM_DOCUMENTUMS_EP_TAB
        SET     IND_STATUS             =   0
               ,NUM_LAST_UPDATED_BY   =   psinnum_last_updated_by
               ,FEC_LAST_UPDATE_DATE  =   sysdate
        WHERE   ID_EP_FK          =   pinid_ep_fk;
        COMMIT;
EXCEPTION
          WHEN OTHERS THEN
          pstOuterror := SQLERRM;
END;
PROCEDURE QUERY_DOCUMENTUMS_EP_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_ep_fk NUMBER)
AS
    BEGIN
           OPEN porcRSResultado FOR
            SELECT
              *
              FROM PENDIUM_DOCUMENTUMS_EP_TAB
                WHERE
                  ID_EP_FK  = pinid_ep_fk AND
                  IND_STATUS = 1
              ORDER BY DESC_TITLE;
    END QUERY_DOCUMENTUMS_EP_PR;
PROCEDURE INSERT_OTORGAPODER_EP_PR (pinid_ep_fk NUMBER
                                    ,pinnum_podertipo NUMBER
                                    ,pstdes_podertipo VARCHAR2
                                    ,pinnum_vigenciatipo NUMBER
                                    ,pstdes_vigenciatipo VARCHAR2
                                    ,pinnum_vigenciatiempo NUMBER
                                    ,pstfec_vigenciainicio VARCHAR2
                                    ,pstfec_vigenciafin VARCHAR2
                                    ,pstdesc_caracteristicas VARCHAR2
                                    ,pstdesc_descripcion VARCHAR2
                                    ,pstdesc_apoderados CLOB
                                    ,pstdesc_actosdominio VARCHAR2
                                    ,pstdesc_actosadmon VARCHAR2
                                    ,pstdesc_pleitoscobranza VARCHAR2
                                    ,pstdesc_tituloscredito VARCHAR2
                                    ,pstdesc_revocados VARCHAR2
                                    ,pinnum_order NUMBER
                                    ,pstdesc_vigencia VARCHAR2
                                    ,pstdes_poder varchar2
                                    ,pinid_opoder_ep_pk OUT NUMBER
                                    ,pstOuterror OUT varchar2)
AS
    BEGIN
      INSERT INTO PENDIUM_OTORGAPODER_EP_TAB (ID_EP_FK
                                    ,NUM_PODERTIPO
                                    ,DES_PODERTIPO
                                    ,NUM_VIGENCIATIPO
                                    ,DES_VIGENCIATIPO
                                    ,NUM_VIGENCIATIEMPO
                                    ,FEC_VIGENCIAINICIO
                                    ,FEC_VIGENCIAFIN
                                    ,DESC_CARACTERISTICAS
                                    ,DESC_DESCRIPCION
                                    ,DESC_APODERADOS
                                    ,DESC_ACTOSDOMINIO
                                    ,DESC_ACTOSADMON
                                    ,DESC_PLEITOSCOBRANZA
                                    ,DESC_TITULOSCREDITO
                                    ,DESC_REVOCADOS
                                    ,DESC_VIGENCIA
                                    ,NUM_ORDER
                                    ,IND_STATUS
                                    ,DES_PODER)
                        VALUES(pinid_ep_fk
                              ,pinnum_podertipo
                              ,pstdes_podertipo
                              ,pinnum_vigenciatipo
                              ,pstdes_vigenciatipo
                              ,pinnum_vigenciatiempo
                              ,pstfec_vigenciainicio
                              ,pstfec_vigenciafin
                              ,pstdesc_caracteristicas
                              ,pstdesc_descripcion
                              ,pstdesc_apoderados
                              ,pstdesc_actosdominio
                              ,pstdesc_actosadmon
                              ,pstdesc_tituloscredito
                              ,pstdesc_pleitoscobranza
                              ,pstdesc_revocados
                              ,pstdesc_vigencia
                              ,pinnum_order
                              ,1
                              ,pstdes_poder)
                    returning ID_OPODER_EP_PK into pinid_opoder_ep_pk;
EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
  END;
PROCEDURE UPDATE_OTORGAPODER_EP_PR ( pinid_opoder_ep_pk NUMBER
                                    ,pinnum_podertipo NUMBER
                                    ,pstdes_podertipo VARCHAR2
                                    ,pinnum_vigenciatipo NUMBER
                                    ,pstdes_vigenciatipo VARCHAR2
                                    ,pinnum_vigenciatiempo NUMBER
                                    ,pstfec_vigenciainicio VARCHAR2
                                    ,pstfec_vigenciafin VARCHAR2
                                    ,pstdesc_caracteristicas VARCHAR2
                                    ,pstdesc_apoderados CLOB
                                    ,pstdesc_actosdominio VARCHAR2
                                    ,pstdesc_actosadmon VARCHAR2
                                    ,pstdesc_pleitoscobranza VARCHAR2
                                    ,pstdesc_tituloscredito VARCHAR2
                                    ,pstdesc_revocados VARCHAR2
                                    ,pinnum_order NUMBER
                                    ,pstdesc_vigencia VARCHAR2
                                    ,pinnum_last_updated_by NUMBER
                                    ,pstOuterror OUT varchar2)
AS
  BEGIN
       UPDATE PENDIUM_OTORGAPODER_EP_TAB
         SET  NUM_PODERTIPO        =     pinnum_podertipo
             ,DES_PODERTIPO        =     pstdes_podertipo
             ,NUM_VIGENCIATIPO     =     pinnum_vigenciatipo
             ,DES_VIGENCIATIPO     =     pstdes_vigenciatipo
             ,NUM_VIGENCIATIEMPO   =     pinnum_vigenciatiempo
             ,FEC_VIGENCIAINICIO   =     pstfec_vigenciainicio
             ,FEC_VIGENCIAFIN      =     pstfec_vigenciafin
             ,DESC_CARACTERISTICAS =     pstdesc_caracteristicas
             ,DESC_APODERADOS      =     pstdesc_apoderados
             ,DESC_ACTOSDOMINIO    =     pstdesc_actosdominio
             ,DESC_ACTOSADMON      =     pstdesc_actosadmon
             ,DESC_PLEITOSCOBRANZA =     pstdesc_pleitoscobranza
             ,DESC_TITULOSCREDITO  =     pstdesc_tituloscredito
             ,DESC_REVOCADOS       =     pstdesc_revocados
             ,NUM_LAST_UPDATED_BY  =     pinnum_last_updated_by
             ,FEC_LAST_UPDATE_DATE =     SYSDATE
             ,NUM_ORDER            =     pinnum_order
             ,DESC_VIGENCIA        =     pstdesc_vigencia
       WHERE  ID_OPODER_EP_PK      =     pinid_opoder_ep_pk;
       COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
END;
PROCEDURE DELETE_OTORGAPODER_EP_PR(pstResultado OUT varchar2
                                  ,pinid_ep_fk NUMBER
                                  ,psinnum_last_updated_by NUMBER)
AS
  BEGIN
       UPDATE PENDIUM_OTORGAPODER_EP_TAB
       SET    IND_STATUS            =   0
             ,NUM_LAST_UPDATED_BY   =   psinnum_last_updated_by
             ,FEC_LAST_UPDATE_DATE  =   SYSDATE
      WHERE   ID_EP_FK       =   pinid_ep_fk;
      COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        pstResultado := SQLERRM;
END;
PROCEDURE QUERY_OTORGAPODER_EP_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_ep_fk NUMBER)
AS
    BEGIN
           OPEN porcRSResultado FOR
            SELECT
              null AS "Apoderados"
              ,null AS "Facultades"
              ,null As "Mancomunados"
              ,ID_OPODER_EP_PK
              ,ID_EP_FK
              ,NUM_PODERTIPO
              ,DES_PODERTIPO
              ,NUM_VIGENCIATIPO
              ,DES_VIGENCIATIPO
              ,NUM_VIGENCIATIEMPO
              ,FEC_VIGENCIAINICIO
              ,FEC_VIGENCIAFIN
              ,DESC_CARACTERISTICAS
              ,DESC_ACTOSDOMINIO
              ,DESC_ACTOSADMON
              ,DESC_PLEITOSCOBRANZA
              ,DESC_REVOCADOS
              ,NUM_CREATED_BY
              ,FEC_CREATION_DATE
              ,NUM_LAST_UPDATED_BY
              ,FEC_LAST_UPDATE_DATE
              ,NUM_LAST_UPDATE_LOGIN
              ,ATRIBUTO1
              ,ATRIBUTO2
              ,ATRIBUTO3
              ,ATRIBUTO4
              ,ATRIBUTO5
              ,ATRIBUTO6
              ,ATRIBUTO7
              ,ATRIBUTO8
              ,ATRIBUTO9
              ,ATRIBUTO10
              ,ATRIBUTO11
              ,ATRIBUTO12
              ,ATRIBUTO13
              ,ATRIBUTO14
              ,ATRIBUTO15
              ,ATTRIBUTE_CATEGORY
              ,NUM_ORDER
              ,DESC_TITULOSCREDITO
              ,DESC_VIGENCIA
              ,IND_STATUS
              ,DESC_DESCRIPCION
              ,DES_PODER
              ,DESC_APODERADOS
              FROM PENDIUM_OTORGAPODER_EP_TAB
                WHERE
                  ID_EP_FK  = pinid_ep_fk AND
                  IND_STATUS = 1
              ORDER BY NUM_ORDER;
END QUERY_OTORGAPODER_EP_PR;
PROCEDURE INSERT_APODERADO_EP_PR (
                                   pinid_opoder_ep_fk NUMBER
                                  ,pinid_ep_fk NUMBER
                                  ,pinid_empl_fk NUMBER
                                  ,pstdesc_nom_empl VARCHAR2
                                  ,pinind_tipoapoderado NUMBER
                                  ,pstdesc_tipoapoderado VARCHAR2
                                  ,pinnum_created_by NUMBER
                                  ,pstdes_grupo VARCHAR2
                                  ,pinid_grupo_fk NUMBER
                                  ,pstind_aprevoca VARCHAR2
                                  ,pstdesc_revoca VARCHAR2
                                  ,pinind_status NUMBER
                                  ,pinid_apod_ep OUT NUMBER
                                  ,pstOuterror OUT varchar2)
AS
  BEGIN
        INSERT INTO PENDIUM_APODERADO_EP_TAB(
                                             ID_OPODER_EP_FK
                                            ,ID_EP_FK
                                            ,ID_EMPL_FK
                                            ,DESC_NOM_EMPL
                                            ,IND_TIPOAPODERADO
                                            ,DESC_TIPOAPODERADO
                                            ,IND_STATUS
                                            ,NUM_CREATED_BY
                                            ,DES_GRUPO
                                            ,ID_GRUPO_FK
                                            ,IND_APREVOCA
                                            ,DESC_REVOCA )
                                    VALUES(
                                            pinid_opoder_ep_fk
                                            ,pinid_ep_fk
                                            ,pinid_empl_fk
                                            ,pstdesc_nom_empl
                                            ,pinind_tipoapoderado
                                            ,pstdesc_tipoapoderado
                                            ,pinind_status
                                            ,pinnum_created_by
                                            ,pstdes_grupo
                                            ,pinid_grupo_fk
                                            ,pstind_aprevoca
                                            ,pstdesc_revoca)
returning ID_APOD_EP_PK into pinid_apod_ep;
EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
END;
PROCEDURE UPDATE_APODERADO_EP_PR ( pinid_apod_ep_pk NUMBER
                                  ,pinind_tipoapoderado NUMBER
                                  ,pstdesc_tipoapoderado VARCHAR2
                                  ,pstnum_last_updated_by VARCHAR2
                                  ,pstOuterror OUT varchar2)
AS
  BEGIN
        UPDATE PENDIUM_APODERADO_EP_TAB
        SET    IND_TIPOAPODERADO     =    pinind_tipoapoderado
              ,DESC_TIPOAPODERADO    =    pstdesc_tipoapoderado
              ,NUM_LAST_UPDATED_BY   =    pstnum_last_updated_by
              ,FEC_LAST_UPDATE_DATE  =    SYSDATE
        WHERE ID_APOD_EP_PK          =    pinid_apod_ep_pk;
        COMMIT;
    EXCEPTION WHEN OTHERS
    THEN
    pstOuterror := SQLERRM;
END;
PROCEDURE DELETE_APODERADO_EP_PR ( pinid_ep_pk NUMBER
                                  ,psinnum_last_updated_by NUMBER
                                  ,pstOuterror OUT NUMBER)
AS
  BEGIN
      UPDATE PENDIUM_APODERADO_EP_TAB
      SET   IND_STATUS          =  0,
            NUM_LAST_UPDATED_BY =  psinnum_last_updated_by
      WHERE ID_EP_FK       =  pinid_ep_pk;
        COMMIT;
    EXCEPTION WHEN OTHERS
    THEN
    pstOuterror := SQLERRM;
END;
PROCEDURE QUERY_APODERADO_EP_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_opoder_ep NUMBER)
AS
    BEGIN
           OPEN porcRSResultado FOR
           SELECT *
           FROM PENDIUM_APODERADO_EP_TAB
           WHERE ID_OPODER_EP_FK =  pinid_opoder_ep
           AND   IND_STATUS in ( 1,2)
           AND   DESC_TIPOAPODERADO!='MANCOMUNADO'
           ORDER BY ID_APOD_EP_PK;
END QUERY_APODERADO_EP_PR;
PROCEDURE QUERY_APODERADO_EP_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinind_sonmancomunados NUMBER
                                    ,pinid_opoder_ep NUMBER)
AS
    BEGIN
           IF pinind_sonmancomunados = 1 THEN
               OPEN porcRSResultado FOR
               SELECT
                ID_EMPL_FK AS id
                ,DESC_NOM_EMPL AS value
                ,PENDIUM_APODERADO_EP_TAB.*
               FROM PENDIUM_APODERADO_EP_TAB
               WHERE ID_GRUPO_FK =  pinid_opoder_ep
               AND   IND_STATUS in (1,2)
               AND   DESC_TIPOAPODERADO = 'MANCOMUNADO'
               ORDER BY DESC_NOM_EMPL;
            ELSE
                 OPEN porcRSResultado FOR
                 SELECT *
                 FROM PENDIUM_APODERADO_EP_TAB
                 WHERE ID_OPODER_EP_FK =  pinid_opoder_ep
                 AND   IND_STATUS in ( 1,2)
                 AND   DESC_TIPOAPODERADO!='MANCOMUNADO'
                 ORDER BY ID_APOD_EP_PK;
            END IF;
END QUERY_APODERADO_EP_PR;
PROCEDURE INSERT_FACULTADES_EP_PR ( pinid_opoder_ep_fk NUMBER
                                  ,pinid_ep_fk NUMBER
                                  ,pinind_tipo NUMBER
                                  ,pstdes_tipo VARCHAR2
                                  ,pinind_delegable VARCHAR2
                                  ,pinind_individual VARCHAR2
                                  ,pstCaracteristicas VARCHAR2
                                  ,pinMancomunado NUMBER
                                  ,pstdes_formae VARCHAR2
                                  ,pinid_fac_ep_pk OUT NUMBER
                                  ,pstOuterror OUT varchar2)
AS
 pinnum_created_by number;
  BEGIN
   SELECT NUM_LAST_UPDATED_BY INTO pinnum_created_by FROM PENDIUM_ESCRITURA_PODER_TAB where ID_EP_PK = pinid_ep_fk ;
  INSERT INTO PENDIUM_FACULTADES_EP_TAB(
                                      ID_OPODER_EP_FK
                                      ,ID_EP_FK
                                      ,IND_TIPO
                                      ,DES_TIPO
                                      ,IND_DELEGABLE
                                      ,IND_INDIVIDUAL
                                      ,CARACTERISTICAS
                                      ,MANCOMUNADO
                                      ,IND_STATUS
                                      ,DES_FORMAE
                                      ,NUM_LAST_UPDATED_BY
                                      ,FEC_LAST_UPDATE_DATE
                                      ,NUM_CREATED_BY
                                      ,FEC_CREATION_DATE)
              VALUES                  (
                                      pinid_opoder_ep_fk
                                     ,pinid_ep_fk
                                     ,pinind_tipo
                                     ,pstdes_tipo
                                     ,pinind_delegable
                                     ,pinind_individual
                                     ,pstCaracteristicas
                                     ,pinMancomunado
                                     ,1
                                     ,pstdes_formae
                                     ,pinnum_created_by
                                     ,SYSDATE
                                     ,pinnum_created_by
                                     ,SYSDATE
                                      )
 returning ID_FAC_EP_PK into pinid_fac_ep_pk;
EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
END;
PROCEDURE UPDATE_FACULTADES_EP_PR (pind_fac_ep NUMBER
                                  ,pinind_tipo NUMBER
                                  ,pstdes_tipo VARCHAR2
                                  ,pinind_delegable VARCHAR2
                                  ,pinind_individual VARCHAR2
                                  ,pstCaracteristicas VARCHAR2
                                  ,pinMancomunado NUMBER
                                  ,pinnum_last_updated_by NUMBER
                                  ,pstOuterror OUT varchar2)
AS
  BEGIN
      UPDATE PENDIUM_FACULTADES_EP_TAB
      SET   IND_TIPO             =    pinind_tipo
           ,IND_DELEGABLE        =    pinind_delegable
           ,IND_INDIVIDUAL       =    pinind_individual
           ,CARACTERISTICAS      =    pstCaracteristicas
           ,MANCOMUNADO          =    pinMancomunado
           ,NUM_LAST_UPDATED_BY  =    pinnum_last_updated_by
           ,FEC_LAST_UPDATE_DATE =    SYSDATE
      WHERE ID_FAC_EP_PK    =       pind_fac_ep;
      COMMIT;
    EXCEPTION WHEN OTHERS
    THEN
    pstOuterror := SQLERRM;
END;
PROCEDURE DELETE_FACULTADES_EP_PR (pinid_fac_ep_pk NUMBER
                                    ,pstOuterror OUT NUMBER)
AS
  BEGIN
        UPDATE PENDIUM_FACULTADES_EP_TAB
        SET   IND_STATUS    = 0
        WHERE ID_FAC_EP_PK  = pinid_fac_ep_pk;
        COMMIT;
  EXCEPTION WHEN OTHERS
    THEN
    pstOuterror := SQLERRM;
END;
PROCEDURE QUERY_FACULTADES_EP_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_opoder_ep_fk NUMBER)
AS
    BEGIN
           OPEN porcRSResultado FOR
            SELECT
             null as "listMancomunados"
              ,PENDIUM_FACULTADES_EP_TAB.*
              FROM PENDIUM_FACULTADES_EP_TAB
              WHERE ID_OPODER_EP_FK  =  pinid_opoder_ep_fk
              AND   IND_STATUS       =  1
              ORDER BY ID_FAC_EP_PK;
END QUERY_FACULTADES_EP_PR;
PROCEDURE INSERT_REVOCA_EP_PR ( pinid_opoder_ep_fk NUMBER
                                  ,pinid_ep_fk NUMBER
                                  ,pinid_apod_ep_fk NUMBER
                                  ,pinind_razonrevoca NUMBER
                                  ,pstdes_razonrevoca VARCHAR2
                                  ,pinid_escriturarevoca_fk VARCHAR2
                                  ,pinid_documentumrevoca VARCHAR2
                                  ,pstfec_revoca VARCHAR2
                                  ,pstdes_textorevoca VARCHAR2
                                  ,pstdesc_apendicerevoca VARCHAR2
                                  ,pinid_revoca_ep OUT NUMBER
                                  ,pstOuterror OUT varchar2)
AS
  BEGIN
  INSERT INTO PENDIUM_REVOCA_EP_TAB (ID_OPODER_EP_FK
                                    ,ID_EP_FK
                                    ,ID_APOD_EP_FK
                                    ,IND_RAZONREVOCA
                                    ,DES_RAZONREVOCA
                                    ,ID_ESCRITURAREVOCA_FK
                                    ,ID_DOCUMENTUMREVOCA
                                    ,FEC_REVOCA
                                    ,DES_TEXTOREVOCA
                                    ,DESC_APENDICEREVOCA
                                    ,IND_STATUS)
          VALUES                    (
                                     pinid_opoder_ep_fk
                                    ,pinid_ep_fk
                                    ,pinid_apod_ep_fk
                                    ,pinind_razonrevoca
                                    ,pstdes_razonrevoca
                                    ,pinid_escriturarevoca_fk
                                    ,pinid_documentumrevoca
                                    ,pstfec_revoca
                                    ,pstdes_textorevoca
                                    ,pstdesc_apendicerevoca
                                    ,1
                                    )
returning ID_REVOCA_EP_PK into pinid_revoca_ep;
EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
END;
PROCEDURE UPDATE_REVOCA_EP_PR (  pinid_revoca_ep_pk NUMBER
                                ,pinind_razonrevoca NUMBER
                                ,pstdes_razonrevoca VARCHAR2
                                ,pinid_escriturarevoca_fk NUMBER
                                ,pinid_documentumrevoca NUMBER
                                ,pstfec_revoca VARCHAR2
                                ,pstdes_textorevoca VARCHAR2
                                ,pstdesc_apendicerevoca VARCHAR2
                                ,pinnum_last_updated_by NUMBER
                                ,pstOuterror OUT varchar2)
AS
  BEGIN
      UPDATE PENDIUM_REVOCA_EP_TAB
      SET    IND_RAZONREVOCA       =  pinind_razonrevoca
            ,DES_RAZONREVOCA       =  pstdes_razonrevoca
            ,ID_ESCRITURAREVOCA_FK =  pinid_escriturarevoca_fk
            ,ID_DOCUMENTUMREVOCA   =  pinid_documentumrevoca
            ,FEC_REVOCA            =  pstfec_revoca
            ,DES_TEXTOREVOCA       =  pstdes_textorevoca
            ,DESC_APENDICEREVOCA   =  pstdesc_apendicerevoca
            ,NUM_LAST_UPDATED_BY   =  pinnum_last_updated_by
            ,FEC_LAST_UPDATE_DATE  =  SYSDATE
      WHERE ID_REVOCA_EP_PK        =  pinid_revoca_ep_pk;
      COMMIT;
    EXCEPTION WHEN OTHERS
    THEN
    pstOuterror := SQLERRM;
END;
PROCEDURE DELETE_REVOCA_EP_PR (pinid_revoca_ep_pk NUMBER
                              ,pstOuterror OUT NUMBER)
AS
  BEGIN
        UPDATE PENDIUM_REVOCA_EP_TAB
        SET   IND_STATUS      = 0
        WHERE ID_REVOCA_EP_PK  = pinid_revoca_ep_pk;
        COMMIT;
  EXCEPTION WHEN OTHERS
    THEN
    pstOuterror := SQLERRM;
END;
PROCEDURE QUERY_REVOCA_EP_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_ep NUMBER)
AS
  BEGIN
           OPEN porcRSResultado FOR
            SELECT
              *
              FROM PENDIUM_REVOCA_EP_TAB
              WHERE ID_EP_FK    =  pinid_ep
              AND   IND_STATUS  =  1
              ORDER BY ID_REVOCA_EP_PK;
END QUERY_REVOCA_EP_PR;
PROCEDURE INSERT_CATALOGO_PODERES_PR ( pstdes_podertipo VARCHAR2
                                      ,pstind_podertipo VARCHAR2
                                      ,pstdes_descripcion VARCHAR2
                                      ,pinind_tiene_ad NUMBER
                                      ,pstind_ad_delegable VARCHAR2
                                      ,pstind_ad_individual VARCHAR2
                                      ,pstdes_ad_formaejercerlo VARCHAR2
                                      ,pstdes_ad_caracteristicas VARCHAR2
                                      ,pstdes_actosdominio VARCHAR2
                                      ,pinind_tiene_aa NUMBER
                                      ,pstind_aa_delegable VARCHAR2
                                      ,pstind_aa_individual VARCHAR2
                                      ,pstdes_aa_formaejercerlo VARCHAR2
                                      ,pstdes_aa_caracteristicas VARCHAR2
                                      ,pstdes_actosadmon VARCHAR2
                                      ,pinind_tiene_tc NUMBER
                                      ,pstind_tc_delegable VARCHAR2
                                      ,pstind_tc_individual VARCHAR2
                                      ,pstdes_tc_formaejercerlo VARCHAR2
                                      ,pstdes_tc_caracteristicas VARCHAR2
                                      ,pstdes_titulosdecreditos VARCHAR2
                                      ,pinind_tiene_pc NUMBER
                                      ,pstind_pc_delegable VARCHAR2
                                      ,pstind_pc_individual VARCHAR2
                                      ,pstdes_pc_formaejercerlo VARCHAR2
                                      ,pstdes_pc_caracteristicas VARCHAR2
                                      ,pstdes_pleitoscobranzas VARCHAR2
                                      ,pstind_pe_delegable VARCHAR2
                                      ,pstind_pe_individual VARCHAR2
                                      ,pstdes_pe_formaejercerlo VARCHAR2
                                      ,pstdes_pe_caracteristicas VARCHAR2
                                      ,pstdes_facultades VARCHAR2
                                      ,pinnum_created_by NUMBER
                                      ,pinid_poder_pk OUT NUMBER
                                      ,pinid_catalogo NUMBER
                                      ,pstOuterror OUT varchar2)
AS
  lin_num_seq NUMBER;
  BEGIN
    SELECT USRDRC.PENDIUM_CAT_POD_SEQ.NEXTVAL INTO lin_num_seq
    FROM DUAL;
  INSERT INTO PENDIUM_CATALOGO_PODERES_TAB (ID_PODER_PK
                                            ,DES_PODERTIPO
                                            ,IND_PODERTIPO
                                            ,DES_DESCRIPCION
                                            ,IND_TIENE_AD
                                            ,IND_AD_DELEGABLE
                                            ,IND_AD_INDIVIDUAL
                                            ,DES_AD_FORMAEJERCERLO
                                            ,DES_AD_CARACTERISTICAS
                                            ,DES_ACTOSDOMINIO
                                            ,IND_TIENE_AA
                                            ,IND_AA_DELEGABLE
                                            ,IND_AA_INDIVIDUAL
                                            ,DES_AA_FORMAEJERCERLO
                                            ,DES_AA_CARACTERISTICAS
                                            ,DES_ACTOSADMON
                                            ,IND_TIENE_TC
                                            ,IND_TC_DELEGABLE
                                            ,IND_TC_INDIVIDUAL
                                            ,DES_TC_FORMAEJERCERLO
                                            ,DES_TC_CARACTERISTICAS
                                            ,DES_TITULOSDECREDITOS
                                            ,IND_TIENE_PC
                                            ,IND_PC_DELEGABLE
                                            ,IND_PC_INDIVIDUAL
                                            ,DES_PC_FORMAEJERCERLO
                                            ,DES_PC_CARACTERISTICAS
                                            ,DES_PLEITOSCOBRANZAS
                                            ,IND_PE_DELEGABLE
                                            ,IND_PE_INDIVIDUAL
                                            ,DES_PE_FORMAEJERCERLO
                                            ,DES_PE_CARACTERISTICAS
                                            ,DES_FACULTADES
                                            ,NUM_CREATED_BY
                                            ,FEC_CREATION_DATE
                                            ,IND_STATUS
                                            ,ID_CATALOGO
                                           )
      VALUES                              (lin_num_seq
                                          ,pstdes_podertipo
                                          ,pstind_podertipo
                                          ,pstdes_descripcion
                                          ,pinind_tiene_ad
                                          ,pstind_ad_delegable
                                          ,pstind_ad_individual
                                          ,pstdes_ad_formaejercerlo
                                          ,pstdes_ad_caracteristicas
                                          ,pstdes_actosdominio
                                          ,pinind_tiene_aa
                                          ,pstind_aa_delegable
                                          ,pstind_aa_individual
                                          ,pstdes_aa_formaejercerlo
                                          ,pstdes_aa_caracteristicas
                                          ,pstdes_actosadmon
                                          ,pinind_tiene_tc
                                          ,pstind_tc_delegable
                                          ,pstind_tc_individual
                                          ,pstdes_tc_formaejercerlo
                                          ,pstdes_tc_caracteristicas
                                          ,pstdes_titulosdecreditos
                                          ,pinind_tiene_pc
                                          ,pstind_pc_delegable
                                          ,pstind_pc_individual
                                          ,pstdes_pc_formaejercerlo
                                          ,pstdes_pc_caracteristicas
                                          ,pstdes_pleitoscobranzas
                                          ,pstind_pe_delegable
                                          ,pstind_pe_individual
                                          ,pstdes_pe_formaejercerlo
                                          ,pstdes_pe_caracteristicas
                                          ,pstdes_facultades
                                          ,pinnum_created_by
                                          ,SYSDATE
                                          ,1
                                          ,pinid_catalogo
                                          );
  COMMIT;
 pinid_poder_pk := lin_num_seq;
EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
END;
PROCEDURE UPDATE_CATALOGO_PODERES_PR ( pinid_poder_pk NUMBER
                                      ,pstdes_podertipo VARCHAR2
                                      ,pstind_podertipo VARCHAR2
                                      ,pstdes_descripcion VARCHAR2
                                      ,pinind_tiene_ad NUMBER
                                      ,pstind_ad_delegable VARCHAR2
                                      ,pstind_ad_individual VARCHAR2
                                      ,pstdes_ad_formaejercerlo VARCHAR2
                                      ,pstdes_ad_caracteristicas VARCHAR2
                                      ,pstdes_actosdominio VARCHAR2
                                      ,pinind_tiene_aa NUMBER
                                      ,pstind_aa_delegable VARCHAR2
                                      ,pstind_aa_individual VARCHAR2
                                      ,pstdes_aa_formaejercerlo VARCHAR2
                                      ,pstdes_aa_caracteristicas VARCHAR2
                                      ,pstdes_actosadmon VARCHAR2
                                      ,pinind_tiene_tc NUMBER
                                      ,pstind_tc_delegable VARCHAR2
                                      ,pstind_tc_individual VARCHAR2
                                      ,pstdes_tc_formaejercerlo VARCHAR2
                                      ,pstdes_tc_caracteristicas VARCHAR2
                                      ,pstdes_titulosdecreditos VARCHAR2
                                      ,pinind_tiene_pc NUMBER
                                      ,pstind_pc_delegable VARCHAR2
                                      ,pstind_pc_individual VARCHAR2
                                      ,pstdes_pc_formaejercerlo VARCHAR2
                                      ,pstdes_pc_caracteristicas VARCHAR2
                                      ,pstdes_pleitoscobranzas VARCHAR2
                                      ,pstind_pe_delegable VARCHAR2
                                      ,pstind_pe_individual VARCHAR2
                                      ,pstdes_pe_formaejercerlo VARCHAR2
                                      ,pstdes_pe_caracteristicas VARCHAR2
                                      ,pstdes_facultades VARCHAR2
                                      ,pinnum_last_updated_by NUMBER
                                      ,pstOuterror OUT varchar2)
AS
  BEGIN
      UPDATE PENDIUM_CATALOGO_PODERES_TAB
      SET    DES_PODERTIPO          =  pstdes_podertipo
            ,IND_PODERTIPO          =  pstind_podertipo
            ,DES_DESCRIPCION        =  pstdes_descripcion
            ,IND_TIENE_AD           =  pinind_tiene_ad
            ,IND_AD_DELEGABLE       =  pstind_ad_delegable
            ,IND_AD_INDIVIDUAL      =  pstind_ad_individual
            ,DES_AD_FORMAEJERCERLO  =  pstdes_ad_formaejercerlo
            ,DES_AD_CARACTERISTICAS =  pstdes_ad_caracteristicas
            ,DES_ACTOSDOMINIO       =  pstdes_actosdominio
            ,IND_TIENE_AA           =  pinind_tiene_aa
            ,IND_AA_DELEGABLE       =  pstind_aa_delegable
            ,IND_AA_INDIVIDUAL      =  pstind_aa_individual
            ,DES_AA_FORMAEJERCERLO  =  pstdes_aa_formaejercerlo
            ,DES_AA_CARACTERISTICAS =  pstdes_aa_caracteristicas
            ,DES_ACTOSADMON         =  pstdes_actosadmon
            ,IND_TIENE_TC           =  pinind_tiene_tc
            ,IND_TC_DELEGABLE       =  pstind_tc_delegable
            ,IND_TC_INDIVIDUAL      =  pstind_tc_individual
            ,DES_TC_FORMAEJERCERLO  =  pstdes_tc_formaejercerlo
            ,DES_TC_CARACTERISTICAS =  pstdes_tc_caracteristicas
            ,DES_TITULOSDECREDITOS  =  pstdes_titulosdecreditos
            ,IND_TIENE_PC           =  pinind_tiene_pc
            ,IND_PC_DELEGABLE       =  pstind_pc_delegable
            ,IND_PC_INDIVIDUAL      =  pstind_pc_individual
            ,DES_PC_FORMAEJERCERLO  =  pstdes_pc_formaejercerlo
            ,DES_PC_CARACTERISTICAS =  pstdes_pc_caracteristicas
            ,DES_PLEITOSCOBRANZAS   =  pstdes_pleitoscobranzas
            ,IND_PE_DELEGABLE       =  pstind_pe_delegable
            ,IND_PE_INDIVIDUAL      =  pstind_pe_individual
            ,DES_PE_FORMAEJERCERLO  =  pstdes_pe_formaejercerlo
            ,DES_PE_CARACTERISTICAS =  pstdes_pe_caracteristicas
            ,DES_FACULTADES         =  pstdes_facultades
            ,NUM_LAST_UPDATED_BY    =  pinnum_last_updated_by
            ,FEC_LAST_UPDATE_DATE   =  SYSDATE
      WHERE ID_PODER_PK          =  pinid_poder_pk;
      COMMIT;
    EXCEPTION WHEN OTHERS
    THEN
    pstOuterror := SQLERRM;
END;
PROCEDURE DELETE_CATALOGO_PODERES_PR (pinid_poder_pk NUMBER
                                      ,pinnum_last_updated_by NUMBER
                                      ,pstOuterror OUT NUMBER)
AS
  CATALOGO_OCUPADO EXCEPTION;
  numOcupados    NUMBER;
  BEGIN
      SELECT COUNT(*) INTO numOcupados
      FROM PENDIUM_OTORGAPODER_EP_TAB
      WHERE NUM_PODERTIPO = pinid_poder_pk;
      IF numOcupados>0 THEN
        RAISE CATALOGO_OCUPADO;
      ELSE
        DELETE FROM PENDIUM_CATALOGO_PODERES_TAB
        WHERE ID_PODER_PK     =   pinid_poder_pk;
        COMMIT;
      END IF;
    EXCEPTION
    WHEN CATALOGO_OCUPADO THEN
    pstOuterror := 0;
    WHEN OTHERS THEN
    pstOuterror := SQLERRM;
END;
PROCEDURE QUERY_CATALOGO_PODERES_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pinid_poder_pk NUMBER)
AS
  BEGIN
           OPEN porcRSResultado FOR
            SELECT *
            FROM PENDIUM_CATALOGO_PODERES_TAB
              WHERE ID_PODER_PK    =  pinid_poder_pk
              AND   IND_STATUS  =  1
              ORDER BY DES_PODERTIPO;
END QUERY_CATALOGO_PODERES_PR;
PROCEDURE QUERY_CATALOGO_PODERES_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pstind_podertipo VARCHAR2)
AS
  BEGIN
           OPEN porcRSResultado FOR
            SELECT *
            FROM PENDIUM_CATALOGO_PODERES_TAB
              WHERE IND_PODERTIPO    =  pstind_podertipo
              AND   IND_STATUS  =  1
              ORDER BY DES_PODERTIPO;
END QUERY_CATALOGO_PODERES_PR;
PROCEDURE QUERY_CATALOGO_PODERES_PR (porcRSResultado OUT SYS_REFCURSOR
                                    ,pstind_podertipo VARCHAR2
                                    ,pstdes_podertipo VARCHAR2)
AS
  BEGIN
           OPEN porcRSResultado FOR
            SELECT *
            FROM PENDIUM_CATALOGO_PODERES_TAB
              WHERE IND_PODERTIPO    =  pstind_podertipo
              AND   LOWER(DES_PODERTIPO)   LIKE '%'||LOWER(pstdes_podertipo)||'%'
              AND   IND_STATUS  =  1
              ORDER BY DES_PODERTIPO;
END QUERY_CATALOGO_PODERES_PR;
PROCEDURE QUERY_PODERES_ESPECIALES_PR(porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdesc_busqueda varchar2
                                  ,pinid_empresa NUMBER
                                  ,pstOuterror OUT varchar2)
           AS
           BEGIN
           OPEN porcRSResultado FOR
           SELECT PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK AS ID_EP_PK,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA AS IND_TIPO_ESCRITURA,
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA AS FEC_FECHA,
                          PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO AS DES_PODERTIPO,
                          PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN AS FEC_VIGENCIAFIN,
                          PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS AS DESC_APODERADOS,
                          PENDIUM_OTORGAPODER_EP_TAB.DES_PODER AS DES_PODER,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS AS IND_STATUS,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO AS IND_REQUIERE_PROTO,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS_ESC AS IND_STATUS_ESC,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS_RPPC AS IND_STATUS_RPPC,
                          PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA AS DES_ESCRITURA,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_INSCR_RPPC,
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_REGISTRO,
                          PENDIUM_ESCRITURA_PODER_TAB.NUM_FOLIO_MERC,
                          PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR,
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR,
                          PENDIUM_ESCRITURA_PODER_TAB.NUM_LICENCIADO
                  FROM PENDIUM_ESCRITURA_PODER_TAB
                    INNER JOIN PENDIUM_OTORGAPODER_EP_TAB
                      ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK              = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
                  WHERE PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA = 'PE'
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS           = 1
                    AND PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA           = pinid_empresa
                    AND (pstdesc_busqueda is null OR pstdesc_busqueda = '' OR
                      (PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA             LIKE  '%' || pstdesc_busqueda || '%'
                      OR REGEXP_REPLACE(LOWER(PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS),'([[:digit:]])','')     LIKE  '%' || LOWER(pstdesc_busqueda) || '%'))
                                  ORDER BY PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA DESC;
                                  EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
  END;
  PROCEDURE QUERY_PODERES_CARTA_PODER_PR(porcRSResultado OUT SYS_REFCURSOR
                                  ,pstdesc_busqueda varchar2
                                  ,pinid_empresa NUMBER
                                  ,pstOuterror OUT varchar2)
                                   AS
           BEGIN
            OPEN porcRSResultado FOR
           SELECT PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA,
                          PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA,
                          PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO,
                          PENDIUM_OTORGAPODER_EP_TAB.FEC_VIGENCIAFIN,
                          PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS,
                          PENDIUM_OTORGAPODER_EP_TAB.DES_PODER,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_INSCR_RPPC,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS_ESC,
                          PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS_RPPC,
                          PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA
                  FROM PENDIUM_ESCRITURA_PODER_TAB
                    INNER JOIN PENDIUM_OTORGAPODER_EP_TAB
                      ON PENDIUM_ESCRITURA_PODER_TAB.ID_EP_PK              = PENDIUM_OTORGAPODER_EP_TAB.ID_EP_FK
                  WHERE PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA = 'CP'
                    AND PENDIUM_ESCRITURA_PODER_TAB.IND_STATUS           = 1
                    AND PENDIUM_ESCRITURA_PODER_TAB.ID_EMPRESA           = pinid_empresa
                    AND (pstdesc_busqueda is null OR pstdesc_busqueda = '' OR
                      (PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA             LIKE  '%' || pstdesc_busqueda || '%'
                      OR REGEXP_REPLACE(LOWER(PENDIUM_OTORGAPODER_EP_TAB.DESC_APODERADOS),'([[:digit:]])','')    LIKE  '%' || LOWER(pstdesc_busqueda) || '%'))
                                  ORDER BY PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA DESC;
                                  EXCEPTION
    WHEN OTHERS THEN
        pstOuterror := SQLERRM;
  END;
END DERCORP_PODERES_PKG;
/;
