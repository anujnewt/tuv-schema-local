-- dmap_object_gen_tag : type : index name : ppempmesidx_02
set search_path = labppto,oracle,dmap_extension,public;
create index ppempmesidx_02 on ppempmes (emm_keyver, emm_ciaorg, emm_keycen, emm_keypue);
