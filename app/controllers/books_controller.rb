class BooksController < ApplicationController
   def index
    @books = Book.page(params[:page]).reverse_order
     @book = Book.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
      if @book.save
        redirect_to book_path(@book.id), notice: "New book has been created successfully."
      else
        @books =  Book.page(params[:page]).reverse_order
        render :index
      end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "The  has been updated successfully."
    else
      render :edit
    end
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy!
      redirect_to books_path, notice: "The book has been deleted successfully."
    else
      @book = Book.find(params[:id])
      render :show
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
