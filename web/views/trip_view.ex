defmodule BsnWeb.TripView do
    use BsnWeb.Web, :view
  def render("get_all_stops.json", %{stops: stops}) do
  %{stops: stops}
 end
 def render("show.json", %{tripdetail: tripdetail}) do
   %{tripdetail: tripdetail}
 end
 def render("get_members.json", %{members: members}) do
   %{members: members}
 end
 def render("get_all_routes.json", %{polylines: routes}) do 
 	%{routes: routes}
 end
 def render("get_trips_near_user.json", %{trips: trips}) do
 	%{trips: trips}
 end
  def render("get_trips_new.json", %{trips: trips}) do
 	%{trips: trips}
 end
 #   def render("get_trips_new.json", %{trips: trips}) do
 # 	%{trips: trips}
 # end
  def render("get_trips_finish.json", %{trips: trips}) do
 	%{trips: trips}
 end
  def render("get_trips_near_province.json", %{trips: trips}) do
 	%{trips: trips}
 end
 def render("find_trip.json", %{trips: trips}) do
 	%{trips: trips}
 end
 def render("get_my_trips.json", %{trips: trips}) do
  	%{trips: trips}
 end 
 def render("get_stop_images.json", %{images: images}) do
 	%{images: images}
 end

end
