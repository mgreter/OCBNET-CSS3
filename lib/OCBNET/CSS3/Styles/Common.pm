###################################################################################################
# Copyright 2013/2014 by Marcel Greter
# This file is part of OCBNET-CSS3 (GPL3)
####################################################################################################
package OCBNET::CSS3::Styles::Common;
####################################################################################################

use strict;
use warnings;

####################################################################################################

use OCBNET::CSS3::Regex::Base;
use OCBNET::CSS3::Regex::Colors;

####################################################################################################
# register longhand properties for fonts
####################################################################################################

OCBNET::CSS3::Styles::register('color', $re_color, 'inherit');

####################################################################################################
####################################################################################################
1;