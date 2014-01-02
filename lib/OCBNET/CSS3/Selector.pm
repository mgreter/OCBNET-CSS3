###################################################################################################
# Copyright 2013/2014 by Marcel Greter
# This file is part of OCBNET-CSS3 (GPL3)
####################################################################################################
package OCBNET::CSS3::Selector;
####################################################################################################

use strict;
use warnings;

####################################################################################################
use base 'OCBNET::CSS3::Block';
####################################################################################################

# static getter
#**************************************************************************************************
sub type { return 'selector' }

####################################################################################################

# load regex for vendor prefixes
#**************************************************************************************************
use OCBNET::CSS3::Regex::Selectors qw($re_selector_rules);

# add basic extended type with highest priority
#**************************************************************************************************
unshift @OCBNET::CSS3::types, [
	qr/\A\s*$re_selector_rules/is,
	'OCBNET::CSS3::Selector',
	sub { !! $_[1] }
];

####################################################################################################
####################################################################################################
1;
