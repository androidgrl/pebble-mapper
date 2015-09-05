class DirectionController < ApplicationController
  def show
    latlon = params[:latlon].split(",")
    lat = latlon[0]
    lon = latlon[1]
    puts latlon
    client = Hurley::Client.new
    response = client.get("https://maps.googleapis.com/maps/api/directions/json?mode=bicycling&origin=#{lat},#{lon}&destination=835+Walnut+Street+Boulder+CO&key=#{Figaro.env.google_key}")
    parsed = JSON.parse(response.body)
    #direction = parsed["routes"][0]["legs"][0]["steps"][0]["html_instructions"]
    direction = parsed["routes"][0]["legs"][0]["steps"]
    render json: direction
    #if direction[/left/]
      #render json: "left"
    #elsif direction[/right/]
      #render json: "right"
    #else
      #render json: "center"
    #end
  end
end
