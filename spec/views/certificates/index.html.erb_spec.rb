# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'certificates/index.html.erb', type: :view do
  it 'defines home page template' do
    render

    assert_select 'h1'
    assert_select 'form[action=?][method=?][class=?]', search_events_path, 'get', 'form-horizontal' do
      assert_select 'div[class=?]', 'form-group col-md-12' do
        assert_select 'input#email[name=?][class=?]', 'email', 'form-control input-lg'
      end
      assert_select 'button[class=?][type=?]', 'btn btn-primary', 'submit'
    end
  end

  it 'must have participant information' do
  end
end
