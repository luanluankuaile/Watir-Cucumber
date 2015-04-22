# encoding: utf-8
require 'watir-webdriver'

When /^the user visits LRM deeplink (.+)$/  do |url|
  @browser.goto(url)
  wait_for_display(3)
end

Then /^all passed labruns should be filtered away$/ do
   @labrun_list_page.max_labrun_each_page_list.click
   wait_for_display(3)
   expected_all_pass_src="http://lrm/PassFailStatusPill.aspx?passed=100&completed=100"

  if @labrun_list_page.lrm_rows.count==1
    if @labrun_list_page.pass_status_img_for_labrun(lrm_rows[0]).src!= expected_all_pass_src
      @labrun_list_page.labrun_select_checkbox(lrm_rows[0]).click
    end

  elsif @labrun_list_page.lrm_rows.count >1
  for m in 0..@labrun_list_page.lrm_rows.count-1
    if  @labrun_list_page.pass_status_img_for_labrun(@labrun_list_page.lrm_rows[m]).src!= expected_all_pass_src
      puts  @labrun_list_page.pass_status_img_for_labrun(@labrun_list_page.lrm_rows[m])
      @labrun_list_page.labrun_select_checkbox(@labrun_list_page.lrm_rows[m]).click
    end
  end
  end

   @labrun_list_page.group_panel_for_hover.hover
   @labrun_list_page.view_selected_labrun_link.click
   wait_for_display(3)
end


Then /^all LRM include (.+) assignments should be collected$/  do |statistic_type |

  @url_builder="http://lrm/default.aspx?_labrunId="

 if statistic_type=="Unfinished"

  if @labrun_list_page.page_num_ems.count==1
    do_each_page_count(1,"url building")
  elsif  @labrun_list_page.page_num_ems.count > 1
   for p in 1..@labrun_list_page.page_num_ems.count
     puts "#{p} in #{@labrun_list_page.page_num_ems.count}"
     do_each_page_count(p,"url building")
   end
  end

  @browser.goto(@url_builder)
  if @labrun_list_page.check_all_lrm.exists?
     @labrun_list_page.check_all_lrm.click
     wait_for_display(2)
     @labrun_list_page.view_selected_labrun_link.click
  end
  puts "The unfinished labruns are #{@browser.url}"
 end

end


Then /^all bugs referred in each labrun should be collected$/ do
  @labrun_bug_list=Hash.new()
  if @labrun_list_page.page_num_ems.count==1
    do_each_page_count(1,"each labrun bugs")
  elsif  @labrun_list_page.page_num_ems.count > 1
    for p in 1..@labrun_list_page.page_num_ems.count
      puts "#{p} in #{@labrun_list_page.page_num_ems.count}"
      do_each_page_count(p,"each labrun bugs")
    end
  end
   puts @labrun_bug_list

end





