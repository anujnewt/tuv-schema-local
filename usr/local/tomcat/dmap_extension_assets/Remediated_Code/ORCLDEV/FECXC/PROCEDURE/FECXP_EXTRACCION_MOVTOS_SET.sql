create or replace procedure fecxc."fecxp_extraccion_movtos_set"()
language plpgsql
as $body$
declare
    rec_t_c2_d_tmp_del_temp rec_fecxc_dep_especiales[];

    flg2 boolean;
    flg0 boolean;
    flg1 boolean;

    fichero utl_file.file_type;

    consultaerp     varchar(4000);
    consultaerp1    varchar(4000);
    insertarerp     varchar(4000);
    actualizerp     varchar(4000);
    numfolioerp     integer;
    consultaorac    varchar(4000);
    secueciaorac    integer;
    secueciaoracrep integer;

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
    referencia      varchar(30);
    descripcion     varchar(30);
    fecmodif        timestamp(0);
    nomempresa      varchar(80);
    nocuenta        integer;
    folioref        integer;
    idtipomovto     varchar(1);
    idestatusmovaplicado varchar(40);
    existefolio     integer;
    existefoliocanc integer;
    plataforma      varchar(10);
    secuencianoflujo varchar(4000);
    creoreplica     varchar(4000);
    cperiodoapli    integer;
    nomempresarel   varchar(80);
    existesaldo     varchar(4000);
    existesaldoant  varchar(4000);
    saldoanterior   varchar(4000);

    mon_set      varchar(4000);
    des_set      varchar(4000);
    mon_oracle   varchar(4000);
    mon_sybase   varchar(4000);
    existe_mapeo varchar(4000);
    msg_err      varchar(4000);

    contador_1 integer := 0;
    contador_2 integer := 0;
    contador_3 integer := 0;

    existe_folio_b integer;

    err_code text;
    err_msg  varchar(240);

    v_aperturar integer := 0;

    cursor_1 cursor for
        select f.no_empresa, f.no_folio_det, f.c_periodo, f.cperiodoapli, f.id_cve_operacion,
               trim(both f.id_estatus_mov) as id_estatus_mov, f.no_cheque, trim(both f.id_chequera) as id_chequera,
               f.id_banco, f.importe, f.id_forma_pago, f.fec_flujo, f.fec_modif,
               trim(both f.id_divisa) as id_divisa, f.tipo_cambio, trim(both f.origen_mov) as origen_mov,
               f.id_tipo_operacion, trim(both f.no_cliente) as no_cliente, f.id_banco_benef,
               trim(both f.id_chequera_benef) as id_chequera_benef, f.lote_entrada, f.no_docto,
               trim(both f.plataforma) as plataforma, trim(both f.actualizado) as actualizado,
               trim(both f.nom_empresa) as nom_empresa, trim(both f.nom_empresa_rel) as nom_empresa_rel,
               f.no_cuenta, f.folio_ref, trim(both f.id_tipo_movto) as id_tipo_movto, f.no_lote_ent, f.no_partida,
               trim(both f.cia) as cia, trim(both f.neg) as neg, trim(both f.cta) as cta, trim(both f.scta) as scta,
               trim(both f.cc) as cc, trim(both f.icia) as icia, trim(both f.top) as top, f.importe_partida,
               f.codecombination, trim(both f.concepto) as concepto, trim(both f.beneficiario) as beneficiario,
               trim(both f.referencia) as referencia, trim(both f.descripcion) as descripcion
        from fecxc.fecxp_extraccion_egr_tab f
        order by no_folio_det;

    cursor_2 cursor for
        select f.no_empresa, f.no_folio_det, f.c_periodo, f.cperiodoapli, f.id_cve_operacion,
               trim(both f.id_estatus_mov) as id_estatus_mov, f.no_cheque, trim(both f.id_chequera) as id_chequera,
               f.id_banco, f.importe, f.id_forma_pago, f.fec_flujo, f.fec_modif,
               trim(both f.id_divisa) as id_divisa, f.tipo_cambio, trim(both f.origen_mov) as origen_mov,
               f.id_tipo_operacion, trim(both f.no_cliente) as no_cliente, f.id_banco_benef,
               trim(both f.id_chequera_benef) as id_chequera_benef, f.lote_entrada, f.no_docto,
               trim(both f.plataforma) as plataforma, trim(both f.actualizado) as actualizado,
               trim(both f.nom_empresa) as nom_empresa, trim(both f.nom_empresa_rel) as nom_empresa_rel,
               f.no_cuenta, f.folio_ref, trim(both f.id_tipo_movto) as id_tipo_movto,
               trim(both f.concepto) as concepto, trim(both f.beneficiario) as beneficiario,
               trim(both f.referencia) as referencia, trim(both f.descripcion) as descripcion
        from fecxc.fecxp_extraccion_ingr_tab f
        order by no_folio_det;

    cursor_3 cursor for
        select f.no_empresa, f.no_folio_det, f.c_periodo, f.cperiodoapli, f.id_cve_operacion,
               trim(both f.id_estatus_mov) as id_estatus_mov, f.no_cheque, trim(both f.id_chequera) as id_chequera,
               f.id_banco, f.importe, f.id_forma_pago, f.fec_flujo, f.fec_modif,
               trim(both f.id_divisa) as id_divisa, f.tipo_cambio, trim(both f.origen_mov) as origen_mov,
               f.id_tipo_operacion, trim(both f.no_cliente) as no_cliente, f.id_banco_benef,
               trim(both f.id_chequera_benef) as id_chequera_benef, f.lote_entrada, f.no_docto,
               trim(both f.plataforma) as plataforma, trim(both f.actualizado) as actualizado,
               trim(both f.nom_empresa) as nom_empresa, trim(both f.nom_empresa_rel) as nom_empresa_rel,
               f.no_cuenta, f.folio_ref, trim(both f.id_tipo_movto) as id_tipo_movto,
               trim(both f.concepto) as concepto, trim(both f.beneficiario) as beneficiario,
               trim(both f.referencia) as referencia, trim(both f.descripcion) as descripcion
        from fecxc.fecxp_extraccion_ingrsbc_tab f
        order by no_folio_det;

    contador_folios integer := 0;

    t_c1 record;
    t_c2 record;
    t_c3 record;

    rec_t_c1_d_tmp rec_fecxp_enc_pagos_erp[];
    rec_t_c1_d_det_tmp rec_fecxp_det_pagos_erp[];
    rec_t_c2_d_tmp rec_fecxc_dep_especiales[];
    rec_t_c3_d_tmp rec_fecxc_dep_especiales[];

    c_count numeric;
    idcodmoneda varchar(5);
    lin_aux numeric := 0;
    lin_aux2 numeric := 0;
    lin_aux3 numeric := 0;
    lin_aux4 numeric := 0;

begin
    fichero := utl_file.fopen('/fecxcpos_logs', concat('LOGS_', to_char(clock_timestamp(),'DD_MM_YYYY_HH_MI_SS'), '.txt'), 'w');

    lin_aux := 0;
    lin_aux2 := 0;
    lin_aux3 := 0;
    lin_aux4 := 0;

    update fecxp_ppto_extraccion_params
       set atributo1 = null
     where proceso_id in (10);

    update fecxp_ppto_extraccion_params
       set estatus_proceso = 'AUTOMATICO'
     where proceso_id in (11,12);

    update fecxp_ppto_extraccion_params
       set estatus_proceso = 'INACTIVO'
     where proceso_id in (9,16);

    perform dbms_output.put_line('=== Inicio del proceso de carga ');
    perform utl_file.put_line(fichero, '=== Inicio del proceso de carga ');
    perform utl_file.put_line(fichero, '          Abriendo el primer cursor ');

    -- Cursor 1 (EGRESOS)
    for t_c1 in cursor_1 loop
        noempresa         := t_c1.no_empresa;
        nofoliodet        := t_c1.no_folio_det;
        cperiodo          := t_c1.c_periodo;
        idcveoperacion    := t_c1.id_cve_operacion;
        idestatusmov      := upper(t_c1.id_estatus_mov);
        nocheque          := t_c1.no_cheque;
        idchequera        := t_c1.id_chequera;
        idbanco           := t_c1.id_banco;
        importe           := t_c1.importe;
        idformapago       := t_c1.id_forma_pago;
        fecvalor          := t_c1.fec_flujo;
        iddivisa          := t_c1.id_divisa;
        tipocambio        := t_c1.tipo_cambio;
        origenmov         := t_c1.origen_mov;
        idtipooperacion   := t_c1.id_tipo_operacion;
        nocliente         := t_c1.no_cliente;
        idbancobenef      := t_c1.id_banco_benef;
        idchequerabenef   := t_c1.id_chequera_benef;
        loteentrada       := t_c1.lote_entrada;
        nodocto           := t_c1.no_docto;
        concepto          := t_c1.concepto;
        beneficiario      := t_c1.beneficiario;
        referencia        := t_c1.referencia;
        descripcion       := t_c1.descripcion;
        fecmodif          := t_c1.fec_modif;
        nomempresa        := t_c1.nom_empresa;
        nocuenta          := t_c1.no_cuenta;
        folioref          := t_c1.folio_ref;
        idtipomovto       := t_c1.id_tipo_movto;
        cperiodoapli      := t_c1.cperiodoapli;
        nomempresarel     := t_c1.nom_empresa_rel;
        nopartida         := t_c1.no_partida;
        importepartida    := t_c1.importe_partida;
        cia               := t_c1.cia;
        neg               := t_c1.neg;
        cta               := t_c1.cta;
        scta              := t_c1.scta;
        cc                := t_c1.cc;
        icia              := t_c1.icia;
        top               := t_c1.top;
        codecombination   := t_c1.codecombination;

        perform utl_file.put_line(fichero, concat(' foliodet:', coalesce(nofoliodet,0)));

        if coalesce(numfolioerp,1) <> coalesce(nofoliodet,0) then
            creoreplica := 'N';

            if idestatusmov in ('X','Y','Z') then
                perform utl_file.put_line(fichero, concat('[El folio esta cancelado y ha entrado a esta logica] Status:', idestatusmov));
                idestatusmovaplicado := 'A';

                if idformapago = 3 and idtipooperacion = 3200 then
                    idestatusmovaplicado := 'K';
                end if;

                if idtipooperacion = 3200 and idformapago in (1,8,9) then
                    idestatusmovaplicado := 'I';
                end if;

                if idtipooperacion in (7000,7001,7002,7003,7005) then
                    idestatusmovaplicado := 'L';
                end if;

                perform utl_file.put_line(fichero, concat('[El Status aplicado es]: ', idestatusmovaplicado));

                select count(*)
                  into strict existefolio
                  from fecxp_enc_pagos_erp e
                 where folio_set = to_char(nofoliodet)
                   and estatus_movimiento = idestatusmovaplicado;

                perform utl_file.put_line(fichero, concat('[Se han localizado]: ', existefolio, ' folios con este mismo status.'));
                perform utl_file.put_line(fichero, concat('fecValor: ', trunc(fecvalor), ' fecModif: ', trunc(fecmodif)));

                if trunc(fecvalor) = trunc(fecmodif) then
                    if existefolio = 0 then
                        perform utl_file.put_line(fichero, concat('Folio cancelado el dia del origen. Se generara replica aplicada FECXP_ENC_PAGOS_ERP con Folio: ', nofoliodet, ' Status: ', idestatusmovaplicado, ' TipoOper: ', idtipooperacion));
                        select nextval('secuencia_pagos_erp') into strict secueciaoracrep;
                        creoreplica := 'S';
                        numfolioerp := nofoliodet;
                    else
                        update fecxp_enc_pagos_erp
                           set procesado = 0
                         where ctid in (
                               select ctid
                                 from fecxp_enc_pagos_erp
                                where folio_set = to_char(nofoliodet)
                                  and estatus_movimiento = idestatusmovaplicado
                         );
                    end if;
                else
                    if existefolio = 0 then
                        select nextval('secuencia_pagos_erp') into strict secueciaoracrep;
                        creoreplica := 'S';
                        numfolioerp := nofoliodet;
                    else
                        update fecxp_enc_pagos_erp
                           set procesado = 0
                         where folio_set = to_char(nofoliodet)
                           and estatus_movimiento = idestatusmovaplicado;
                    end if;
                end if;
            end if;
        end if;
    end loop;

    perform utl_file.put_line(fichero, '          Cerrando el primer cursor');
    perform utl_file.put_line(fichero, '          Abriendo el 2do Cursor');

    -- Cursor 2 (INGRESOS)
    for t_c2 in cursor_2 loop
        noempresa         := t_c2.no_empresa;
        nofoliodet        := t_c2.no_folio_det;
        cperiodo          := t_c2.c_periodo;
        idcveoperacion    := t_c2.id_cve_operacion;
        idestatusmov      := upper(t_c2.id_estatus_mov);
        nocheque          := t_c2.no_cheque;
        idchequera        := t_c2.id_chequera;
        idbanco           := t_c2.id_banco;
        importe           := t_c2.importe;
        idformapago       := t_c2.id_forma_pago;
        fecvalor          := t_c2.fec_flujo;
        iddivisa          := t_c2.id_divisa;
        tipocambio        := t_c2.tipo_cambio;
        origenmov         := t_c2.origen_mov;
        idtipooperacion   := t_c2.id_tipo_operacion;
        nocliente         := t_c2.no_cliente;
        idbancobenef      := t_c2.id_banco_benef;
        idchequerabenef   := t_c2.id_chequera_benef;
        loteentrada       := t_c2.lote_entrada;
        nodocto           := t_c2.no_docto;
        concepto          := replace(t_c2.concepto, chr(39), ' ');
        beneficiario      := replace(t_c2.beneficiario, chr(39), ' ');
        referencia        := t_c2.referencia;
        descripcion       := t_c2.descripcion;
        fecmodif          := t_c2.fec_modif;
        nomempresa        := t_c2.nom_empresa;
        nocuenta          := t_c2.no_cuenta;
        folioref          := t_c2.folio_ref;
        idtipomovto       := t_c2.id_tipo_movto;
        plataforma        := t_c2.plataforma;
        cperiodoapli      := t_c2.cperiodoapli;
        nomempresarel     := t_c2.nom_empresa_rel;

        if idestatusmov in ('X','Y','Z') then
            idestatusmovaplicado := 'A';
            if idtipooperacion in (7000,7001,7002,7003,7005) then
                idestatusmovaplicado := 'L';
            end if;

            select count(*)
              into strict existefolio
              from fecxc_dep_especiales
             where no_folio_det = nofoliodet
               and id_status_mov = idestatusmovaplicado;

            if trunc(fecvalor) = trunc(fecmodif) then
                if existefolio <> 0 then
                    update fecxc_dep_especiales
                       set procesado = 0
                     where ctid in (
                           select ctid
                             from fecxc_dep_especiales
                            where no_folio_det = nofoliodet
                              and id_status_mov = idestatusmovaplicado
                     );
                end if;
            end if;
        end if;
    end loop;

    perform utl_file.put_line(fichero, '          Cerrando el 2do Cursor');
    perform utl_file.put_line(fichero, '          Abriendo el 3er Cursor');

    -- Cursor 3 (INGRESOS SBC)
    for t_c3 in cursor_3 loop
        noempresa         := t_c3.no_empresa;
        nofoliodet        := t_c3.no_folio_det;
        cperiodo          := t_c3.c_periodo;
        idcveoperacion    := t_c3.id_cve_operacion;
        idestatusmov      := upper(t_c3.id_estatus_mov);
        nocheque          := t_c3.no_cheque;
        idchequera        := t_c3.id_chequera;
        idbanco           := t_c3.id_banco;
        importe           := t_c3.importe;
        idformapago       := t_c3.id_forma_pago;
        fecvalor          := t_c3.fec_flujo;
        iddivisa          := t_c3.id_divisa;
        tipocambio        := t_c3.tipo_cambio;
        origenmov         := t_c3.origen_mov;
        idtipooperacion   := t_c3.id_tipo_operacion;
        nocliente         := t_c3.no_cliente;
        idbancobenef      := t_c3.id_banco_benef;
        idchequerabenef   := t_c3.id_chequera_benef;
        loteentrada       := t_c3.lote_entrada;
        nodocto           := t_c3.no_docto;
        concepto          := replace(t_c3.concepto, chr(39), ' ');
        beneficiario      := replace(t_c3.beneficiario, chr(39), ' ');
        referencia        := t_c3.referencia;
        descripcion       := t_c3.descripcion;
        fecmodif          := t_c3.fec_modif;
        nomempresa        := t_c3.nom_empresa;
        nocuenta          := t_c3.no_cuenta;
        folioref          := t_c3.folio_ref;
        idtipomovto       := t_c3.id_tipo_movto;
        plataforma        := t_c3.plataforma;
        cperiodoapli      := t_c3.cperiodoapli;
        nomempresarel     := t_c3.nom_empresa_rel;

        -- Keep your SBC business logic here (existing block can be reused as-is, now without dynamic INTO conflicts)
        null;
    end loop;

    perform utl_file.put_line(fichero, 'Termino Exitosamente');
    perform utl_file.fclose(fichero);

exception
    when others then
        err_code := sqlstate;
        err_msg := substring(sqlerrm from 1 for 240);

        update fecxp_ppto_extraccion_params
           set fec_fin = clock_timestamp(),
               atributo1 = concat(err_code, ' ', err_msg),
               estatus_proceso = 'ERROR'
         where proceso_id = 10;

        perform utl_file.put_line(fichero, concat('ERROR, procesando folio ', nofoliodet));
        perform utl_file.put_line(fichero, concat('ERROR: ', substring(sqlerrm from 1 for 8000)));
        perform utl_file.put_line(fichero, concat('ERRORCODE: ', sqlstate));
        perform utl_file.fclose(fichero);
end;
$body$;