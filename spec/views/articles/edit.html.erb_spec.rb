require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/articles/edit.html.erb" do
  include ArticlesHelper

  before(:each) do
    assigns[:article] = @article = stub_model(Article,
      :new_record? => false,
      :title => "value for title",
      :content => "value for content",
      :author => 1
    )
  end

  it "renders the edit article form" do
    render

    response.should have_tag("form[action=#{article_path(@article)}][method=post]") do
      with_tag('input#article_title[name=?]', "article[title]")
      with_tag('textarea#article_content[name=?]', "article[content]")
      with_tag('input#article_author[name=?]', "article[author]")
    end
  end
end
