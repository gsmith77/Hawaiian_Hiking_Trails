class Helpers

  #This method should use the user_id from the
  #session hash to find the user in the database and return that user.
  def self.current_user(session)
    @user = User.find_by(session[:id])
    if session[:id] == @user
      @user
    end
    @user
  end

  def self.is_logged_in?(session)
    !!self.current_user(session)
  end

end
