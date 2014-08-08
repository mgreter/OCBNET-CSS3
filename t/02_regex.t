# -*- perl -*-

use strict;
use warnings;

use Test::More tests => 5;
BEGIN { use_ok('OCBNET::CSS3::Regex::Base') };

use OCBNET::CSS3::Regex::Base qw(unwrapUrl);

is    (unwrapUrl('url("test.png")'),             'test.png',         'unwrapUrl test #1');
is    (unwrapUrl('url(url("test.png"))'),        'test.png',         'unwrapUrl test #2');
is    (unwrapUrl("url(url('test.png'))"),        'test.png',         'unwrapUrl test #3');
is    (unwrapUrl('url(test.png)'),               'test.png',         'unwrapUrl test #4');
