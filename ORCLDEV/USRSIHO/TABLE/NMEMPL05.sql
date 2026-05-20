-- dmap_object_gen_tag : type : index name : nmempl05
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmempl05 on nmcoempl (emp_keypro, emp_keyemp, emp_forpag);
