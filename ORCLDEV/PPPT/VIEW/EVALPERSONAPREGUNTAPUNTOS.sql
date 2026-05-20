-- dmap_object_gen_tag : type : view name : evalpersonapreguntapuntos
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "evalpersonapreguntapuntos"  ("idpersonaevaluacion", "idpregunta", "idseccion", "idopcion", "puntos") as select evalpersonapregunta.idpersonaevaluacion,  evalpersonapregunta.idpregunta,  evalpersonapregunta.idseccion,  evalpersonapregunta.idopcion,  evacatopcion.puntos
from evalpersonapregunta inner join evacatopcion on evalpersonapregunta.idopcion = evacatopcion.idopcion;/* dmap converted statement end */
-- estimed cost of view [ evalpersonapreguntapuntos ]: 1.00;
