use strict;
use warnings;
use utf8;
use Test::More tests => 6;
use Lingua::JA::Heisig -all;

is((kanji)[0], '一');
is((kanji)[1], '二');
is((kanji)[2], '三');

is(substr(scalar(kanji), 0, 1), '一');
is(substr(scalar(kanji), 1, 1), '二');
is(substr(scalar(kanji), 2, 1), '三');

