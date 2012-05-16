class MessagesController < ApplicationController
  respond_to :html, :json

  def create
    @forum = Forum.find(params[:forum_id])
    @message = @forum.messages.build(params[:message])
    @message.name = session[:nickname]
    if @message.save
      respond_with do |format|
        format.html do
          if request.xhr?
            render @message
          else
            redirect_to "/forums/#{@forum.id}/#{@message.position}-"
          end
        end
      end
    else
      respond_with do |format|
        format.html do
          if request.xhr?
            render :json => @message.errors, :status => :unprocessable_entity
          else
            render
          end
        end
      end
    end
  end
end
