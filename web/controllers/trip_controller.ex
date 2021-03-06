defmodule BsnWeb.TripController do
  use BsnWeb.Web, :controller
  alias BsnWeb.Backend

  def get_all_stops(conn, %{"id"=>trip_id}) do
    stops = Backend.retrieve(%{"id"=>trip_id}, %{type: "Stop"}, nil)
    render(conn, "get_all_stops.json", stops: stops)
  end

  def get_all_routes(conn, %{"id"=>trip_id}) do
    routes = Backend.retrieve(%{"id" => trip_id}, %{type: "Route"}, nil)
    render(conn, "get_all_routes.json", routes: routes)
  end

  def show(conn, %{"id"=>trip_id})do
    trip = Backend.retrieve(nil, %{type: "Trip", id: trip_id}, nil)
    render(conn, "show.json", tripdetail: trip)
  end

  def get_members(conn, %{"id"=>trip_id}) do
    members=Backend.retrieve(%{"id" => trip_id}, %{type: "Member"}, nil)
    render(conn, "get_members.json", members: members)
  end
  def update_member_location(conn, %{"member_id"=>member_id, "lat"=>lat, "lng"=>lng}) do
    response=Backend.retrieve(%{type: "MemberLocation", member_id: member_id, lat: lat, lng: lng}, nil)
    json conn, response
  end
  def add_stop(conn, %{"name"=>name, "address"=>address, "arrive"=>arrive,"departure"=>departure, "order"=>order,"lat"=>lat, "lng"=>lng, "description"=>description, "tripid"=>trip_id,"route_name"=>route_name, "route_duration"=>route_duration, "route_distance"=>route_distance, "route_mode"=>route_mode, "route_polyline"=>route_polyline}) do
    response=Backend.retrieve(%{id: trip_id}, %{type: "AddStop", name: name, address: address, arrive: arrive, departure: departure, order: order, lat: lat, lng: lng, description: description, route_name: route_name, route_duration: route_duration, route_distance: route_distance, route_mode: route_mode, route_polyline: route_polyline}, nil)
    json conn, response
  end
  def add_stop_edit_route(conn, %{"name"=>name, "duration"=>duration, "distance"=>distance, "stop_order"=>stop_order, "tripid"=>trip_id}) do
    response=Backend.retrieve(%{id: trip_id}, %{type: "EditRoute", name: name, duration: duration, distance: distance, stop_order: stop_order})
    json conn, response
  end
  def add_stop_update_order(conn, %{"tripid"=>trip_id, "new_stop_order"=>new_stop_order}) do
    response=Backend.retrieve(%{id: trip_id}, %{new_stop_order: new_stop_order})
    json conn, response
  end
  def create(conn, %{"form-start-address"=>start_address,"start-lat"=>start_lat, "start-lng"=>start_lng,"form-end-address"=>end_address,"end-lat"=>end_lat, "end-lng"=>end_lng, "form-trip-name"=>trip_name,"start-date-ms"=>start_date, "end-date-ms"=>end_date, "form-estimate-cost"=>estimated_cost, "form-estimate-members"=>estimated_members,"holder-id"=>holder_id, "form-mode"=>mode,"route-name"=>route_name, "route-duration"=>route_duration, "route-distance"=>route_distance, "route-polyline"=>route_polyline}) do
    response=Backend.retrieve(%{holder_id: holder_id}, %{type: "TripNew", start_address: start_address, start_lat: start_lat, start_lng: start_lng, end_address: end_address,end_lat: end_lat, end_lng: end_lng, trip_name: trip_name, start_date: start_date, end_date: end_date, estimated_cost: estimated_cost, estimated_members: estimated_members, mode: mode, route_name: route_name, route_duration: route_duration, route_distance: route_distance, route_polyline: route_polyline}) 
    trip_id=Map.get(Enum.at(response,0), "trip_id")
    redirect conn, to: "/trips/#{trip_id}"
  end
  def edit_trip_detail(conn, %{"trip_id"=>trip_id, "trip_name"=>trip_name, "start_date"=>start_date, "end_date"=>end_date, "description"=>description, "estimated_cost"=>estimated_cost, "estimated_members"=>estimated_members, "cost_detail"=>cost_detail, "off_time"=>off_time, "off_place"=>off_place, "necessary_tool"=>necessary_tool, "note"=>note, "status"=>status}) do
    response=Backend.update(nil, %{type: "Trip", id: trip_id, trip_name: trip_name, start_date: start_date, end_date: end_date, description: description, estimated_cost: estimated_cost, estimated_members: estimated_members, cost_detail: cost_detail, off_time: off_time, off_place: off_place, necessary_tool: necessary_tool, note: note, status: status}, nil)
    json conn, response
  end
  def edit_route(conn, %{"stop_id"=>stop_id, "route_duration"=>route_duration, "route_description"=>route_description}) do
    response=Backend.retrieve(%{id: stop_id}, %{type: "UpdateRoute", route_duration: route_duration, route_description: route_description}, nil)
    json conn, response;
  end
  def edit_stop(conn, %{"stop_id"=>stop_id, "stop_name"=>name, "stop_arrive"=>arrive, "stop_departure"=>departure, "stop_description"=>description, "stop_address"=>address, "stop_lat"=>lat, "stop_lng"=>lng}) do
    response=Backend.retrieve(%{id: stop_id},%{ type: "UpdateStop", name: name, arrive: arrive, departure: departure, description: description, address: address, lat: lat, lng: lng}, nil)
    json conn, response
  end
  def edit_arrive_departure_stop(conn, %{"stop_id"=>stop_id, "stop_arrive"=>arrive, "stop_departure"=>departure}) do
    response=Backend.retrieve(%{id: stop_id},%{ type: "UpdateArriveDepartureStop", arrive: arrive, departure: departure}, nil)
    json conn, response
  end
  def edit_trip_start_date(conn, %{"id"=>trip_id, "start_date"=> start_date}) do
    response=Backend.retrieve(%{id: trip_id}, %{ type: "UpdateTripStartDate", start_date: start_date})
    json conn, response
  end
  def edit_trip_end_date(conn, %{"id"=>trip_id, "end_date"=> end_date}) do
    response=Backend.retrieve(%{id: trip_id}, %{ type: "UpdateTripEndDate", end_date: end_date})
    json conn, response
  end
  def get_trips_near_user(conn, %{"user_id"=>user_id}) do
    trips=Backend.retrieve(%{id: user_id}, %{type: "ViewTripsList"})
    render(conn, "get_trips_near_user.json", trips: trips)
  end
    def get_trips_new(conn, %{"user_id"=>user_id}) do
    trips=Backend.retrieve(%{id: user_id}, %{type: "ViewTripsListNew"})
    render(conn, "get_trips_new.json", trips: trips)
  end
    def get_trips_finish(conn, %{"user_id"=>user_id}) do
    trips=Backend.retrieve(%{id: user_id}, %{type: "ViewTripsListFinish"})
    render(conn, "get_trips_finish.json", trips: trips)
  end
    def get_trips_near_province(conn, %{"province"=>province}) do
    trips=Backend.retrieve(%{province: province}, %{type: "ViewTripsListProvince"})
    render(conn, "get_trips_near_province.json", trips: trips)
  end
  #   def get_trips_finish(conn, %{"user_id"=>user_id}) do
  #   trips=Backend.retrieve(%{id: user_id}, %{type: "ViewTripsListFinish"})
  #   render(conn, "get_trips_finish.json", trips: trips)
  # end
  def get_my_trips(conn, %{"user_id"=>user_id}) do
     trips=Backend.retrieve(%{id: user_id}, %{type: "ViewMyTrips"})
    render(conn, "get_my_trips.json", trips: trips)
  end
  def find_trip(conn, %{"user_id"=>user_id, "location"=>location, "start_date"=>start_date, "end_date"=>end_date}) do
    trips=Backend.retrieve(%{type: "FindTrip", user_id: user_id, location: location, start_date: start_date, end_date: end_date})
    render(conn, "find_trip.json", trips: trips)
  end
  def edit_route_mode(conn, %{"id"=>stop_id, "mode"=>route_mode, "distance"=>route_distance, "duration"=>route_duration, "arrive"=>stop_arrive, "departure"=>stop_departure}) do
    response=Backend.update(%{type: "Mode", stop_id: stop_id, route_mode: route_mode, route_distance: route_distance, route_duration: route_duration, stop_arrive: stop_arrive, stop_departure: stop_departure})
    json conn, response;
  end
  def get_stop_images(conn, %{"id"=>trip_id}) do
    images=Backend.retrieve(%{type: "StopImages", trip_id: trip_id})
    render(conn, "get_stop_images.json", images: images)
  end
  def delete_stop(conn, %{"trip_id"=>trip_id, "stop_id"=>stop_id}) do
    response= Backend.delete(%{type: "Stop", trip_id: trip_id, stop_id: stop_id})
    json conn, response
  end
end
