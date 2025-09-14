class SubmissionsController < ApplicationController
  before_action :set_course
  before_action :set_submission, only: [:edit, :update, :destroy]

  # GET /courses/:course_id/submissions/new
  def new
    @submission = Submission.new
    @enrollments = @course.enrollments  # only students enrolled in this course
    @lessons = @course.lessons          # only lessons for this course
  end

  # POST /courses/:course_id/submissions
  def create
    @submission = @course.submissions.new(submission_params)

    if @submission.save
      redirect_to course_path(@course), notice: "Submission was successfully created."
    else
      @enrollments = @course.enrollments
      @lessons = @course.lessons
      render :new, status: :unprocessable_entity
    end
  end
  

  # GET /courses/:course_id/submissions/:id/edit
  def edit
    @enrollments = @course.enrollments
    @lessons = @course.lessons
  end

  # PATCH/PUT /courses/:course_id/submissions/:id
  def update
    if @submission.update(mentor_review_params)
      redirect_to course_path(@course), notice: "Submission was successfully updated."
    else
      @enrollments = @course.enrollments
      @lessons = @course.lessons
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/:course_id/submissions/:id
  def destroy
    @submission.destroy
    redirect_to course_path(@course), notice: "Submission was successfully deleted."
  end

  private

    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_submission
      @submission = Submission.find(params[:id])
    end

    def submission_params
      params.require(:submission).permit(:lesson_id, :enrollment_id, :pull_request_url)
    end
    
    def mentor_review_params
      # mentor params
      params.require(:submission).permit(:review_result, :reviewed_at, :mentor_id)
    end
    
end

