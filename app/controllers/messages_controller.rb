class MessagesController < ApplicationController
  def new
  end

  def create
    @forum = Forum.find(params[:forum_id])
    @message = @forum.messages.build(params[:message])
    @message.name = session[:nickname]
    redirect_to "/forums/#{@forum.id}/#{@message.position}-" if @message.save
  end
end
