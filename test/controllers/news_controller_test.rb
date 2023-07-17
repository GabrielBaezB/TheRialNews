require "test_helper"

class NewsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @news = news(:one)
    @user = users(:one)
  end

  test "should get index" do
    get news_index_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_news_url
    assert_response :success
  end

  test "should create news" do
    sign_in @user
    assert_difference("News.count") do
      post news_index_url, params: { news: { content: @news.content, title: @news.title, user_id: @user.id } }
    end

    assert_redirected_to news_url(News.last)
  end

  test "should show news" do
    get news_url(@news)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_news_url(@news)
    assert_response :success
  end

  test "should update news" do
    sign_in @user
    patch news_url(@news), params: { news: { content: @news.content, title: @news.title, user_id: @user.id } }
    assert_redirected_to news_url(@news)
  end

  test "should destroy news" do
    sign_in @user
    assert_difference("News.count", -1) do
      delete news_url(@news)
    end

    assert_redirected_to news_index_url
  end
end
