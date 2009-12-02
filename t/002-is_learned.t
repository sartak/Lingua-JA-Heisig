use strict;
use warnings;
use utf8;
use Test::More tests => 7;
use Lingua::JA::Heisig (
    -learned => { up_to => 10 },
);

is(is_learned('一'), 1);
is(is_learned('九'), 1);
is(is_learned('十'), 1, 'the last kanji we know');
is(is_learned('口'), 0, 'the next kanji to learn');
is(is_learned('何'), 0, 'well off into the future');
is(is_learned('not kanji'), undef, 'nonkanji returns undef');
is(is_learned('罹'), undef, 'nonheisig kanji returns undef too');

