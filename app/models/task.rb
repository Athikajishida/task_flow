class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :status, inclusion: { in: ['pending', 'in_progress', 'completed'] }

  after_create_commit { broadcast_task('created') }
  after_update_commit { broadcast_task('updated') }
  after_destroy_commit { broadcast_task('destroyed') }

  private

  def broadcast_task(action)
    ActionCable.server.broadcast("task_channel_#{user_id}", {
      action: action,
      task: self
    })
  end
end
