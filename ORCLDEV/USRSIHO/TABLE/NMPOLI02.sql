-- dmap_object_gen_tag : type : index name : nmpoli02
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmpoli02 on nmwkpoli (pol_keypol, pol_numcta, pol_descta);
