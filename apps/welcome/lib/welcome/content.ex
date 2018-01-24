defmodule Welcome.Content do

  @config Phoenix.Config.from_env(:welcome, __MODULE__, [])


  def list_posts do
	Contentful.Delivery.entries(@config[:space_id], @config[:token], %{"content_type" => "blog"})
  end

  def get_post(slug) do
	Contentful.Delivery.entries(@config[:space_id], @config[:token], %{"content_type" => "blog", "query" => slug})
  end

  def get_post_preview(slug) do
	Contentful.Delivery.entries(@config[:space_id], @config[:preview_token], %{"content_type" => "blog", "query" => slug})
  end

  def get_index do
	c = Contentful.Delivery.entries(@config[:space_id], @config[:token], %{"content_type" => "homepage"})
	|> List.first
	c["fields"]
  end
end
