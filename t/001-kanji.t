use strict;
use warnings;
use utf8;
use Test::More tests => 9;
use Lingua::JA::Heisig 'kanji';

is((kanji)[0], '一');
is((kanji)[1], '二');
is((kanji)[2], '三');
is((kanji)[2041], '巳');
is((kanji)[2042], undef);

is(substr(scalar(kanji), 0, 1), '一');
is(substr(scalar(kanji), 1, 1), '二');
is(substr(scalar(kanji), 2, 1), '三');
is(substr(scalar(kanji), 2041, 1), '巳');

