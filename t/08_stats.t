# -*- perl -*-

use strict;
use warnings;

use Test::More tests => 7;
BEGIN { use_ok('OCBNET::CSS3') };

my $css = OCBNET::CSS3::Stylesheet->new;

my $code = <<EOF;

\@import url(test.css);

.test-01
{
	color: red;
	margin: 20px;
}

.test-02
{
	margin-left: 12px;
	margin-right: 12px;
}

EOF

my $stats;
$css->parse($code);
$stats = $css->stats;
is    (scalar(@{$stats->{'imports'} || []}),    1,  'stat import count');
is    (scalar(@{$stats->{'selectors'} || []}),  2,  'stat selector count');
is    (scalar(@{$stats->{'properties'} || []}),  4,  'stat property count');

$css->clean(qw/margin-left/);
$stats = $css->stats;
is    (scalar(@{$stats->{'properties'} || []}),  3,  'stat property count');

$css->clean(qw/^margin/);
$stats = $css->stats;
is    (scalar(@{$stats->{'properties'} || []}),  1,  'stat property count');

$css->clean;
$stats = $css->stats;
is    (scalar(@{$stats->{'properties'} || []}),  0,  'stat property count');

