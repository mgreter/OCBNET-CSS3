###################################################################################################
# Copyright 2013 by Marcel Greter
# This file is part of Webmerge (GPL3)
####################################################################################################
package OCBNET::CSS3::Text;
####################################################################################################

use strict;
use warnings;

####################################################################################################
use base 'OCBNET::CSS3';
####################################################################################################

# static getter
#**************************************************************************************************
sub type { return 'text' }

####################################################################################################

# add basic extended type with highest priority
#**************************************************************************************************
push @OCBNET::CSS3::types, [
	qr/\A.+\z/is,
	'OCBNET::CSS3::Text'
];

####################################################################################################
####################################################################################################
1;
