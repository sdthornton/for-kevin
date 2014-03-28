class HomeController < ApplicationController
  def index
    @haircuts = Haircut.random(4)
  end

  def about

  end
end
