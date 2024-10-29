class UrlsController < ApplicationController
  protect_from_forgery except: :create 

  def create
    @url = Url.find_or_initialize_by(original_url: url_params[:original_url])

    if @url.new_record?
      @url.assign_attributes(url_params)
      @url.save
    end

    if @url.persisted?
      render json: { short_url: url_short_link(@url) }, status: :created
    else
      render json: { errors: @url.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @url = Url.find_by(short_url: params[:short_url])

    if @url
      @url.increment_access_count  # Increment access count when the URL is accessed
      redirect_to @url.original_url
    else
      render plain: "URL not found", status: :not_found
    end
  end

  def top
    @urls = Url.order(access_count: :desc).limit(100)  # Get top 100 URLs by access count
    render json: @urls.as_json(only: [:original_url, :short_url, :access_count, :title])
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end

  def url_short_link(url)
    "#{request.base_url}/#{url.short_url}"
  end
end
