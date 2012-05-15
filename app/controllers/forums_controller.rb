class ForumsController < ApplicationController
  caches_page :index, :show

  def index
    @forums = Forum.order('updated_at DESC')
    @message = Message.new
  end

  def new
    @forum = Forum.new
    @message = Message.new
  end

  def create
    @forum = Forum.new(params[:forum])
    @message = @forum.messages.build(params[:message])
    @message.name = session[:nickname]
    if @forum.save
      redirect_to @forum
    else
      render 'new'
    end
  end

  def show
    @forum = Forum.find(params[:id])
    @messages = @forum.messages.filtered(@forum, params[:filter])
    @message = Message.new
  end
end
