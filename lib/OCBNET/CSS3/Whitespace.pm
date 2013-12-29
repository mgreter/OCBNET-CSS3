###################################################################################################
# Copyright 2013 by Marcel Greter
# This file is part of Webmerge (GPL3)
####################################################################################################
package OCBNET::CSS3::Whitespace;
####################################################################################################

use strict;
use warnings;

####################################################################################################
use base 'OCBNET::CSS3';
####################################################################################################

# static getter
#**************************************************************************************************
sub type { return 'whitespace' }

####################################################################################################

# add basic extended type with highest priority
#**************************************************************************************************
push @OCBNET::CSS3::types, [
	qr/\A\s+\z/is,
	'OCBNET::CSS3::Whitespace',
	sub { ! $_[1] }
];

####################################################################################################
####################################################################################################
1;
