defmodule BsnWeb.Backend.Schema.Viewer do
  @moduledoc """
  An object representing the current viewer.

  The idea here is that application’s data is fundamentally relative to 
  who is viewing it, so most of other fields nest within it. In 
  practice not all of data may change depending on the viewer, but 
  doing so gives the ability to change mind later.
  """
  alias GraphQL.{Type}
  alias GraphQL.Relay.Connection

  alias BsnWeb.Backend
  alias Backend.{Schema}

  defstruct token: nil, user: nil 

  @doc """
  The GraphQL type of the viewer
  """
  def type(fields \\ %{}) do
    %Type.ObjectType{
      name: "GenBackendViewer",
      description: """
      Global Node used to query all objects and current user.

      GenBackendViewer has a user field, which is currently logged-in user. 
      If there is no logged-in user, this field will return null.

      For each type, GenBackendViewer holds a field with a Connection to all 
      objects of that type. Its name is allObjects, where Objects is a 
      pluralized name of the type.
      """,
      fields: Map.merge(fields, %{
        user: %{
          type: Schema.User,
          description: "The logged in user if any.",
          resolve: fn(viewer, _args, _context) ->
            viewer.user
          end
        }
      })
    }
  end

  @doc """
  Generates a new viewer struct and authenticate if token provided.
  """
  def new(token \\ nil) do
    %__MODULE__{token: token, user: %{
      "name" => "Son Tran-Nguyen",
      "picture" => "http://apriliauae.com/wp-content/uploads/2014/04/vespa-girl.jpg",
      "level" => 13,
      "progress" => 0.75
    }}
  end
end