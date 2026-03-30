# const_set_p.rb
[![Gem Version](https://badge.fury.io/rb/const_set_p.svg)](https://badge.fury.io/rb/const_set_p)
[![RSpec](https://github.com/epaew/const_set_p.rb/actions/workflows/rspec.yaml/badge.svg)](https://github.com/epaew/const_set_p.rb/actions/workflows/rspec.yaml)

Provides `Module#const_set_p`, a wrapper method for `Module#const_set` that acts like `mkdir -p` does for `mkdir`.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add const_set_p
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install const_set_p
```

## Usage

```ruby
require "const_set_p"

module M
  C = Class.new
  S = "str"

  # Ruby's `Module#const_set` raises NameError if the name contains `::`.
  const_set("N::O", Class.new)
  const_set("C::D", Class.new)

  # `Module#const_set_p` automatically defines all intermediate modules.
  # e.g. The code below defines `M::N`, `M::N::O` and `M::N::O::P`.
  const_set_p("N::O::P", Class.new)

  # Respects pre-defined classes and modules.
  # e.g. The code below does not replace the pre-defined `M::C` class.
  const_set_p("C::D", Class.new)

  # Raises a `NameError` if the specified intermediate constant is already defined and is neither a Class nor a Module.
  const_set_p("S::T", Class.new)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/epaew/const_set_p.rb.
