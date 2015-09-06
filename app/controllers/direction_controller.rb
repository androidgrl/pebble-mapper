class DirectionController < ApplicationController
  def show
    latlon = params[:latlon].gsub("p",".").split("&")
    lat = latlon[0]
    lon = latlon[1]
    client = Hurley::Client.new
    response = client.get("https://maps.googleapis.com/maps/api/directions/json?mode=bicycling&origin=#{lat},#{lon}&destination=835+Walnut+Street+Boulder+CO&key=#{Figaro.env.google_key}")
    parsed = JSON.parse(response.body)
    first_direction = parsed["routes"][0]["legs"][0]["steps"][0]["distance"]
    first_distance = first_direction["value"].to_i
    if first_distance < 50
      second_direction = parsed["routes"][0]["legs"][0]["steps"][1]["html_instructions"]
      if second_direction[/left/]
        render json: { direction: "left", distance: first_distance }.to_json
      elsif second_direction[/right/]
        render json: { direction: "right", distance: first_distance }.to_json
      end
    else
      render json: { direction: "center", distance: first_distance }.to_json
    end
  end
end
