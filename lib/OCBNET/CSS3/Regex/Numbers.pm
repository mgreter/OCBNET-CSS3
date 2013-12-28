###################################################################################################
# Copyright 2013 by Marcel Greter
# This file is part of Webmerge (GPL3)
####################################################################################################
package OCBNET::CSS3::Regex::Numbers;
####################################################################################################

use strict;
use warnings;

####################################################################################################

# load exporter and inherit from it
BEGIN { use Exporter qw(); our @ISA = qw(Exporter); }

# define our functions that will be exported
BEGIN { our @EXPORT = qw($re_number $re_percent $re_byte); }

####################################################################################################
# base regular expressions
####################################################################################################

# match (floating point) numbers
#**************************************************************************************************
our $re_number = qr/[\-\+]?[0-9]*\.?[0-9]+/s;
# our $re_number_neg = qr/\-[0-9]*\.?[0-9]+/s;
# our $re_number_pos = qr/\+?[0-9]*\.?[0-9]+/s;

# match a percent value
#**************************************************************************************************
our $re_percent = qr/$re_number\%/s;

# match a number from 0 to 255 (strict match)
#**************************************************************************************************
our $re_byte = qr/(?:0|[1-9]\d?|1\d{2}|2(?:[0-4]\d|5[0-5]))/s;

####################################################################################################
####################################################################################################
1;
