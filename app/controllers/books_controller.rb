class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       redirect_to book_path(@book.id), notice: "You have creatad book successfully."
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render "index"
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def show
    @my_book = Book.find(params[:id])
    @book = Book.new
    @user = @my_book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book), notice: "You have updated book successfully."
    else
       render "edit"
    end
  end

  def destroy
  	@book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end