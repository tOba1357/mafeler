class HomeController < ApplicationController
  skip_before_action :logged_in_user
  def index
  end
end