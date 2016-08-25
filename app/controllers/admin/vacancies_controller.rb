class Admin::VacanciesController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  before_action :load_model, only: [:edit, :update, :destroy]

  def index
    @vacancies = Vacancy.order(:name)
  end

  def new
    @vacancy = Vacancy.new
  end

  def create
    @vacancy = Vacancy.new vacancy_params
    if @vacancy.save
      redirect_to admin_vacancies_path, notice: "Вакансия добавлена!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @vacancy.update vacancy_params
      redirect_to admin_vacancies_path, notice: "Вакансия обновлена!"
    else
      render :edit
    end
  end

  def destroy
    @vacancy.destroy
    redirect_to admin_vacancies_path notice: "Вакансия удалена!"
  end

  def managing
    @vacancies = Vacancy.order(:name)
  end

  private

  def load_model
    @vacancy = Vacancy.find params[:id]
  end

  def vacancy_params
    params.require(:vacancy).permit(:name, :comment, :starts_at, :ends_at)
  end
  
end
