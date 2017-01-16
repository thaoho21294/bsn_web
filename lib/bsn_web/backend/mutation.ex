defmodule BsnWeb.Backend.Mutation do
  @moduledoc """
  Contains various mutations used.
  """
  alias GraphQL.{Type, Relay}
  alias Relay.{Connection, Mutation}

  alias BsnWeb.Backend
  alias Backend.Schema.{Trip}
  
  @doc """
  A mutation to create a trip.
  """
  def create_trip() do
    %{
      name: "CreateTrip",
      input_fields: %{
        name: %{type: %Type.NonNull{ofType: %Type.String{}}},
        description: %{type: %Type.String{}}
      },
      output_fields: %{
        # tripEdge: %{
        #   type: Trip.connection[:edge_type],
        #   resolve: fn(trip, _args, _info) ->
        #     IO.inspect(trip)
        #     %{
        #       cursor: Connection.List.cursor_for_object_in_connection(trip),
        #       node: trip
        #     }
        #   end
        # }
        trip: %{
          type: Trip.type,
          resolve: fn(trip, _args, _context) ->
            trip
          end
        }
      },
      mutate_and_get_payload: fn(input, context) ->
        input
        |> Backend.create(context)
      end
    } |> Mutation.new
  end

  def create_token() do
    %{
      name: "CreateToken",
      input_fields: %{
        username: %{type: %Type.NonNull{ofType: %Type.String{}}},
        password: %{type: %Type.NonNull{ofType: %Type.String{}}}
      },
      output_fields: %{
        token: %{
          type: %Type.String{},
          resolve: fn(user, _args, _context) ->
            user["token"]
          end
        }
      },
      mutate_and_get_payload: fn(input, context) ->
        Backend.retrieve(nil, Map.put(input, :type, "User"), context)
        || %{}
      end
    } |> Mutation.new
  end
end