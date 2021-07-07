class TaskSerializer
  include JSONAPI::Serializer
  attributes :name, :description
end
