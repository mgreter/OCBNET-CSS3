###################################################################################################
# Copyright 2013 by Marcel Greter
# This file is part of Webmerge (GPL3)
####################################################################################################
# regular expressions to match css2/css3 selectors
####################################################################################################
package OCBNET::CSS3::Regex::Stylesheet;
####################################################################################################

use strict;
use warnings;

####################################################################################################

# load exporter and inherit from it
BEGIN { use Exporter qw(); our @ISA = qw(Exporter); }

# define our functions that will be exported
BEGIN { our @EXPORT = qw(%opener %closer $re_statement); }

# define our functions than can be exported
BEGIN { our @EXPORT_OK = qw($re_bracket); }

####################################################################################################

use OCBNET::CSS3::Regex::Base;
use OCBNET::CSS3::Regex::Comments;

####################################################################################################

# openers and closers for certain block type
# ***************************************************************************************
our %opener = ( '{' => '{', '[' => '[', '(' => '(', '\"' => '\"', '\'' => '\'' );
our %closer = ( '{' => '}', '[' => ']', '(' => ')', '\"' => '\"', '\'' => '\'' );

# declare regex to parse a block
# with correct bracket counting
# ***************************************************************************************
our $re_bracket; $re_bracket = qr/
	\{ # match opening bracket
	(?: # inner block capture group
		# allowd chars
		[^\\\"\'\/{}]+ |
		# escaped char
		(?: \\ .)+ |
		# comment or only a slash
		(??{$re_comment}) |
		# a string in delimiters
		\' (??{$re_apo}) \' |
		\" (??{$re_quot}) \" |
		# recursive blocks
		(??{$re_bracket})
	)* # can be empty or repeat
	\} # match closing bracket
/x;

# declare regex to parse a rule
# optional brackets (ie. media query)
# ***************************************************************************************
our $re_statement; $re_statement = qr/
	((?: # inner block capture group
		# allowd chars
		[^\\\"\'\/{};]+ |
		# escaped char
		(?: \\ .)+ |
		# comment or only a slash
		(??{$re_comment}) |
		# a string in delimiters
		\' (??{$re_apo}) \' |
		\" (??{$re_quot}) \" |
	)*) # can be empty or repeat
	((??{$re_bracket})?) # optional
	((?:\z|;)?) # match exit clause
/x;

####################################################################################################
####################################################################################################
1;