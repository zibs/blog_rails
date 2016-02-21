class RecentCommentsReportJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    recent_comments = Comment.where(["created_at >= ?", 1.day.ago])
    users_with_new_comments = Hash.new { |h, k| h[k] = [] }
      recent_comments.each do |comment|
        users_with_new_comments[comment.post.user] << comment
      end
      users_with_new_comments.each do |user, comments|
      PostsMailer.comment_counter_post_owner(comments).deliver_later
    end
  end
end
