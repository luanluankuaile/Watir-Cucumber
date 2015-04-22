
def assert_true(boolean, message =nil)
if boolean
  return true
else
   message
end
end

def assert_same(actual_value, expect_value, message =nil)
 if actual_value.equal? expect_value
   return true
 else
   message
 end
end

def wait_for_display(time)
  sleep(time)
end

def init_browser()
  @browser=Watir::Browser.new(browser = :chrome)
 # @browser.cookies.clear
end