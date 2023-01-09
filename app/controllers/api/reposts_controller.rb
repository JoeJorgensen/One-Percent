class Api::RepostsController < ApplicationController
    before_action :set_post, only: [:show, :destroy, :update]

 
 
    #finds all repost in DB
   def index
   render json: Repost.all
   end
 
   #finds specific repost in DB
   def show 
   render json: @repost
   end
 
   #creates a repost in DB
   def create 
     repost = Repost.new(post_params)
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
             repost.image = cloud_image['secure_url']
         rescue => e
             # image did not save to cloudinary
             render json: {errors:e}, status: 422
             # exit function for now
             return
         end
       end
     if(repost.save)
       render json: repost
     else
       render json: {errors: repost.errors.full_messages}, status: 422
     end
 end
 
 #updates a repost in DB (edit)
 def update 
   if(@repost.update(post_params))
     render json: @repost
   else
     render json: {errors: @repost.errors.full_messages}, status: 422
  end
 end
 
 #deletes a repost in DB
 def destroy 
   render json: @repost.destroy
 end
 
 # def campaign_plus_categories
 #   render json: Campaign.campaign_plus_categories(params[:id])
 # end
 
 private
 #function that allows @repost to find specific campign
 def set_repost
     @repost = repost.find(params[:id])
 end
 
 def repost_params
   params.permit(:title, :description, :image, :user_id)
 end
end
