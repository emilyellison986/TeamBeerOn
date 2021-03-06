class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :find_logged_in_member
  
  def find_logged_in_member
    @current_member = Member.find_by_id(session[:mid])
  end
  
  def redirect_if_not_logged_in
    if @current_member.nil?
      flash[:error] = 'You must be signed in first.'
      redirect_to sign_in_url
    end
  end
  
  def redirect_if_logged_in
    if @current_member.present?
      flash[:error] = 'You\'re already signed in. You must be signed out first.'
      redirect_to member_url(@current_member.id)
    end
  end
  
  def redirect_if_user_doesnt_match
    member = Member.find(params[:id])
    if member.id != session[:mid]
      flash[:error] = 'You\'re not authorized to view that page.'
      redirect_to root_url
    end
  end
  
end
