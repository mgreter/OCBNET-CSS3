# -*- perl -*-

use strict;
use warnings;

use Test::More tests => 7;
BEGIN { use_ok('OCBNET::CSS3::Regex::Comments') };

my (@rv);

use OCBNET::CSS3::Regex::Comments qw(comments);

my $code = <<EOF;

.test-01
{
	/* css-id: test-01; */
	border: 1px solid;
}

.test-02
{
	/* css-id: test-02; */
	/* css-ref: test-01; */
	border-style: dotted;
}

.test-03
{
	/* css-id: test-03; */
	/* css-ref: test-02; */
	border: 5px;
}

EOF


@rv = comments($code);

is    (scalar(@rv),                    5,                                      'correct number of comments extracted');
is    ($rv[0],                         'css-id: test-01;',                     'correct number of comments extracted');
is    ($rv[1],                         'css-id: test-02;',                     'correct number of comments extracted');
is    ($rv[2],                         'css-ref: test-01;',                    'correct number of comments extracted');
is    ($rv[3],                         'css-id: test-03;',                     'correct number of comments extracted');
is    ($rv[4],                         'css-ref: test-02;',                    'correct number of comments extracted');
