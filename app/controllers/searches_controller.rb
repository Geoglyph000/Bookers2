class SearchesController < ApplicationController

  def search
    @model = params[:model]
    @value = params[:content]
    @method = params[:method]
    if @model == 'user'
      @records = User.search_for(@content, @method)
    else
      @records = Book.search_for(@content, @method)
    end
  end
end
