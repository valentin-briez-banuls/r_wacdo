class PostsController < ApplicationController
  def index
    Rails.logger.debug "current_collaborateur = #{current_collaborateur.inspect}"
    # ton code habituel ici
  end
end
