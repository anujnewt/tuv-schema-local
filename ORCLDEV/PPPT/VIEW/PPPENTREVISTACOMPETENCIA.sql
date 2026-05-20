-- dmap_object_gen_tag : type : view name : pppentrevistacompetencia
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pppentrevistacompetencia"  ("identrevista", "idpersona", "idperfil", "resultado", "compatibilidad", "nivel", "comentarios", "idcompetencia", "competencia", "tipo", "idempresa", "inactiva", "definicion") as select pppentrevista.identrevista,  pppentrevista.idpersona,  pppentrevista.idperfil,  ecpersonacompetencia.resultado,
ecpersonacompetencia.compatibilidad,  ecpersonacompetencia.nivel,  ecpersonacompetencia.comentarios,  pppcompetencia.idcompetencia, pppcompetencia.competencia, pppcompetencia.tipo, pppcompetencia.idempresa, pppcompetencia.inactiva, pppcompetencia.definicion
from pppentrevista inner join
ecpersonacompetencia on pppentrevista.identrevista = ecpersonacompetencia.identrevista inner join
pppcompetencia on ecpersonacompetencia.idcompetencia = pppcompetencia.idcompetencia;/* dmap converted statement end */
-- estimed cost of view [ pppentrevistacompetencia ]: 1.00;
