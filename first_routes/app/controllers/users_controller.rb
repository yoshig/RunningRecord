class UsersController < ApplicationController

  def index
    @users = User.all
    render :json => @users
  end

  def favorite
    @favs = Contact.favorites_for_user_id(params[:id])
    render :json => @favs
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      render :json => @user
    else
      render :json => @user.errors.full_messages, :status => 422
    end
  end

  def destroy
    user = User.find(params[:id])
    name = user.username
    user.destroy!

    render :json => "#{name} destroyed"
  end

  def show
    @user = User.find(params[:id])
    render :json => @user
  end

  def update
    # if params.include?(:favorite)
  #     if params[:favorite].include?(:add_fav)
  #       fav = Favorite.new(fav_params)
  #       if fav.save
  #         render :json => fav
  #       else
  #         render :json => contact.errors.full_messages, :status => 422
  #       else
  #         fav.delete
  #     end
  #   else
      @user = User.find(params[:id])
      if @user.update!(user_params)
        render :json => @user
      else
        render :json => @user.errors.full_messages, :status => 422
      end
    # end
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end

  def fav_params
    params.require(:favorite).permit(:contact_id)
  end
end
