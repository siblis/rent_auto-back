# Дефолтный мейлер для отправки писем администратору проката
class AdminMailer < ApplicationMailer
  def request_email
    @parameters = params[:parameters]
    mail(to: ENV['ADMIN_EMAIL'], subject: I18n.t('mailer.subjects.request'))
  end
end
