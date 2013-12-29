# -*- perl -*-

use strict;
use warnings;

use Test::More tests => 9;
BEGIN { use_ok('OCBNET::CSS3') };

my $css = OCBNET::CSS3->new;
my $block1 = OCBNET::CSS3->new;
my $block2 = OCBNET::CSS3->new;

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
