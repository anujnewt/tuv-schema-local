create or replace procedure fecxc."fecxp_extraccion_movtos_set"  () as $body$
declare

    
    
    
    /* /* rec_t_c3_d_tmp_del_temp rec_fecxc_dep_especiales[]; */ */
rec_t_c2_d_tmp_del_temp rec_fecxc_dep_especiales[];
/* rec_t_c1_d_det_tmp_del_temp rec_fecxp_det_pagos_erp[]; */
/* rec_t_c1_d_tmp_del_temp rec_fecxp_enc_pagos_erp[]; */
flg2 text;
flg0 text;
flg1 text;
-- pgv moved types start
-- pgv moved types end
--se agrega variable para escritura en logs
fichero utl_file.file_type;
-- variables para el proceso de inserci?n de erp(oracle).
consultaerp     varchar(4000);
consultaerp1    varchar(4000);
insertarerp     varchar(4000);
actualizerp     varchar(4000);
numfolioerp     integer;
consultaorac    varchar(4000);
secueciaorac    integer;
secueciaoracrep integer;
-- existe_secuencia integer; --se elimina ya que se corregio el problema de las secuencias duplicadas
-- variables para la extraccion del set.
noempresa       integer;
nofoliodet      integer;
cperiodo        integer;
idcveoperacion  integer;
idestatusmov    varchar(1);
nocheque        integer;
idchequera      varchar(11);
idbanco         integer;
importe         numeric;
idformapago     integer;
fecvalor        timestamp(0);
iddivisa        varchar(3);
tipocambio      numeric;
origenmov       varchar(3);
noloteent       integer;
idtipooperacion integer;
nopartida       integer;
cuentacont      varchar(4000);
subcta          varchar(4000);
subsubcta       varchar(4000);
importepartida  numeric;
cia             varchar(4);
neg             varchar(2);
cta             varchar(3);
scta            varchar(6);
cc              varchar(8);
icia            varchar(4);
top             varchar(1);
codecombination numeric;
nocliente       varchar(15);
idbancobenef    integer;
idchequerabenef varchar(11);
loteentrada     integer;
nodocto         integer;
concepto        varchar(100);
beneficiario    varchar(60);
-- cierre_set      varchar(4000);
-- horasegura      varchar(4000);
-- estatus_set     varchar(4000);
-- estatus_flujo   varchar(4000);
-- arranca_proceso varchar(4000);
referencia      varchar(30);
descripcion     varchar(30);
-- realiza_extraccion varchar(4000);
--variables adicionales
--step_desc            varchar(4000);
--status_desc          varchar(4000);
--id_extraccion        varchar(4000);
fecmodif             timestamp(0);
nomempresa           varchar(80);
nocuenta             integer;
folioref             integer;
idtipomovto          varchar(1);
idestatusmovaplicado varchar(40);
existefolio          integer;
existefoliocanc      integer;
plataforma           varchar(10);
secuencianoflujo     varchar(4000);
creoreplica          varchar(4000);
cperiodoapli         integer;
nomempresarel        varchar(80);
existesaldo          varchar(4000);
existesaldoant       varchar(4000);
saldoanterior        varchar(4000);
/*variables para sincronizaci?n de monedas*/
mon_set       varchar(4000);
des_set       varchar(4000);
mon_oracle    varchar(4000);
mon_sybase    varchar(4000);
existe_mapeo  varchar(4000);
msg_err       varchar(4000);
/*contadores para los cursores*/
contador_1 integer:=0;
contador_2 integer:=0;
contador_3 integer:=0;
/*para revisar si exise el folio*/
existe_folio_b    integer;
/*manejo de excepciones*/
err_code integer;
err_msg varchar(240);
/*variable para la aperturacionde ingresos*/
v_aperturar integer:=0;
/*cursores para simular lo que se extrajo del set*/
---de la linea 657 a la 708
cursor_1 cursor for select     f.no_empresa, f.no_folio_det, f.c_periodo,
f.cperiodoapli, f.id_cve_operacion, trim(both f.id_estatus_mov) as id_estatus_mov,
f.no_cheque, trim(both f.id_chequera) as id_chequera, f.id_banco,
f.importe, f.id_forma_pago, f.fec_flujo,
f.fec_modif, trim(both f.id_divisa) as id_divisa, f.tipo_cambio,
trim(both f.origen_mov) as origen_mov, f.id_tipo_operacion, trim(both f.no_cliente) as no_cliente,
f.id_banco_benef, trim(both f.id_chequera_benef) as id_chequera_benef, f.lote_entrada,
f.no_docto, trim(both f.plataforma) as plataforma, trim(both f.actualizado) as actualizado,
trim(both f.nom_empresa) as nom_empresa, trim(both f.nom_empresa_rel) as nom_empresa_rel, f.no_cuenta,
f.folio_ref, trim(both f.id_tipo_movto) as id_tipo_movto, f.no_lote_ent,
f.no_partida, trim(both f.cia) as cia, trim(both f.neg) as neg,
trim(both f.cta) as cta, trim(both f.scta) as scta, trim(both f.cc) as cc,
trim(both f.icia) as icia, trim(both f.top) as top, f.importe_partida,
f.codecombination, trim(both f.concepto) as concepto, trim(both f.beneficiario) as beneficiario,
trim(both f.referencia) as referencia, trim(both f.descripcion) as descripcion
from fecxc.fecxp_extraccion_egr_tab f
--where no_folio_det=0
order by no_folio_det ;
---de la linea 2319 a la 2357
cursor_2 cursor for select     f.no_empresa, f.no_folio_det, f.c_periodo,
f.cperiodoapli, f.id_cve_operacion, trim(both f.id_estatus_mov) as id_estatus_mov,
f.no_cheque, trim(both f.id_chequera) as id_chequera, f.id_banco,
f.importe, f.id_forma_pago, f.fec_flujo,
f.fec_modif, trim(both f.id_divisa) as id_divisa, f.tipo_cambio,
trim(both f.origen_mov) as origen_mov, f.id_tipo_operacion, trim(both f.no_cliente) as no_cliente,
f.id_banco_benef, trim(both f.id_chequera_benef) as id_chequera_benef, f.lote_entrada,
f.no_docto, trim(both f.plataforma) as plataforma, trim(both f.actualizado) as actualizado,
trim(both f.nom_empresa) as nom_empresa, trim(both f.nom_empresa_rel) as nom_empresa_rel, f.no_cuenta,
f.folio_ref, trim(both f.id_tipo_movto) as id_tipo_movto, trim(both f.concepto) as concepto,
trim(both f.beneficiario) as beneficiario, trim(both f.referencia) as referencia, trim(both f.descripcion) as descripcion
from fecxc.fecxp_extraccion_ingr_tab f
--where no_folio_det=0
order by no_folio_det ;
cursor_3 cursor for select     f.no_empresa, f.no_folio_det, f.c_periodo,
f.cperiodoapli, f.id_cve_operacion, trim(both f.id_estatus_mov) as id_estatus_mov,
f.no_cheque, trim(both f.id_chequera) as id_chequera, f.id_banco,
f.importe, f.id_forma_pago, f.fec_flujo,
f.fec_modif, trim(both f.id_divisa) as id_divisa, f.tipo_cambio,
trim(both f.origen_mov) as origen_mov, f.id_tipo_operacion, trim(both f.no_cliente) as no_cliente,
f.id_banco_benef, trim(both f.id_chequera_benef) as id_chequera_benef, f.lote_entrada,
f.no_docto, trim(both f.plataforma) as plataforma, trim(both f.actualizado) as actualizado,
trim(both f.nom_empresa) as nom_empresa, trim(both f.nom_empresa_rel) as nom_empresa_rel, f.no_cuenta,
f.folio_ref, trim(both f.id_tipo_movto) as id_tipo_movto, trim(both f.concepto) as concepto,
trim(both f.beneficiario) as beneficiario, trim(both f.referencia) as referencia, trim(both f.descripcion) as descripcion
from fecxc.fecxp_extraccion_ingrsbc_tab f
--where no_folio_det=0
order by no_folio_det ;
contador_folios integer:=0;
/* decalracion de arreglos nuevos */
/* type t_c1_t is table of cursor_1%rowtype
index by integer; */
t_c1 CURSOR_1 [];
/* type t_c2_t is table of cursor_2%rowtype
index by integer; */
t_c2 CURSOR_2 [];
/* type t_c3_t is table of cursor_3%rowtype
index by integer; */
t_c3 CURSOR_3 [];

rec_t_c1_d_tmp rec_fecxp_enc_pagos_erp[];

rec_t_c1_d_det_tmp rec_fecxp_det_pagos_erp[];

rec_t_c2_d_tmp rec_fecxc_dep_especiales[];

rec_t_c3_d_tmp rec_fecxc_dep_especiales[];
c_count numeric;
idcodmoneda varchar(5);
lin_aux numeric :=0;
lin_aux2 numeric :=0;
lin_aux3 numeric :=0;
lin_aux4 numeric :=0;
    cursor_1_v1_query TEXT;
    cursor_1_v2_query TEXT;
    cursor_1_final_query TEXT;
    cursor_2_v1_query TEXT;
    cursor_2_v2_query TEXT;
    cursor_2_final_query TEXT;
    cursor_3_v1_query TEXT;
    cursor_3_v2_query TEXT;
    cursor_3_final_query TEXT;
    v_limit NUMERIC := 100;
    v_offset NUMERIC := 0;
begin 
 
 
 
 
 
 
 
 
 
 
 
 

/* dmap converted statement start */
fichero := utl_file.fopen('/fecxcpos_logs', concat('LOGS_', to_char(clock_timestamp(),'DD_MM_YYYY_HH_MI_SS'), '.txt') ,'w');/* dmap converted statement end */
lin_aux :=0;
lin_aux2 :=0;
lin_aux3 :=0;
lin_aux4 :=0;
update fecxp_ppto_extraccion_params  --se limpia tabla
set atributo1 = null
where proceso_id in (10);
/* commit; */
update fecxp_ppto_extraccion_params  --se detienen los procesos de llenado
set estatus_proceso='AUTOMATICO'
where proceso_id in (11,12);
/* commit; */
update fecxp_ppto_extraccion_params   --se detienen los procesos de clasificacion
set estatus_proceso='INACTIVO'
where proceso_id in (9,16);
/* commit; */
perform dbms_output.put_line('=== Inicio del proceso de carga ');
select
utl_file.put_line(fichero,'=== Inicio del proceso de carga ');
select
utl_file.put_line(fichero,'          Abriendo el primer cursor ');
/* open cursor_1; */
loop
--dbms_output.put_line('          Abriendo el primer cursor ');
v_limit := 100;
    cursor_1_v1_query := concat('select array_agg(s) OVER (ROWS BETWEEN CURRENT ROW AND (', v_limit, ' - 1) FOLLOWING) INTO t_c1 from (SELECT q.* from  ( ');
                                            cursor_1_v2_query := concat(') s LIMIT ', v_limit, ' OFFSET ', v_offset, ';');
                                            cursor_1_final_query := concat (cursor_1_v1_query, ' select     f.no_empresa, f.no_folio_det, f.c_periodo,
f.cperiodoapli, f.id_cve_operacion, trim(both f.id_estatus_mov) as id_estatus_mov,
f.no_cheque, trim(both f.id_chequera) as id_chequera, f.id_banco,
f.importe, f.id_forma_pago, f.fec_flujo,
f.fec_modif, trim(both f.id_divisa) as id_divisa, f.tipo_cambio,
trim(both f.origen_mov) as origen_mov, f.id_tipo_operacion, trim(both f.no_cliente) as no_cliente,
f.id_banco_benef, trim(both f.id_chequera_benef) as id_chequera_benef, f.lote_entrada,
f.no_docto, trim(both f.plataforma) as plataforma, trim(both f.actualizado) as actualizado,
trim(both f.nom_empresa) as nom_empresa, trim(both f.nom_empresa_rel) as nom_empresa_rel, f.no_cuenta,
f.folio_ref, trim(both f.id_tipo_movto) as id_tipo_movto, f.no_lote_ent,
f.no_partida, trim(both f.cia) as cia, trim(both f.neg) as neg,
trim(both f.cta) as cta, trim(both f.scta) as scta, trim(both f.cc) as cc,
trim(both f.icia) as icia, trim(both f.top) as top, f.importe_partida,
f.codecombination, trim(both f.concepto) as concepto, trim(both f.beneficiario) as beneficiario,
trim(both f.referencia) as referencia, trim(both f.descripcion) as descripcion
from fecxc.fecxp_extraccion_egr_tab f
--where no_folio_det=0
order by no_folio_det ', cursor_1_v2_query);
                                            execute cursor_1_final_query into t_c1 ;
                                            
v_offset := v_offset + v_limit;
                                            
flg0 := found;
flg1 := found;
flg2 := found;
--dbms_output.put_line('          Asignando el cursor al arreglo ');
c_count := COALESCE(array_length(akeys(t_c1), 1), 0);
exit when (not flg0)or(not flg1)or(not flg2);
--dbms_output.put_line('          c_count: '||c_count);
if c_count > 0 then
for i in ARRAY_lower(akeys(t_c1), 1) .. ARRAY_upper(akeys(t_c1), 1)
loop
noempresa         := t_c1[i].no_empresa;
nofoliodet        := t_c1[i].no_folio_det;
cperiodo          := t_c1[i].c_periodo;
idcveoperacion    := t_c1[i].id_cve_operacion;
idestatusmov      := upper(t_c1[i].id_estatus_mov);
nocheque          := t_c1[i].no_cheque;
idchequera        := t_c1[i].id_chequera;
idbanco           := t_c1[i].id_banco;
importe           := t_c1[i].importe;
idformapago       := t_c1[i].id_forma_pago;
fecvalor          := t_c1[i].fec_flujo;
iddivisa          := t_c1[i].id_divisa;
tipocambio        := t_c1[i].tipo_cambio;
origenmov         := t_c1[i].origen_mov;
idtipooperacion   := t_c1[i].id_tipo_operacion;
nocliente         := t_c1[i].no_cliente;
idbancobenef      := t_c1[i].id_banco_benef;
idchequerabenef   := t_c1[i].id_chequera_benef;
loteentrada       := t_c1[i].lote_entrada;
nodocto           := t_c1[i].no_docto;
concepto          := t_c1[i].concepto;
beneficiario      := t_c1[i].beneficiario;
referencia        := t_c1[i].referencia;
descripcion       := t_c1[i].descripcion;
fecmodif          := t_c1[i].fec_modif;
nomempresa        := t_c1[i].no_empresa;
nocuenta          := t_c1[i].no_cuenta;
folioref          := t_c1[i].folio_ref;
idtipomovto       := t_c1[i].id_tipo_movto;
cperiodoapli      := t_c1[i].cperiodoapli;
nomempresarel     := t_c1[i].nom_empresa_rel;
nopartida         := t_c1[i].no_partida;
importepartida    := t_c1[i].importe_partida;
cia               := t_c1[i].cia;
neg               := t_c1[i].neg;
cta               := t_c1[i].cta;
scta              := t_c1[i].scta;
cc                := t_c1[i].cc;
icia              := t_c1[i].icia;
top               := t_c1[i].top;
codecombination   := t_c1[i].codecombination;/* dmap converted statement start */
------------------------------------------------
--dbms_output.put_line(' foliodet:'||nvl(nofoliodet,0));
select
utl_file.put_line(fichero, concat(' foliodet:', coalesce(nofoliodet,0))) ;/* dmap converted statement end */
--dbms_output.put_line('------------------------------------------------------------------------------------------------------------------------------------------------      ');
--dbms_output.put_line('          Iguala las variables del proceso');
--dbms_output.put_line('folioerp:'||nvl(numfolioerp,1)||' foliodet:'||nvl(nofoliodet,0));
------------------------------------------------
--verificar si debe generar encabezado o detalle
if (coalesce(numfolioerp,1)!=coalesce(nofoliodet,0)) then
--inicializa bandera de crear r?plicas
--dbms_output.put_line('          Primer If');
creoreplica:='N';/* dmap converted statement start */
if (idestatusmov='X' or idestatusmov='Y' or idestatusmov='Z') then
--para el movimiento aplicado original hay que determinar qu? estatus debe llevar de acuerdo a la forma de pago
--dbms_output.put_line('[El folio esta cancelado y ha entrado a esta l?gica] Status:'||idestatusmov );
select
utl_file.put_line(fichero, concat('[El folio esta cancelado y ha entrado a esta logica] Status:', idestatusmov)  );/* dmap converted statement end */
idestatusmovaplicado := 'A';
if (idformapago=3 and idtipooperacion=3200) then
idestatusmovaplicado := 'K';
end if;
if idtipooperacion=3200 and (idformapago=1 or idformapago=8 or idformapago=9) then
idestatusmovaplicado := 'I';
end if;
if (idtipooperacion=7000) or (idtipooperacion = 7001) or (idtipooperacion = 7002) or (idtipooperacion= 7003) or ( idtipooperacion= 7005 ) then
idestatusmovaplicado := 'L';
end if;/* dmap converted statement start */
--dbms_output.put_line('[El Status aplicado es]: ' || idestatusmovaplicado || '');
select
utl_file.put_line(fichero, concat('[El Status aplicado es]: ', idestatusmovaplicado , '')) ;/* dmap converted statement end */
--buscar el folio con estatus aplicado en la base de datos, esto para las validaciones en caso de que la
--cancelaci?n se haga o no el d??a de la generaci?n.
select /*+ index (e idx2_pag_erp_folio) */ count(*) into strict existefolio from fecxp_enc_pagos_erp e where folio_set = to_char(nofoliodet)  and estatus_movimiento =  idestatusmovaplicado;
if existefolio!=0 then
--dbms_output.put_line('existe folio');
select
utl_file.put_line(fichero,'existe folio');
null;
end if;/* dmap converted statement start */
--dbms_output.put_line('[Se han localizado]: ' || existefolio || ' folios con este mismo status.');
--dbms_output.put_line('fecValor: ' ||trunc(fecvalor) || ' fecModif: '||trunc(fecmodif));
select
utl_file.put_line(fichero, concat('[Se han localizado]: ', existefolio , ' folios con este mismo status.')) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('fecValor: ', trunc(fecvalor) , ' fecModif: ', trunc(fecmodif))) ;/* dmap converted statement end *//* dmap converted statement start */
--es un cancelado comparar las fechas, cuando se cancela el d??a de la generaci?n hay que crear la r?plica aplicada
--cuando tienen fechas diferentes debe validar que ya existe la aplicada previamente
if  trunc(fecvalor)=trunc(fecmodif) then
--se gener?? y se cancel?? el mismo d??a, por tanto hay que crear primero la r?plica aplicada
if (existefolio=0) then
--no existe el folio+status+tipooper y se generar?
--dbms_output.put_line('Folio cancelado el d??a del origen. Se generar? r?plica aplicada FECXP_ENC_PAGOS_ERP con Folio: '|| nofoliodet ||' Status: ' || idestatusmovaplicado||' TipoOper: ' || idtipooperacion);
--dbms_output.put_line('Folio cancelado el d??a del origen.');
select
utl_file.put_line(fichero, concat('Folio cancelado el dia del origen. Se generara replica aplicada FECXP_ENC_PAGOS_ERP con Folio: ', nofoliodet , ' Status: ' , idestatusmovaplicado, ' TipoOper: ' , idtipooperacion)) ;/* dmap converted statement end */
-- obtenemos la secuencia de la tabla fecxp_enc_pagos_erp
select nextval('secuencia_pagos_erp') into strict secueciaoracrep;/* dmap converted statement start */
--dbms_output.put_line('    [DATO] Folio: ' || nofoliodet);
--dbms_output.put_line('    [DATO] Status: ' || idestatusmovaplicado);
--dbms_output.put_line('    [DATO] fecFlujo: ' || fecvalor);
--dbms_output.put_line('    [DATO] fecModif: ' || fecmodif);
select
utl_file.put_line(fichero, concat('    [DATO] Folio: ', nofoliodet)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] Status: ', idestatusmovaplicado)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecFlujo: ', fecvalor)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecModif: ', fecmodif)) ;/* dmap converted statement end */
select array_append(rec_t_c1_d_tmp, null) into rec_t_c1_d_tmp;
lin_aux:=lin_aux+1;--bogar
-- inserta replica aplicada en la tabla fecxp_enc_pagos_erp
select             secueciaoracrep        , noempresa        , b.secmoneda    , nofoliodet          , cperiodoapli             , idcveoperacion,
idestatusmovaplicado   , nocheque         , idchequera     , idbanco             , (importe*-1)               , idformapago,
fecvalor            , iddivisa       , tipocambio       , trim(both origenmov)       , idtipooperacion, nocliente,
idbancobenef        , idchequerabenef  , loteentrada    , nodocto             , concepto              , beneficiario,
clock_timestamp()             , nomempresa       , nomempresarel  , nocuenta            ,  folioref             , referencia    , descripcion,0
into strict rec_t_c1_d_tmp[lin_aux].secuencia_pagos_erp, rec_t_c1_d_tmp[lin_aux].e_codigo         , rec_t_c1_d_tmp[lin_aux].secmoneda        , rec_t_c1_d_tmp[lin_aux].folio_set           , rec_t_c1_d_tmp[lin_aux].periodo             , rec_t_c1_d_tmp[lin_aux].cve_operacion,
rec_t_c1_d_tmp[lin_aux].estatus_movimiento , rec_t_c1_d_tmp[lin_aux].no_cheque        , rec_t_c1_d_tmp[lin_aux].id_chequera      , rec_t_c1_d_tmp[lin_aux].id_banco            , rec_t_c1_d_tmp[lin_aux].importe             , rec_t_c1_d_tmp[lin_aux].forma_pago   ,
rec_t_c1_d_tmp[lin_aux].fecha_aplicacion   , rec_t_c1_d_tmp[lin_aux].moneda           , rec_t_c1_d_tmp[lin_aux].tipo_cambio      , rec_t_c1_d_tmp[lin_aux].origen_movimiento   , rec_t_c1_d_tmp[lin_aux].tipo_operacion      , rec_t_c1_d_tmp[lin_aux].no_cliente   ,
rec_t_c1_d_tmp[lin_aux].id_banco_benef     , rec_t_c1_d_tmp[lin_aux].id_chequera_benef, rec_t_c1_d_tmp[lin_aux].lote_entrada     , rec_t_c1_d_tmp[lin_aux].no_docto            , rec_t_c1_d_tmp[lin_aux].concepto            , rec_t_c1_d_tmp[lin_aux].beneficiario ,
rec_t_c1_d_tmp[lin_aux].fecha_actualizacion, rec_t_c1_d_tmp[lin_aux].nom_empresa      , rec_t_c1_d_tmp[lin_aux].nom_empresa_rel  , rec_t_c1_d_tmp[lin_aux].no_cuenta           , rec_t_c1_d_tmp[lin_aux].folio_ref           , rec_t_c1_d_tmp[lin_aux].referencia   ,
rec_t_c1_d_tmp[lin_aux].descripcion,rec_t_c1_d_tmp[lin_aux].procesado
a, fecxc_monedas b
where b.codmoneda = iddivisa;
--dbms_output.put_line('        [INSERT FECXP_ENC_PAGOS_ERP ]: ');
select
utl_file.put_line(fichero,'        [INSERT FECXP_ENC_PAGOS_ERP ]: ');
creoreplica :='S';
numfolioerp := nofoliodet;
else -- termina if existe folio aplicado
--ya existe el folio+status en este caso se reabre para su aperturaci??n y se
--mandar??n los datos al log de jaguar
--debido a que el movimiento no deber??a existir previamente, pues en el set nace y se
--cancela el mismo dia.
--forzar al reprocesamiento
update    fecxp_enc_pagos_erp
set procesado = 0 where ctid in (select ctid from fecxp_enc_pagos_erp where folio_set = to_char(nofoliodet)
and estatus_movimiento = idestatusmovaplicado;
--dbms_output.put_line('        [REAPERTURA]: ');
select
utl_file.put_line(fichero,'        [REAPERTURA]: ');
delete    from fecxp_det_pagos_procesados d
where    exists (
select    1
from    fecxp_enc_pagos_erp e
where    e.folio_set = to_char(nofoliodet)
and    e.estatus_movimiento = idestatusmovaplicado
and    e.secuencia_pagos_erp = d.secuencia_pagos_erp);
delete    from fecxp_bit_cont_din_folios_ap d
where    exists (
select    1
from      fecxp_enc_pagos_erp e
where     e.folio_set = to_char(nofoliodet)
and       e.estatus_movimiento = idestatusmovaplicado
and       e.secuencia_pagos_erp = d.secuencia_pagos_erp);
delete    from fecxp_bit_cont_din_aper_det d
where    exists (
select   1
from     fecxp_enc_pagos_erp e
where    e.folio_set = to_char(nofoliodet)
and      e.estatus_movimiento = idestatusmovaplicado
and      e.secuencia_pagos_erp = d.secuencia_pagos_erp);
delete    from fecxp_bit_cont_din_aper_enc d
where    exists (
select    1
from    fecxp_enc_pagos_erp e
where    e.folio_set = to_char(nofoliodet)
and    e.estatus_movimiento = idestatusmovaplicado
and        e.secuencia_pagos_erp = d.secuencia_pagos_erp);
end if; --finaliza else, caso en el que la r?plica aplicada del egreso oracle ya existe y se actualiza
else   -- termina if cuando fechamodif = fechavalor
--si la fecha de cancelaci?n no es la de generaci?n validar que ya existe el registro aplicado
if existefolio=0 then
--no existe el folio+status aplicado y se generar?? con los nuevos datos
--dbms_output.put_line(' Se cancel?? en fecha distinta al origen y no existe el aplicado.Se generar? r?plica aplicada fecxp_enc_pagos_erp con Folio: ' || nofoliodet || ' Status: ' || idestatusmovaplicado || ' TipoOper: ' || idtipooperacion);
--dbms_output.put_line(' La fecha de modificaci?n y aplicaci?n no son iguales.');
-- obtenemos la secuencia de la tabla fecxp_enc_pagos_erp
select nextval('secuencia_pagos_erp') into strict secueciaoracrep;/* dmap converted statement start */
--dbms_output.put_line('    [DATO] Folio: ' || nofoliodet);
--dbms_output.put_line('    [DATO] Status: ' || idestatusmovaplicado);
--dbms_output.put_line('    [DATO] fecFlujo: ' || fecvalor);
--dbms_output.put_line('    [DATO] fecModif: ' || fecmodif);
select
utl_file.put_line(fichero, concat('    [DATO] Folio: ', nofoliodet)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] Status: ', idestatusmovaplicado)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecFlujo: ', fecvalor)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecModif: ', fecmodif)) ;/* dmap converted statement end */
select array_append(rec_t_c1_d_tmp, null) into rec_t_c1_d_tmp;
lin_aux:=lin_aux+1;--bogar
select                secueciaoracrep       , noempresa        , b.secmoneda    , nofoliodet          , cperiodoapli              , idcveoperacion,
idestatusmovaplicado        , nocheque         , idchequera     , idbanco             , (importe*-1)               , idformapago,
fecvalor            , iddivisa       , tipocambio       , trim(both origenmov)     , idtipooperacion       , nocliente,
idbancobenef        , idchequerabenef  , loteentrada    , nodocto             , concepto              , beneficiario,
clock_timestamp()             , nomempresa       , nomempresarel  , nocuenta            ,  folioref             , referencia    , descripcion,0
into strict rec_t_c1_d_tmp[lin_aux].secuencia_pagos_erp, rec_t_c1_d_tmp[lin_aux].e_codigo         , rec_t_c1_d_tmp[lin_aux].secmoneda        , rec_t_c1_d_tmp[lin_aux].folio_set           , rec_t_c1_d_tmp[lin_aux].periodo             , rec_t_c1_d_tmp[lin_aux].cve_operacion,
rec_t_c1_d_tmp[lin_aux].estatus_movimiento , rec_t_c1_d_tmp[lin_aux].no_cheque        , rec_t_c1_d_tmp[lin_aux].id_chequera      , rec_t_c1_d_tmp[lin_aux].id_banco            , rec_t_c1_d_tmp[lin_aux].importe             , rec_t_c1_d_tmp[lin_aux].forma_pago   ,
rec_t_c1_d_tmp[lin_aux].fecha_aplicacion   , rec_t_c1_d_tmp[lin_aux].moneda           , rec_t_c1_d_tmp[lin_aux].tipo_cambio      , rec_t_c1_d_tmp[lin_aux].origen_movimiento   , rec_t_c1_d_tmp[lin_aux].tipo_operacion      , rec_t_c1_d_tmp[lin_aux].no_cliente   ,
rec_t_c1_d_tmp[lin_aux].id_banco_benef     , rec_t_c1_d_tmp[lin_aux].id_chequera_benef, rec_t_c1_d_tmp[lin_aux].lote_entrada     , rec_t_c1_d_tmp[lin_aux].no_docto            , rec_t_c1_d_tmp[lin_aux].concepto            , rec_t_c1_d_tmp[lin_aux].beneficiario ,
rec_t_c1_d_tmp[lin_aux].fecha_actualizacion, rec_t_c1_d_tmp[lin_aux].nom_empresa      , rec_t_c1_d_tmp[lin_aux].nom_empresa_rel  , rec_t_c1_d_tmp[lin_aux].no_cuenta           , rec_t_c1_d_tmp[lin_aux].folio_ref           , rec_t_c1_d_tmp[lin_aux].referencia   ,
rec_t_c1_d_tmp[lin_aux].descripcion,rec_t_c1_d_tmp[lin_aux].procesado
a, fecxc_monedas b
where b.codmoneda = iddivisa;
--dbms_output.put_line('        [INSERT FECXP_ENC_PAGOS_ERP ]: ');
numfolioerp := nofoliodet;
creoreplica :='S';
else --finaliza if cuando el folio aplicado no existe y las fechas de cancelaci?n y aplicaci?n no coinciden
-- cuando el folio aplicado ya existe y las fechas de aplicaci?n y cancelaci?n no coinciden
--se asume que ya existe el folio y se realiz?? su aperturaci?n, por tanto se reabre para
--reprocesarlo
--se obliga al sistema a reprocesar la aperturaci??n de los folios cambiando su status
--y eliminando el pago procesado anterior para que sea regenerado
--dbms_output.put_line('Forzar al reprocesamiento');
select
utl_file.put_line(fichero,'Forzar al reprocesamiento');
--forzar al reprocesamiento
update    fecxp_enc_pagos_erp
set    procesado = 0
where    folio_set = to_char(nofoliodet)
and    estatus_movimiento = idestatusmovaplicado;
--dbms_output.put_line('        [REAPERTURA]: ');
select
utl_file.put_line(fichero,'        [REAPERTURA]: ');
delete    from fecxp_det_pagos_procesados d
where    exists (
select  1
from    fecxp_enc_pagos_erp e
where   e.folio_set = to_char(nofoliodet)
and     e.estatus_movimiento = idestatusmovaplicado
and     e.secuencia_pagos_erp = d.secuencia_pagos_erp);
--dbms_output.put_line('        [DELETE FECXP_DET_PAGOS_PROCESADOS]:');
delete    from fecxp_bit_cont_din_folios_ap d
where    exists (
select  1
from    fecxp_enc_pagos_erp e
where   e.folio_set = to_char(nofoliodet)
and     e.estatus_movimiento = idestatusmovaplicado
and     e.secuencia_pagos_erp = d.secuencia_pagos_erp);
--dbms_output.put_line('        [DELETE FECXP_BIT_CONT_DIN_FOLIOS_AP]: ' );
delete    from fecxp_bit_cont_din_aper_det d
where    exists (
select    1
from    fecxp_enc_pagos_erp e
where    e.folio_set = to_char(nofoliodet)
and e.estatus_movimiento = idestatusmovaplicado
and        e.secuencia_pagos_erp = d.secuencia_pagos_erp);
--dbms_output.put_line('       [DELETE FECXP_BIT_CONT_DIN_APER_DET]: ');
delete    from fecxp_bit_cont_din_aper_enc d
where    exists (
select    1
from    fecxp_enc_pagos_erp e
where    e.folio_set = to_char(nofoliodet)
and e.estatus_movimiento = idestatusmovaplicado
and        e.secuencia_pagos_erp = d.secuencia_pagos_erp);
end if; --finaliza cuando las fechas no coinciden pero el aplicado ya existe y se reaperturar?
end if; --finaliza else  cuando las fechas de cancelaci?n del egreso erp y aplicaci?n son distintas y el folio aplicado no existe
end if;-- termina if estatus cancelado
--buscar el folio original
select /*+ index (e idx2_pag_erp_folio) */ count(*) into strict existefolio from fecxp_enc_pagos_erp e where folio_set = to_char(nofoliodet) and estatus_movimiento = idestatusmov;
/* begin
select 1
into existefolio
from fecxp_enc_pagos_erp e
where folio_set = nofoliodet  and estatus_movimiento =  idestatusmovaplicado and rownum = 1;
exception
when no_data_found
then
existefolio := 0;
when others
then
existefolio := 0;
end;*/
--dbms_output.put_line('Se localizaron: ' || existefolio || ' folios existentes para el folio :' || nofoliodet);
if ( idestatusmov='X' or idestatusmov='Y' or idestatusmov='Z') then
--para los registros cancelados la fecha flujo debe ser la fecha de cancelaci?n
fecvalor := fecmodif;
end if;/* dmap converted statement start */
if (existefolio=0) then
--no existe previamente el movimiento de egreso erp y se generar?? como viene en el set
--obtenemos la secuencia de la tabla fecxp_enc_pagos_erp
--dbms_output.put_line('NO EXISTE PREVIAMENTE EL MOVIMIENTO DE EGRESO ERP Y SE GENERAR?? COMO VIENE EN EL SET');
--dbms_output.put_line('    [DATO] Folio: ' || nofoliodet);
--dbms_output.put_line('    [DATO] Status: ' || idestatusmovaplicado);
--dbms_output.put_line('    [DATO] fecFlujo: ' || fecvalor);
--dbms_output.put_line('    [DATO] fecModif: ' || fecmodif);
select
utl_file.put_line(fichero, concat('    [DATO] Folio: ', nofoliodet)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] Status: ', idestatusmovaplicado)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecFlujo: ', fecvalor)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecModif: ', fecmodif)) ;/* dmap converted statement end */
select nextval('secuencia_pagos_erp') into strict secueciaorac;
--dbms_output.put_line('noFolioDet '||nofoliodet||' secueciaORAC:'||secueciaorac);
select array_append(rec_t_c1_d_tmp, null) into rec_t_c1_d_tmp;
lin_aux:=lin_aux+1;--bogar
---------------------------------
-- inserta r?plica aplicada en la tabla fecxp_enc_pagos_erp
select                 secueciaorac        , noempresa        , b.secmoneda    , nofoliodet          , cperiodo              , idcveoperacion,
idestatusmov        , nocheque         , idchequera     , idbanco             , importe               , idformapago,
fecvalor            , iddivisa         , tipocambio     , trim(both origenmov)     , idtipooperacion       , nocliente,
idbancobenef        , idchequerabenef  , loteentrada    , nodocto             , concepto              , beneficiario,
clock_timestamp()             , nomempresa       , nomempresarel  , nocuenta            ,  folioref             , referencia    , descripcion,0
into strict rec_t_c1_d_tmp[lin_aux].secuencia_pagos_erp, rec_t_c1_d_tmp[lin_aux].e_codigo         , rec_t_c1_d_tmp[lin_aux].secmoneda        , rec_t_c1_d_tmp[lin_aux].folio_set           , rec_t_c1_d_tmp[lin_aux].periodo             , rec_t_c1_d_tmp[lin_aux].cve_operacion,
rec_t_c1_d_tmp[lin_aux].estatus_movimiento , rec_t_c1_d_tmp[lin_aux].no_cheque        , rec_t_c1_d_tmp[lin_aux].id_chequera      , rec_t_c1_d_tmp[lin_aux].id_banco            , rec_t_c1_d_tmp[lin_aux].importe             , rec_t_c1_d_tmp[lin_aux].forma_pago   ,
rec_t_c1_d_tmp[lin_aux].fecha_aplicacion   , rec_t_c1_d_tmp[lin_aux].moneda           , rec_t_c1_d_tmp[lin_aux].tipo_cambio      , rec_t_c1_d_tmp[lin_aux].origen_movimiento   , rec_t_c1_d_tmp[lin_aux].tipo_operacion      , rec_t_c1_d_tmp[lin_aux].no_cliente   ,
rec_t_c1_d_tmp[lin_aux].id_banco_benef     , rec_t_c1_d_tmp[lin_aux].id_chequera_benef, rec_t_c1_d_tmp[lin_aux].lote_entrada     , rec_t_c1_d_tmp[lin_aux].no_docto            , rec_t_c1_d_tmp[lin_aux].concepto            , rec_t_c1_d_tmp[lin_aux].beneficiario ,
rec_t_c1_d_tmp[lin_aux].fecha_actualizacion, rec_t_c1_d_tmp[lin_aux].nom_empresa      , rec_t_c1_d_tmp[lin_aux].nom_empresa_rel  , rec_t_c1_d_tmp[lin_aux].no_cuenta           , rec_t_c1_d_tmp[lin_aux].folio_ref           , rec_t_c1_d_tmp[lin_aux].referencia   ,
rec_t_c1_d_tmp[lin_aux].descripcion,rec_t_c1_d_tmp[lin_aux].procesado
a, fecxc_monedas b
where b.codmoneda = iddivisa;
--dbms_output.put_line('        [INSERT FECXP_ENC_PAGOS_ERP ]: noFolioDet: '||nofoliodet);
numfolioerp := nofoliodet;/* dmap converted statement start */
else --termina if no existe previamente el egreso erp inserta como viene del set
--el egreso erp existe previamente con ese folio+status
--se procede como se hac??a originalmente
--dbms_output.put_line('EL EGRESO ERP EXISTE PREVIAMENTE CON ESE FOLIO+STATUS '||nofoliodet ||' + '||idestatusmov);
select
utl_file.put_line(fichero, concat('EL EGRESO ERP EXISTE PREVIAMENTE CON ESE FOLIO+STATUS ', nofoliodet , ' + ', idestatusmov)) ;/* dmap converted statement end */
--obtenemos la secuencia de la tabla fecxp_enc_pagos_erp
select nextval('secuencia_pagos_erp') into strict secueciaorac;
--dbms_output.put_line('   [DATO] Folio: ' || nofoliodet);
--dbms_output.put_line('   [DATO] Status: ' || idestatusmov);
--dbms_output.put_line('   [DATO] fecFlujo: ' || fecvalor);
--dbms_output.put_line('   [DATO] fecModif: ' || fecmodif);
delete    from fecxp_gastos_set_erp d
where    exists (
select     /*+ index (e idx_pag_erp_folio) */ 1
from    fecxp_enc_pagos_erp e
where    e.e_codigo = noempresa
and        e.folio_set =  to_char(nofoliodet)
and        e.estatus_movimiento =  idestatusmov
and        e.secuencia_pagos_erp = d.secuencia_pagos_erp);
--dbms_output.put_line('        [DELETE FECXP_GASTOS_SET_ERP]: ');
delete    from fecxp_det_pagos_procesados d
where    exists (
select    /*+ index (e idx_pag_erp_folio) */ 1
from    fecxp_enc_pagos_erp e
where    e.e_codigo = noempresa
and        e.folio_set =  to_char(nofoliodet)
and        e.estatus_movimiento =  idestatusmov
and        e.secuencia_pagos_erp = d.secuencia_pagos_erp);
--dbms_output.put_line('        [DELETE FECXP_DET_PAGOS_PROCESADOS]: ');
delete    from fecxp_det_pagos_erp d
where    exists (
select    /*+ index (e idx_pag_erp_folio) */  1
from    fecxp_enc_pagos_erp e
where    e.e_codigo = noempresa
and        e.folio_set = to_char(nofoliodet)
and        e.estatus_movimiento = idestatusmov
and        e.secuencia_pagos_erp = d.secuencia_pagos_erp);
--dbms_output.put_line('        [DELETE FECXP_DET_PAGOS_ERP]: ');
delete    from fecxp_bit_cont_din_folios_ap d
where    exists (
select    /*+ index (e idx_pag_erp_folio) */  1
from    fecxp_enc_pagos_erp e
where    e.e_codigo = noempresa
and        e.folio_set = to_char(nofoliodet)
and        e.estatus_movimiento = idestatusmov
and        e.secuencia_pagos_erp = d.secuencia_pagos_erp);
--dbms_output.put_line('        [DELETE FECXP_BIT_CONT_DIN_FOLIOS_AP]: ');
delete    from fecxp_bit_cont_din_aper_det d
where    exists (
select    /*+ index (e idx_pag_erp_folio) */ 1
from    fecxp_enc_pagos_erp e
where    e.e_codigo = noempresa
and    e.folio_set = to_char(nofoliodet)
and    e.estatus_movimiento = idestatusmov
and    e.secuencia_pagos_erp = d.secuencia_pagos_erp);
--dbms_output.put_line('        [DELETE FECXP_BIT_CONT_DIN_APER_DET]: ');
delete    from fecxp_bit_cont_din_aper_enc d
where    exists (
select    /*+ index (e idx_pag_erp_folio) */  1
from    fecxp_enc_pagos_erp e
where    e.e_codigo = noempresa
and        e.folio_set = to_char(nofoliodet)
and        e.estatus_movimiento = idestatusmov
and        e.secuencia_pagos_erp = d.secuencia_pagos_erp);
--dbms_output.put_line('        [DELETE FECXP_BIT_CONT_DIN_APER_ENC]: ');
delete    from fecxp_enc_pagos_erp
where    e_codigo = noempresa
and    folio_set = to_char(nofoliodet)
and    estatus_movimiento = idestatusmov;
--dbms_output.put_line('        [DELETE FECXP_ENC_PAGOS_ERP]: ->'||secueciaorac);
---------------------------------
--inserta r?plica aplicada en la tabla fecxp_enc_pagos_erp
select array_append(rec_t_c1_d_tmp, null) into rec_t_c1_d_tmp;
lin_aux:=lin_aux+1;--bogar
select                 secueciaorac        , noempresa        , b.secmoneda    , nofoliodet          , cperiodo              , idcveoperacion,
idestatusmov        , nocheque         , idchequera     , idbanco             , importe               , idformapago,
fecvalor            , iddivisa         , tipocambio     , trim(both origenmov)     , idtipooperacion       , nocliente,
idbancobenef        , idchequerabenef  , loteentrada    , nodocto             , concepto              , beneficiario,
clock_timestamp()             , nomempresa       , nomempresarel  , nocuenta            ,  folioref             , referencia    , descripcion,0
into strict rec_t_c1_d_tmp[lin_aux].secuencia_pagos_erp, rec_t_c1_d_tmp[lin_aux].e_codigo         , rec_t_c1_d_tmp[lin_aux].secmoneda        , rec_t_c1_d_tmp[lin_aux].folio_set           , rec_t_c1_d_tmp[lin_aux].periodo             , rec_t_c1_d_tmp[lin_aux].cve_operacion,
rec_t_c1_d_tmp[lin_aux].estatus_movimiento , rec_t_c1_d_tmp[lin_aux].no_cheque        , rec_t_c1_d_tmp[lin_aux].id_chequera      , rec_t_c1_d_tmp[lin_aux].id_banco            , rec_t_c1_d_tmp[lin_aux].importe             , rec_t_c1_d_tmp[lin_aux].forma_pago   ,
rec_t_c1_d_tmp[lin_aux].fecha_aplicacion   , rec_t_c1_d_tmp[lin_aux].moneda           , rec_t_c1_d_tmp[lin_aux].tipo_cambio      , rec_t_c1_d_tmp[lin_aux].origen_movimiento   , rec_t_c1_d_tmp[lin_aux].tipo_operacion      , rec_t_c1_d_tmp[lin_aux].no_cliente   ,
rec_t_c1_d_tmp[lin_aux].id_banco_benef     , rec_t_c1_d_tmp[lin_aux].id_chequera_benef, rec_t_c1_d_tmp[lin_aux].lote_entrada     , rec_t_c1_d_tmp[lin_aux].no_docto            , rec_t_c1_d_tmp[lin_aux].concepto            , rec_t_c1_d_tmp[lin_aux].beneficiario ,
rec_t_c1_d_tmp[lin_aux].fecha_actualizacion, rec_t_c1_d_tmp[lin_aux].nom_empresa      , rec_t_c1_d_tmp[lin_aux].nom_empresa_rel  , rec_t_c1_d_tmp[lin_aux].no_cuenta           , rec_t_c1_d_tmp[lin_aux].folio_ref           , rec_t_c1_d_tmp[lin_aux].referencia   ,
rec_t_c1_d_tmp[lin_aux].descripcion,rec_t_c1_d_tmp[lin_aux].procesado
a, fecxc_monedas b
where b.codmoneda = iddivisa;
numfolioerp := nofoliodet;
end if;  --termina else en el que el folio egreso erp ya existe
end if; --termina verificar si debe generar encabezado o detalle -- finaliza validaci?n para generar encabezado  numfolioerp = nofoliodet
--dbms_output.put_line('creoReplica:'||creoreplica||' idEstatusMov'||idestatusmov||' secueciaORAC:'||secueciaorac);
--genera los detalles
if upper(creoreplica)='S' and ( idestatusmov='X' or idestatusmov='Y' or idestatusmov='Z' ) then
-- inserta detalle de replica aplicada en la tabla fecxp_det_pagos_erp
-- obtenemos la secuencia de la tabla fecxp_enc_pagos_erp
--dbms_output.put_line('          selecciona secuencia  secueciaORACrep->'|| secueciaoracrep);
--dbms_output.put_line('Inserta detalle de replica aplicada en la tabla FECXP_DET_PAGOS_ERP');
select
utl_file.put_line(fichero,'Inserta detalle de replica aplicada en la tabla FECXP_DET_PAGOS_ERP');
select array_append(rec_t_c1_d_det_tmp, null) into rec_t_c1_d_det_tmp;
lin_aux2:=lin_aux2+1;--bogar
select nextval('secuencia_det_pagos_erp'),
secueciaoracrep,
noempresa,
nopartida,
codecombination,
(-1 * importepartida),
cia,
neg,
cta,
scta,
cc,
icia,
top
into strict rec_t_c1_d_det_tmp[lin_aux2].secuencia_det_pagos_erp,
rec_t_c1_d_det_tmp[lin_aux2].secuencia_pagos_erp,
rec_t_c1_d_det_tmp[lin_aux2].e_codigo,
rec_t_c1_d_det_tmp[lin_aux2].numero_de_partida_erp,
rec_t_c1_d_det_tmp[lin_aux2].code_combination,
rec_t_c1_d_det_tmp[lin_aux2].importe_linea,
rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento1,
rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento2,
rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento3,
rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento4,
rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento5,
rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento6,
rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento7
;
--            --dbms_output.put_line('          Termina de insertar en el arreglo');
end if; -- fin estatus cancelado para detalles
--dbms_output.put_line('          Termina 2do if');
--inserta detalle de r?plica aplicada en la tabla fecxp_det_pagos_erp
select array_append(rec_t_c1_d_det_tmp, null) into rec_t_c1_d_det_tmp;
lin_aux2:=lin_aux2+1;--bogar
select nextval('secuencia_det_pagos_erp'), secueciaorac, noempresa, nopartida, codecombination, importepartida, cia, neg, cta, scta, cc, icia, top
into strict rec_t_c1_d_det_tmp[lin_aux2].secuencia_det_pagos_erp, rec_t_c1_d_det_tmp[lin_aux2].secuencia_pagos_erp, rec_t_c1_d_det_tmp[lin_aux2].e_codigo,
rec_t_c1_d_det_tmp[lin_aux2].numero_de_partida_erp, rec_t_c1_d_det_tmp[lin_aux2].code_combination, rec_t_c1_d_det_tmp[lin_aux2].importe_linea,
rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento1, rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento2, rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento3,
rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento4, rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento5, rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento6,
rec_t_c1_d_det_tmp[lin_aux2].oracle_segmento7
;
--dbms_output.put_line('          Inserta en los arreglos');
end loop;
if COALESCE(array_length(rec_t_c1_d_tmp, 1), 0) != 0 then
FOR z IN array_lower(rec_t_c1_d_tmp, 1) .. array_upper(rec_t_c1_d_tmp, 1)
LOOP
insert into fecxp_enc_pagos_erp
values rec_t_c1_d_tmp(z);
END LOOP;
rec_t_c1_d_tmp := rec_t_c1_d_tmp_del_temp;
--/* commit; */
end if;
--dbms_output.put_line('Insertando DETALLE ');
--dbms_output.put_line('DETALLE FIRST'||rec_t_c1_d_det_tmp.first);
--dbms_output.put_line('DETALLE LAST'||rec_t_c1_d_det_tmp.last);
if COALESCE(array_length(rec_t_c1_d_det_tmp, 1), 0) != 0 then
FOR z IN array_lower(rec_t_c1_d_det_tmp, 1) .. array_upper(rec_t_c1_d_det_tmp, 1)
LOOP
insert into fecxp_det_pagos_erp
values rec_t_c1_d_det_tmp(z);
END LOOP;
rec_t_c1_d_det_tmp := rec_t_c1_d_det_tmp_del_temp;
--/* commit; */
end if;
lin_aux := 0;
lin_aux2 := 0;
end if;
--/* commit; */
end loop;
/* close cursor_1; */
--dbms_output.put_line('          Cerrando el primer cursor');
select
utl_file.put_line(fichero,'          Cerrando el primer cursor');
--dbms_output.put_line('=== Proces? Egresos ORACLE. Procesando Egresos SOIN ');
--dbms_output.put_line('=== Proces? Egresos SOIN. Procesando Ingresos ORACLE ');
--dbms_output.put_line('=== Procesando Ingresos ORACLE ');
--dbms_output.put_line('[SELECT INGRESOS ORACLE]: ');
--dbms_output.put_line('          Abriendo el 2do Cursor');
select
utl_file.put_line(fichero,'          Abriendo el 2do Cursor');
/* open cursor_2; */
loop
v_limit := 100;
    cursor_2_v1_query := concat('select array_agg(s) OVER (ROWS BETWEEN CURRENT ROW AND (', v_limit, ' - 1) FOLLOWING) INTO t_c2 from (SELECT q.* from  ( ');
                                            cursor_2_v2_query := concat(') s LIMIT ', v_limit, ' OFFSET ', v_offset, ';');
                                            cursor_2_final_query := concat (cursor_2_v1_query, ' select     f.no_empresa, f.no_folio_det, f.c_periodo,
f.cperiodoapli, f.id_cve_operacion, trim(both f.id_estatus_mov) as id_estatus_mov,
f.no_cheque, trim(both f.id_chequera) as id_chequera, f.id_banco,
f.importe, f.id_forma_pago, f.fec_flujo,
f.fec_modif, trim(both f.id_divisa) as id_divisa, f.tipo_cambio,
trim(both f.origen_mov) as origen_mov, f.id_tipo_operacion, trim(both f.no_cliente) as no_cliente,
f.id_banco_benef, trim(both f.id_chequera_benef) as id_chequera_benef, f.lote_entrada,
f.no_docto, trim(both f.plataforma) as plataforma, trim(both f.actualizado) as actualizado,
trim(both f.nom_empresa) as nom_empresa, trim(both f.nom_empresa_rel) as nom_empresa_rel, f.no_cuenta,
f.folio_ref, trim(both f.id_tipo_movto) as id_tipo_movto, trim(both f.concepto) as concepto,
trim(both f.beneficiario) as beneficiario, trim(both f.referencia) as referencia, trim(both f.descripcion) as descripcion
from fecxc.fecxp_extraccion_ingr_tab f
--where no_folio_det=0
order by no_folio_det ', cursor_2_v2_query);
                                            execute cursor_2_final_query into t_c2 ;
                                            
v_offset := v_offset + v_limit;
                                            
flg0 := found;
flg1 := found;
flg2 := found;
c_count := COALESCE(array_length(t_c2, 1), 0);
exit when (not flg0)or(not flg1)or(not flg2);
if c_count > 0 then
for i in ARRAY_lower(t_c2, 1) .. ARRAY_upper(t_c2, 1)
loop
--dbms_output.put_line('Antes de la asignaci?n');
noempresa         := t_c2[i].no_empresa;
nofoliodet        := t_c2[i].no_folio_det;
cperiodo          := t_c2[i].c_periodo;
idcveoperacion    := t_c2[i].id_cve_operacion;
idestatusmov      := upper(t_c2[i].id_estatus_mov);
nocheque          := t_c2[i].no_cheque;
idchequera        := t_c2[i].id_chequera;
idbanco           := t_c2[i].id_banco;
importe           := t_c2[i].importe;
idformapago       := t_c2[i].id_forma_pago;
fecvalor          := t_c2[i].fec_flujo;
iddivisa          := t_c2[i].id_divisa;
tipocambio        := t_c2[i].tipo_cambio;
origenmov         := t_c2[i].origen_mov;
idtipooperacion   := t_c2[i].id_tipo_operacion;
nocliente         := t_c2[i].no_cliente;
idbancobenef      := t_c2[i].id_banco_benef;
idchequerabenef   := t_c2[i].id_chequera_benef;
loteentrada       := t_c2[i].lote_entrada;
nodocto           := t_c2[i].no_docto;
concepto          := replace(t_c2[i].concepto,chr(39),' ');
beneficiario      := replace(t_c2[i].beneficiario,chr(39),' ');
referencia        := t_c2[i].referencia;
descripcion       := t_c2[i].descripcion;
fecmodif          := t_c2[i].fec_modif;
nomempresa        := t_c2[i].nom_empresa;
nocuenta          := t_c2[i].no_cuenta;
folioref          := t_c2[i].folio_ref;
idtipomovto       := t_c2[i].id_tipo_movto;
plataforma        := t_c2[i].plataforma;
cperiodoapli      := t_c2[i].cperiodoapli;
nomempresarel     := t_c2[i].nom_empresa_rel;
--dbms_output.put_line('Despues de la asignaci?n : '||nofoliodet||' :'||idestatusmov);
if (idestatusmov='X' or idestatusmov='Y' or idestatusmov='Z') then
idestatusmovaplicado := 'A';
if idtipooperacion=7000 or idtipooperacion=7001 or idtipooperacion=7002 or idtipooperacion=7003 or idtipooperacion=7005
then
idestatusmovaplicado := 'L';
end if;
select count(*) into strict existefolio from fecxc_dep_especiales where no_folio_det = nofoliodet  and id_status_mov =  idestatusmovaplicado;/* dmap converted statement start */
if trunc(fecvalor)=trunc(fecmodif) then
if (existefolio=0) then
--no existe el folio+status y se generar?
--dbms_output.put_line('Folio cancelado el d?a del origen. Se generar? r?plica FECXC_DEP_ESPECIALES aplicada con Folio: ' || nofoliodet || ' Status: ' || idestatusmovaplicado || ' TipoOper: ' || idtipooperacion);
--inserta r?plica aplicada en la tabla fecxc_dep_especiales
select
utl_file.put_line(fichero, concat('Folio cancelado el d?a del origen. Se generar? r?plica FECXC_DEP_ESPECIALES aplicada con Folio: ', nofoliodet , ' Status: ' , idestatusmovaplicado , ' TipoOper: ' , idtipooperacion)) ;/* dmap converted statement end *//* dmap converted statement start */
--dbms_output.put_line('   [DATO] Folio: ' || nofoliodet);
--dbms_output.put_line('    [DATO] Status: ' || idestatusmovaplicado);
--dbms_output.put_line('    [DATO] fecFlujo: ' || fecvalor);
--dbms_output.put_line('    [DATO] fecModif: ' || fecmodif);
select
utl_file.put_line(fichero, concat('    [DATO] Folio: ', nofoliodet)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] Status: ', idestatusmovaplicado)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecFlujo: ', fecvalor)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecModif: ', fecmodif)) ;/* dmap converted statement end */
/*se limpia la bandera para revisar si se va a marcar el registro para su posterios apertura*/
v_aperturar:=1;
/*se revisa si el ingreso deberia de ser aperturado o no*/
if idtipooperacion = 3700 or idtipooperacion =3701 or idtipooperacion =3705 or idtipooperacion =3706 or idtipooperacion =3708 or idtipooperacion =3715 or idtipooperacion =4102 or idtipooperacion =4103 then
v_aperturar:=0;
end if;
select array_append(rec_t_c2_d_tmp, null) into rec_t_c2_d_tmp;
lin_aux3 := lin_aux3+1;
select noempresa         , nofoliodet         , fecvalor        , referencia     , idbanco              , idbancobenef            , idchequera,
concepto           , tipocambio         , (importe*-1)         , nocheque       , idtipooperacion      , idformapago             , iddivisa,
fecvalor           ,idestatusmovaplicado, beneficiario    , descripcion    , nocliente            , nextval('secuencia_dep_especiales'),cperiodoapli,
idcveoperacion     , origenmov          , idchequerabenef , loteentrada    , nodocto              , plataforma              , nomempresa,
nomempresarel      , nocuenta           , folioref        , clock_timestamp() ,0,  v_aperturar
into strict rec_t_c2_d_tmp[lin_aux3].no_empresa        , rec_t_c2_d_tmp[lin_aux3].no_folio_det     , rec_t_c2_d_tmp[lin_aux3].fec_valor        , rec_t_c2_d_tmp[lin_aux3].referencia         , rec_t_c2_d_tmp[lin_aux3].id_banco             , rec_t_c2_d_tmp[lin_aux3].id_banco_benef          , rec_t_c2_d_tmp[lin_aux3].id_chequera,
rec_t_c2_d_tmp[lin_aux3].concepto          , rec_t_c2_d_tmp[lin_aux3].tipo_cambio      , rec_t_c2_d_tmp[lin_aux3].importe          , rec_t_c2_d_tmp[lin_aux3].no_cheque          , rec_t_c2_d_tmp[lin_aux3].id_tipo_operacion_set, rec_t_c2_d_tmp[lin_aux3].id_forma_pago           , rec_t_c2_d_tmp[lin_aux3].id_divisa,
rec_t_c2_d_tmp[lin_aux3].fec_valor_original, rec_t_c2_d_tmp[lin_aux3].id_status_mov    , rec_t_c2_d_tmp[lin_aux3].beneficiario     , rec_t_c2_d_tmp[lin_aux3].descripcion        , rec_t_c2_d_tmp[lin_aux3].no_cliente           , rec_t_c2_d_tmp[lin_aux3].secuencia_dep_especiales, rec_t_c2_d_tmp[lin_aux3].periodo,
rec_t_c2_d_tmp[lin_aux3].cve_operacion     , rec_t_c2_d_tmp[lin_aux3].origen_movimiento, rec_t_c2_d_tmp[lin_aux3].id_chequera_benef, rec_t_c2_d_tmp[lin_aux3].lote_entrada       , rec_t_c2_d_tmp[lin_aux3].no_docto             , rec_t_c2_d_tmp[lin_aux3].plataforma              , rec_t_c2_d_tmp[lin_aux3].nom_empresa,
rec_t_c2_d_tmp[lin_aux3].nom_empresa_rel   , rec_t_c2_d_tmp[lin_aux3].no_cuenta        , rec_t_c2_d_tmp[lin_aux3].folio_ref        , rec_t_c2_d_tmp[lin_aux3].fecha_actualizacion, rec_t_c2_d_tmp[lin_aux3].procesado,rec_t_c2_d_tmp[lin_aux3].aperturadoar
;
else
--ya existe el folio+status+tipooper en este caso se mandar?n los datos al log de jaguar
--debido a que el movimiento no deber?a existir previamente, pues en el set nace y se
--cancela el mismo d?a.
--si el folio aplicado ya existe y se gener? un cancelado se tiene que forzar la obtenci?n de cuentas
--forzar al reprocesamiento
select
utl_file.put_line(fichero,'YA EXISTE EL FOLIO+STATUS+TIPOOPER EN ESTE CASO SE MANDAR?N LOS DATOS AL LOG DE JAGUAR');
select
utl_file.put_line(fichero,'Forzar al reprocesamiento');
update    fecxc_dep_especiales
set    procesado = 0 where ctid in (select ctid from fecxc_dep_especiales where no_folio_det = nofoliodet
and    id_status_mov = idestatusmovaplicado;
--dbms_output.put_line('        [REAPERTURA INGRESOS]: ');
delete    /*+ index (d idx_fecxc_dep_esp_d00) */                                      fecxc_dep_especiales_d d
where    exists (
select    1
from    fecxc_dep_especiales e
where    e.no_folio_det = nofoliodet
and    e.secuencia_dep_especiales = d.secuencia_dep_especiales );
delete    from fecxp_bit_ingr_cc d
where    exists (
select    1
from    fecxc_dep_especiales e
where    e.no_folio_det = nofoliodet
and     e.secuencia_dep_especiales = d.secuencia_dep_especiales );
delete    from fecxp_bit_ingr_misc d
where    exists (
select    1
from    fecxc_dep_especiales e
where    e.no_folio_det = nofoliodet
and     e.secuencia_dep_especiales = d.secuencia_dep_especiales );
delete    from fecxp_misc_repe d
where    d.no_folio_det = nofoliodet;
delete    from fecxp_fact_var d
where    d.no_folio_det = nofoliodet;
delete    from fecxp_bit_ingr_fact d
where    exists (
select    1
from    fecxc_dep_especiales e
where    e.no_folio_det =  nofoliodet
and     e.secuencia_dep_especiales = d.secuencia_dep_especiales );
end if; --fin else cuando el folio aplicado de ingreso ya existe
/* dmap converted statement start */
else --finaliza if fecvalor = fecmodif
--si la fecha de cancelaci?n no es la de generaci?n validar que ya existe el registro aplicado
if (existefolio=0) then
--no existe el folio+status y se generar? con los nuevos datos
--dbms_output.put_line('Se cancel? en fecha distinta al origen y no existe el aplicado. Se generar? r?plica fecxc_dep_especiales aplicada con Folio: ' || nofoliodet || ' Status: ' || idestatusmovaplicado || ' TipoOper: ' || idtipooperacion);
--dbms_output.put_line(' La fecha de modificaci?n y aplicaci?n no son iguales.');
-- inserta r?plica aplicada en la tabla fecxc_dep_especiales
select
utl_file.put_line(fichero, concat('Se cancel? en fecha distinta al origen y no existe el aplicado. Se generar? r?plica fecxc_dep_especiales aplicada con Folio: ', nofoliodet , ' Status: ' , idestatusmovaplicado , ' TipoOper: ' , idtipooperacion)) ;/* dmap converted statement end */
select
utl_file.put_line(fichero,'Inserta r?plica aplicada en la tabla FECXC_DEP_ESPECIALES');/* dmap converted statement start */
--dbms_output.put_line('    [DATO] Folio: ' || nofoliodet);
--dbms_output.put_line('    [DATO] Status: ' || idestatusmovaplicado);
--dbms_output.put_line('    [DATO] fecFlujo: ' || fecvalor);
--dbms_output.put_line('    [DATO] fecModif: ' || fecmodif);
select
utl_file.put_line(fichero, concat('    [DATO] Folio: ', nofoliodet)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] Status: ', idestatusmovaplicado)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecFlujo: ', fecvalor)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecModif: ', fecmodif)) ;/* dmap converted statement end */
/*se limpia la bandera para revisar si se va a marcar el registro para su posterios apertura*/
v_aperturar:=1;
/*se revisa si el ingreso deberia de ser aperturado o no*/
if idtipooperacion = 3700 or idtipooperacion =3701 or idtipooperacion =3705 or idtipooperacion =3706 or idtipooperacion =3708 or idtipooperacion =3715 or idtipooperacion =4102 or idtipooperacion =4103 then
v_aperturar:=0;
end if;
select array_append(rec_t_c2_d_tmp, null) into rec_t_c2_d_tmp;
lin_aux3 := lin_aux3+1;
select noempresa    , nofoliodet                      ,fecvalor    , referencia          , idbanco    , idbancobenef,
idchequera   , concepto                        , tipocambio , (importe*-1)             ,nocheque    , idtipooperacion,
idformapago  , iddivisa                        ,fecvalor    , idestatusmovaplicado,beneficiario, descripcion,
nocliente    , nextval('secuencia_dep_especiales'),cperiodoapli,idcveoperacion,trim(both origenmov)    , idchequerabenef,
loteentrada  , nodocto                         ,plataforma  ,nomempresa     , nomempresarel    , nocuenta,
folioref     ,clock_timestamp(),0,v_aperturar
into strict rec_t_c2_d_tmp[lin_aux3].no_empresa   , rec_t_c2_d_tmp[lin_aux3].no_folio_det            , rec_t_c2_d_tmp[lin_aux3].fec_valor         , rec_t_c2_d_tmp[lin_aux3].referencia   , rec_t_c2_d_tmp[lin_aux3].id_banco         , rec_t_c2_d_tmp[lin_aux3].id_banco_benef,
rec_t_c2_d_tmp[lin_aux3].id_chequera  , rec_t_c2_d_tmp[lin_aux3].concepto                , rec_t_c2_d_tmp[lin_aux3].tipo_cambio       , rec_t_c2_d_tmp[lin_aux3].importe      , rec_t_c2_d_tmp[lin_aux3].no_cheque        , rec_t_c2_d_tmp[lin_aux3].id_tipo_operacion_set,
rec_t_c2_d_tmp[lin_aux3].id_forma_pago, rec_t_c2_d_tmp[lin_aux3].id_divisa               , rec_t_c2_d_tmp[lin_aux3].fec_valor_original, rec_t_c2_d_tmp[lin_aux3].id_status_mov, rec_t_c2_d_tmp[lin_aux3].beneficiario     , rec_t_c2_d_tmp[lin_aux3].descripcion,
rec_t_c2_d_tmp[lin_aux3].no_cliente   , rec_t_c2_d_tmp[lin_aux3].secuencia_dep_especiales, rec_t_c2_d_tmp[lin_aux3].periodo           , rec_t_c2_d_tmp[lin_aux3].cve_operacion, rec_t_c2_d_tmp[lin_aux3].origen_movimiento, rec_t_c2_d_tmp[lin_aux3].id_chequera_benef,
rec_t_c2_d_tmp[lin_aux3].lote_entrada , rec_t_c2_d_tmp[lin_aux3].no_docto                , rec_t_c2_d_tmp[lin_aux3].plataforma        , rec_t_c2_d_tmp[lin_aux3].nom_empresa  , rec_t_c2_d_tmp[lin_aux3].nom_empresa_rel  , rec_t_c2_d_tmp[lin_aux3].no_cuenta,
rec_t_c2_d_tmp[lin_aux3].folio_ref    , rec_t_c2_d_tmp[lin_aux3].fecha_actualizacion     , rec_t_c2_d_tmp[lin_aux3].procesado         , rec_t_c2_d_tmp[lin_aux3].aperturadoar
;
--dbms_output.put_line('        [INSERT FECXC_DEP_ESPECIALES]: ');
end if;--finaliza if cuando el folio aplicado no existe y las fechas de cancelaci?n y aplicaci?n no coinciden
end if;--finaliza else  cuando las fechas de cancelaci?n del ingreso erp y aplicaci?n son distintas y el folio aplicado no existe
end if;--finaliza if de status cancelados
--una vez que se gener? la r?plica aplicada para los ingresos erp cancelados se insertar? el ingreso erp leido
--tal y como viene (cancelado o bien aplicado si nunca entr? al if anterior)
--se validar? que la combinaci?n folio+status no exista, si existe se procede como se hac?a originalmente
--buscar el folio con estatus aplicado en la base de datos, esto para las validaciones en caso de que la
--cancelaci?n se haga o no el d?a de la generaci?n.
select count(*) into strict existefolio from fecxc_dep_especiales where no_folio_det = nofoliodet and id_status_mov =idestatusmov;
if (idestatusmov='X' or idestatusmov='Y' or idestatusmov='Z') then
fecvalor := fecmodif;
end if;
--dbms_output.put_line(' Paso 2 existe folio->'||existefolio);
if existefolio=0 then
--no existe previamente el movimiento de ingreso erp y se generar? como viene en el set
--dbms_output.put_line('    [DATO] Folio: ' || nofoliodet);
--dbms_output.put_line('    [DATO] Status: ' || idestatusmov);
--dbms_output.put_line('    [DATO] fecFlujo: ' || fecvalor);
--dbms_output.put_line('    [DATO] fecModif: ' || fecmodif);
select
utl_file.put_line(fichero,'NO EXISTE PREVIAMENTE EL MOVIMIENTO DE INGRESO ERP Y SE GENERAR? COMO VIENE EN EL SET');/* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] Folio: ', nofoliodet)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] Status: ', idestatusmov)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecFlujo: ', fecvalor)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecModif: ', fecmodif)) ;/* dmap converted statement end */
/*se limpia la bandera para revisar si se va a marcar el registro para su posterios apertura*/
v_aperturar:=1;
/*se revisa si el ingreso deberia de ser aperturado o no*/
if idtipooperacion = 3700 or idtipooperacion =3701 or idtipooperacion =3705 or idtipooperacion =3706 or idtipooperacion =3708 or idtipooperacion =3715 or idtipooperacion =4102 or idtipooperacion =4103 then
v_aperturar:=0;
end if;
select array_append(rec_t_c2_d_tmp, null) into rec_t_c2_d_tmp;
lin_aux3 := lin_aux3+1;
select noempresa    , nofoliodet    , fecvalor, referencia   , idbanco          , idbancobenef,
idchequera   , concepto                , tipocambio        , importe      , nocheque         , idtipooperacion,
idformapago  , iddivisa      ,  fecvalor, idestatusmov , beneficiario     , descripcion,
nocliente,nextval('secuencia_dep_especiales'),cperiodo        ,idcveoperacion, origenmov  , idchequerabenef,
loteentrada  , nodocto       , plataforma                  , nomempresa   , nomempresarel    , nocuenta,
folioref     , clock_timestamp(),0,v_aperturar
into strict rec_t_c2_d_tmp[lin_aux3].no_empresa   , rec_t_c2_d_tmp[lin_aux3].no_folio_det            , rec_t_c2_d_tmp[lin_aux3].fec_valor         , rec_t_c2_d_tmp[lin_aux3].referencia   , rec_t_c2_d_tmp[lin_aux3].id_banco         , rec_t_c2_d_tmp[lin_aux3].id_banco_benef,
rec_t_c2_d_tmp[lin_aux3].id_chequera  , rec_t_c2_d_tmp[lin_aux3].concepto                , rec_t_c2_d_tmp[lin_aux3].tipo_cambio       , rec_t_c2_d_tmp[lin_aux3].importe      , rec_t_c2_d_tmp[lin_aux3].no_cheque        , rec_t_c2_d_tmp[lin_aux3].id_tipo_operacion_set,
rec_t_c2_d_tmp[lin_aux3].id_forma_pago, rec_t_c2_d_tmp[lin_aux3].id_divisa               , rec_t_c2_d_tmp[lin_aux3].fec_valor_original, rec_t_c2_d_tmp[lin_aux3].id_status_mov, rec_t_c2_d_tmp[lin_aux3].beneficiario     , rec_t_c2_d_tmp[lin_aux3].descripcion,
rec_t_c2_d_tmp[lin_aux3].no_cliente   , rec_t_c2_d_tmp[lin_aux3].secuencia_dep_especiales, rec_t_c2_d_tmp[lin_aux3].periodo           , rec_t_c2_d_tmp[lin_aux3].cve_operacion, rec_t_c2_d_tmp[lin_aux3].origen_movimiento, rec_t_c2_d_tmp[lin_aux3].id_chequera_benef,
rec_t_c2_d_tmp[lin_aux3].lote_entrada , rec_t_c2_d_tmp[lin_aux3].no_docto                , rec_t_c2_d_tmp[lin_aux3].plataforma        , rec_t_c2_d_tmp[lin_aux3].nom_empresa  , rec_t_c2_d_tmp[lin_aux3].nom_empresa_rel  , rec_t_c2_d_tmp[lin_aux3].no_cuenta,
rec_t_c2_d_tmp[lin_aux3].folio_ref    , rec_t_c2_d_tmp[lin_aux3].fecha_actualizacion     , rec_t_c2_d_tmp[lin_aux3].procesado         , rec_t_c2_d_tmp[lin_aux3].aperturadoar
;
else--termina if no existe previamente el ingreso erp inserta como viene del set
--el ingreso erp existe previamente con ese folio+status
--se procede como se hac?a orignalmente
--dbms_output.put_line('    [DATO] Folio: ' || nofoliodet);
--dbms_output.put_line('    [DATO] Status: ' || idestatusmov);
--dbms_output.put_line('    [DATO] fecFlujo: ' || fecvalor);
--dbms_output.put_line('    [DATO] fecModif: ' || fecmodif);
select
utl_file.put_line(fichero,'EL INGRESO ERP EXISTE PREVIAMENTE CON ESE FOLIO+STATUS');/* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] Folio: ', nofoliodet)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] Status: ', idestatusmov)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecFlujo: ', fecvalor)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecModif: ', fecmodif)) ;/* dmap converted statement end */
select
utl_file.put_line(fichero,'forzar la reapertura');
--primero forzar la reapertura
--borrar las cuentas actuales
delete   /*+ index (d idx_fecxc_dep_esp_d00) */                                  fecxc_dep_especiales_d d
where    exists (
select    1
from    fecxc_dep_especiales e
where    e.no_folio_det = nofoliodet
and     e.secuencia_dep_especiales = d.secuencia_dep_especiales );
delete    from fecxp_bit_ingr_cc d
where    exists (
select    1
from    fecxc_dep_especiales e
where    e.no_folio_det =nofoliodet
and     e.secuencia_dep_especiales = d.secuencia_dep_especiales );
delete    from fecxp_bit_ingr_misc d
where    exists (
select    1
from
fecxc_dep_especiales e
where    e.no_folio_det = nofoliodet
and    e.secuencia_dep_especiales = d.secuencia_dep_especiales );
delete    from fecxp_misc_repe d
where    d.no_folio_det = nofoliodet;
delete    from fecxp_fact_var d
where    d.no_folio_det = nofoliodet;
delete    from fecxp_bit_ingr_fact d
where    exists (
select    1
from    fecxc_dep_especiales e
where    e.no_folio_det = nofoliodet
and     e.secuencia_dep_especiales = d.secuencia_dep_especiales );
delete    /*+ index (d idx_fecxc_dep_esp_d00) */                                  fecxc_dep_especiales_d d
where    exists (
select    1
from    fecxc_dep_especiales e
where    e.no_empresa =  noempresa
and        e.no_folio_det = nofoliodet
and        e.id_status_mov =  idestatusmov
and        e.secuencia_dep_especiales = d.secuencia_dep_especiales);
delete    from fecxc_dep_especiales
where    no_empresa = noempresa
and        no_folio_det = nofoliodet
and        id_status_mov = idestatusmov;
/*se limpia la bandera para revisar si se va a marcar el registro para su posterios apertura*/
v_aperturar:=1;
/*se revisa si el ingreso deberia de ser aperturado o no*/
if idtipooperacion = 3700 or idtipooperacion =3701 or idtipooperacion =3705 or idtipooperacion =3706 or idtipooperacion =3708 or idtipooperacion =3715 or idtipooperacion =4102 or idtipooperacion =4103 then
v_aperturar:=0;
end if;
select array_append(rec_t_c2_d_tmp, null) into rec_t_c2_d_tmp;
lin_aux3 := lin_aux3+1;
select noempresa    , nofoliodet    , fecvalor, referencia   , idbanco          , idbancobenef,
idchequera   , concepto                , tipocambio        , importe      , nocheque         , idtipooperacion,
idformapago  , iddivisa      , fecvalor, idestatusmov , beneficiario     , descripcion,
nocliente,nextval('secuencia_dep_especiales'),cperiodo        ,idcveoperacion, origenmov  , idchequerabenef,
loteentrada  , nodocto       , plataforma                  , nomempresa   , nomempresarel    , nocuenta,
folioref     , clock_timestamp(),0,v_aperturar
into strict    rec_t_c2_d_tmp[lin_aux3].no_empresa   , rec_t_c2_d_tmp[lin_aux3].no_folio_det            , rec_t_c2_d_tmp[lin_aux3].fec_valor         , rec_t_c2_d_tmp[lin_aux3].referencia   , rec_t_c2_d_tmp[lin_aux3].id_banco         , rec_t_c2_d_tmp[lin_aux3].id_banco_benef,
rec_t_c2_d_tmp[lin_aux3].id_chequera  , rec_t_c2_d_tmp[lin_aux3].concepto                , rec_t_c2_d_tmp[lin_aux3].tipo_cambio       , rec_t_c2_d_tmp[lin_aux3].importe      , rec_t_c2_d_tmp[lin_aux3].no_cheque        , rec_t_c2_d_tmp[lin_aux3].id_tipo_operacion_set,
rec_t_c2_d_tmp[lin_aux3].id_forma_pago, rec_t_c2_d_tmp[lin_aux3].id_divisa               , rec_t_c2_d_tmp[lin_aux3].fec_valor_original, rec_t_c2_d_tmp[lin_aux3].id_status_mov, rec_t_c2_d_tmp[lin_aux3].beneficiario     , rec_t_c2_d_tmp[lin_aux3].descripcion,
rec_t_c2_d_tmp[lin_aux3].no_cliente   , rec_t_c2_d_tmp[lin_aux3].secuencia_dep_especiales, rec_t_c2_d_tmp[lin_aux3].periodo           , rec_t_c2_d_tmp[lin_aux3].cve_operacion, rec_t_c2_d_tmp[lin_aux3].origen_movimiento, rec_t_c2_d_tmp[lin_aux3].id_chequera_benef,
rec_t_c2_d_tmp[lin_aux3].lote_entrada , rec_t_c2_d_tmp[lin_aux3].no_docto                , rec_t_c2_d_tmp[lin_aux3].plataforma        , rec_t_c2_d_tmp[lin_aux3].nom_empresa  , rec_t_c2_d_tmp[lin_aux3].nom_empresa_rel  , rec_t_c2_d_tmp[lin_aux3].no_cuenta,
rec_t_c2_d_tmp[lin_aux3].folio_ref    , rec_t_c2_d_tmp[lin_aux3].fecha_actualizacion     , rec_t_c2_d_tmp[lin_aux3].procesado         , rec_t_c2_d_tmp[lin_aux3].aperturadoar
;
end if;  --termina else en el que el folio ingreso erp ya existe
end loop;
if COALESCE(array_length(rec_t_c2_d_tmp, 1), 0) != 0 then
FOR z IN array_lower(rec_t_c2_d_tmp, 1) .. array_upper(rec_t_c2_d_tmp, 1)
LOOP
insert into fecxc_dep_especiales
values rec_t_c2_d_tmp(z);
END LOOP;
rec_t_c2_d_tmp := rec_t_c2_d_tmp_del_temp;
--/* commit; */
end if;
lin_aux3 := 0;
end if;
end loop;
/* close cursor_2; */
--dbms_output.put_line('          Cerrando el 2do Cursor');
select
utl_file.put_line(fichero, '          Cerrando el 2do Cursor');
--dbms_output.put_line('=== Proces? Ingresos ORACLE. Procesando Ingresos SBC ORACLE ');
--dbms_output.put_line('          Abriendo el 3er Cursor');
select
utl_file.put_line(fichero,'          Abriendo el 3er Cursor');
/* open cursor_3; */
loop
v_limit := 100;
    cursor_3_v1_query := concat('select array_agg(s) OVER (ROWS BETWEEN CURRENT ROW AND (', v_limit, ' - 1) FOLLOWING) INTO t_c3 from (SELECT q.* from  ( ');
                                            cursor_3_v2_query := concat(') s LIMIT ', v_limit, ' OFFSET ', v_offset, ';');
                                            cursor_3_final_query := concat (cursor_3_v1_query, ' select     f.no_empresa, f.no_folio_det, f.c_periodo,
f.cperiodoapli, f.id_cve_operacion, trim(both f.id_estatus_mov) as id_estatus_mov,
f.no_cheque, trim(both f.id_chequera) as id_chequera, f.id_banco,
f.importe, f.id_forma_pago, f.fec_flujo,
f.fec_modif, trim(both f.id_divisa) as id_divisa, f.tipo_cambio,
trim(both f.origen_mov) as origen_mov, f.id_tipo_operacion, trim(both f.no_cliente) as no_cliente,
f.id_banco_benef, trim(both f.id_chequera_benef) as id_chequera_benef, f.lote_entrada,
f.no_docto, trim(both f.plataforma) as plataforma, trim(both f.actualizado) as actualizado,
trim(both f.nom_empresa) as nom_empresa, trim(both f.nom_empresa_rel) as nom_empresa_rel, f.no_cuenta,
f.folio_ref, trim(both f.id_tipo_movto) as id_tipo_movto, trim(both f.concepto) as concepto,
trim(both f.beneficiario) as beneficiario, trim(both f.referencia) as referencia, trim(both f.descripcion) as descripcion
from fecxc.fecxp_extraccion_ingrsbc_tab f
--where no_folio_det=0
order by no_folio_det ', cursor_3_v2_query);
                                            execute cursor_3_final_query into t_c3 ;
                                            
v_offset := v_offset + v_limit;
                                            
flg0 := found;
flg1 := found;
flg2 := found;
c_count := COALESCE(array_length(t_c3, 1), 0);
exit when (not flg0)or(not flg1)or(not flg2);
if c_count > 0 then
for i in ARRAY_lower(t_c3, 1) .. ARRAY_upper(t_c3, 1)
loop
--dbms_output.put_line('          Iniciando el 3er Cursor');
noempresa         := t_c3[i].no_empresa;
nofoliodet        := t_c3[i].no_folio_det;
cperiodo          := t_c3[i].c_periodo;
idcveoperacion    := t_c3[i].id_cve_operacion;
idestatusmov      := upper(t_c3[i].id_estatus_mov);
nocheque          := t_c3[i].no_cheque;
idchequera        := t_c3[i].id_chequera;
idbanco           := t_c3[i].id_banco;
importe           := t_c3[i].importe;
idformapago       := t_c3[i].id_forma_pago;
fecvalor          := t_c3[i].fec_flujo;
iddivisa          := t_c3[i].id_divisa;
tipocambio        := t_c3[i].tipo_cambio;
origenmov         := t_c3[i].origen_mov;
idtipooperacion   := t_c3[i].id_tipo_operacion;
nocliente         := t_c3[i].no_cliente;
idbancobenef      := t_c3[i].id_banco_benef;
idchequerabenef   := t_c3[i].id_chequera_benef;
loteentrada       := t_c3[i].lote_entrada;
nodocto           := t_c3[i].no_docto;
concepto          := replace(t_c3[i].concepto,chr(39),' ');
beneficiario      := replace(t_c3[i].beneficiario,chr(39),' ');
referencia        := t_c3[i].referencia;
descripcion       := t_c3[i].descripcion;
fecmodif          := t_c3[i].fec_modif;
nomempresa        := t_c3[i].nom_empresa;
nocuenta          := t_c3[i].no_cuenta;
folioref          := t_c3[i].folio_ref;
idtipomovto       := t_c3[i].id_tipo_movto;
plataforma        := t_c3[i].plataforma;
cperiodoapli      := t_c3[i].cperiodoapli;
nomempresarel     := t_c3[i].nom_empresa_rel;/* dmap converted statement start */
--dbms_output.put_line('Procesando folio '||nofoliodet||' noEmpresa '||noempresa);
if (idestatusmov='X' or idestatusmov='Y' or idestatusmov='Z') then
--dbms_output.put_line('[El folio ' || nofoliodet || ' ] est? cancelado y ha entrado a l?gica SBC cancelados] Status: ' || idestatusmov || '');
select
utl_file.put_line(fichero, concat('[El folio ', nofoliodet , ' ] est? cancelado y ha entrado a l?gica SBC cancelados] Status: ' , idestatusmov , '')) ;/* dmap converted statement end */
existefoliocanc := 0;
select count(*) into strict existefoliocanc from fecxc_dep_especiales where no_folio_det = nofoliodet and id_status_mov = idestatusmov;/* dmap converted statement start */
--dbms_output.put_line('[Se han localizado]: ' || existefoliocanc || ' folios SBC con estatus cancelado.');
select
utl_file.put_line(fichero, concat('[Se han localizado]: ', existefoliocanc , ' folios SBC con estatus cancelado.')) ;/* dmap converted statement end */
if (existefoliocanc=0)then
--cuando no exista previamente el cancelado proceder normalmente
idestatusmovaplicado := 'A';/* dmap converted statement start */
--dbms_output.put_line('[No existe previamente el cancelado, el Status aplicado es]: ' || idestatusmovaplicado || '');
select
utl_file.put_line(fichero, concat('[No existe previamente el cancelado, el Status aplicado es]: ', idestatusmovaplicado , '')) ;/* dmap converted statement end */
existefolio := 0;
select count(*) into strict  existefolio from fecxc_dep_especiales where no_folio_det =  nofoliodet  and id_status_mov = idestatusmovaplicado;
--dbms_output.put_line('[Se han localizado]: ' || existefolio || ' folios con estatus aplicado.');
--si no existe como aplicado verificar si existe como pendiente
if (existefolio=0)then
idestatusmovaplicado := 'P';/* dmap converted statement start */
--dbms_output.put_line('[El Status pendiente es]: ' || idestatusmovaplicado || '');
select
utl_file.put_line(fichero, concat('[El Status pendiente es]: ', idestatusmovaplicado , '')) ;/* dmap converted statement end */
select count(*) into strict existefolio from fecxc_dep_especiales where no_folio_det = nofoliodet and id_status_mov = idestatusmovaplicado;/* dmap converted statement start */
--dbms_output.put_line('[Se han localizado]: ' || existefolio || ' folios con estatus pendiente.');
select
utl_file.put_line(fichero, concat('[Se han localizado]: ', existefolio , ' folios con estatus pendiente.')) ;/* dmap converted statement end */
end if;
--si no existe ninguna r?plica sbc crearla
if (existefolio=0)then
--crear la r?plica aplicada del folio cancelado
idestatusmovaplicado := 'A';/* dmap converted statement start */
--dbms_output.put_line('Folio SBC cancelado. Se generar? r?plica FECXC_DEP_ESPECIALES aplicada con Folio: ' || nofoliodet || ' Status: ' || idestatusmovaplicado || ' TipoOper: ' || idtipooperacion);
select
utl_file.put_line(fichero, concat('Folio SBC cancelado. Se generar? r?plica FECXC_DEP_ESPECIALES aplicada con Folio: ', nofoliodet , ' Status: ' , idestatusmovaplicado , ' TipoOper: ' , idtipooperacion)) ;/* dmap converted statement end *//* dmap converted statement start */
--no existe el folio+status y se generar?
--dbms_output.put_line('    [DATO] Folio SBC: ' || nofoliodet);
--dbms_output.put_line('    [DATO] Status: ' || idestatusmovaplicado);
--dbms_output.put_line('    [DATO] fecFlujo: ' || fecvalor);
--dbms_output.put_line('    [DATO] fecModif: ' || fecmodif);
select
utl_file.put_line(fichero, concat('    [DATO] Folio SBC: ', nofoliodet)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] Status: ', idestatusmovaplicado)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecFlujo: ', fecvalor)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecModif: ', fecmodif)) ;/* dmap converted statement end */
--inserta r?plica aplicada en la tabla fecxc_dep_especiales
select array_append(rec_t_c3_d_tmp, null) into rec_t_c3_d_tmp;
lin_aux4 := lin_aux4+1;
select noempresa    , nofoliodet    , fecvalor, referencia   , idbanco          , idbancobenef,
idchequera   , concepto                , tipocambio        , (importe*-1), nocheque   ,idtipooperacion,
idformapago  , iddivisa      , fecvalor, idestatusmovaplicado,beneficiario     , descripcion,
nocliente,nextval('secuencia_dep_especiales'),cperiodoapli    ,idcveoperacion, origenmov  , idchequerabenef,
loteentrada  , nodocto       , plataforma                  , nomempresa   , nomempresarel    , nocuenta,
folioref     , clock_timestamp(),0
into strict rec_t_c3_d_tmp[lin_aux4].no_empresa   , rec_t_c3_d_tmp[lin_aux4].no_folio_det            , rec_t_c3_d_tmp[lin_aux4].fec_valor         , rec_t_c3_d_tmp[lin_aux4].referencia   , rec_t_c3_d_tmp[lin_aux4].id_banco         , rec_t_c3_d_tmp[lin_aux4].id_banco_benef,
rec_t_c3_d_tmp[lin_aux4].id_chequera  , rec_t_c3_d_tmp[lin_aux4].concepto                , rec_t_c3_d_tmp[lin_aux4].tipo_cambio       , rec_t_c3_d_tmp[lin_aux4].importe      , rec_t_c3_d_tmp[lin_aux4].no_cheque        , rec_t_c3_d_tmp[lin_aux4].id_tipo_operacion_set,
rec_t_c3_d_tmp[lin_aux4].id_forma_pago, rec_t_c3_d_tmp[lin_aux4].id_divisa               , rec_t_c3_d_tmp[lin_aux4].fec_valor_original, rec_t_c3_d_tmp[lin_aux4].id_status_mov, rec_t_c3_d_tmp[lin_aux4].beneficiario     , rec_t_c3_d_tmp[lin_aux4].descripcion,
rec_t_c3_d_tmp[lin_aux4].no_cliente   , rec_t_c3_d_tmp[lin_aux4].secuencia_dep_especiales, rec_t_c3_d_tmp[lin_aux4].periodo           , rec_t_c3_d_tmp[lin_aux4].cve_operacion, rec_t_c3_d_tmp[lin_aux4].origen_movimiento, rec_t_c3_d_tmp[lin_aux4].id_chequera_benef,
rec_t_c3_d_tmp[lin_aux4].lote_entrada , rec_t_c3_d_tmp[lin_aux4].no_docto                , rec_t_c3_d_tmp[lin_aux4].plataforma        , rec_t_c3_d_tmp[lin_aux4].nom_empresa  , rec_t_c3_d_tmp[lin_aux4].nom_empresa_rel  , rec_t_c3_d_tmp[lin_aux4].no_cuenta,
rec_t_c3_d_tmp[lin_aux4].folio_ref    , rec_t_c3_d_tmp[lin_aux4].fecha_actualizacion     , rec_t_c3_d_tmp[lin_aux4].procesado
;
--dbms_output.put_line('        [INSERT FECXC_DEP_ESPECIALES]: ' );
else-- fin creaci?n de r?plica aplicada
--si ya existe la r?plica aplicada o pendiente del folio sbc
--si el folio aplicado ya existe y se gener? un cancelado se tiene que forzar la obtenci?n de cuentas
--forzar al reprocesamiento
update    fecxc_dep_especiales
set procesado = 0
where    no_folio_det =nofoliodet;
--dbms_output.put_line('        [REAPERTURA INGRESOS SBC]: ');
select
utl_file.put_line(fichero,'        [REAPERTURA INGRESOS SBC]: ');
delete   /*+ index (d idx_fecxc_dep_esp_d00) */                                      fecxc_dep_especiales_d d
where    exists (select    1
from    fecxc_dep_especiales e
where    e.no_folio_det = nofoliodet
and     e.secuencia_dep_especiales = d.secuencia_dep_especiales );
--dbms_output.put_line('        [DELETE FECXC_DEP_ESPECIALES_D]: ');
delete    from fecxp_bit_ingr_cc d
where    exists (select    1
from    fecxc_dep_especiales e
where    e.no_folio_det = nofoliodet
and     e.secuencia_dep_especiales = d.secuencia_dep_especiales );
--dbms_output.put_line('        [DELETE FECXP_BIT_INGR_CC]:' );
delete    from fecxp_bit_ingr_misc d
where    exists (select    1
from    fecxc_dep_especiales e
where    e.no_folio_det = nofoliodet
and    e.secuencia_dep_especiales = d.secuencia_dep_especiales );
--dbms_output.put_line('        [DELETE FECXP_BIT_INGR_MISC]: ');
delete    from fecxp_misc_repe d
where    d.no_folio_det =nofoliodet;
--dbms_output.put_line('        [DELETE FECXP_MISC_REPE]: ');
delete    from fecxp_fact_var d
where    d.no_folio_det =nofoliodet;
--dbms_output.put_line('        [DELETE FECXP_FACT_VAR]: ');
delete    from fecxp_bit_ingr_fact d
where    exists (select    1
from    fecxc_dep_especiales e
where    e.no_folio_det = nofoliodet
and     e.secuencia_dep_especiales = d.secuencia_dep_especiales );
--dbms_output.put_line('        [DELETE FECXP_BIT_INGR_FACT]: ');
--dbms_output.put_line('        [TERMINA FORZAR REPROCESO DE INGRESOS SBC CUENTAS CONTABLES]: ');
end if; -- fin else  r?plica aplicada
--una vez creada la r?plica crear el cancelado pues no existe previamente
--para los registros cancelados la fecha flujo debe ser la fecha de cancelaci?n
fecvalor := fecmodif;/* dmap converted statement start */
--dbms_output.put_line('Folio SBC se generar? FECXC_DEP_ESPECIALES con Folio cancelado: ' || nofoliodet || ' Status: ' || idestatusmov || ' TipoOper: ' || idtipooperacion);
--dbms_output.put_line('    [DATO] Folio: ' || nofoliodet);
--dbms_output.put_line('    [DATO] Status: ' || idestatusmov);
--dbms_output.put_line('    [DATO] fecFlujo: ' || fecvalor);
--dbms_output.put_line('    [DATO] fecModif: ' || fecmodif);
select
utl_file.put_line(fichero, concat('Folio SBC se generar? FECXC_DEP_ESPECIALES con Folio cancelado: ', nofoliodet , ' Status: ' , idestatusmov , ' TipoOper: ' , idtipooperacion)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('   [DATO] Folio: ', nofoliodet)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('   [DATO] Status: ', idestatusmov)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecFlujo: ', fecvalor)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('    [DATO] fecModif: ', fecmodif)) ;/* dmap converted statement end */
select array_append(rec_t_c3_d_tmp, null) into rec_t_c3_d_tmp;
lin_aux4 := lin_aux4+1;
select noempresa    , nofoliodet    , fecvalor, referencia   , idbanco          , idbancobenef,
idchequera   , concepto                , tipocambio        , importe, nocheque   ,idtipooperacion,
idformapago  , iddivisa      , fecvalor, idestatusmov,beneficiario     , descripcion,
nocliente,nextval('secuencia_dep_especiales'),cperiodo    ,idcveoperacion, origenmov  , idchequerabenef,
loteentrada  , nodocto       , plataforma                  , nomempresa   , nomempresarel    , nocuenta,
folioref     , clock_timestamp(),0
into strict rec_t_c3_d_tmp[lin_aux4].no_empresa   , rec_t_c3_d_tmp[lin_aux4].no_folio_det            , rec_t_c3_d_tmp[lin_aux4].fec_valor         , rec_t_c3_d_tmp[lin_aux4].referencia   , rec_t_c3_d_tmp[lin_aux4].id_banco         , rec_t_c3_d_tmp[lin_aux4].id_banco_benef,
rec_t_c3_d_tmp[lin_aux4].id_chequera  , rec_t_c3_d_tmp[lin_aux4].concepto                , rec_t_c3_d_tmp[lin_aux4].tipo_cambio       , rec_t_c3_d_tmp[lin_aux4].importe      , rec_t_c3_d_tmp[lin_aux4].no_cheque        , rec_t_c3_d_tmp[lin_aux4].id_tipo_operacion_set,
rec_t_c3_d_tmp[lin_aux4].id_forma_pago, rec_t_c3_d_tmp[lin_aux4].id_divisa               , rec_t_c3_d_tmp[lin_aux4].fec_valor_original, rec_t_c3_d_tmp[lin_aux4].id_status_mov, rec_t_c3_d_tmp[lin_aux4].beneficiario     , rec_t_c3_d_tmp[lin_aux4].descripcion,
rec_t_c3_d_tmp[lin_aux4].no_cliente   , rec_t_c3_d_tmp[lin_aux4].secuencia_dep_especiales, rec_t_c3_d_tmp[lin_aux4].periodo           , rec_t_c3_d_tmp[lin_aux4].cve_operacion, rec_t_c3_d_tmp[lin_aux4].origen_movimiento, rec_t_c3_d_tmp[lin_aux4].id_chequera_benef,
rec_t_c3_d_tmp[lin_aux4].lote_entrada , rec_t_c3_d_tmp[lin_aux4].no_docto                , rec_t_c3_d_tmp[lin_aux4].plataforma        , rec_t_c3_d_tmp[lin_aux4].nom_empresa  , rec_t_c3_d_tmp[lin_aux4].nom_empresa_rel  , rec_t_c3_d_tmp[lin_aux4].no_cuenta,
rec_t_c3_d_tmp[lin_aux4].folio_ref    , rec_t_c3_d_tmp[lin_aux4].fecha_actualizacion     , rec_t_c3_d_tmp[lin_aux4].procesado
;
--dbms_output.put_line('        [INSERT FECXC_DEP_ESPECIALES]: ');
end if;--finaliza validaci?n de que no exista previamente el cancelado
/* dmap converted statement start */
else--fin if es cancelado
--es un folio sbc no cancelado
--dbms_output.put_line('[El folio SBC ' || nofoliodet || ' no est? cancelado, entra a la l?gica de no cancelados.] Status: '||  idestatusmov );
--buscar si existe el folio con estatus aplicado y si no est? como pendiente
select
utl_file.put_line(fichero, concat('[El folio SBC ', nofoliodet , ' no est? cancelado, entra a la l?gica de no cancelados.] Status: ', idestatusmov)  );/* dmap converted statement end */
idestatusmovaplicado := 'A';
existefolio :=0;
select count(*) into strict existefolio from fecxc_dep_especiales where no_folio_det = nofoliodet  and id_status_mov =  idestatusmovaplicado;/* dmap converted statement start */
--dbms_output.put_line('[Se han localizado]: ' || existefolio || ' folios SBC con estatus aplicado. No se insert? este folio si ya existe y se verificar? si actualiza status.');
select
utl_file.put_line(fichero, concat('[Se han localizado]: ', existefolio , ' folios SBC con estatus aplicado. No se insert? este folio si ya existe y se verificar? si actualiza status.')) ;/* dmap converted statement end */
--si no existe como aplicado buscar como pendiente
if (existefolio=0) then
idestatusmovaplicado := 'P';
select count(*) into strict existefolio from fecxc_dep_especiales where no_folio_det =  nofoliodet  and id_status_mov =  idestatusmovaplicado;/* dmap converted statement start */
--dbms_output.put_line('[Se han localizado]: ' || existefolio || ' folios SBC con estatus pendiente.');
select
utl_file.put_line(fichero, concat('[Se han localizado]: ', existefolio , ' folios SBC con estatus pendiente.')) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
--si no existe crearlo
if (existefolio=0)then
--dbms_output.put_line('Folio SBC se generar? FECXC_DEP_ESPECIALES aplicada con Folio: ' || nofoliodet || ' Status: ' || idestatusmov || ' TipoOper: ' || idtipooperacion);
--dbms_output.put_line('FOLIO SBC:'||nofoliodet ||' noEmpresa:'||noempresa);
select
utl_file.put_line(fichero, concat('Folio SBC se generar? FECXC_DEP_ESPECIALES aplicada con Folio: ', nofoliodet , ' Status: ' , idestatusmov , ' TipoOper: ' , idtipooperacion)) ;/* dmap converted statement end */
select array_append(rec_t_c3_d_tmp, null) into rec_t_c3_d_tmp;
lin_aux4 := lin_aux4+1;
select noempresa    , nofoliodet    , fecvalor, referencia   , idbanco          , idbancobenef,
idchequera   , concepto                , tipocambio        , importe, nocheque   ,idtipooperacion,
idformapago  , iddivisa      , fecvalor, idestatusmov,beneficiario     , descripcion,
nocliente,nextval('secuencia_dep_especiales'),cperiodo    ,idcveoperacion, origenmov  , idchequerabenef,
loteentrada  , nodocto       , plataforma                  , nomempresa   , nomempresarel    , nocuenta,
folioref     , clock_timestamp(),0
into strict rec_t_c3_d_tmp[lin_aux4].no_empresa   , rec_t_c3_d_tmp[lin_aux4].no_folio_det            , rec_t_c3_d_tmp[lin_aux4].fec_valor         , rec_t_c3_d_tmp[lin_aux4].referencia   , rec_t_c3_d_tmp[lin_aux4].id_banco         , rec_t_c3_d_tmp[lin_aux4].id_banco_benef,
rec_t_c3_d_tmp[lin_aux4].id_chequera  , rec_t_c3_d_tmp[lin_aux4].concepto                , rec_t_c3_d_tmp[lin_aux4].tipo_cambio       , rec_t_c3_d_tmp[lin_aux4].importe      , rec_t_c3_d_tmp[lin_aux4].no_cheque        , rec_t_c3_d_tmp[lin_aux4].id_tipo_operacion_set,
rec_t_c3_d_tmp[lin_aux4].id_forma_pago, rec_t_c3_d_tmp[lin_aux4].id_divisa               , rec_t_c3_d_tmp[lin_aux4].fec_valor_original, rec_t_c3_d_tmp[lin_aux4].id_status_mov, rec_t_c3_d_tmp[lin_aux4].beneficiario     , rec_t_c3_d_tmp[lin_aux4].descripcion,
rec_t_c3_d_tmp[lin_aux4].no_cliente   , rec_t_c3_d_tmp[lin_aux4].secuencia_dep_especiales, rec_t_c3_d_tmp[lin_aux4].periodo           , rec_t_c3_d_tmp[lin_aux4].cve_operacion, rec_t_c3_d_tmp[lin_aux4].origen_movimiento, rec_t_c3_d_tmp[lin_aux4].id_chequera_benef,
rec_t_c3_d_tmp[lin_aux4].lote_entrada , rec_t_c3_d_tmp[lin_aux4].no_docto                , rec_t_c3_d_tmp[lin_aux4].plataforma        , rec_t_c3_d_tmp[lin_aux4].nom_empresa  , rec_t_c3_d_tmp[lin_aux4].nom_empresa_rel  , rec_t_c3_d_tmp[lin_aux4].no_cuenta,
rec_t_c3_d_tmp[lin_aux4].folio_ref    , rec_t_c3_d_tmp[lin_aux4].fecha_actualizacion     , rec_t_c3_d_tmp[lin_aux4].procesado
;
--dbms_output.put_line('        [INSERT FECXC_DEP_ESPECIALES]: ');
else  --// finaliza crear sbc no cancelado
--//si el sbc no cancelado ya existe
--dbms_output.put_line('Logica existe Folio != 0 tipo operacion: '||idtipooperacion||'');
if idtipooperacion=3110 or idtipooperacion=3112 then
--//buscar si el folio existente sigue pendiente para cambiarlo de estatus
--dbms_output.put_line('Buscar si el folio existente sigue pendiente para cambiarlo de estatus');
existefolio:=0;
select count(*) into strict existefolio from fecxc_dep_especiales where no_folio_det =  nofoliodet  and id_status_mov = 'P';/* dmap converted statement start */
--dbms_output.put_line('Se encontraron '||existefolio||' Con Estatus Pendiente');
select
utl_file.put_line(fichero, concat('Se encontraron ', existefolio, ' Con Estatus Pendiente')) ;/* dmap converted statement end *//* dmap converted statement start */
if (existefolio!=0) then
--dbms_output.put_line('Actualiza status de SBC DNI en FECXC_DEP_ESPECIALES con Folio: ' || nofoliodet || ' Status: P,  TipoOper: ' || idtipooperacion);
select
utl_file.put_line(fichero, concat('Actualiza status de SBC DNI en FECXC_DEP_ESPECIALES con Folio: ', nofoliodet , ' Status: P,  TipoOper: ' , idtipooperacion)) ;/* dmap converted statement end */
update fecxc_dep_especiales set id_status_mov = 'A'
where no_folio_det = nofoliodet  and id_status_mov = 'P';
--dbms_output.put_line('        [UPDATE FECXC_DEP_ESPECIALES]: ');
end if;
end if;--//termina si es operaci?n sbc dni
end if; --//finaliza el sbc no cancelado ya existe
end if;--//fin no es un folio sbc cancelado
end loop;
if COALESCE(array_length(rec_t_c3_d_tmp, 1), 0) != 0 then
FOR z IN array_lower(rec_t_c3_d_tmp, 1) .. array_upper(rec_t_c3_d_tmp, 1)
LOOP
insert into fecxc_dep_especiales
values rec_t_c3_d_tmp(z);
END LOOP;
rec_t_c3_d_tmp := rec_t_c3_d_tmp_del_temp;
--/* commit; */
end if;
lin_aux4 := 0;
end if;
end loop;
/* close cursor_3; */
/* commit; */
select
utl_file.put_line(fichero,'Termino Exitosamente');
select
utl_file.fclose(fichero);
exception
when others then
err_code := sqlstate;
err_msg := oracle.substr(sqlerrm, 1, 240);/* dmap converted statement start */
update fecxp_ppto_extraccion_params
set fec_fin=clock_timestamp()
,atributo1= concat(err_code, ' ', err_msg
) ,estatus_proceso='ERROR'
where proceso_id=10;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('ERROR, procesando folio ', nofoliodet)) ;/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('ERROR: ', oracle.substr(sqlerrm,0,8000) ) );/* dmap converted statement end *//* dmap converted statement start */
select
utl_file.put_line(fichero, concat('ERRORCODE: ', sqlstate )) ;/* dmap converted statement end */
select
utl_file.fclose(fichero);
end;
$body$
language plpgsql
;
