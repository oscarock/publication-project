require "test_helper"

class PublicationsControllerTest < ActionController::TestCase

  include Devise::Test::ControllerHelpers
  include Warden::Test::Helpers

  setup do
    @user = users(:user1)
    @publication = publications(:publication1)
    @publication2 = publications(:publication2)
    sign_in @user
  end

  test "publications get index" do
    get :index
    @publications = Publication.paginate(page: 1, per_page: 6).visible
    assert_equal(@publication.title, @publications[0].title)
    assert_equal(@publication.user_id, @publications[0].user_id)
    assert_select "h4", "Publicaciones"
    assert_select "div.digg_pagination"
    assert_not_nil(@publications)
    assert_not_nil(@publication)
    assert_template 'publications/index'
    assert_response :success
  end

  test "publication get new" do
    get :new
    assert_select "h1", "Nueva publicación"
    assert_template 'publications/new'
    assert_response :success
  end

  test "publication get create" do
    assert_difference('Publication.count') do
      post :create, params: { publication: {
        title: "probando test",
        description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
        price: 100,
        city: "bogota",
        address: "cra 200",
        phone: "1234560",
        visible: true,
        user_id: @user.id
      }}
    end

    assert_redirected_to publication_url(Publication.last)
  end

  test "publications get show" do
    get :show, params: { id: @publication }
    assert_select "div.user-profile-name", @publication.title
    assert_select "div.user-job-title", @publication.city
    assert_template 'publications/show'
    assert_response :success
  end

  test "publications get edit" do
    get :edit, params: { id: @publication }
    assert_template 'publications/edit'
    assert_response :success
  end

  test "publication get update" do
    updated_title = "prueba test"
    updated_price = 100
    patch :update, params: {
      id: @publication2.id,
      title: updated_title,
      price: updated_price,
    }

    assert_not_nil(@publication)
    assert_not_empty(@publication.title)
    assert_equal updated_title, @publication.title
    assert_equal updated_price, @publication.price

    assert_response :redirect
  end

  test "publication get destroy" do
    assert_difference("Publication.count", -1) do
      delete :destroy, params: { id: @publication }
    end

    assert_redirected_to(controller: "publications", action: "index"  )
  end

  test "publications get my_publications" do
    get :my_publications
    @publications = Publication.where(user_id: @publication.id).paginate(page: 1, per_page: 6).visible
    assert_template 'publications/my_publications'
    assert_response :success
  end

  test "publications get search" do
    get :search
    @publications = Publication.paginate(page: 1, per_page: 6)
       .includes(:categories)
       .where("publications.title LIKE ?", "%#{@publication.title}%")
       .where("publications.created_at LIKE ?", "%%")
       .visible

    assert_equal @publications[0].title, @publication.title
    assert_response :redirect
  end
end
