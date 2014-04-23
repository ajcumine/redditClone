class VotesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @votes = @post.votes.new direction: params[:direction]
    @votes.user = current_user
    if @votes.save
      render json: {vote_count: @post.vote_count}
    end 
  end

end
