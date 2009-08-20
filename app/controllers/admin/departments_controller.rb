class Admin::DepartmentsController < Admin::AdminController
  before_filter :new_department, :only => [:new, :create]
  before_filter :find_department, :only => [:show, :edit, :update, :destroy]
  filter_access_to :all
  filter_access_to [:new, :create], :attribute_check => true
  filter_access_to [:edit, :update, :destroy], :attribute_check => true

  # GET /admin/departments
  # GET /admin/departments.xml
  def index
    @departments = Department.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_departments }
    end
  end

  # GET /admin/departments/1
  # GET /admin/departments/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @department }
    end
  end

  # GET /admin/departments/new
  # GET /admin/departments/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @department }
    end
  end

  # GET /admin_departments/1/edit
  def edit
  end

  # POST /admin/departments
  # POST /admin/departments.xml
  def create
    respond_to do |format|
      if @department.save
        flash[:notice] = 'Department was successfully created.'
        format.html { redirect_to admin_department_path(@department) }
        format.xml  { render :xml => @department, :status => :created, :location => admin_department_path(@department) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/departments/1
  # PUT /admin/departments/1.xml
  def update
    respond_to do |format|
      if @department.update_attributes(params[:department])
        flash[:notice] = 'Department was successfully updated.'
        format.html { redirect_to admin_department_path(@department) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/departments/1
  # DELETE /admin/departments/1.xml
  def destroy
    @department.destroy

    respond_to do |format|
      format.html { redirect_to(admin_departments_url) }
      format.xml  { head :ok }
    end
  end

  protected

  def new_department
    @department = Department.new(params[:department])
  end

  def find_department
    @department = Department.find(params[:id])
  end
end
