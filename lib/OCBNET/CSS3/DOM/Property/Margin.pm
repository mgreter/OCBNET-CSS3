###################################################################################################
# Copyright 2013/2014 by Marcel Greter
# This file is part of OCBNET-CSS3 (GPL3)
####################################################################################################
package OCBNET::CSS3::DOM::Property::Margin;
####################################################################################################

use strict;
use warnings;

####################################################################################################
# import regular expressions
####################################################################################################

use OCBNET::CSS3::Regex::Numbers;

####################################################################################################
# register longhand properties for margin
####################################################################################################

OCBNET::CSS3::DOM::Property::register('margin-top', $re_length, '0');
OCBNET::CSS3::DOM::Property::register('margin-left', $re_length, '0');
OCBNET::CSS3::DOM::Property::register('margin-right', $re_length, '0');
OCBNET::CSS3::DOM::Property::register('margin-bottom', $re_length, '0');

####################################################################################################
# register shorthand property for margin
####################################################################################################

OCBNET::CSS3::DOM::Property::register('margin',
{
	'ordered' =>
	# needed in order
	[
		# always needed
		[ 'margin-top' ],
		# additional optional values
		# may evaluate to other value
		[ 'margin-right', 'margin-top'],
		[ 'margin-bottom', 'margin-top'],
		[ 'margin-left', 'margin-right']
	]
});

####################################################################################################
####################################################################################################
1;
