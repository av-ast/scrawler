defmodule Scrawler.Factory do
  use ExMachina.Ecto, repo: Scrawler.Repo

	def user_factory do
    %Scrawler.User{
      name: "Jane Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      crawls: build_pair(:crawl)
    }
  end

	def crawl_factory do
    %Scrawler.Crawl{
      url: sequence(:url, &"http://example.com/#{&1}.html"),
      max_depth: 1,
      max_retries: 3,
      state: "created",
      user: build(:user),
      links: build_list(3, :link)
    }
  end

	def link_factory do
    %Scrawler.Link{
      url: sequence(:url, &"http://example.com/#{&1}.html"),
      title: sequence("Title"),
      crawl: build(:crawl)
    }
  end

end
