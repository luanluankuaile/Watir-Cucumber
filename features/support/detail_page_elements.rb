
class LabrunDetailPage
  def initialize(driver)
    @browser=driver
  end

  def is_current_page?(url)
    if url.match("LabRunReport") !=nil
      return true
    end
  end

  def error_catg_ems
    @browser.div(:id,"PieCharts").divs(:class, "pieChart")[1].div(:id,"errCategoryChart").elements
  end

  def exec_status_ems
   @browser.div(:id,"PieCharts").divs(:class, "pieChart")[0].div(:id,"statusChart").elements
  end

  def max_assign_on_detail
   @browser.tr(:class, "DefaultGridPager").selects[1].options.last
  end

  def assign_rows_exclude_pass
    @browser.table(:id, "tfx_TfxContent_AssignmentDetailsGridView").trs(:class, /DefaultGrid\w*Row\s*(Error|PassManually)/)
  end

  def error_reason_text(assign_row)
    assign_row.tds[2].div(:class,"ErrorDetailDisplay").spans[1].text

  end
end
