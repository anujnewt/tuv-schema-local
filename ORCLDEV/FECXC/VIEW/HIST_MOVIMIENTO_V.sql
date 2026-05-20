CREATE OR REPLACE FORCE EDITIONABLE VIEW "FECXC"."HIST_MOVIMIENTO_V" ("NO_EMPRESA", "NO_FOLIO_DET", "REFERENCIA", "ID_CODIGO", "ID_SUBCODIGO", "DESC_SUBCODIGO") AS 
  SELECT hist."no_empresa" no_empresa,
          hist."no_folio_det" no_folio_det,
          hist."referencia" referencia,
          hist."id_codigo" id_codigo,
          hist."id_subcodigo" id_subcodigo,
          cats."desc_subcodigo" desc_subcodigo
     FROM "hist2movimiento"@sybtsm1 hist, "cat_subcodigo"@sybtsm1 cats
    WHERE     hist."no_empresa" = cats."no_empresa"
          AND hist."id_codigo" = cats."id_codigo"
          AND hist."id_subcodigo" = cats."id_subcodigo";
