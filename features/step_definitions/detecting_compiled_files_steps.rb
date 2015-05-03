require 'aruba/api'
require 'aruba/cucumber/hooks'
require 'aruba/reporting'

require 'yaml'

World(Aruba::Api)

Then(/^its output for "(.*?)" should not contain "(.*?)"$/) do |key, value|
  output = YAML.load(unescape(all_output))
  expect(output[key]).not_to include(value)
end

Then(/^its output for "(.*?)" should contain "(.*?)"$/) do |key, value|
  output = YAML.load(unescape(all_output))
  expect(output[key]).to include(value)
end

Then(/^its output for "(.*?)" should be empty$/) do |key|
  output = YAML.load(unescape(all_output))
  expect(output[key]).to be_empty
end
