require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/articles/new.html.erb" do
  include ArticlesHelper

  before(:each) do
    assigns[:article] = stub_model(Article,
      :new_record? => true,
      :title => "value for title",
      :content => "value for content",
      :author => 1
    )
  end

  it "renders new article form" do
    render

    response.should have_tag("form[action=?][method=post]", articles_path) do
      with_tag("input#article_title[name=?]", "article[title]")
      with_tag("textarea#article_content[name=?]", "article[content]")
      with_tag("input#article_author[name=?]", "article[author]")
    end
  end
end
