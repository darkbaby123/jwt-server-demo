class HomeController < ApplicationController
  def index
    render json: {data: 'Hello World'}
  end
end
