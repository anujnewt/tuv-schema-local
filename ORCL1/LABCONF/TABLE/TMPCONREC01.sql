-- dmap_object_gen_tag : type : index name : tmpconrec01
set search_path = labconf,oracle,dmap_extension,public;
create index tmpconrec01 on tmpconrec (rec_keypro, rec_keyper, rec_keynom, rec_keycon, rec_codimp);
