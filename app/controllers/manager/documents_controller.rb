class Manager::DocumentsController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  def index
    @documents = Document.order("title")
  end

  def show
    @document = Document.find params[:id]
  end

end
