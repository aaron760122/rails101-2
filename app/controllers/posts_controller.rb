class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create]

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end


  def new
    @group = Group.find(params[:group_id])
    if !current_user.is_member_of?(@group)
      flash[:alert] = "先加入讨论版才能Write a Post!"
      redirect_to group_path(@group)
    else
      @post = Post.new
    end

  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.user = current_user

    if @post.update(post_params)
      redirect_to account_posts_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to account_posts_path, alert: "Post Deleted!"
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
