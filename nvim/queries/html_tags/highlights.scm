(tag_name) @tag
(erroneous_end_tag_name) @error
(comment) @comment
(attribute_name) @tag.attribute
(attribute
  (quoted_attribute_value) @string)
(text) @text @spell

((element (start_tag (tag_name) @_tag) (text) @text.literal)
 (#match? @_tag "^(code|kbd)$"))

((attribute
   (attribute_name) @_attr
   (quoted_attribute_value (attribute_value) @text.uri))
 (#match? @_attr "^(href|src)$"))

[
 "<"
 ">"
 "</"
 "/>"
] @tag.delimiter

"=" @operator
