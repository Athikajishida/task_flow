class TaskChannel < ApplicationCable::Channel
  def subscribed
    stream_from "task_channel_#{params[:user_id]}"
  end
end
