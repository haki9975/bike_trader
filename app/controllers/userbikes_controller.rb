class UserbikesController < ApplicationController
    before_action :redirect_if_not_logged_in
  
    def index
        @ubikes = current_user.userbikes
    end

    def new         
        @bike = Userbike.new
    end

    def create 
        
        @bike = Userbike.create!(userbike_params)        
        if @bike.persisted?
          flash[:message] = "Bike Information Saved!"
          redirect_to userbike_path(@bike)
        else
          flash[:message] = "Bike Information Could Not Be Saved, Check Parameters."
          redirect_to new_userbike_path
        end
    end


    def show
        @bike = Userbike.find_by_id(params[:id])
    end

    def update 
        @bike = Userbike.find_by_id(params[:id])
        @bike.update_attribues(params[:bikes])
        redirect_to bike_path(@bike)
    end

    def destroy
        @bike = Userbike.find_by_id(params[:id])
        @bike.destroy
        redirect_to new_userbike_path
    end




    private
     def userbike_params
        params.require(:userbike).permit(:id, :name, :notes, :user_id, :bike_id, :serial_number)
     end
end