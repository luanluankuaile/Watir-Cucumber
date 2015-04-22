require "features/support/list_page_elements"



def do_each_page_count(index, string_method)
    string_method.gsub!(/\s/,"_")
  if @labrun_list_page.lrm_rows.count==1
    if @labrun_list_page.lrm_rows[0].tds[2].a.visible?
      @labrun_list_page.lrm_rows[0].tds[2].a.click
    end
    wait_for_display(5)
    eval string_method
    @browser.back
    if index==2
      @labrun_list_page.compare_labrun_for_hover.hover
      @labrun_list_page.next_button.click
      wait_for_display(3)
    elsif index>2
      for c in 1..index-1
        @labrun_list_page.compare_labrun_for_hover.hover
        @labrun_list_page.next_button.click
        wait_for_display(3)
      end
    end
  elsif @labrun_list_page.lrm_rows.count>=2
    for i in 0..@labrun_list_page.lrm_rows.count-1
      puts "i=#{i}"
      puts  "lrm_rows.count is#{@labrun_list_page.lrm_rows.count}"
      puts @labrun_list_page.lrm_rows[i].tds[2].a.href
      if @labrun_list_page.lrm_rows[i].tds[2].a.visible?
        @labrun_list_page.lrm_rows[i].tds[2].a.click
      end
      wait_for_display(5)
      eval string_method
      @browser.back
      if index==2
        @labrun_list_page.compare_labrun_for_hover.hover
        @labrun_list_page.next_button.click
        wait_for_display(3)
      elsif index>2
        for c in 1..index-1
          @labrun_list_page.compare_labrun_for_hover.hover
          @labrun_list_page.next_button.click
          wait_for_display(3)
        end
      end

      if i==@labrun_list_page.lrm_rows.count-1 && @labrun_list_page.next_button.exists? && @labrun_list_page.next_button.visible?
        @labrun_list_page.compare_labrun_for_hover.hover
        @labrun_list_page.next_button.click
        wait_for_display(3)
      end

    end
  end

end

def url_building()
  #if element_collection.kind_of?(Watir::ElementCollection)
  # if element_collection.eql?(@error_catg_ems)
  @labrun_detail_page.error_catg_ems.each{|em|
    if em.text=="Unresolved"
      @url_builder= @url_builder + @browser.url.match(/\d.+/).to_s+","
      break
    end
  }
  current_labrun_id=@browser.url.match(/\d.+/).to_s
  if @url_builder.match(current_labrun_id)==nil
    @labrun_detail_page.exec_status_ems.each{|em|
      if (em.text=="None"||em.text=="Timeout"||em.text=="Queued"||em.text=="Assigned"||em.text=="Executing")
        @url_builder= @url_builder + @browser.url.match(/\d.+/).to_s+","
        break
      end
    }
  end

end

def each_labrun_bugs()
  @labrun_detail_page.max_assign_on_detail.click
  wait_for_display(5)
  bug_array=Array.new()

  if @labrun_detail_page.assign_rows_exclude_pass.count==1
    if  @labrun_detail_page.error_reason_text(@labrun_detail_page.assign_rows_exclude_pass[0])!=nil
       current_bug_id= @labrun_detail_page.error_reason_text(@labrun_detail_page.assign_rows_exclude_pass[0]).match(/^[A-Z]*\-\s*\d*/).to_s
       if current_bug_id != nil
       bug_array.push(current_bug_id)
       end
    end

  elsif @labrun_detail_page.assign_rows_exclude_pass.count>=2
    for i in 0..@labrun_detail_page.assign_rows_exclude_pass.count-1
      if @labrun_detail_page.error_reason_text(@labrun_detail_page.assign_rows_exclude_pass[i])!=nil
        current_bug_id= @labrun_detail_page.error_reason_text(@labrun_detail_page.assign_rows_exclude_pass[i]).match(/^[A-Z]*\-\s*\d*/).to_s
        if current_bug_id != nil
          bug_array.push(current_bug_id)
        end
       end
    end
    bug_array.shift()
    bug_array.uniq!
  end

  if (@labrun_detail_page.assign_rows_exclude_pass.count!=0&&bug_array[0]!="")
    labrun_id=@browser.url.match(/\d.+/).to_s
    value_hash=bug_array
    current_lrm_bugs={labrun_id=>value_hash}
    @labrun_bug_list.merge!(current_lrm_bugs)
    puts "The labrun is #{labrun_id}"
    puts "The bugs in the labruns are #{value_hash}"

  end

end


