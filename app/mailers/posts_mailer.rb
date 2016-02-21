class PostsMailer < ApplicationMailer

  def notify_post_owner(comment)
    @comment = comment
    @post = comment.post
    @owner = @post.user
    mail(to: @owner.email, subject: "A Comment Appears!")
  end

  def comment_counter_post_owner(comments)
    @comments = comments
    @owner = @comments[0].post.user
    mail(to: @owner.email, subject: "Quotidian Commentary")
  end


end
