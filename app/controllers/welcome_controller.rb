class WelcomeController < ApplicationController
  def doc
  end

  def about
  end
  def resize_icons
    gallery = Gallery.find(params[:id])
    gsl = session["gallery_#{gallery.id}_size_level".to_sym]
    gsl = 5 if gsl.nil? 
    direction = params[:direction]
    if direction == "up"
      gsl += 1 unless gsl == 10
    elsif direction == "down"
      gsl -= 1 unless gsl == 1
    end
    session["gallery_#{gallery.id}_size_level".to_sym] = gsl
    Rails.logger.info "WelcomeController:resize_icons gsl is #{gsl} " 
    respond_to do |format|
       format.js { render 'resize_icons.js.erb', locals: {gsl: gsl, gallery: gallery} }
    end
    #redirect_to (:back)
  end
=begin  def gallery_name_filter
    gallery = Gallery.find(params[:id])
    respond_to do |format|
       format.js { render 'gallery_name_filter.js.erb', locals: {gallery: gallery} }
    end
  end
=end  
def gallery_name_filter
    Rails.logger.info "In gallery_name_filter" 
    @gid = params[:id].to_i
    Rails.logger.info "@gid is: #{@gid}" 
    respond_to do |format|
       format.js { render 'gallery_name_filter.js.erb', locals: { gid: @gid} }
    end
    session[:galleries_active].include?(@gid) ? session[:galleries_active].delete(@gid) : session[:galleries_active] << @gid
    Rails.logger.info "Session galleries_active: #{session[:galleries_active]}" 
  end
  

 def modal_image_resize
    respond_to do |format|
       format.js { render 'modal_image_resize.js.erb', locals: {image: params[:image]} }
    end
  end

  def home
    if session[:local_dttm_tz].nil? 
      if params[:local_dttm].nil?
        render :home_local_dttm
      else
        set_local_session_tz
      end
    end
    @galleries = Gallery.all
    Rails.logger.info "WelcomeController:home returning #{@galleries.length} records " 
  end

  def set_local_session_tz
    local_dttm = DateTime.parse(params[:local_dttm])
    session[:local_dttm_tz] = Time.find_zone!(local_dttm.utc_offset.seconds).name
    Rails.logger.info "WelcomeController:set_local_session_tz  " + session.to_hash.to_s

  end

  private
      # Only allow a list of trusted parameters through.
    def gallery_params
      params.require(:id).permit( :id)
    end

end
