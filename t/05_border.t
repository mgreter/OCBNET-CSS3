# -*- perl -*-

use strict;
use warnings;

use Test::More tests => 13;
BEGIN { use_ok('OCBNET::CSS3') };

my $rv;

use OCBNET::CSS3::Styles::Border;
use OCBNET::CSS3::Styles::References;
use OCBNET::CSS3::DOM::Comment::Options;

# OO interface
my $css = OCBNET::CSS3::Stylesheet->new;

my $code = <<EOF;

.test-01
{
	/* css-id: test-01; */
	border: 1px solid;
}



EOF

$rv = $css->parse($code);

is    ($css->child(0)->style('border-top-width'),      '1px',         'parse border-top-width (shorthand)');
is    ($css->child(0)->style('border-left-width'),     '1px',         'parse border-left-width (shorthand)');
is    ($css->child(0)->style('border-bottom-width'),   '1px',         'parse border-bottom-width (shorthand)');
is    ($css->child(0)->style('border-right-width'),    '1px',         'parse border-right-width (shorthand)');
is    ($css->child(0)->style('border-top-style'),      'solid',       'parse border-top-style (shorthand)');
is    ($css->child(0)->style('border-left-style'),     'solid',       'parse border-left-style (shorthand)');
is    ($css->child(0)->style('border-bottom-style'),   'solid',       'parse border-bottom-style (shorthand)');
is    ($css->child(0)->style('border-right-style'),    'solid',       'parse border-right-style (shorthand)');
is    ($css->child(0)->style('border-top-color'),      'transparent', 'parse border-top-width (shorthand)');
is    ($css->child(0)->style('border-left-color'),     'transparent', 'parse border-left-width (shorthand)');
is    ($css->child(0)->style('border-bottom-color'),   'transparent', 'parse border-bottom-width (shorthand)');
is    ($css->child(0)->style('border-right-color'),    'transparent', 'parse border-right-width (shorthand)');
