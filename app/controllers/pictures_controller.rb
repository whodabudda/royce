class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy,:modal_picture_annotate, :toggle_selection]
  before_action :authenticate_admin!
  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  #deletes the blob and its associated attachements, picture records, and gallery assignments
 def remove
  if !session[:pictures_to_remove].nil?
    session[:pictures_to_remove].each do |p| 
      blob_id = Picture.find(p).image.blob_id
      ActiveStorage::Attachment.where(blob_id: blob_id).each do |i| i.purge end
      GalleryPicture.delete_by(picture_id: p)
      Picture.delete_by(id: p)
    end
    session[:pictures_to_remove] = []
  end
  @pictures = Picture.all
  respond_to do |format|
    format.html { redirect_back fallback_location: edit_image_container_path(1)}
  end
 end
 def toggle_selection
    Rails.logger.info "In toggle_selection" 
    @pic_id = params[:id].to_i
    Rails.logger.info "@pic_id is: #{@pic_id}" 

    #session variable is initialized in image_containers_controller#edit, which is the
    #action that launches the add/remove pictures
    session[:pictures_to_remove].include?(@pic_id) ? session[:pictures_to_remove].delete(@pic_id) : session[:pictures_to_remove] << @pic_id
    Rails.logger.info "Session galleries_active: #{session[:pictures_to_remove]}" 

    respond_to do |format|
       format.js 
    end
  end

 def modal_picture_annotate
    respond_to do |format|
       format.js 
    end
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      #@picture.picture.attach(picture_params[:picture])
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constrainuser.avatar.attach(params[:avatar])ts between actions.
    def set_picture
      @picture = Picture.find(params[:id])
      #set_picture_attachment
    end

    def set_picture_attachment
      if ! params[:picture].nil?
        @picture.picture.attach(params[:picture])
      end
    end

    # Only allow a list of trusted parameters through.
    def picture_params
      params.require(:picture).permit(:picture, :created_on_date, :title, :moniker, :comment)
    end
end
