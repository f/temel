require "./spec_helper"

describe Temel do
  it "works" do
    _html = html ({a: 1}) do
      [head,
      body do
        [img({src: "a.jpg"}), b i u "hello"]
      end]
    end
    _html.should eq("<html a=\"1\"><head /><body><img src=\"a.jpg\" /><b><i><u>hello</u></i></b></body></html>")
  end

  it "runs with readme example" do
    _html = html do
      body do
        h1 "Hello World!"
      end
    end
    _html.should eq("<html><body><h1>Hello World!</h1></body></html>")
  end
end
