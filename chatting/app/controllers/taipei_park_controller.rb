class TaipeiParkController < ApplicationController

  def park

    @parks = Park.all
  end

end
