require 'selenium-webdriver'
require 'pry'
require 'rspec/expectations'
include RSpec::Matchers

def setup
  hub_url = 'http://localhost:4444/wd/hub'
  caps = define_browsers("safari")
#   caps[:platform] = :any
  @driver = Selenium::WebDriver.for(
    :remote,
    url: hub_url,
    desired_capabilities: caps)
  @driver.manage.window.resize_to(2560, 1600)
#   @driver.manage.timeouts.page_load = "10"
end


def define_browsers(name)
   define_options(name)
   Selenium::WebDriver::Remote::Capabilities.send(name.to_sym) # ie,safari,chrome,firefox
end

def teardown
  @driver.quit
end

def run
  setup
  yield
  teardown
end

run do
  @driver.get 'http://the-internet.herokuapp.com'
  expect(@driver.title).to eq('The Internet')
end