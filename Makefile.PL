use inc::Module::Install;

all_from 'lib/Lingua/JA/Heisig.pm';
githubmeta;

requires 'Sub::Exporter';

install_script 'bin/heisig';
install_script 'bin/heisig-analyze';
WriteAll;

