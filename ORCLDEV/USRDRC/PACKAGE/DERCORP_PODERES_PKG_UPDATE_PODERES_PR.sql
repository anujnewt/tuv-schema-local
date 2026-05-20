create or replace procedure usrdrc.dercorp_poderes_pkg_update_poderes_pr ( pinidpoder numeric ,pinidempresa numeric ,pstinttipopoder varchar ,pininddelegadopor numeric ,pstfecfecha varchar ,pstfechora varchar ,pstindtipodocumento varchar ,pstdescescritura varchar ,pstfecotorgamientoinstr varchar ,pstnumdocumentuminstr varchar ,pstindrequiereproto varchar ,pstindrequiereinscrrppc varchar ,pstnomsemaforo varchar ,pinnumlicenciado numeric ,pstnomnotariopublico varchar ,pinnumde numeric ,pstdessuplenciaasociado varchar ,pstnuminscritaregistropublico varchar ,pstfecregistro varchar ,pstnumfoliomec varchar ,pstdesotrosdatosregistro varchar ,pstindmemo varchar ,pinnumsolicitadopor numeric ,pstfecdocumentomemo varchar ,pstfecrecibidomemo varchar ,pstnumfolio varchar ,pstnumdocumentomemo varchar ,pstinddocentrega varchar ,pstfecdocumentoentrega varchar ,pstfecrecibidaentrega varchar ,pstnumdocumentumentrega varchar ,psindotros varchar ,pstfecdocumentootros varchar ,pstfecrecibidootros varchar ,pstnumdocumentumotros varchar ,pstindaplicaestatus varchar ,pstnomsemaforoestatus varchar ,pstfecprogentregaestatus varchar ,pstindredactada varchar ,pinnumrespredactada numeric ,pstfeccumplimientoredactada varchar ,pstindrevisiongerente varchar ,pstnumrespgerente numeric ,pstfeccumplimientogerente varchar ,pstindcorrecciones varchar ,pinnumrespcorrecciones numeric ,pstfeccumplimientocorrecciones varchar ,pstindautdireccion varchar ,pinnumrespaut numeric ,pstfeccumplimientoaut varchar ,pstindfirmas varchar ,pinnumrespfirmas numeric ,pstfeccumplimientofirmas varchar ,pstindentregada varchar ,pinnumrespentregada numeric ,pstfeccumplimientoentregada varchar ,pstnumenviadanotaria varchar ,pstfecenvionotaria varchar ,pstindpoderasunto varchar ,pstindtipoarmado varchar ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
update dercorp_poderes_tab
set        in_tipo_poder			              =	pstinttipopoder
,ind_delegado_por                 =	pininddelegadopor
,fec_fecha  			                =	clock_timestamp()--pstfecfecha
,fec_hora 			                  =	pstfechora
,ind_tipo_documento			          =	pstindtipodocumento
,des_escritura 			              =	pstdescescritura
,fec_otorgamiento_instr	          =	pstfecotorgamientoinstr
,num_documentum_instr		          =	pstnumdocumentuminstr
,ind_requiere_proto			          =	pstindrequiereproto
,ind_requiere_inscr_rppc	        =	pstindrequiereinscrrppc
,nom_semaforo      			          =	pstnomsemaforo
,num_licenciado 			            =	pinnumlicenciado
,nom_notario_publico			        =	pstnomnotariopublico
,num_de			                      =	pinnumde
,des_suplencia_asociado	          =	pstdessuplenciaasociado
,num_inscrita_registro_publico    =	pstnuminscritaregistropublico
,fec_registro                			=	pstfecregistro
,num_folio_merc              			=	pstnumfoliomec
,des_otros_datos_registro    			=	pstdesotrosdatosregistro
,ind_memo                    			=	pstindmemo
,num_solicitado_por          			=	pinnumsolicitadopor
,fec_documento_memo          			=	pstfecdocumentomemo
,fec_recibido_memo           			=	pstfecrecibidomemo
,num_folio			                  =	pstnumfolio
,num_documentum_memo			        =	pstnumdocumentomemo
,ind_doc_entrega             			=	pstinddocentrega
,fec_documento_entrega       			=	pstfecdocumentoentrega
,fec_recibido_entrega        			=	pstfecrecibidaentrega
,num_documentum_entrega      			=	pstnumdocumentumentrega
,ind_otros                   			=	psindotros
,fec_documento_otros         			=	pstfecdocumentootros
,fec_recibido_otros          			=	pstfecrecibidootros
,num_documentum_otros        			=	pstnumdocumentumotros
,ind_aplica_status           			=	pstindaplicaestatus
,nom_semaforo_status         			=	pstnomsemaforoestatus
,fec_prog_entrega_status 			    =	pstfecprogentregaestatus
,ind_redactada               			=	pstindredactada
,num_resp_redactada            		=	pinnumrespredactada
,fec_cumplimiento_redactada    		=	pstfeccumplimientoredactada
,ind_revision_gerente        			=	pstindrevisiongerente
,num_resp_gerente            			=	pstnumrespgerente
,fec_cumplimiento_gerente    			=	pstfeccumplimientogerente
,ind_correcciones            			=	pstindcorrecciones
,num_resp_correcciones       			=	pinnumrespcorrecciones
,fec_cumplimiento_correcciones		=	pstfeccumplimientocorrecciones
,ind_aut_direccion           			=	pstindautdireccion
,num_resp_aut                			=	pinnumrespaut
,fec_cumplimiento_aut        			=	pstfeccumplimientoaut
,ind_firmas                  			=	pstindfirmas
,num_resp_firmas             			=	pinnumrespfirmas
,fec_cumplimiento_firmas     			=	pstfeccumplimientofirmas
,ind_entregada               			=	pstindentregada
,num_resp_entregada          			=	pinnumrespentregada
,fec_cumplimiento_entregada  			=	pstfeccumplimientoentregada
,num_enviada_notaria         			=	pstnumenviadanotaria
,fec_envio_notaria			          =	pstfecenvionotaria
,ind_poder_asunto			            =	pstindpoderasunto
,ind_tipo_armado			            =	pstindtipoarmado
where 1=1
and  id_poder   = pinidpoder
and  id_empresa =	pinidempresa;
/* commit; */
exception when others
then
pstouterror := sqlerrm;
end;end;
$body$
language plpgsql
;
