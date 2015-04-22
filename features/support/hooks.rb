Before ('@dummytest') do
  puts "Preparing environment"
  puts "Starting browser"
end

Before('@labrun_test') do
  init_browser()
  @labrun_list_page=LabrunListPage.new(@browser)
  @labrun_detail_page=LabrunDetailPage.new(@browser)

end

After  do
  puts "Browser closed"
  puts "Cleaned environment"
end