class PublicationsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :search]
  before_action :set_publication, only: %i[ show edit update destroy permit_validation ]
  before_action :permit_validation, only: %i[edit update destroy]
  after_action :send_email, only: %i[ create ]

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
    @publication = Publication.create(publication_params)
    @publication.user_id = current_user.id

    respond_to do |format|
      if @publication.save
        format.html { redirect_to publication_path(@publication), notice: "Publicación creada con exito." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publications/1 or /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to publication_url(@publication), notice: "Publicación editada con exito." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1 or /publications/1.json
  def destroy
    @publication.destroy

    respond_to do |format|
      format.html { redirect_to publications_path, notice: "Publicación eliminada con exito." }
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
      .where("categories.id LIKE ?", "%#{@categories}%").references(:categories)
      .visible

    if @publications.count < 1
      redirect_to publications_path, alert: "No se encontraron resultados"
    end
  end

  def send_email
    RegisterPublicationMailer.with(publication: @publication, user: current_user.email).new_publication_email.deliver_later(wait: 5.seconds)
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
