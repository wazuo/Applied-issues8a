class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
      render "index"
    else
      @book_comment = @comment
      @booknew = Book.new
      render "error"
    end
  end

  def destroy
    BookComment.find_by(id: params[:id]).destroy
    @book = Book.find(params[:book_id])
    render "index"
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end
