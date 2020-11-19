class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
  end

  def about
  end

  def dashboard
  end

  def missions_mes_codeurs
  end

  def missions_recruteur
  end

end
