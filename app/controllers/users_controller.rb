class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :check_login
    authorize_resource

  
    # def index
    #   # finding all the active users and paginating that list (will_paginate)
    #   @employees = User.case_worker.paginate(page: params[:page]).per_page(15)
    # end
  
    def new
      @user = User.new
    end
  
    def edit
      @user.role = "case_worker" if current_user.role?(:case_worker)
    end

    def create
      @user = User.new(user_params)
      @user.role = "case_worker" if current_user.role?(:case_worker)
      if @user.save
        flash[:notice] = "Successfully added #{@user.username} as a user."
        redirect_to users_url
      else
        render action: 'new'
      end
    end
  
  
    def update
      if @user.update_attributes(user_params)
        flash[:notice] = "Successfully updated #{@user.username}."
        redirect_to users_url
      else
        render action: 'edit'
      end
    end
    
   
  
    private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:active, :username, :role, :password, :password_confirmation)
      end
    

  end
