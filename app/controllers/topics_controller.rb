class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :confirm_user, only: [:edit, :destroy, :update]

  def index
    @topics = Topic.all
  end

  def show
    @comment = @topic.comments.build
    @comments = @topic.comments
  end

  def new
    if params[:back]
      @topic = Topic.new(topics_params)
    else
      @topic = Topic.new
    end
  end

  def edit

  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    respond_to do |format|
      if @topic.save
        format.html { redirect_to topics_path, notice: 'トピックの投稿が完了しました' }
        format.json { render :show, status: :created, location: @topic }
        NoticeMailer.sendmail_topic(@topic).deliver
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'トピックの編集が完了しました' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'トピックの削除が完了しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :content)
    end

    def confirm_user
      if @topic.user_id == current_user.id
      else
        redirect_to topics_path
      end
    end
end
