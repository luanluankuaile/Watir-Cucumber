# encoding: utf-8
require 'watir-webdriver'

When /^the user visit Google web site$/ do
  #$browser=Watir::Browser.start("http://www.google.com",browser=:chrome)

  @browser.goto("http://www.google.com")
end

Then /^the current page should be Google site/ do
  wait_for_display(3)
  @targetsite="www.google"
  @url= @browser.url
  #puts @browser.body(:id,"gsr").html
 # puts @browser.body(:id,"gsr").tag_name
  assert_true((@url.include?@targetsite), "This page is not Google site")
end

 Then /^the user input (.+) as search condition and perform search$/ do |input|
   @browser.text_field(:id,"gbqfq").value= input
   #puts  @browser.text_field(:id,"gbqfq").attribute_value(:type)(:class)(:id)
   puts  @browser.text_field(:id,"gbqfq").attribute_value(:value)
   outing||=@browser.text_field(:id,"gbqfq").value
   @browser.button(:id,"gbqfb").click
 end


 Then /^the page should display the search result for (.+)$/ do |search_text|
  wait_for_display(5)
  @actualTitle= @browser.title
  @actualUrl=@browser.url
  assert_true((@actualTitle.include?search_text.to_s) && (@actualUrl.include?search_text.to_s), "This page is not the #{search_text} page")
  @res=@browser.div(:class,"srg").lis.to_a
  @res.each_index {|x|puts @res[x].a.text}
  assert_true(@res.first.a.text.include?search_text.to_s)
  @browser.div(:class,"srg").lis.first.a.click


  #@browser.text_field(:id,"gbqfq").send_keys :backspace,:backspace,:backspace,:backspace,"escape",:enter
  #@path=File.expand_path(File.dirname(__FILE__))
  @path=Dir.getwd
  @fpath=File.new(@path+"/test #{$times.to_s}.png","w")
  @browser.screenshot.png
  @browser.screenshot.save(@fpath)
  $times+=1
  step "close the browser"
 end

Then /^close the browser$/ do
  @browser.close
end

Then /^the user clicks \+You link$/ do
  puts @browser.div(:class=>"gb_e gb_f gb_g gb_Ic").html
  @browser.a(:class=>"gb_d gb_f").click

end

Then /^the user input (.+) and (.+) to sign in$/ do |user,pass|
  @browser.text_field(:id,"Email").value=user if @browser.text_field(:id,"Email").visible?
  @browser.text_field(:id,"Passwd").value=pass
  @browser.button(:id,"signIn").click
end

Then /^the user should log in successfully$/ do
  wait_for_display(3)
  @targetsite="plus.google"
  @url= @browser.url
  assert_true((@url.include?@targetsite), "The log in is failed, you may have input wrong email or password")
end

Then /^the user should be on signed in page$/ do
  wait_for_display(3)
  @targetsite="www.google"
  @url= @browser.url
  assert_true((@url.include?@targetsite), "The log in is failed, you may have input wrong email or password")
end

Then /^the user clicks the profile icon$/ do
  @browser.a(:class=>"gb_A gb_7 gb_f").click
end

Then /^the user clicks sign out link$/  do
  @browser.a(:class=>"gb_Sb gb_Zb gb_U").click
  wait_for_display(3)
end

Then /^the user clicks sign in link$/  do
  @browser.a(:class=>"gb_Xb gb_V gb_U").click
end

Then /^the user relogin with the old (.+) and (.+)$/ do  |user,pass|
#step "the user input <valid email> and <password> to sign in" --not able to reuse step if table param used
  @browser.text_field(:id,"Email").value=user if @browser.text_field(:id,"Email").visible?
  @browser.text_field(:id,"Passwd").value=pass
  @browser.button(:id,"signIn").click
  wait_for_display(3)
step "close the browser"
end

When /^the yml file is loaded into the system$/ do
  @path=Dir.getwd
  @yml=YAML.load_file "#{@path}/features/test_data.yml"
  puts @yml
  # each pair sent to iterator is divided as p[0] and p[1], p[0] is the key, p[1] is the value
  @yml.each {|p|
    if p[0]!="children"
      print "#{p[0]} is #{p[1]["name"]} \n"
    elsif p[0]="children"
      print "#{p[1][0]["title"]} is #{p[1][0]["name"]} \n"
      print "#{p[1][1]["title"]} is #{p[1][1]["name"]} \n"
    end
   }

  print"**************************************************************\n"
  print "They are a happy family \n"
end