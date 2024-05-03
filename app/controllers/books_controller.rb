class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :show, :destroy]

  # GET /books
  def index
    @books = Book.all
    @books = @books.where(year: params[:year]) if params[:year].present?
    @books = @books.where(month: params[:month]) if params[:month].present?
  end

  # GET /books/:id
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # POST /books
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

  # GET /books/:id/edit
  def edit
  end

  # PATCH/PUT /books/:id
  def update
    if @book.update(book_params)
      flash[:notice] = "家計簿にデータを更新しました"
      redirect_to books_path
    else
      flash.now[:alert] = "家計簿更新に失敗しました"
      render :edit
    end
  end

  # DELETE /books/:id
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
