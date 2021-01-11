module Mutations
  class CreateTask < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end

    field :task, Types::TaskType, null: false
    field :result, Boolean, null: false

    argument :title, String, required: false

    def resolve(**args)
      task = Task.create(title: args[:title])
      {
        task: task,
        result: task.errors.blank?
      }
    end
  end
end
