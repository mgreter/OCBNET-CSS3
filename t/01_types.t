# -*- perl -*-

use strict;
use warnings;

use Test::More tests => 29;
BEGIN { use_ok('OCBNET::CSS3') };

my $rv;

# OO interface
my $css = OCBNET::CSS3::Stylesheet->new;

$rv = $css->parse('key : value;');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'property',   'upgrades to selector type');

$rv = $css->parse('/* hello */;');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'base',       'does not parse comments');

$rv = $css->parse(' 	 ;');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'whitespace', 'upgrades to selector type');

$rv = $css->parse('.valid { ... }');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'selector',   'upgrades to selector type');

$rv = $css->parse('@charset { ... }');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'charset',    'upgrades to charset type');

$rv = $css->parse('@font-face { ... }');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'fontface',   'upgrades to font type');

$rv = $css->parse('@import url(test);');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'import',     'upgrades to import type');

$rv = $css->parse('@keyframes { }');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'keyframes',  'upgrades to keyframes type');

$rv = $css->parse('@namespace { }');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'namespace',  'upgrades to namespace type');

$rv = $css->parse('@page { }');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'page',       'upgrades to page type');


$rv = $css->parse('@supports { }');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'supports',   'upgrades to supports type');

$rv = $css->parse('@viewport { }');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'viewport',   'upgrades to viewport type');

$rv = $css->parse('@ { ... }');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'extended',   'upgrades to extended type');

$rv = $css->parse('@foobar { ... }');
is    ($rv,                        $css,         'parse returns ourself');
is    ($css->children->[-1]->type, 'extended',   'upgrades to extended type');
