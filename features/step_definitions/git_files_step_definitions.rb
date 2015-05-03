World(Aruba::Api)

Given(/^an empty, tracked file named "(.*?)"$/) do |file_name|
  write_file(file_name, "")
  in_current_dir do
    `git add -f "#{file_name}"`
  end
end
