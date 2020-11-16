class ShortcodesController < ApplicationController
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
        @shortcode = Shortcode.find_by!(short_url: params[:short_url])
        @shortcode.increment!(:popularity,1)
        if(@shortcode.save)
        # render plain: params[:short_url]
            redirect_to @shortcode.original_url
        else
            render 'new'
        end
    end

    def new
        @shortcode = Shortcode.new
        render error: {message: @shortcode.errors.full_messages.each}, status: 400
    end

    def create
        @shortcode = Shortcode.new(shortcode_params)
        @shortcode.short_url
        @shortcode.popularity = 1
        if(@shortcode.save)
            render json: @shortcode
        else
            render 'new'
        end
    end

    private def shortcode_params
        params.require(:shortcode).permit(:original_url)
    end

end
