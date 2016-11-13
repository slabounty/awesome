[![Build Status](https://travis-ci.org/slabounty/awesome.svg?branch=master)](https://travis-ci.org/slabounty/awesome)
[![Coverage Status](https://coveralls.io/repos/slabounty/awesome/badge.png?branch=master)](https://coveralls.io/r/slabounty/awesome?branch=master)
[![Code Climate](https://codeclimate.com/github/slabounty/awesome.png)](https://codeclimate.com/github/slabounty/awesome)

# awesome
Awesome Programming Language from Book [How to Create Your Own Freaking Awesome Programming Language](http://createyourproglang.com/) by Marc-André Cournoyer.

## Installation
    gem install awesome

## Running the REPL
    bin/awesome
or
    bin/awesome path/to/file.awm

## Building
    bundle exec rake parser:build

## Thought on the Language and Book

### Good
The best thing about the book is that it actually exists. To the best of
my knowledge, there aren't any other books out there that show building
a language in ruby. Additionally, it's a rare book that will take you
all the way through building not just an interpreter, but a runtime and
even compiling to bytecode and machine code.

### Bad
There's no implementation given for any of the math (```+``` is given as an
optional exercise with the answer, so you can implement the rest) or
logical operators even though they are parsed as part of the language.
There's no looping except ```while``` again as an optional exercise. There's
no ```else``` for if/then/else. There's no comments. There's a ```:``` on the
end of lines before indentation, but it's not shown in the grammar. It's
only in the lexer, hidden in a regex, and pretty much tossed on the
floor. There's no ```return``` statement. The language isn't implemented as
a gem as one would expect. 

I've added most of the above to my version here, but there are certainly
more things you could do. It turns out that doing a REPL is not as easy
as one would think and that's a big thing that would help.

## Acknowledgements
Marc-André Cournoyer for creating the book and the language.

