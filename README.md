# QLab

Interact with QLab from Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'qlab-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install qlab-ruby

## Usage

    > require 'qlab-ruby'
    > machine = QLab.connect # defaults to ('localhost', 53000)
    > machine.workspaces.first.go

And you're off.

A `machine` has one or more `workspaces`. A `workspace` has one or more
`cue_lists`. A `cue` can respond to any of the QLab OSC commands.

    > cue.start
    > cue.stop

etc.

Most OSC commands that accept a single value can be called by their `=`
versions. For example:

    > cue.rate(0.5)

and

    > cue.rate = 0.5

do the same thing.

OSC commands that require multiple arguments will still have to be called
as methods.

    > cue.sliderLevel(1, -5)

To set slider 1 to the value -5.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
