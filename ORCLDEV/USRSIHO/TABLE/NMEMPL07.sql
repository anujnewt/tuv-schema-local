-- dmap_object_gen_tag : type : index name : nmempl07
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmempl07 on nmcoempl (emp_keypro, emp_keyloc, emp_forpag, emp_keyemp);
