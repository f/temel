macro attributes(list)
  %key_value = {{list}}.map do |key, value|
    "#{key}=\"#{value}\""
  end
  %key_value.join " "
end

macro legalize_tag(name)
  "#{ "{{name}}".gsub(/_/, '-') }"
end

macro tag(name)
  def {{name}}
    "<#{ legalize_tag {{name.id}} } />"
  end
  def {{name}}(attrs : Hash)
    "<#{ legalize_tag {{name.id}} } #{attributes attrs} />"
  end
  def {{name}}(content : String|Int)
    "<#{ legalize_tag {{name.id}} }>#{content}</#{ legalize_tag {{name.id}} }>"
  end

  # Block Based DSL
  def {{name}}(&block)
    content = yield
    content = content.join "" if content.is_a? Array
    "<#{ legalize_tag {{name.id}} }>#{content}</#{ legalize_tag {{name.id}} }>"
  end
  def {{name}}(attrs : Hash, &block)
    content = yield
    content = content.join "" if content.is_a? Array
    "<#{ legalize_tag {{name.id}} } #{attributes attrs}>#{content}</#{ legalize_tag {{name.id}} }>"
  end

  # Argument Based DSL
  def {{name}}(*elements)
    "<#{ legalize_tag {{name.id}} }>#{elements.join ""}</#{ legalize_tag {{name.id}} }>"
  end
  def {{name}}(attrs : Hash, *elements)
    "<#{ legalize_tag {{name.id}} } #{attributes attrs}>#{elements.join ""}</#{ legalize_tag {{name.id}} }>"
  end
end
