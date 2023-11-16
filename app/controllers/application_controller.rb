class ApplicationController < ActionController::Base

      def show_content_params
        @filtro = params[:filtro]
      end
end
