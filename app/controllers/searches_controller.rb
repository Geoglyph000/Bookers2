class SearchesController < ApplicationController

  def search
    @model = params[:search][:model]
    @content = params[:content]
    @method = params[:search][:how]
    if @model == 'user'
      @records = User.search_for(@content, @method)
    else
      @records = Book.search_for(@content, @method)
    end
    # p @method
    # binding.pry
  end
end
