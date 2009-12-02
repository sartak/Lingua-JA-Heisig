use strict;
use warnings;
use utf8;
use Test::More tests => 13;
use Lingua::JA::Heisig (
    -learned => { up_to => 10 },
);

my $text = 'this text has no kanji';
is(rewrite($text), $text, 'no change for no kanji');

my ($learned, $unlearned, $nonheisig) = (0, 0, 0);
my %cb = (
    learned   => sub { ++$learned;   "L<$_>" },
    unlearned => sub { ++$unlearned; "U<$_>" },
    nonheisig => sub { ++$nonheisig; "N<$_>" },
);
is(rewrite($text, %cb), $text, 'no change for no kanji');
is($learned,   0, 'no learned kanji');
is($unlearned, 0, 'no unlearned kanji');
is($nonheisig, 0, 'no nonheisig kanji');

$text = '一二三、何、罹';
is(rewrite($text), $text, 'no callbacks means no change');
is($learned,   0, 'no learned kanji because no callbacks');
is($unlearned, 0, 'no unlearned kanji because no callbacks');
is($nonheisig, 0, 'no nonheisig kanji because no callbacks');

is(rewrite($text, %cb),  'L<一>L<二>L<三>、U<何>、N<罹>');
is($learned,   3, '3 learned kanji');
is($unlearned, 1, '1 unlearned kanji');
is($nonheisig, 1, '1 nonheisig kanji');

