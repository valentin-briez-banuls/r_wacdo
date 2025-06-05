class ApplicationController < ActionController::Base
  before_action :authenticate_collaborateur!
end
