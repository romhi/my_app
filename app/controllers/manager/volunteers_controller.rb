class Manager::VolunteersController < ApplicationController

  before_filter :authenticate_user!
  authorize_resource

  before_filter :load_model, only: [:edit, :show, :update, :destroy]

  def index
    @congregation = current_user.congregation
    scope = Volunteer.by_congregation_id(@congregation.id)
    scope = scope.where("email ilike :part or first_name ilike :part or last_name ilike :part or phone ilike :part", part: "%#{params[:part]}%") if params[:part].present?
    @volunteers = scope
  end

  def show
  end

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = current_user.congregation.volunteers.build params_volunteer
    if @volunteer.save
      redirect_to manager_volunteers_path, notice: "Доброволец успешно создан!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @volunteer.update params_volunteer
      redirect_to manager_volunteers_path, notice: "Информация о добровольце обновлена"
    else
      render :edit
    end
  end

  def destroy
    @volunteer.destroy
    redirect_to manager_volunteers_path
  end

  private

  def params_volunteer
    params.require(:volunteer).permit( :last_name, :first_name, :age, :service_time_id,
                                      :convenient_start_time, :convenient_end_time, :will_be_since_8, :car,
                                      :will_be_until_17, :outdoor, :phone,:email, :comment, :responsibility_id)
  end

  def load_model
    @volunteer = Volunteer.find params[:id]
  end

end
