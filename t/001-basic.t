use strict;
use warnings;
use utf8;
use Test::More tests => 1;
use Lingua::JA::Heisig -all;

is((kanji_list)[0], '一');
is((kanji_list)[1], '二');
is((kanji_list)[2], '三');

is(substr(kanji_string, 0, 1), '一');
is(substr(kanji_string, 1, 1), '二');
is(substr(kanji_string, 2, 1), '三');

