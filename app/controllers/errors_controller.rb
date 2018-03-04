class ErrorsController < ApplicationController
  def not_found
    render json: {
      status: 404,
      error: :not_found,
      message: 'Where did the 403 errors go'
    }, status: 404
  end

  def match_all
    puts 'NO SUCH ROUTE'
  end
end
