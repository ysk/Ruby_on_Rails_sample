class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :show, :destroy]

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "家計簿にデータを登録しました"
      redirect_to books_path
    else
      flash.now[:alert] = "家計簿登録に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "家計簿にデータを更新しました"
      redirect_to books_path
    else
      flash.now[:alert] = "家計簿更新に失敗しました"
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:notice] = "削除しました"
    else
      flash[:alert] = "削除に失敗しました"
    end
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:year, :month, :inout, :category, :amount)
  end
end
