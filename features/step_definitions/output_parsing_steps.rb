require 'aruba/api'
require 'aruba/cucumber/hooks'
require 'aruba/reporting'

require 'yaml'

World(Aruba::Api)

Then(/^its output for "(.*?)" should not contain "(.*?)"$/) do |key, value|
  fancy_output = YAML.load(unescape(all_output))
  expect(fancy_output[key]).not_to include(value)
end

Then(/^its output for "(.*?)" should contain "(.*?)"$/) do |key, value|
  fancy_output = YAML.load(unescape(all_output))
  expect(fancy_output[key]).to include(value)
end
