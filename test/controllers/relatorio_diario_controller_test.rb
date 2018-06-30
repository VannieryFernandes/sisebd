require 'test_helper'

class RelatorioDiarioControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get relatorio_diario_index_url
    assert_response :success
  end

end
