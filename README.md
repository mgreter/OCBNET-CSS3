OCBNET-CSS3
===========

Perl module for CSS3 parsing, manipulation and rendering.

Should be able to parse nearly any css based format (i.e. scss). We try to be as unstrict as possible
when parsing css code and blocks. If the blocks are in a known format, the node/object will automatically
be set to the specific class. This enables any implementor to define its own specific implementation (todo).

Great care has been taken to parse everything correctly (like handling escaped chars and chars in quoted
strings correctly). I think many css processors and tools ignore these edge cases. This module has been
built from ground up to actually be able to parse them correctly. The key base to this is a set of well
tested regular expressions, which may be handy for other css related tasks.