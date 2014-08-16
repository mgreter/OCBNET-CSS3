###################################################################################################
# Copyright 2013/2014 by Marcel Greter
# This file is part of OCBNET-CSS3 (GPL3)
####################################################################################################
package OCBNET::CSS3::DOM::Extended::Import;
####################################################################################################
our $VERSION = '0.2.5';
####################################################################################################

use strict;
use warnings;

####################################################################################################
use base 'OCBNET::CSS3::DOM::Extended';
####################################################################################################

# static getter
#**************************************************************************************************
sub type { return 'import' }

####################################################################################################

# load regex for vendor prefixes
#**************************************************************************************************
use OCBNET::CSS3::Regex::Base qw($re_vendors);

# add basic extended type with highest priority
#**************************************************************************************************
unshift @OCBNET::CSS3::types, [
	qr/\A\s*\@(?:-$re_vendors-)?import/is,
	'OCBNET::CSS3::DOM::Extended::Import'
];

####################################################################################################
####################################################################################################
1;
