class AuthorsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  include Authors
end
