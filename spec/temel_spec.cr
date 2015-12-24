require "./spec_helper"

tag hello
tag world
tag application
tag hello_world

describe Temel do
  it "works" do
    _html = html ({a: 1}) do [
      head,
      body do [
        img({src: "a.jpg"}),
        b i u "hello"
      ] end
    ] end
    _html.should eq("<html a=\"1\"><head /><body><img src=\"a.jpg\" /><b><i><u>hello</u></i></b></body></html>")
  end

  it "supports simpler same-level elements syntax" do
    _html = html(
      head(
        script({src: "main.js"})
      ),
      body(
        p "Hello"
      )
    )
    _html.should eq("<html><head><script src=\"main.js\" /></head><body><p>Hello</p></body></html>")
  end

  it "runs with readme example" do
    _html = html do
      body do
        h1 "Hello World!"
      end
    end
    _html.should eq("<html><body><h1>Hello World!</h1></body></html>")
  end

  it "able to add custom tags" do
    _html = hello do
      world "!"
    end
    _html.should eq("<hello><world>!</world></hello>")
  end

  it "able to add web components" do
    _html = hello_world do
      "!"
    end
    _html.should eq("<hello-world>!</hello-world>")
  end

  it "able to add comments" do
    _html = hello_world do
      comment "Hello"
    end
    _html.should eq("<hello-world><!-- Hello --></hello-world>")
  end

  it "able to write simple dsl" do
    _html = application hello_world 1
    _html.should eq("<application><hello-world>1</hello-world></application>")
  end

  it "supports complex syntax" do
    _html = html(
      head(
        script({src: "main.js"})
      ),
      body({id: "main"},
        h1 "Hello World!",
        p "Lorem ipsum dolor sit amet"
      )
    )
    _html2 = html do [
      head do
        script({src: "main.js"})
      end,
      body({id: "main"}) do [
        h1 "Hello World!",
        p "Lorem ipsum dolor sit amet"
      ] end
    ] end
    _html.should eq(_html2)
    _html.should eq("<html><head><script src=\"main.js\" /></head><body id=\"main\"><h1>Hello World!<p>Lorem ipsum dolor sit amet</p></h1></body></html>")
  end
end
