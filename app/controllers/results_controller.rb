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
    return unless @user.save

    @result = @user.results.build(result_params)
    if @result.save
      redirect_to '/'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @fortune_number = params[:id].to_i

    # 1〜9, 11, 22, 33 の範囲外は404エラーにする
    unless (1..9).include?(@fortune_number) || [11, 22, 33].include?(@fortune_number)
      render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
    end

    render template: "results/result#{@fortune_number}"
  end

  private

  def user_params
    params.require(:user).permit(:name, :birthday, results_attributes: [:calculation_result])
  end

  def result_params
    params.require(:result).permit(:calculation_result)
  end
end
