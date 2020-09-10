defmodule Chan.Posts.Passwords do
  alias Comeonin.Bcrypt
  alias Chan.Posts.Post

  def hash_password(password), do: Bcrypt.hashpwsalt(password)

  def validate_password(%Post{} = post, password), do: Bcrypt.check_pass(post, password)
end
