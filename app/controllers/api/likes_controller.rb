class Api::LikesController < ApplicationController
    before_action :set_post, only: [:show, :destroy, :update]

 
 
    #finds all like in DB
   def index
   render json: Like.all
   end
 
   #finds specific like in DB
   def show 
   render json: @like
   end
 
   #creates a like in DB
   def create 
     like = Like.new(post_params)
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
             like.image = cloud_image['secure_url']
         rescue => e
             # image did not save to cloudinary
             render json: {errors:e}, status: 422
             # exit function for now
             return
         end
       end
     if(like.save)
       render json: like
     else
       render json: {errors: like.errors.full_messages}, status: 422
     end
 end
 
 #updates a like in DB (edit)
 def update 
   if(@like.update(post_params))
     render json: @like
   else
     render json: {errors: @like.errors.full_messages}, status: 422
  end
 end
 
 #deletes a like in DB
 def destroy 
   render json: @like.destroy
 end
 
 # def campaign_plus_categories
 #   render json: Campaign.campaign_plus_categories(params[:id])
 # end
 
 private
 #function that allows @like to find specific campign
 def set_like
     @like = like.find(params[:id])
 end
 
 def like_params
   params.permit(:title, :description, :image, :user_id)
 end
end
