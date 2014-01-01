###################################################################################################
# Copyright 2013/2014 by Marcel Greter
# This file is part of OCBNET-CSS3 (GPL3)
####################################################################################################
package OCBNET::CSS3::Property;
####################################################################################################

use strict;
use warnings;

####################################################################################################
use base 'OCBNET::CSS3';
####################################################################################################

use OCBNET::CSS3::Regex::Comments;

####################################################################################################

our %matcher;
our %default;
our %list;

####################################################################################################

# static function only
# never call as object
sub register
{

	# get input arguments of static call
	my ($key, $matcher, $default, $list) = @_;

	# store the matcher by key
	$matcher{$key} = $matcher;

	# store the defaults by key
	$default{$key} = $default;

	# store list attribute
	# means we store as array
	# and can parse comma lists
	$list{$key} = $list;

}
# EO fn register

####################################################################################################

# static getter
#**************************************************************************************************
sub type { return 'property' }

# advanced getters
#**************************************************************************************************
sub key { uncomment $_[0]->{'key'} }
sub value { uncomment $_[0]->{'value'} }
sub comment { comments $_[0]->{'value'} }

####################################################################################################

# process key and value
# parse into longhand arrays
my $process = sub
{

	# list variable
	# parse optional
	my %longhands;

	# get input arguments
	my ($key, $value) = @_;

	# check if we have a matcher
	if (exists $matcher{$key})
	{

		# get the configured matcher
		# might be a shorthand value
		my $matcher = $matcher{$key};

		# matcher is a shorthand
		if (ref($matcher) eq 'HASH')
		{

			# get optional options from shorthand
			# create a copy of the array, so we can
			# manipulate them later for loop control
			my $prefix = [ @{$matcher->{'prefix'} || []} ];
			my $ordered = [ @{$matcher->{'ordered'} || []} ];
			my $postfix = [ @{$matcher->{'postfix'} || []} ];

			# create arrays for all longhands
			$longhands{$_} = [] foreach @{$prefix};
			$longhands{$_->[0]} = [] foreach @{$ordered};
			$longhands{$_} = [] foreach @{$postfix};

			# parse list
			# exit if not
			while (1)
			{

				# declare variables
				my ($prop);

				# set defaults for all optional longhands
				push @{$longhands{$_}}, $default{$_} foreach @{$prefix};
				push @{$longhands{$_->[0]}}, $default{$_->[0]} foreach @{$ordered};
				push @{$longhands{$_}}, $default{$_} foreach @{$postfix};

				# optional prefixes (can occur in any order)
				for (my $i = 0; $i < scalar(@{$prefix}); $i++)
				{

					# get property name
					my $prop = $prefix->[$i];

					# get the configured matcher
					# might be a shorthand value
					my $regex = $matcher{$prop};

					# test if we have found this property
					if ($value =~ s/\A\s*($regex)\s*//s)
					{
						# matches this property
						$longhands{$prop}->[-1] = $1;
						# remove from search and
						splice(@{$prefix}, $i, 1);
						# restart loop
						$i = 0; redo;
					}
					# EO match regex

				}
				# EO each prefix

				# mandatory longhands
				foreach $prop (@{$ordered})
				{

					# get property name
					my $name = $prop->[0];
					# get optinal alternative
					# string: eval to this if nothing set
					# regexp: is optinal fallowed by this
					my $alt = $prop->[1];

					# get the configured matcher
					# might be a shorthand value
					my $regex = $matcher{$name};

					# optional alternative
					# delimited from property
					if (ref($alt) eq 'Regexp')
					{
						# test if we found the delimiter
						# if not the value is not mandatory
						next unless ($value =~ s/\A\s*($alt)\s*//s)
					}

					# test if we have found this property
					if ($value =~ s/\A\s*($regex)\s*//s)
					{
						# matches this property
						$longhands{$name}->[-1] = $1;
					}
					# EO match regex

					# has other alternative
					# eval to another longhand
					elsif (ref($alt) eq '')
					{
						# eval to another longhand property
						# property may has been parsed already
						$longhands{$name}->[-1] = $longhands{$alt}->[-1];
					}

				}
				# EO each longhand

				# optional postfixes (can occur in any order)
				for (my $i = 0; $i < scalar(@{$postfix}); $i++)
				{

					# get property name
					my $prop = $postfix->[$i];

					# get the configured matcher
					# might be a shorthand value
					my $regex = $matcher{$prop};

					# test if we have found this property
					if ($value =~ s/\A\s*($regex)\s*//s)
					{
						# matches this property
						$longhands{$prop}->[-1] = $1;
						# remove from search and
						splice(@{$postfix}, $i, 1);
						# restart loop
						$i = 0; redo;
					}
					# EO match regex

				}
				# EO each postfix

				#####################################################
				# implement action to setup styles
				#####################################################
				print "x" x 40, "\n";
				foreach my $key (keys %longhands)
				{ printf "%s => %s\n", $key, $longhands{$key}; }
				#####################################################

				# check if we should parse in list mode
				# if we find a comma we will parse again
				next if $list{$key} && $value =~ s/\A\s*,\s*//s;

				# end loop
				last;

			}
			# EO while 1


		}
		# EO if HASH

		# assertion for hash type
		else { die "unknown type"; }

	}
	# EO while matcher

	# return results
	return \ %longhands;

};
# EO fn $process

####################################################################################################

# set the readed text
# parse key and value
sub set
{

	# get input arguments
	my ($self, $text) = @_;

	# call super class method
	$self->SUPER::set($text);

	# split the key and the value
	# leave whitespace to save later
	my ($key, $value) = split(':', $text, 2);

	# remove whitespace
	my $whitespace =
	{
		'key-prefix' => $key =~ s/\A((?:\s+|$re_comment)+)//s ? $1 : '',
		'key-postfix' => $key =~ s/\A((?:\s+|$re_comment)+)//s ? $1 : '',
		'value-prefix' => $value =~ s/((?:\s+|$re_comment)+)\z//s ? $1 : '',
		'value-postfix' => $value =~ s/((?:\s+|$re_comment)+)\z//s ? $1 : '',
	};

	# store whitespace for rendering
	$self->{'whitespace'} = $whitespace;

	# store key and value
	# as parsed (with comments)
	$self->{'key'} = $key;
	$self->{'value'} = $value;

	# uncomment key/value
	$key = $self->key;
	$value = $self->value;

	# get the comments from the value
	# my $comment = join(';', $self->comment);

	$process->($key, $value);

	# instance
	return $self;

}
# EO sub set

####################################################################################################

sub render
{

	# get input arguments
	my ($self, $comments, $indent) = @_;

	# declare string
	my $code = '';

	# init default indent
	$indent = 0 unless $indent;

	# print to debug the css "dom" tree
	# print "  " x $indent, $self, "\n";

	# put back the original code
	$code .= $self->{'whitespace'}->{'key-prefix'};
	$code .= $self->{'key'};
	$code .= $self->{'whitespace'}->{'key-postfix'};
	$code .= ':';
	$code .= $self->{'whitespace'}->{'value-prefix'};
	$code .= $self->{'value'};
	$code .= $self->{'whitespace'}->{'value-postfix'};

	# re-add suffix if one has been parsed
	$code .= $self->suffix if $self->suffix;

	# return code
	return $code;

}
# EO sub render

####################################################################################################

# load regex for vendor prefixes
#**************************************************************************************************
use OCBNET::CSS3::Regex::Base qw($re_identifier);

# add basic extended type with highest priority
#**************************************************************************************************
unshift @OCBNET::CSS3::types, [
	qr/\A\s*$re_identifier\s*\:/is,
	'OCBNET::CSS3::Property',
	sub { ! $_[1] }
];

####################################################################################################
####################################################################################################
1;
