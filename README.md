# Temel

Temel is a markup language for **Crystal**. A simpler alternative to [HTML Builder](http://github.com/crystal-lang/html-builder).

- Custom tag registration with a simple `tag` macro.
- Supports **Web Components**.
- Simpler DSL (comparing to HTML::Builder).

```ruby
# Register tags first.
tag my_application
tag hello_world

get "/" do
  html(
    body({id: "main"},
      my_application hello_world "Hello World!"
    )
  )
end
```

Or, you can alternatively use block based syntax (Just like HTML::Builder) instead of argument based syntax:

```ruby
get "/" do
  html do
    body({id: "main"}) do
      my_application hello_world "Hello World!"
    end
  end
end
```

The output will be:
```html
<html>
  <body id="main">
    <my-application>
      <hello-world>Hello World!</hello-world>
    </my-application>
  </body>
</html>
```

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  temel:
    github: f/temel
```

## Usage

```ruby
require "kemal"
require "temel"

get "/" do
  html(
    body(
      h1 "Hello World"
    )
  )
end
```

### Using as Template Engine

You can use Temel as layout engine with functions.

```crystal
# layout.tpl.cr
def layout(content)
  html(
    head(
      title("Hello")
    ),
    body(content)
  )
end
```

... just by using Crystal's internals, nothing more...

```crystal
# hello.tpl.cr
require "layout.tpl"

def hello(where)
  layout("Hello #{where}")
end
```

... use it with Kemal makes everything better.
```crystal
# main.cr
require "hello.tpl"

get "/" do |env|
  hello(env.params.where)
end
```

### Argument Based DSL vs Block Based DSL

Argument based DSL is a bit different than HTML::Builder's.

#### Argument Based DSL
```ruby
get "/" do
  html(
    head(
      script({src: "main.js"})
    ),
    body({id: "main"},
      h1 "Hello World!",
      p "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    )
  )
end
```

#### Block Based DSL
```ruby
get "/" do
  html do [
    head do
      script({src: "main.js"})
    end,
    body({id: "main"}) do [
      h1 "Hello World!",
      p "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    ] end
  ] end
] end
```

### Comments
You can add HTML comments with Temel.

```ruby
get "/" do
  html(
    body(
      ul(
        comment("ko foreach: myItems"),
        li({"data-bind": "text: $data"}),
        comment("/ko")
      )
    )
  )
end
```

## Using with [Onyx](https://github.com/ozra/onyx-lang)

Works with Onyx seamlessly.[*](https://github.com/ozra/onyx-lang/issues/60#issuecomment-201954355).

```coffee
html
   head
      title "Testing it out!"
      script
         { type: "bad-script" }
         "my-fine-file.bad-ass"
   body
      div
         {id: "main-div"}

         if is-welcome ? h1 "Welcome" : h2 "This is it"

         article
            h2 "The fat and the furious"
            p
               "
               Long
               article text
               here
               and stuff, mkay Mr. {some-name}!
               "

               ul items.map(~> li _1).join

      div {id: "footer"},
         nav ul
            li a {href: "asdfsadf"}, "Contact"
            li a {href: "bfadfasdf.se"}, "About"
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
