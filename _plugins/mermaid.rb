# Custom Jekyll plugin to handle Mermaid diagrams
# This converts ```mermaid code blocks into <div class="mermaid"> elements

module Jekyll
  class MermaidBlock < Jekyll::Block
    def initialize(tag_name, markup, tokens)
      super
      @caption = markup.strip
    end

    def render(context)
      content = super.strip
      "<div class=\"mermaid\">#{content}</div>"
    end
  end
end

Liquid::Template.register_tag('mermaid', Jekyll::MermaidBlock)
