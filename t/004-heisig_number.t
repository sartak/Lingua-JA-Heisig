use strict;
use warnings;
use utf8;
use Test::More tests => 7;
use Lingua::JA::Heisig 'heisig_number';

is(heisig_number('一'), 1);
is(heisig_number('二'), 2);
is(heisig_number('三'), 3);
is(heisig_number('何'), 1012);
is(heisig_number('巳'), 2042);
is(heisig_number('nonkanji'), undef, 'nonkanji');
is(heisig_number('罹'), undef, 'nonheisig kanji');

