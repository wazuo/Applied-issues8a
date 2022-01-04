class SerchesController < ApplicationController
    before_action :authenticate_user!
    
    def serch
        @model = params[:model]
        @content = params[:content]
        @method = params[:method]
        if @model == 'user'
            @records = User.serch_for(@content,@method)
        else
            @records = Book.serch_for(@content,@method)
        end
    end
end
