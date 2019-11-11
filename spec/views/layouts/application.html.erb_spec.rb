# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'layouts/application.html.erb', type: :view do
  it 'defines basic layout' do
    render

    assert_select 'div[class=?]', 'container' do
      assert_select 'div[class=?]', 'col-md-12 logo' do
        assert_select 'img'
      end
      assert_select 'div[class=?]', 'col-md-12 content'
    end
  end
end
