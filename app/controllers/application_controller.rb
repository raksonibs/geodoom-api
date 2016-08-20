class ApplicationController < ActionController::API
  def index
    render text: "Red Green API"
  end
end
