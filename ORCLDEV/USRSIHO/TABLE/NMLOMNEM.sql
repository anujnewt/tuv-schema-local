-- dmap_object_gen_tag : type : table name : nmlomnem
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmlomnem"  (
mne_keynem varchar(16),
mne_keytab varchar(8),
mne_keycam varchar(16),
mne_condic varchar(16),
mne_tipdat varchar(1)
) ;
