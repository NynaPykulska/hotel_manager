class RoomController < ApplicationController
	before_filter :init_items_size_list
    before_filter :authenticate_user!

    def list
         @room = Room.new

         if params[:group] == "all"
            @rooms = Room.all
         elsif params[:group] == "open"
            @rooms = Room.where("is_clean = ?", false)
         else params[:group] == "ready"
   	      @rooms = Room.where("is_clean = ?", true)
         end
   	end

   	def init_items_size_list
	    @items_size_list ||= [Room.all.size, Room.where("is_clean = ?", false).size, Room.where("is_clean = ?", true).size]
	    #                             0                           1                                       2
	end		

end
