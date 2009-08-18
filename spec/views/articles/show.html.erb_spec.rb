require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/articles/show.html.erb" do
  include ArticlesHelper
  before(:each) do
    assigns[:article] = @article = stub_model(Article,
      :title => "value for title",
      :content => "value for content",
      :author => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ title/)
    response.should have_text(/value\ for\ content/)
    response.should have_text(/1/)
  end
end
