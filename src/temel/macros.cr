macro attributes(list)
  %key_value = {{list}}.map do |key, value|
    "#{key}=\"#{value}\""
  end
  %key_value.join " "
end

macro legalize_tag(name)
  "#{ "{{name.id}}".gsub(/_/, '-') }"
end

macro tag(name)
  def {{name.id}}
    "<#{ legalize_tag {{name}} } />"
  end
  def {{name.id}}(attrs : NamedTuple)
    "<#{ legalize_tag {{name}} } #{attributes attrs} />"
  end
  def {{name.id}}(content : String|Int)
    "<#{ legalize_tag {{name}} }>#{content}</#{ legalize_tag {{name}} }>"
  end

  # Block Based DSL
  def {{name.id}}(&block)
    content = yield
    content = content.join "" if content.is_a? Array
    "<#{ legalize_tag {{name}} }>#{content}</#{ legalize_tag {{name}} }>"
  end
  def {{name.id}}(attrs : NamedTuple, &block)
    content = yield
    content = content.join "" if content.is_a? Array
    "<#{ legalize_tag {{name}} } #{attributes attrs}>#{content}</#{ legalize_tag {{name}} }>"
  end

  # Argument Based DSL
  def {{name.id}}(*elements)
    "<#{ legalize_tag {{name}} }>#{elements.join ""}</#{ legalize_tag {{name}} }>"
  end
  def {{name.id}}(attrs : NamedTuple, *elements)
    "<#{ legalize_tag {{name}} } #{attributes attrs}>#{elements.join ""}</#{ legalize_tag {{name}} }>"
  end
end
