-- dmap_object_gen_tag : type : index name : nmpoli02_2
set search_path = labconf,oracle,dmap_extension,public;
create index nmpoli02_2 on nmwkpoli2 (pol_keypol, pol_numcta, pol_descta);
