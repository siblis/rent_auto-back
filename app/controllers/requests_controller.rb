# Контроллер заявок (запросов) на аренду
class RequestsController < ApplicationController
  # POST /requests
  # POST /requests.json
  def create
    # rp - request parameters
    rp = Hashie::Mash.new(params)
    AdminMailer.with(parameters: rp).request_email.deliver_now
  end
end
