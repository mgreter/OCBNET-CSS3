###################################################################################################
# Copyright 2013/2014 by Marcel Greter
# This file is part of OCBNET-CSS3 (GPL3)
####################################################################################################
# a css3 object with styles and options
####################################################################################################
package OCBNET::CSS3::DOM::Block;
####################################################################################################

use strict;
use warnings;

####################################################################################################
use base 'OCBNET::CSS3';
use OCBNET::CSS3::Styles;
####################################################################################################

# create a new object
# ***************************************************************************************
sub new
{

	# package name
	my ($pckg) = shift;

	# create a new instance
	my $self = $pckg->SUPER::new;

	# store only longhands
	$self->{'style'} = OCBNET::CSS3::Styles->new;
	$self->{'option'} = OCBNET::CSS3::Styles->new;

	# instance
	return $self;

}
# EO constructor

####################################################################################################

# static getter
# always overwrite this
#**************************************************************************************************
sub type { die 'not implemented' }

# static getters
#**************************************************************************************************
sub styles { $_[0]->{'style'} }
sub options { $_[0]->{'option'} }

####################################################################################################

# setters and getters
#**************************************************************************************************
sub style : lvalue { $_[0]->{'style'}->{$_[1]}->[$_[2] || 0] }
sub option : lvalue { $_[0]->{'option'}->{$_[1]}->[$_[2] || 0] }

####################################################################################################
####################################################################################################
1;
