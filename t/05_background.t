# -*- perl -*-

use strict;
use warnings;

use Test::More tests => 19;
BEGIN { use_ok('OCBNET::CSS3') };

my $rv;

use OCBNET::CSS3::Styles::Background;
use OCBNET::CSS3::Styles::References;
use OCBNET::CSS3::DOM::Comment::Options;

# OO interface
my $css = OCBNET::CSS3::Stylesheet->new;

my $code = <<EOF;

.test-01
{
	/* css-id: test-01; */
	background: red;
}

.test-02
{
	/* css-id: test-02; */
	background: blue 20px 40px;
}

.test-03
{
	/* css-id: test-03; */
	background: blue right bottom;
}


EOF

$rv = $css->parse($code);

is    ($css->child(0)->style('background-color'),      'red',        'parse background-color (shorthand)');
is    ($css->child(0)->style('background-image'),      'none',       'parse background-image (default)');
is    ($css->child(0)->style('background-repeat'),     'repeat',     'parse background-repeat (default)');
is    ($css->child(0)->style('background-position-y'), 'top',        'parse background-position-y (default)');
is    ($css->child(0)->style('background-position-x'), 'left',       'parse background-position-x (default)');
is    ($css->child(0)->style('background-attachment'), 'scroll',     'parse background-attachment (default)');

is    ($css->child(1)->style('background-color'),      'blue',       'parse background-color (shorthand)');
is    ($css->child(1)->style('background-image'),      'none',       'parse background-image (default)');
is    ($css->child(1)->style('background-repeat'),     'repeat',     'parse background-repeat (default)');
is    ($css->child(1)->style('background-position-y'), '20px',       'parse background-position-y (shorthand)');
is    ($css->child(1)->style('background-position-x'), '40px',       'parse background-position-x (shorthand)');
is    ($css->child(1)->style('background-attachment'), 'scroll',     'parse background-attachment (default)');

is    ($css->child(2)->style('background-color'),      'blue',       'parse background-color (shorthand)');
is    ($css->child(2)->style('background-image'),      'none',       'parse background-image (default)');
is    ($css->child(2)->style('background-repeat'),     'repeat',     'parse background-repeat (default)');
is    ($css->child(2)->style('background-position-y'), 'bottom',     'parse background-position-y (shorthand - wrong order)');
is    ($css->child(2)->style('background-position-x'), 'right',      'parse background-position-x (shorthand - wrong order)');
is    ($css->child(2)->style('background-attachment'), 'scroll',     'parse background-attachment (default)');

