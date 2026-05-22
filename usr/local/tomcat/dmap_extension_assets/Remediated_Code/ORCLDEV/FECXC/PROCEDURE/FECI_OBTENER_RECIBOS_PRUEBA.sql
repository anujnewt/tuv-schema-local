create or replace procedure fecxc."feci_obtener_recibos_prueba"
(
    p_ver varchar,
    p_fecha_inicio date,
    p_fecha_fin date,
    p_tipo_recibo varchar default null,
    p_empresa varchar default null,
    p_folio_inicial numeric default null,
    p_folio_final numeric default null,
    p_clase_cliente varchar default null,
    INOUT feci_cursor refcursor DEFAULT 'feci_cursor'
)
as $body$
declare
    v_query text;
begin

    v_query :=
    'select *
     from fecxc.feci_recibos_vw
     where cod_estado_recibo in (' || p_ver || ')
     and fec_operativa >= ' || quote_literal(p_fecha_inicio) || '
     and fec_operativa <= ' || quote_literal(p_fecha_fin);

    if p_tipo_recibo is not null then
        v_query := v_query ||
        ' and tipo_recibo in (' || p_tipo_recibo || ')';
    end if;

    if p_empresa is not null then
        v_query := v_query ||
        ' and cod_empresa in (' || p_empresa || ')';
    end if;

    if p_folio_inicial is not null
       and p_folio_final is not null then

        v_query := v_query ||
        ' and folio_recibo between ' ||
        p_folio_inicial ||
        ' and ' ||
        p_folio_final;

    end if;

    if p_clase_cliente is not null then
        v_query := v_query ||
        ' and clase_cliente in (' ||
        p_clase_cliente || ')';
    end if;

    open feci_cursor for execute v_query;

exception
when others then
    raise exception 'Error: %', sqlerrm;

end;
$body$
language plpgsql;