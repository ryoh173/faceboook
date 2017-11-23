class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :destroy, :update, :show]
  # コメントを保存、投稿するためのアクションです。
  def create
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    # @notification = @comment.notifications.build(user_id: @topic.user.id )
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def index
    @topics = Topic.all
  end

  def show

 end

 def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to topic_path(@comment.topic), notice: "コメントを編集しました"
  end

 def destroy
   @comment = Comment.find(params[:id])
   @topic = @comment.topic
   respond_to do |format|
     if @comment.destroy
       format.html { redirect_to topic_path(@topic), notice: 'コメントを削除しました。' }
       format.js { render :index }
     else
       format.html { render :new }
     end
   end
 end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
    def set_comment
      #ブログのどのコメントの情報かを取得する
      @comment = Comment.find(params[:id])
    end
end
