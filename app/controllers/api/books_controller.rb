class Api::BooksController < ApplicationController
  before_action :set_book, only: [:show]
  def index
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      created_json("Book created success")
    else
      model_error_json(@book.errors)
    end
  end

  def show; end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    # params.permit(:title, :description)
    params.require(:book).permit(:title, :description)
  end
end
