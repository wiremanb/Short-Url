class ShortcodesController < ApplicationController
    def index
        @shortcodes = Shortcode.all
    end

    def show
        @shortcode = Shortcode.find(params[:id])
    end

    def goto
        @shortcode = Shortcode.find_by!(short_url: params[:short_url])
        # render plain: params[:short_url]
        redirect_to @shortcode.original_url
    end

    def new
        @shortcode = Shortcode.new
    end

    def create
        @shortcode = Shortcode.new(shortcode_params)
        @shortcode.short_url
        if(@shortcode.save)
            redirect_to @shortcode
        else
            render 'new'
        end
    end

    private def shortcode_params
        params.require(:shortcode).permit(:original_url)
    end

end
