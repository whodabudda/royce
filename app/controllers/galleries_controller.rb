class GalleriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_gallery, only: [:show, :edit, :update, :destroy, :smallerIcons,:largerIcons]

  # GET /galleries
  # GET /galleries.json
  def index
    @galleries = Gallery.all
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
  end

  # GET /galleries/new
  def new
    @gallery = Gallery.new
  end

  # GET /galleries/1/edit
  def edit
  end

  def remove_gallery_picture
    GalleryPicture.delete_by(picture_id: params[:picture_id], gallery_id: params[:gallery_id])
    respond_to do |format|
      format.js { render 'remove_gallery_picture.js.html.erb', locals: {picture_id: params[:picture_id], gallery_id: params[:gallery_id]} }
    end
  end
  def add_gallery_pictures
    @picture = Picture.find(params[:picture_id])
    if session[:galleries_active].length > 0
      session[:galleries_active].each do |g|
        if not GalleryPicture.exists?(picture_id: @picture.id, gallery_id: g)
          GalleryPicture.create(picture_id: @picture.id, gallery_id: g)
        end
      end
    end
    respond_to do |format|
      format.js { render 'add_gallery_pictures.js.html.erb', locals: {picture: @picture, gallery_ids: session[:galleries_active]} }
    end
  end

  def manage
    @pictures = Picture.all
    @galleries = Gallery.all
    session[:galleries_active] = []
#    @galleries.each do |g| session[:galleries_active] << g.id end
  end

  def smallerIcons
    #redirect_to (:back)
    respond_to do |format|
       format.js
    end
  end
  def largerIcons
    #redirect_to (:back)
    respond_to do |format|
       format.js
    end
  end
  # POST /galleries
  # POST /galleries.json
  def create
    #@gallery = Gallery.new(gallery_params)
    @gallery = Gallery.create!(gallery_params)
#    @gallery.images.attach(params[:gallery][:images])
    respond_to do |format|
      if @gallery.save
        format.html { redirect_to galleries_path, notice: 'Gallery was successfully updated.' }
        format.json { render :show, status: :created, location: @gallery }
      else
        format.html { render :new }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update

    respond_to do |format|
     if @gallery.update(gallery_params)
        format.html { redirect_to galleries_path, notice: 'Gallery was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery }
     else
        format.html { render :edit }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
     end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to galleries_url, notice: 'Gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gallery_params
      params.require(:gallery).permit( :name, images: [])
    end
    def manage_params
      params.permit( :gallery_id, :picture_id )
    end
end
