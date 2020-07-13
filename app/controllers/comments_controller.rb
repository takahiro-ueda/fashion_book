class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_coordinate

  def create
    @comment = @coordinate.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html { redirect_to coordinate_path(params[:coordinate_id])  }
        format.json
      end
      # render :index
      flash[:notice] = "コメントしました"
    else
      flash[:notice] = "コメントできませんでした"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    # respond_to do |format|
    #   format.html { redirect_to coordinate_path(params[:coordinate_id]), notice: 'Coordinate was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
    render :index
  end 

  private

    def set_coordinate
      @coordinate = Coordinate.find(params[:coordinate_id])
    end

    def comment_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id, coordinate_id: params[:coordinate_id])
    end
end
