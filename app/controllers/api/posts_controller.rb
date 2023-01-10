class Api::PostsController < ApplicationController
  #defines the CRUD actions before using them
  before_action :set_post, only: [:show, :destroy, :update]

 
 
   #finds all post in DB
  def index
  render json: Post.all
  end

  #finds specific post in DB
  def show 
  render json: @post
  end

  #creates a post in DB
  def create 
    post = Post.new(post_params)
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
            post.image = cloud_image['secure_url']
        rescue => e
            # image did not save to cloudinary
            render json: {errors:e}, status: 422
            # exit function for now
            return
        end
      end
    if(post.save)
      render json: post
    else
      render json: {errors: post.errors.full_messages}, status: 422
    end
end

#updates a post in DB (edit)
def update 
  if(@post.update(post_params))
    render json: @post
  else
    render json: {errors: @post.errors.full_messages}, status: 422
 end
end

#deletes a post in DB
def destroy 
  render json: @post.destroy
end

# def campaign_plus_categories
#   render json: Campaign.campaign_plus_categories(params[:id])
# end

private
#function that allows @post to find specific campign
def set_post
    @post = Post.find(params[:id])
end

def post_params
  params.permit(:title, :description, :image, :user_id)
end
end
