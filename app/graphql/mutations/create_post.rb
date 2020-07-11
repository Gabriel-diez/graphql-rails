class Mutations::CreatePost < Mutations::BaseMutation
  argument :title, String, required: true
  argument :body, String, required: true
  argument :user_email, String, required: true

  field :post, Types::PostType, null: false
  field :errors, [String], null: false

  def resolve(title:, body:, user_email:)
    user = User.find_by_email(user_email)
    post = Post.new(title: title, body: body, user: user)

    if post.save
      {
          post: post,
          errors: []
      }
    else
      {
          post: nil,
          errors: post.errors.full_messages
      }
    end
  end
end