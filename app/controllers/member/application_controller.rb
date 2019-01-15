class Member::ApplicationController < ApplicationController
  before_action :authenticate_user!
end
