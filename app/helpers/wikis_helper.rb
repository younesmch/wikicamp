module WikisHelper
  def markdown(text)
    extensions = {
     fenced_code_blocks: true,
     autolink: true,
     superscript: true,
     disable_indented_code_blocks: true,
     strikethrough: true,
     underline: true,
     highlight: true,
     quote: true,
     footnotes: true,
     space_after_headers: false
  }

  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions)
  markdown.render(text).html_safe
  end
end
