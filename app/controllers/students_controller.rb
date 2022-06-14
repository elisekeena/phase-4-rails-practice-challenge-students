class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_not_valid_response

    def index
        students = Student.all 
        render json: students, include: :instructor, status: 200
    end

    def show
        student = find_student
        render json: student, include: :instructor, status: :ok
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

    def student_params
        params.permit(:name, :age, :major, :instructor_id)
    end

    def find_student
        Student.find(params[:id])
    end

    def render_not_found_response
        render json: {error: 'Not Found'}, status: :not_found
    end

    def render_not_valid_response
        render json: {error: 'Name can\'t be blank'}, status: :unprocessable_entity
    end
end
