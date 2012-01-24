require 'test_helper'

class PastesControllerTest < ActionController::TestCase
  setup do
    @paste = Factory(:paste)
    @named = Factory(:named_paste)
    @syntax = Factory(:syntax_paste)
    @full = Factory(:full_paste)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bare paste" do
    assert_difference('Paste.count') do
      post :create, paste: @paste.attributes
    end

    assert_redirected_to paste_path(@controller.paste)
  end

  test "should create named paste" do
    assert_difference('Paste.count') do
      post :create, paste: @named.attributes
    end

    assert_redirected_to paste_path(@controller.paste)
  end
  
  test "should create syntax paste" do
    assert_difference('Paste.count') do
      post :create, paste: @syntax.attributes
    end

    assert_redirected_to paste_path(@controller.paste)
  end
  
  test "should create full paste" do
    assert_difference('Paste.count') do
      post :create, paste: @full.attributes
    end

    assert_redirected_to paste_path(@controller.paste)
  end

  test "should show bare paste" do
    get :show, id: @paste
    assert_response :success
    assert_select '.highlight pre', 1
  end

  test "should show named paste" do
    get :show, id: @named
    assert_response :success
    assert_select '.highlight pre', 1
    assert_select '.highlight pre .cp'
  end

  test "should show syntax paste" do
    get :show, id: @syntax
    assert_response :success
    assert_select '.highlight pre', 1
    assert_select '.highlight pre .cp'
  end

  test "should show full paste" do
    get :show, id: @full
    assert_response :success
    assert_select '.highlight pre', 1
    assert_select '.highlight pre .cp'
  end

#  test "should get edit" do
#    get :edit, id: @paste
#    assert_response :success
#  end
#
#  test "should update paste" do
#    put :update, id: @paste, paste: @paste.attributes
#    assert_redirected_to paste_path(@controller.paste)
#  end
#
#  test "should destroy paste" do
#    assert_difference('Paste.count', -1) do
#      delete :destroy, id: @paste
#    end
#
#    assert_redirected_to pastes_path
#  end
end
