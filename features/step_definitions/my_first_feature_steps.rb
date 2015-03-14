When /I yolo/ do
  @sound = "meow"
end

Then /I hear "meow"/ do
  expect(@sound).to eq("meow")
end
