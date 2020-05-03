class NotificationController < ApplicationController

  def item_subscribe_mailer(item)
    ItemSubscribeAlertMailer.with(item).item_available_email
  end

end
