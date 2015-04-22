class LabrunListPage
  def  initialize(driver)
    @browser=driver
  end

  def is_current_page?(url)
    if url.match("lrm\/default.aspx") !=nil
      return true
    end
  end

  def lrm_rows
    @browser.table(:id,"tfx_TfxContent_LabRunsGridView").trs(:class,/^DefaultGrid\w*Row$/)
  end

  def page_num_ems
    @browser.table(:class,"GridViewCurrButton").tr.td(:class,"scott").elements
  end

  def check_all_lrm
    @browser.tr(:class, "DefaultGridHeader").input(:id,"chkAllItems")
  end

  def next_button
    @browser.tr(:class,"DefaultGridPager").img(:src,"/img/GridView/next.gif")
  end

  def execute_status_list
    @browser.span(:class, "PassFailStatusPill")
  end

  def max_labrun_each_page_list
  @browser.tr(:class,"DefaultGridPager").selects[1].options.last
  end

  def pass_status_img_for_labrun(lrm_row)
    lrm_row.tds[4].span(:class,"PassFailStatusPill").img
  end

  def labrun_select_checkbox(lrm_row)
    lrm_row.tds[0].span.input
  end

  def grip_header
    @browser.tr(:class,"DefaultGridHeader")
  end

  def group_panel_for_hover
    @browser.div(:id,"GroupPanel").selects[0]
  end

  def view_selected_labrun_link
    @browser.a(:id,"tfx_TfxContent_ViewLabRunsLink")
  end

  def compare_labrun_for_hover
    @browser.a(:id,"tfx_TfxContent_CompareLabRunsLink")
  end
end






