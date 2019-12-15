class SightingsController < ApplicationController
    def show
        sighting = Sighting.find_by(id:params[:id])
        #👇to send entire "raw" data, with bird and location ids:
        # render json: sighting

        #👇to send  nested objects data:
        # render json: {id: sighting.id, bird: sighting.bird, location: sighting.location}
        
        #👇using 'include', an alternative to render nested objects data:
=begin
    all attributes of included objects will be listed by default. 
    Using 'include:' also works fine when dealing with an action that renders an array,
    SEE def index  
=end 
        # render json: sighting, include: [:bird, :location]

        #👇pull it all together with some error handling:
        if sighting
            # render json: sighting, include: [:bird, :location], except: [:updated_at, :created_at]
        #👆 verbose way to remove all instances of ':created_at' and ':updated_at' from the nested bird and location data:
    
=begin
        render json: sighting.to_json(:include =>{
            :bird => {:only => [:name, :species]},
            :location => {:only => [:latitude, :longitude]},
        }, :except => [:updated_at, :created_at])  
=end
        else
            render json: {message: "No sighting found with that id"}
        end 




    end 

    def index 
        sightings = Sighting.all
        #'inclue' is also an attribute of 'to_json'. as:
        #render json: sightings.to_json(inclue: [:bird, :location])
        render json: sighting, include: [:bird, :location]
    end
end
