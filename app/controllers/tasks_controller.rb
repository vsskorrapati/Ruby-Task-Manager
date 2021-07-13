class TasksController < ApplicationController
    skip_before_action :authorize!, only: [:index, :show]
    include Paginable

    def index
        paginated = paginate(Task.recent)
        render_collection(paginated)
    end

    def show
        task = Task.find(params[:id])
        render json: serializer.new(task)
    end

    def create
        task = current_user.tasks.build(task_params)
        task.save!
        render json: serializer.new(task), status: :created
      rescue
        render json: errorserializer.new(task), status: :unprocessable_entity
    end

    def update
        task = current_user.tasks.find(params[:id])
        task.update_attributes!(task_params)
        render json: serializer.new(task), status: :ok
      rescue
        render json: errorserializer.new(task), status: :unprocessable_entity
    end

    def destroy
        task = current_user.tasks.find(params[:id])
        task.destroy
        head :no_content
      rescue
        authorization_error
    end

    private

    def errorserializer
        ErrorSerializer
    end

    def serializer
        TaskSerializer
    end

    def task_params
        params.require(:data).require(:attributes).
          permit(:name, :description) ||
        ActionController::Parameters.new
    end
end
