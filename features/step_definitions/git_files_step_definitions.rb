World(Aruba::Api)

Given(/^an empty, committed file named "(.*?)"$/) do |file_name|
  write_file(file_name, "")
  in_current_dir do
    `git add "#{file_name}"`
  end
end
