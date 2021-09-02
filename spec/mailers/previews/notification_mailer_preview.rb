# frozen_string_literal: true

class NotificationMailerPreview < ActionMailer::Preview
  def notify_admin
    app_user_content = AppUserContent.first_or_create

    NotificationMailer.notify_admin(app_user_content)
  end

  def business_account_outdated
    user = User.first

    NotificationMailer.business_account_outdated(user)
  end
end
