class ArticlesController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  before_filter :new_article, :only => [:new, :create]
  before_filter :find_article, :only => [:show, :edit, :update, :destroy]
  before_filter :find_created_article, :only => :confirm
  before_filter :find_confirmed_article, :only => :approve
  filter_access_to [:new, :create], :attribute_check => true
  filter_access_to [:edit, :update, :destroy], :attribute_check => true
  filter_access_to :confirm, :attribute_check => true
  filter_access_to :approve, :attribute_check => true
  filter_access_to :all

  # GET /articles
  # GET /articles.xml
  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.xml
  def create
    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to(@article) }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    respond_to do |format|
      if @article.update_attributes(params[:article])
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to(@article) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end

  # PUT /aritcles/1
  # PUT /articles/1.xml
  def confirm
    respond_to do |format|
      if @article.confirm
        flash[:notice] = 'Article was successfully confirmed.'
        format.html { redirect_to(@article) }
        format.xml  { head :ok }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end

  end

  # PUT /aritcles/1
  # PUT /articles/1.xml
  def approve
    respond_to do |format|
      if @article.approve
        flash[:notice] = 'Article was successfully approved.'
        format.html { redirect_to(@article) }
        format.xml  { head :ok }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  protected

  def new_article
    @article = Article.new(params[:article])
    @article.author = current_user
  rescue ActiveRecord::RecordNotFound
    redirect_to articles_path
  end

  def find_article
    @article = Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to articles_path
  end

  def find_created_article
    @article = Article.with_state(:created).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to articles_path
  end

  def find_confirmed_article
    @article = Article.with_state(:confirmed).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to articles_path
  end
end
