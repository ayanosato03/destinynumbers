class ResultsController < ApplicationController
  def index
    @results = Result.all
    @user = User.new
    @result = Result.new
  end

  def new
    @result = Result.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @result = @user.results.build(result_params)
      if @result.save
      redirect_to '/'
    else
      render :index, status: :unprocessable_entity
    end
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :birthday)
  end

  def result_params
    params.require(:result).permit(:calculation_result)
  end

end
