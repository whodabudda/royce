class ImageContainersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_image_container, only: [:update, :edit]

  # GET /image_containers
  # GET /image_containers.json
=begin  def index
    @image_containers = ImageContainer.all
  end
=end
  # GET /image_containers/1
  # GET /image_containers/1.json
=begin  def show
  end
=end
  # GET /image_containers/new
=begin  def new
    @image_container = ImageContainer.new
  end
=end
  # GET /image_containers/1/edit
  def edit
    @pictures = Picture.all
    session[:pictures_to_remove] = []
  end

  # POST /image_containers
  # POST /image_containers.json

=begin  def create
    @image_container = ImageContainer.create!(image_container_params)

    respond_to do |format|
      if @image_container.save
        format.html { redirect_to @image_container, notice: 'Image container was successfully created.' }
        format.json { render :show, status: :created, location: @image_container }
      else
        format.html { render :new }
        format.json { render json: @image_container.errors, status: :unprocessable_entity }
      end
    end
  end
=end
  # PATCH/PUT /image_containers/1
  # PATCH/PUT /image_containers/1.json
  def update
      if params.dig(:image_container, :images).nil?
         Rails.logger.info("Should be redirecting Back with no images")
         return_msg = "No Images Selected"

      end

      #TODO: manage log so output can be turned on and off
      image_container_params.each_key do |k|
        Rails.logger.info("image_container_params keys: #{k} ")
      end
      image_container_params.each_pair do |k,v|
        Rails.logger.info("image_container_params keys & values: #{k} : #{v} ")
      end
      if ! params.dig(:image_container, :images).nil?
        Rails.logger.info("digging 1: #{params.dig(:image_container, :images)}")
        Rails.logger.info("digging 2: #{params.dig(:image_container, :images ).class}")
        images_array = params.dig(:image_container, :images )
        Rails.logger.info("digging 2: #{images_array.length}")
        images_array.each do |i| 
          Rails.logger.info("images_array --
               index:   #{images_array.index(i)} 
   original_filename:   #{i.original_filename} 
             headers:   #{i.headers}
        headers type:   #{i.headers.class}
          ")
        end
      end
      removed_arr = Array.new
      params.dig(:image_container,:images).delete_if do  |i|
        if ActiveStorage::Blob.where(filename: i.original_filename).exists?
         # params.dig(:image_container,:images).delete_at(images_array.index(i))
           removed_arr << i
          Rails.logger.info("Removed from params: #{i.original_filename}")
          true
        end
      end if !params.dig(:image_container,:images).nil?
      if removed_arr.size > 0
        return_msg = "The following files were skipped because they already exist: "
        removed_arr.each do |i|
          return_msg << " #{i.original_filename}"
        end
      end
      #  
      # => We're going to create a Picture record as well for each image we add
      # => add to image_container, so the admin can add annotations in the form
      # => of columns in the Picture table, and have them associated to the image.
      # => to do this, we need to wrap the update and the insert in a transaction.
      #  
      all_ok = true
      if params.dig(:image_container,:images).size ==  0
          Rails.logger.info("No images left to save")
      else
      @image_container.transaction do
        begin
#        updated_container = @image_container.update(image_container_params)
# => TODO:  look at image_container methods to see if there is some way to use the Dirty methods to 
# => get the data rather than making additional queries.

        @image_container.images.attach(params.dig(:image_container,:images))
        Rails.logger.info("Creating Pictures")
        ics = ActiveStorage::Blob.select(:id,:filename).where("id not in (select blob_id from active_storage_attachments where record_type = ?)","Picture")
        ics.each do |blob|
          p = Picture.new
          p[:moniker] = blob.filename
          if p.save
            Rails.logger.info("Saved a new Picture: #{p.id}")

            ActiveStorage::Attachment.insert(
              name: "image",
              record_type: "Picture",
              record_id: p.id,
              blob_id: blob.id,
              created_at: Date.today
            )
          else
            Rails.logger.info("Unable to save a new Picture for image #{i.original_filename}")
          end
        end
        rescue
          raise ActiveRecord::Rollback, "Unable to update the database"
          all_ok = false
        end
      end
      end if !params.dig(:image_container,:images).nil?
    respond_to do |format|
      if all_ok
        format.html { redirect_to edit_image_container_path, notice: "#{return_msg}" }
        format.json { render :show, status: :ok, location: @image_container }
      else
        format.html { render :edit }
        format.json { render json: @image_container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_containers/1
  # DELETE /image_containers/1.json
=begin  def destroy
    @image_container.destroy
    respond_to do |format|
      format.html { redirect_to image_containers_url, notice: 'Image container was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
=end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_container
      @image_container = ImageContainer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_container_params
      params.require(:image_container).permit(:name,images: [])
    end
end
