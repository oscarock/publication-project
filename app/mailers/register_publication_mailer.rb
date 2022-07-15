class RegisterPublicationMailer < ApplicationMailer

  default from: "oscarock02@gmail.com"

  def new_publication_email
    @user = params[:user]
    @publication = params[:publication]

    mail(to: @user, subject: "Creaste una nueva publicación")
  end
end
