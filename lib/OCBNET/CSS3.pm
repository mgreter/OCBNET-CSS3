###################################################################################################
# Copyright 2013 by Marcel Greter
# This file is part of Webmerge (GPL3)
####################################################################################################
package OCBNET::CSS3;
####################################################################################################
# common objects:
#  - stylesheet
#  - selectors
#  - property
#  - media queries
#  - extended blocks
####################################################################################################

use strict;
use warnings;

####################################################################################################

our @types;

####################################################################################################

use OCBNET::CSS3::Extended;
use OCBNET::CSS3::Selector;
use OCBNET::CSS3::Property;
use OCBNET::CSS3::Stylesheet;
use OCBNET::CSS3::Whitespace;
use OCBNET::CSS3::Comments;
use OCBNET::CSS3::Text;

####################################################################################################

use OCBNET::CSS3::Regex::Base;
use OCBNET::CSS3::Regex::Colors;
use OCBNET::CSS3::Regex::Numbers;
use OCBNET::CSS3::Regex::Selectors;
use OCBNET::CSS3::Regex::Stylesheet;

####################################################################################################
# is common base for all classes
####################################################################################################

# create a new object
# ***************************************************************************************
sub new
{

	# package name
	my ($pckg) = shift;

	# create a new instance
	my $self = {

		'text' => undef,
		'suffix' => undef,
		'bracket' => undef,
		'children' => [],

	};

	# bless instance into package
	return bless $self, $pckg;

}
# EO constructor

####################################################################################################

# static getter (overwrite)
# ***************************************************************************************
sub type { return 'base' }

# setter and getter
# ***************************************************************************************
sub text : lvalue { $_[0]->{'text'} }
sub suffix : lvalue { $_[0]->{'suffix'} }
sub bracket : lvalue { $_[0]->{'bracket'} }

# getter (set via reference)
# ***************************************************************************************
sub children { $_[0]->{'children'} }

####################################################################################################

# parse given text
# attachs new objects
sub parse
{

	# get input arguments
	my ($self, $text) = @_;

	# parse as much as possible
	# a stricter version would replace the parsed
	# code and check the final string to be empty
	while ($text =~ m/$re_statement/g)
	{
		# check exit clause
		last if $1 eq '';

		# declare object
		my $object;

		# store the different parts from the match
		my ($text, $scope, $suffix) = ($1, $2, $3);

		# copy text to code and uncomment it
		my $code = $text; $code =~ s/$re_comment//g;

		# dynamically find type
		foreach my $type (@types)
		{
			# get options from type array
			my ($regex, $pckg, $tst) = @{$type};
			# skip if type does not match
			next unless $code =~ m/$regex/s;
			# call optional test if one is defined
			next if $tst && ! $tst->($text, $scope);
			# create new dynamic object
			$object = $pckg->new; last;
		}
		# EO each type

		# create object if no other type found
		$object = new OCBNET::CSS3 unless $object;

		# set to the parsed text
		$object->text = $text;

		# set to the parsed suffix
		$object->suffix = $suffix;

		# set scope status if we have parsed one
		$object->bracket = $scope ? '{' : undef;

		# remove block brackets from scope
		$scope = substr($scope, 1, -1) if $scope;

		# parse scope (only if scope was found)
		$object->parse($scope) if $object->bracket;

		# add object to scope
		$self->add($object);

	}
	# EO each statement

}
# EO sub parse

####################################################################################################

# add some children
# ***************************************************************************************
sub add
{

	# get input arguments
	my ($self, @children) = @_;

	# add passed children to our array
	push @{$self->{'children'}}, @children;

	# attach us as parent to all children
	$_->{'parent'} = $self foreach @children;

	# instance
	return $self;

}
# EO sub add

####################################################################################################

# render block with children
# return the same css as parsed
# ***************************************************************************************
sub render
{

	# get input arguments
	my ($self, $comments, $indent) = @_;

	# init default indent
	$indent = 0 unless $indent;

	# declare string
	my $data = '';

	# add data from instance
	if (defined $self->text)
	{ $data .= $self->text; }

	# print to debug the css "dom" tree
	# print "  " x $indent, $self, "\n";

	# add opener bracket if scope has been set
	$data .= $opener{$self->bracket} if $self->bracket;

	# render and add each children
	foreach my $child (@{$self->children})
	{ $data .= $child->render($comments, $indent + 1); }

	# add closer bracket if scope has been set
	$data .= $closer{$self->bracket} if $self->bracket;

	# add object suffix if it has been set
	$data .= $self->suffix if defined $self->suffix;

	# return string
	return $data;

}
# EO sub render

####################################################################################################
####################################################################################################
1;