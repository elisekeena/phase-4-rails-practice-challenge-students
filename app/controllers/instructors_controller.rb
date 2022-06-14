class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_valid_response

    def index
        instructors = Instructor.all 
        render json: instructors, status: 200
    end

    def show
        instructor = Instructor.find_by(id: params[:id])
        render json: instructor, status: :ok
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end
    
    def update
        student = find_student
        student.update!(student_params)
        render json: student, status: :ok

    end
    
    def destroy
        student = find_student
        student.destroy
        head :no_content
    end
    private

    def instructor_params
        params.permit(:name)
    end

    def find_instructor
        Instructor.find_by!(id: params[:id])
    end

    def render_not_found_response
        render json: {error: 'Not Found'}, status: :not_found
    end

    def render_not_valid_response
        render json: {error: 'Name can\'t be blank'}, status: :unprocessable_entity
    end
end
