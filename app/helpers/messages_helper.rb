module MessagesHelper
  def render_message_text(text)
    auto_link(h(text), html: { target: "_blank", rel: "noopener" })
  end
end
