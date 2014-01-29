class VotesController < ApplicationController
  before_filter :setup

  def up_vote
    update_vote(1)
    redirect_to :back
  end

  def down_vote
    update_vote(-1)
    redirect_to :back
  end

  private

  def setup
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    authorize! :create, Vote, message: "You need to be a user to vote."

    @vote = @post.votes.where(user_id: current_user.id).first
  end

  def update_vote(new_value)
     if @vote # If the vote exists, update it
      @vote.update_attribute(:value, new_value)
    else # Create the vote if it does not exist
      @vote = current_user.votes.create(value: 1, post: @post)
    end
  end

end