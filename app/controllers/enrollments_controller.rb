class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]

  # GET /enrollments
  # GET /enrollments.json
  def index
    @enrollments = Enrollment.all
  end

  def unverified_enrollments
    @enrollments = Enrollment.joins(:student).where(students: { campu_id: params[:campus_id], major_id: params[:major_id]}, enrollments: { verified: false }).includes([:student, :graduation_project, :professional_practice])
  end

  def authorize_enrollment
    @enrollment = Enrollment.find_by_id(params[:enrollment_id])
    @enrollment.verified = true
    respond_to do |format|
      if @enrollment.save
        format.html
        format.json { render json: @enrollment, status: :ok }
      else
        format.html
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments
  # POST /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_params)
    student = @enrollment.student
    student.available = false
    student.save

    unless @enrollment.professional_practice.nil?
      professional_practice = @enrollment.professional_practice
      professional_practice.active = false
      professional_practice.save
    end

    unless @enrollment.graduation_project.nil?
      graduation_project = @enrollment.graduation_project
      graduation_project.active = false
      graduation_project.save
    end

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to @enrollment, notice: 'Enrollment was successfully created.' }
        format.json { render :show, status: :created, location: @enrollment }
      else
        format.html { render :new }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to @enrollment, notice: 'Enrollment was successfully updated.' }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to enrollments_url, notice: 'Enrollment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:student_id, :professional_practice_id, :graduation_project_id)
    end
end
