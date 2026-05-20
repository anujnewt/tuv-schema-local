-- dmap_object_gen_tag : type : index name : ix_comparativo
set search_path = labppto,oracle,dmap_extension,public;
create index ix_comparativo on comparativo (cve_origen, cve_anio, cve_mes, cve_cia, cve_proc, cve_empl);
