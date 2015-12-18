# temel

Temel is a markup language for **Crystal**.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  temel:
    github: f/temel
```


## Usage

```crystal
require "kemal"
require "temel"

get "/" do
  html do
    body do
      h1 "Hello World!"
    end
  end
end
```

## Development

You can extend the Temel by adding your own tags.


### Adding a new tag

```
tag [tagname]
```

will register a new tag.

## Contributing

1. Fork it ( https://github.com/f/temel/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [f](https://github.com/f) Fatih Kadir Akın - creator, maintainer
