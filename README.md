OCBNET-CSS3
===========

Perl module for CSS3 parsing, manipulation and rendering. It does this by parsing the CSS into
a DOM like structure. You then can use various methods to manipulate it and finally render it again.

Should be able to parse nearly any css based format (i.e. scss). We try to be as unstrict as possible
when parsing css code and blocks. If the blocks are in a known format, the node/object will automatically
be set to the specific class. This enables any implementor to define its own specific implementation (todo).

Great care has been taken to parse everything correctly (like handling escaped chars and chars in quoted
strings correctly). I think many css processors and tools ignore these edge cases. This module has been
built from ground up to actually be able to parse them correctly. The key base to this is a set of well
tested regular expressions, which may be handy for other css related tasks.

csslint
=======

Check the given file if it is within the IE limits (selectors and imports).

```
csslint input.css
```

blessc
======

Rewrite the given input.css if it exceeds the IE limitations (only selectors). Adds imports and additional
stylesheets. This has been inspired by http://blesscss.com/. But this version "should" handle nested blocks.

```
blessc input.css output.css
```
