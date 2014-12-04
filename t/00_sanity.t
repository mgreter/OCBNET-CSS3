# -*- perl -*-

use strict;
use warnings;

use Test::More tests => 54;
BEGIN { use_ok('OCBNET::CSS3') };

my $css = OCBNET::CSS3::Stylesheet->new;
my $block1 = OCBNET::CSS3::DOM::Selector->new;
my $block2 = OCBNET::CSS3::DOM::Selector->new;

$css->add($block1, $block2);

is    ($block1->parent,      $css,         'add connects parent');
is    ($block2->parent,      $css,         'add connects parent');
is    ($css->children->[0],  $block1,      'add pushes children in array');
is    ($css->children->[1],  $block2,      'add pushes children in array');

$block1->{'parent'} = undef;
$block2->{'parent'} = undef;
$css->prepend($block2, $block1);

is    ($block1->parent,      $css,         'prepend connects parent');
is    ($block2->parent,      $css,         'prepend connects parent');
is    ($css->children->[0],  $block2,      'prepend unshifts children in array');
is    ($css->children->[1],  $block1,      'prepend unshifts children in array');

$css = OCBNET::CSS3::Stylesheet->new;

my $code = '/* pre1 */ /* pre2 */ ke/* in key */y /* */ : /**/ va/* in value */lue; ;;;/* post1 */;/* post2 */';
my $rv = $css->parse($code);
is    ($rv,                        $css,            'parse returns ourself');
is    ($css->children->[0]->type,  'comment',       'parses pre1 to comment type');
is    ($css->children->[0]->text,  '/* pre1 */ ',   'parses pre1 with correct text');
is    ($css->children->[1]->type,  'comment',       'parses pre2 to comment type');
is    ($css->children->[1]->text,  '/* pre2 */ ',   'parses pre2 with correct text');
is    ($css->children->[2]->type,  'property',      'upgrade to selector type');
is    ($css->children->[2]->text,  'ke/* in key */y /* */ : /**/ va/* in value */lue',   'parses preperty with correct text');
is    ($css->children->[3]->type,  'whitespace',    'upgrade to selector type');
is    ($css->children->[3]->text,  ' ',             'parses whitespace with correct text');
is    ($css->children->[3]->suffix, ';;;',          'parses whitespace suffix correctly');
is    ($css->children->[4]->type,  'comment',       'parses post1 to whitespace type');
is    ($css->children->[4]->text,  '/* post1 */',   'parses post2 with correct text');
is    ($css->children->[5]->type,  'comment',       'parses post1 to whitespace type');
is    ($css->children->[5]->text,  '/* post2 */',   'parses post2 with correct text');
is    (scalar(@{$css->children}),  6,               'parses correct amount of dom nodes');
is    ($css->render,               $code,           'render the same as parsed');
is    ($css->clone(1)->render,     $code,           'clone renders the same as parsed');

BEGIN { use_ok('OCBNET::CSS3::DOM::Block') };

my $base = new OCBNET::CSS3;
$rv = eval { $base->type; };

is    ($rv,          'base',                    'base block type is returned');
is    ($@,               '',                    'base block type implemented');

my $block = new OCBNET::CSS3::DOM::Block;
$rv = eval { $block->type; };

is    ($rv,           undef,                    'block type throws an errors');
like  ($@,            qr/^not implemented/,     'block type not implemented');

my $styles = new OCBNET::CSS3::Styles;
OCBNET::CSS3::Styles::register('foobar');
$rv = eval { $styles->set('foobar', '10px'); };

is    ($rv,           undef,                    'invalid style type throws an errors');
like  ($@,            qr/^unknown type/,        'invalid style type not implemented');

# pertty senseless, but test anyway
use_ok('OCBNET::CSS3::Regex::Base');
my $re = qr/(A)?(B)?(C)?(D)?(E)?(F)?(G)?(H)?(I)?(J)?/;
'A' =~ $re; is (OCBNET::CSS3::Regex::Base::last_match, 'A', 'last_match A');
'B' =~ $re; is (OCBNET::CSS3::Regex::Base::last_match, 'B', 'last_match B');
'C' =~ $re; is (OCBNET::CSS3::Regex::Base::last_match, 'C', 'last_match C');
'D' =~ $re; is (OCBNET::CSS3::Regex::Base::last_match, 'D', 'last_match D');
'E' =~ $re; is (OCBNET::CSS3::Regex::Base::last_match, 'E', 'last_match E');
'F' =~ $re; is (OCBNET::CSS3::Regex::Base::last_match, 'F', 'last_match F');
'G' =~ $re; is (OCBNET::CSS3::Regex::Base::last_match, 'G', 'last_match G');
'H' =~ $re; is (OCBNET::CSS3::Regex::Base::last_match, 'H', 'last_match H');
'I' =~ $re; is (OCBNET::CSS3::Regex::Base::last_match, 'I', 'last_match I');
'J' =~ $re; is (OCBNET::CSS3::Regex::Base::last_match, '', 'last_match J');

'A' =~ $re; is (OCBNET::CSS3::Regex::Base::last_index, '1', 'last_index 1');
'B' =~ $re; is (OCBNET::CSS3::Regex::Base::last_index, '2', 'last_index 2');
'C' =~ $re; is (OCBNET::CSS3::Regex::Base::last_index, '3', 'last_index 3');
'D' =~ $re; is (OCBNET::CSS3::Regex::Base::last_index, '4', 'last_index 4');
'E' =~ $re; is (OCBNET::CSS3::Regex::Base::last_index, '5', 'last_index 5');
'F' =~ $re; is (OCBNET::CSS3::Regex::Base::last_index, '6', 'last_index 6');
'G' =~ $re; is (OCBNET::CSS3::Regex::Base::last_index, '7', 'last_index 7');
'H' =~ $re; is (OCBNET::CSS3::Regex::Base::last_index, '8', 'last_index 8');
'I' =~ $re; is (OCBNET::CSS3::Regex::Base::last_index, '9', 'last_index 9');
'J' =~ $re; is (OCBNET::CSS3::Regex::Base::last_index, '', 'last_index 0');
