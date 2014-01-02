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
	$self->{'style'} = OCBNET::CSS3::Styles->new($self);
	$self->{'option'} = OCBNET::CSS3::Styles->new($self);

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

# simple getter and setter
#**************************************************************************************************
sub option { $_[0]->{'option'}->{$_[1]}->[$_[2] || 0] }

# getter with recursive logic
# can reference ids in options
# try to load styles from there
#**************************************************************************************************
sub style
{

	# get input arguments
	my ($self, $key, $idx) = @_;

	# check if found in current styles
	if (exists $self->{'style'}->{$key}->[$idx || 0])
	{ return $self->{'style'}->{$key}->[$idx || 0]; }

	# check if option references an id
	if ($self->options->get('css-ref'))
	{
		# get the reference to the other dom node
		my $id = $self->options->get('css-ref');
		# get the actual referenced dom node
		my $ref = $self->root->{'ids'}->{$id};
		# give error message if reference was not found
		die "referenced id <$id> not found" unless $ref;
		# call reference dom node for key
		return $ref->styles->get($key, $idx);
	}

	# nothing found
	return undef;

}


####################################################################################################
####################################################################################################
1;
