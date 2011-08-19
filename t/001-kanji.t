use strict;
use warnings;
use utf8;
use Test::More tests => 17;
use Lingua::JA::Heisig 'kanji';

is((kanji)[0], '一');
is((kanji)[1], '二');
is((kanji)[2], '三');
is((kanji)[2041], '巳');
is((kanji)[2042], '此');
is((kanji)[3006], '掟');
is((kanji)[3007], '嗅');
is((kanji)[3029], '鬱');
is((kanji)[3030], undef);

is(substr(scalar(kanji), 0, 1), '一');
is(substr(scalar(kanji), 1, 1), '二');
is(substr(scalar(kanji), 2, 1), '三');
is(substr(scalar(kanji), 2041, 1), '巳');
is(substr(scalar(kanji), 2042, 1), '此');
is(substr(scalar(kanji), 3006, 1), '掟');
is(substr(scalar(kanji), 3007, 1), '嗅');
is(substr(scalar(kanji), 3029, 1), '鬱');

