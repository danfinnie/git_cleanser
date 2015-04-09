# GitCleanser

It's not ideal, but we've all worked with repositories containing compiled
files and their source code.  When there are 5 files and they follow a naming
convention, it's easily fixable.  When there are 1,000 files and they are all
named differently, fixing it seems insurmountable.  This tool helps iteratively
remove these files from your repository in the later case.

## Todo

[ ] Add an option for human readable or YAML output
[ ] Set up CI
[ ] Put some examples in the README
[ ] Check that things added to .gitignore are also `git rm`ed

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'git_cleanser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git_cleanser

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/git_cleanser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
