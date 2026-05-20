-- dmap_object_gen_tag : type : index name : glreca01
set search_path = labprod,oracle,dmap_extension,public;
create index glreca01 on glcoreca (rec_keymen, rec_keytab, rec_keycam);
