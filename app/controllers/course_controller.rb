class CoursesController < ApplicationController
  def index
    @course = Course.page(params[:page]).per Settings.paging.course
  end
  
  def show
    @course = Course.find_by id: params[:id]
    return if @course
  
    flash[:danger] = "Course not found!"
    redirect_to root_path
  end
  
  def new
    @course = Course.new
  end
  
  def edit
    @course = Course.find_by id: params[:id]
  end
  
  def create
    @course = Course.new course_params
    if @course.save
      flash[:info] = "Course created"
      redirect_to courses_path
    else
      flash[:danger] = "Please try again!"
      render :new
    end
  end
  
  def update
    @course = Course.find_by id: params[:id]
    if @course.update_attributes course_params
      flash[:success] = "Course updated"
      redirect_to @course
    else
      render :edit
      flash[:danger] = "Please try again!"
    end
  end
  
  def destroy
    Course.find_by(id: params[:id]).destroy
    flash[:success] = "Course deleted"
    redirect_to courses_path
  end
  
  private
  
  def course_params
    params.require(:course).permit :name, :started_at
  end
end
