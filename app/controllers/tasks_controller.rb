class TasksController < ApplicationController
    include Paginable

    def index
        paginated = paginate(Task.recent)
        render_collection(paginated)
    end

    def show
        task = Task.find(params[:id])
        render json: serializer.new(task)
    end

    def serializer
        TaskSerializer
    end
end
