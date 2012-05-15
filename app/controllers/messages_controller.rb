class MessagesController < ApplicationController
  def create
    @forum = Forum.find(params[:forum_id])
    @message = @forum.messages.build(params[:message])
    @message.name = session[:nickname]
    if @message.save
      redirect_to "/forums/#{@forum.id}/#{@message.position}-"
    end
  end
end
