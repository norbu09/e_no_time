defmodule Welcome.Content do

  @config Phoenix.Config.from_env(:welcome, __MODULE__, [])

  def list_posts do
	Excontentful.entries("blog")
  end

  def get_post(slug) do
	Excontentful.search_entry("blog", "slug", slug)
  end

  def get_post_preview(slug) do
	Excontentful.search_entry_prev("blog", "slug", slug)
  end

  def get_index do
    {:ok, page} = Excontentful.get_entry(@config[:index_entry])
    page
  end

  def get_page(path) do
    Excontentful.search_entry("page", "path", path)
  end
end
