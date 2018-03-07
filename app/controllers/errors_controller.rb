# Basic error handling for the application
class ErrorsController < ApplicationController
  def not_found
    render json: {
      status: 404,
      error: :not_found,
      message: 'Where did the 403 errors go'
    }, status: 404
  end

  def match_all
    render template: 'errors/match_all', status: 404
  end
end
