use inc::Module::Install;

all_from 'lib/Lingua/JA/Heisig.pm';
githubmeta;

requires 'Sub::Exporter';

install_script 'bin/heisig';
install_script 'bin/heisig-analyze';
install_script 'bin/grep-nonheisig';
install_script 'bin/kanji-in';
WriteAll;

