# -*- perl -*-

use strict;
use warnings;

use Test::More tests => 3;
BEGIN { use_ok('OCBNET::CSS3') };

my $rv;

use OCBNET::CSS3::Styles::References;
use OCBNET::CSS3::DOM::Comment::Options;

# OO interface
my $css = OCBNET::CSS3::Stylesheet->new;

my $code = <<EOF;

.test-01 { /* css-id: test; */ }
.test-02 { /* css-ref: test; */ }

EOF


$rv = $css->parse($code);

is    ($css->child(0)->option('css-id'),    'test',      'parse css-id');
is    ($css->child(1)->option('css-ref'),   'test',      'parse css-ref');

