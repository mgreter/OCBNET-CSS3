###################################################################################################
# Copyright 2013/2014 by Marcel Greter
# This file is part of OCBNET-CSS3 (GPL3)
####################################################################################################
package OCBNET::CSS3::Extended::Viewport;
####################################################################################################

use strict;
use warnings;

####################################################################################################
use base 'OCBNET::CSS3::Extended';
####################################################################################################

# static getter
#**************************************************************************************************
sub type { return 'viewport' }

####################################################################################################

# load regex for vendor prefixes
#**************************************************************************************************
use OCBNET::CSS3::Regex::Base qw($re_vendors);

# add basic extended type with highest priority
#**************************************************************************************************
unshift @OCBNET::CSS3::types, [
	qr/\A\s*\@(?:-$re_vendors-)?viewport/is,
	'OCBNET::CSS3::Extended::Viewport'
];

####################################################################################################
####################################################################################################
1;
