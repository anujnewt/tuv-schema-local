-- dmap_object_gen_tag : type : unique name : index
set search_path = cofidi,oracle,dmap_extension,public;
create unique index xxcofidi_origen_uk_idx01 on xxcofidi_origen_ct_tab (origen);
-- dmap_object_gen_tag : type : unique name : index
set search_path = cofidi,oracle,dmap_extension,public;
create unique index xxcofidi_serie_uk_idx01 on xxcofidi_serie_ct_tab (serie);
