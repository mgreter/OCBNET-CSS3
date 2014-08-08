###################################################################################################
# Copyright 2013/2014 by Marcel Greter
# This file is part of OCBNET-CSS3 (GPL3)
####################################################################################################
package OCBNET::CSS3::Property::Background;
####################################################################################################

use strict;
use warnings;

####################################################################################################

use OCBNET::CSS3::Regex::Base;
use OCBNET::CSS3::Regex::Colors;
use OCBNET::CSS3::Regex::Numbers;
use OCBNET::CSS3::Regex::Base qw($re_url);

####################################################################################################

# regular expression for background options
#**************************************************************************************************
my $re_bg_image = qr/(?:none|$re_url|inherit)/i;
my $re_bg_attachment = qr/(?:scroll|fixed|inherit)/i;
my $re_bg_repeat = qr/(?:no-repeat|repeat(?:\-[xy])?)/i;
my $re_bg_position_y = qr/(?:top|bottom|center|$re_length)/i;
my $re_bg_position_x = qr/(?:left|right|center|$re_length)/i;

# regular expression for background position matching
#**************************************************************************************************
my $re_bg_position = qr/(?:left|right|top|bottom|center|$re_length)/i;
my $re_bg_positions = qr/$re_bg_position(?:\s+$re_bg_position)?/i;

####################################################################################################

# register longhand properties for backgrounds
OCBNET::CSS3::Styles::register('background-color', $re_color, 'transparent', 1);
OCBNET::CSS3::Styles::register('background-image', $re_bg_image, 'none', 1);
OCBNET::CSS3::Styles::register('background-repeat', $re_bg_repeat, 'repeat', 1);
OCBNET::CSS3::Styles::register('background-position-y', $re_bg_position_y, 'top', 1);
OCBNET::CSS3::Styles::register('background-position-x', $re_bg_position_x, 'left', 1);
OCBNET::CSS3::Styles::register('background-attachment', $re_bg_attachment, 'scroll', 1);

# register shorthand property for background-position
OCBNET::CSS3::Styles::register('background-position',
{
	'prefix' => [
		'background-position-x',
		'background-position-y'
	],
	'matcher' => $re_bg_positions
}, 'top left', 1);

# register shorthand property for background
OCBNET::CSS3::Styles::register('background',
{
	'prefix' => [
		'background-color',
		'background-image',
		'background-repeat',
		'background-attachment',
		'background-position'
	]
}, 'none', 1);

####################################################################################################
# register getters for virtual longhand properties
####################################################################################################

OCBNET::CSS3::Styles::getter('background-repeat-x', sub
{
	my ($self, $type, $name, $idx) = @_;
	my $fn = $self->can($type) || die "fatal type";
	my $repeat = &{$fn}($self, 'background-repeat', $idx) || return 1;
	return $repeat eq "repeat-x" || $repeat eq "repeat" ? 'repeat' : 0;
});

OCBNET::CSS3::Styles::getter('background-repeat-y', sub
{
	my ($self, $type, $name, $idx) = @_;
	my $fn = $self->can($type) || die "fatal type";
	my $repeat = &{$fn}($self, 'background-repeat', $idx) || return 1;
	return $repeat eq "repeat-y" || $repeat eq "repeat" ? 'repeat' : 0;
});

####################################################################################################
####################################################################################################
1;
