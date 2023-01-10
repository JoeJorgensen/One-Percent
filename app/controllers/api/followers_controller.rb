class Api::FollowersController < ApplicationController
    before_action :set_post, only: [:show, :destroy, :update]

 
 
    #finds all follower in DB
   def index
   render json: Follower.all
   end
 
   #finds specific follower in DB
   def show 
   render json: @follower
   end
 
   #creates a follower in DB
   def create 
     follower = Follower.new(post_params)
     file = params[:file]
     # binding.pry
     # CREATE AN IMAGE TO CLOUDINARY
     #check if we have a file, if we do try to save 
     if file 
         begin
             # try to save img (file) to cloudinary
             # if .env not setup correctly this will fail
             cloud_image = Cloudinary::Uploader.upload(file, public_id: file.original_filename, secure: true, resource_type: :auto)
             # binding.pry
             puts '===cloud_image==='
             puts cloud_image
             follower.image = cloud_image['secure_url']
         rescue => e
             # image did not save to cloudinary
             render json: {errors:e}, status: 422
             # exit function for now
             return
         end
       end
     if(follower.save)
       render json: follower
     else
       render json: {errors: follower.errors.full_messages}, status: 422
     end
 end
 
 #updates a follower in DB (edit)
 def update 
   if(@follower.update(follower_params))
     render json: @follower
   else
     render json: {errors: @follower.errors.full_messages}, status: 422
  end
 end
 
 #deletes a follower in DB
 def destroy 
   render json: @follower.destroy
 end
 
 # def campaign_plus_categories
 #   render json: Campaign.campaign_plus_categories(params[:id])
 # end
 
 private
 #function that allows @follower to find specific campign
 def set_follower
     @follower = Follower.find(params[:id])
 end
 
 def follower_params
   params.permit(:user_id)
 end
end
