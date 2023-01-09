class Api::CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :destroy, :update]

 
 
    #finds all comment in DB
   def index
   render json: Comment.all
   end
 
   #finds specific comment in DB
   def show 
   render json: @comment
   end
 
   #creates a comment in DB
   def create 
     comment = Comment.new(comment_params)
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
             comment.image = cloud_image['secure_url']
         rescue => e
             # image did not save to cloudinary
             render json: {errors:e}, status: 422
             # exit function for now
             return
         end
       end
     if(comment.save)
       render json: comment
     else
       render json: {errors: comment.errors.full_messages}, status: 422
     end
 end
 
 #updates a comment in DB (edit)
 def update 
   if(@comment.update(comment_params))
     render json: @comment
   else
     render json: {errors: @comment.errors.full_messages}, status: 422
  end
 end
 
 #deletes a comment in DB
 def destroy 
   render json: @comment.destroy
 end
 
 # def campaign_plus_categories
 #   render json: Campaign.campaign_plus_categories(params[:id])
 # end
 
 private
 #function that allows @comment to find specific campign
 def set_comment
     @comment = comment.find(params[:id])
 end
 
 def comment_params
   params.permit(:title, :description, :image, :user_id)
 end
end
