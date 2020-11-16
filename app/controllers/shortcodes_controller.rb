class ShortcodesController < ApplicationController
    protect_from_forgery with: :null_session

    def index
        @shortcodes = Shortcode.all.order('popularity DESC')
        render json: @shortcodes
    end

    def top100
        @shortcodes = Shortcode.all.order('popularity DESC').limit(100)
        render json: @shortcodes
    end

    def show
        @shortcode = Shortcode.find(params[:id])
        render json: @shortcode
    end

    def goto
        @shortcode = Shortcode.find_by(short_url: params[:short_url])
        if(@shortcode != nil)
            @shortcode.increment!(:popularity,1)
            if(@shortcode.save)
            # render plain: params[:short_url]
                redirect_to @shortcode.original_url
            else
                render json: {errors: @shortcode.errors.full_messages}, status: 404
            end
        else
            @shortcode = Shortcode.new
            render json: {errors: @shortcode.errors.full_messages}, status: 404
        end
    end

    def new
        @shortcode = Shortcode.new
    end

    def create
        @shortcode = Shortcode.new(shortcode_params)
        @shortcode.get_short_url
        @shortcode.popularity = 1
        if(@shortcode.save)
            UpdateTitleJob.perform_later @shortcode.id
            render json: @shortcode
        else
            render json: {errors: @shortcode.errors.full_messages}
        end
    end

    private def shortcode_params
        params.permit(:original_url)
    end

end
