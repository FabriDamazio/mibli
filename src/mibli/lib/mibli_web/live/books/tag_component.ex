defmodule MibliWeb.Books.TagComponent do
  use Phoenix.Component

  @default_color "bg-blue-100 text-blue-800"

  attr :text, :string, required: true
  attr :color, :string, default: @default_color

  def tag(assigns) do
    ~H"""
    <span class={"#{assigns.color} inline-flex items-center px-3 py-0.5 rounded-full text-sm font-medium"}>
      <%= assigns.text %>
    </span>
    """
  end
end
