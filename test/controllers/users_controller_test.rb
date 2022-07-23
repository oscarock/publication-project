require 'test_helper'

class UserControllerTest < ActionController::TestCase

  test 'new user session' do
    assert_recognizes({controller: 'devise/sessions', action: 'new'}, {path: 'users/sign_in', method: :get})
    assert_routing '/users/sign_in', { :controller => "devise/sessions", :action => "new" }
  end

  test 'create user session' do
    assert_recognizes({controller: 'devise/sessions', action: 'create'}, {path: 'users/sign_in', method: :post})
  end

  test 'destroy user session' do
    assert_recognizes({controller: 'devise/sessions', action: 'destroy'}, {path: 'users/sign_out', method: :delete})
  end

  test 'new user password' do
    assert_recognizes({controller: 'devise/passwords', action: 'new'}, 'users/password/new')
  end

  test 'create user password' do
    assert_recognizes({controller: 'devise/passwords', action: 'create'}, {path: 'users/password', method: :post})
  end

  test 'edit user password' do
    assert_recognizes({controller: 'devise/passwords', action: 'edit'}, 'users/password/edit')
  end

  test 'update user password' do
    assert_recognizes({controller: 'devise/passwords', action: 'update'}, {path: 'users/password', method: :put})
  end

  test 'new user registration' do
    assert_recognizes({controller: 'users/registrations', action: 'new'}, 'users/sign_up')
  end

  test 'create user registration' do
    assert_recognizes({controller: 'users/registrations', action: 'create'}, {path: 'users', method: :post})
  end

  test 'edit user registration' do
    assert_recognizes({controller: 'users/registrations', action: 'edit'}, {path: 'users/edit', method: :get})
  end

  test 'update user registration' do
    assert_recognizes({controller: 'users/registrations', action: 'update'}, {path: 'users', method: :put})
  end

  test 'destroy user registration' do
    assert_recognizes({controller: 'users/registrations', action: 'destroy'}, {path: 'users', method: :delete})
  end
end
