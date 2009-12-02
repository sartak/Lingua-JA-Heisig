use strict;
use warnings;
use utf8;
use Test::More tests => 3;
use Lingua::JA::Heisig (
    -learned => { up_to => 10 },
);

is(is_learned('一'), 1);
is(is_learned('何'), 0);
is(is_learned('not kanji'), undef);
