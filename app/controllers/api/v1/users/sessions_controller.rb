class Api::V1::Users::SessionsController < Api::V1::BaseController
  def create
    user = User.find_by!(email: user_params[:email])
    if user.valid_password?(user_params[:password])
      render json: { user: { email: user.email, token: user.authentication_token } }, status: :ok
    else
      render json: { error: "wrong email or password" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

