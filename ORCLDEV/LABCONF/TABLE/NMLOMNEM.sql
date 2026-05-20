-- dmap_object_gen_tag : type : table name : nmlomnem
set search_path = labconf,oracle,dmap_extension,public;
create table "nmlomnem"  (
mne_keynem varchar(16) not null,
mne_keytab varchar(8),
mne_keycam varchar(16),
mne_condic varchar(16),
mne_tipdat varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : nmlomnem
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlomnem add constraint nmmnem01 unique (mne_keynem);
-- dmap_object_gen_tag : type : alter table name : nmlomnem
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlomnem alter column mne_keynem set not null;
