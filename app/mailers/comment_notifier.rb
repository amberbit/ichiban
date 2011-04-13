class CommentNotifier < ActionMailer::Base
  def notify_users(comment)
    users = User.receive_comment_notification
    recipients users.map { |user| user.email }
    from "ichiban@ichiban.com"
    subject "New Comment Added"
    body comment: comment
  end
end
