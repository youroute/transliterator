## English ##

It is a simple library allowing you to transliterate between cyrillic and latin. It is easy to use from the command line and in your code.

Add this line to your application's Gemfile:

```ruby
gem 'transliterator', github: 'exAspArk/transliterator'
```

And then execute:

```ruby
bundle
```

### Usage ###

```ruby
# ruby 2.1
Transliterator.new.convert("Это простой тест", to: :en)
```

To use translit from the command line you just type <code>transliterator [your_input_here]</code> where your input could be in cyrillic or latin.

Or you can translit stdin now via just: <code>transliterator</code>. To stop stdin input use .\n (press dot and then enter on the new line)
