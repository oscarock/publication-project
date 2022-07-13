class PublicationsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :set_publication, only: %i[ show edit update destroy permit_validation ]
  before_action :permit_validation, only: %i[edit update destroy]

  # GET /publications or /publications.json
  def index
    current_page = params[:page] ||= 1
    @publications = Publication.paginate(page: current_page, per_page: 6).visible
  end

  # GET /publications/1 or /publications/1.json
  def show
  end

  # GET /publications/new
  def new
    @publication = Publication.new
  end

  # GET /publications/1/edit
  def edit
  end

  # POST /publications or /publications.json
  def create
    @publication = Publication.new(publication_params)
    @publication.user_id = current_user.id

    respond_to do |format|
      if @publication.save
        format.html { redirect_to publications_path, notice: "Publicación creada con exito." }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publications/1 or /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to publication_url(@publication), notice: "Publicación editada con exito." }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1 or /publications/1.json
  def destroy
    @publication.destroy

    respond_to do |format|
      format.html { redirect_to publications_path, notice: "Publicación eliminada con exito." }
      format.json { head :no_content }
    end
  end

  def my_publications
    current_page = params[:page] ||= 1
    @publications = Publication.where(user_id: current_user.id).paginate(page: current_page, per_page: 6).visible
  end

  def search
    @title = params[:title]
    @date = params[:date]
    @categories = params[:categories]
    current_page = params[:page] ||= 1
    @publications = Publication.paginate(page: current_page, per_page: 6)
      .includes(:categories)
      .where("publications.title LIKE ?", "%#{@title}%")
      .where("publications.created_at LIKE ?", "%#{@date}%")
      .visible

    unless @categories.empty?
      @publications = Publication.paginate(page: current_page, per_page: 6)
       .includes(:categories)
       .where(categories: { id: @categories })
       .visible
    end

    if @publications.count < 1
      redirect_to publications_path, alert: "No se encontraron resultados"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def publication_params
      params.require(:publication).permit(:title, :description, :price, :city, :address, :phone, :visible, images: [] ,category_ids: [])
    end

    def permit_validation
      if @publication.user_id != current_user.id
        redirect_to publications_path, alert: "No tiene permisos para esta publicación"
      end
    end
end
