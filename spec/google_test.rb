require 'spec_helper'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara/dsl'

Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :js_errors => true, :timeout => 60)
end

Capybara.configure do |config|
    config.run_server = false
    config.default_driver = :poltergeist
    config.app_host = 'http://www.google.com'
end

describe "test", :type => :feature do
  subject{ page }
  before { visit('/') }

  it "test" do
    expect(page).to have_text('画像')
  end

  it "test2" do
    within("form") do
      fill_in "q", with: "Ruby"
    end
    click_button "Google 検索"
    expect(page).to have_text('Ruby')
    page.save_screenshot('screenshot.png')
    page.save_screenshot('screenshot2.png', full: true)
    expect(page).to have_text('次へ')
  end
end
