stocky
======
Get stock quotes.


CLI Usage
========
  Usage: stocky [options]
  
  Command options:
  -s, --source HOST                Stock source (default: GOOGLE)
  -q, --quotes 'comma separated'   Required, no default
  
  -h, --help 

Example
-------
`stocky -q "GOOG, APL, MSFT"`

or

`stocky -s "GOOGLE" -q "GOOG, APL"`


Contributing to Stocky
======================
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.


Copyright
=========
Copyright (c) 2011 Pieter Michels. See LICENSE.txt for further details.
