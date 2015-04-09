Then(/^its output is YAML$/) do
  output = YAML.load(unescape(all_output))
  expect(output).to be_instance_of(Hash)

  GitCleanser::Formatter::YAML::KEYS.each do |key|
    expect(output).to have_key(key)
  end
end
