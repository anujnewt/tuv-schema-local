SET search_path = fecxc, oracle, dmap_extension, public;

CREATE OR REPLACE VIEW hist_movimiento_v (
    no_empresa,
    no_folio_det,
    referencia,
    id_codigo,
    id_subcodigo,
    desc_subcodigo
) AS
SELECT
    hist.no_empresa,
    hist.no_folio_det,
    hist.referencia,
    hist.id_codigo,
    hist.id_subcodigo,
    cats.desc_subcodigo
FROM hist2movimiento hist
JOIN cat_subcodigo cats
    ON  hist.no_empresa   = cats.no_empresa
    AND hist.id_codigo    = cats.id_codigo
    AND hist.id_subcodigo = cats.id_subcodigo;