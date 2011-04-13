Ichiban is yet another CMS/blogging platform for Rails
======================================================

Why?
---- 

We wanted to use MongoDB for content storage and found existing CMSes are not suitable for this purpose.
We also required only admin panel to be generated for us, as we want to write all public views and controllers ourselves.

Status
------

Basic articles, snippets, assets management and parsing content with Markdown works. Comments controller for public site is also done, but still lacking comments management on admin panel.

Installation
------------

    rails new myappname -m http://github.com/amberbit/ichiban/raw/master/template.rb


License
-------

Licensed under the terms of MIT license.

Copyright
---------

Hubert Łępicki, Wojciech Piekutowski, AmberBit

