macro attributes(list)
  %key_value = {{list}}.map {|key, value| "#{key}=\"#{value}\"" }
  %key_value.join " "
end

macro tag(name)
  def {{name}}
    "<{{name}} />"
  end
  def {{name}}(attrs : Hash)
    "<{{name}} #{attributes attrs} />"
  end
  def {{name}}(content : String|Int)
    "<{{name}}>#{content}</{{name}}>"
  end
  def {{name}}(&block)
    content = yield
    content = content.join "" if content.is_a? Array
    "<{{name}}>#{content}</{{name}}>"
  end
  def {{name}}(attrs, &block)
    content = yield
    content = content.join "" if content.is_a? Array
    "<{{name}} #{attributes attrs}>#{content}</{{name}}>"
  end
end
