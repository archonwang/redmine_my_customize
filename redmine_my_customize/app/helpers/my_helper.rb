module MyHelper
  def my_render_project_jump_box
    @default_project = "all"
    @tmp_project = nil
    @param_project = ""
    @param_project_id = ""
    @tmp_project = @default_project ;
    @tmp_project = params[:project] if params[:project] ;
    if @tmp_project != "all"
      @param_project = (params[:project]) ? params[:project] : @default_project.name 
      @param_project_id = (params[:project_id]) ? params[:project_id] : @default_project.id 
    end

    # Retrieve them now to avoid a COUNT query
    projects = User.current.projects.all
    if projects.any?
      #s = '<select onchange="if (this.value != \'\') { window.location = this.value; }">' +
      s = '<select onchange="if (this.value != \'\') { window.location = this.value; }">' +
            "<option value=''>#{ l(:label_jump_to_a_project) }</option>" +
            '<option value="" disabled="disabled">---</option>' +
            "<option value='#{url_for(:controller => 'my', :action => 'page', :project => 'all', :project_id => "")}'>#{ l(:label_all) }</option>" +
            '<option value="" disabled="disabled">---</option>'
      s << project_tree_options_for_select(projects, :selected => @param_project) do |p|
          { :value => url_for(:controller => 'my', :action => 'page', :project => p, :project_id => p.id ) }
      end
      s << '</select>'
      s
    end
  end

  def get_title(project_id)
     if project_id == ""
       return l(:label_all)
     else
       pj = Project.find(project_id)
       return pj.name
     end
  end

  def get_formaction(project_id)
     if project_id == ""
       return {:controller => 'search', :action => 'index'}
     else
       return {:controller => 'search', :action => 'index', :id => project_id}
     end
  end


  def my_render_project_issue_link(project_id)
    if project_id == ""
          s =  "<h4 class='issue'>#{ l(:label_issue_sc)} </h4>"
          s << "<table border='0' style='border:1px solid #BBBBBB'>"
          s << "<tr>"
          s << "<td><s>#{ l(:label_issue_new)} </s></td>"
          s << "<td>-"
          s << "</td>"
          s << "</tr>"
          s << "<tr>"
          s << "<td>#{ link_to(l(:label_issue_activity), :controller => 'activity', :show_issues => '1', :user_id => User.current.id) }</td>"
          s << "<td>-"
          s << "</td>"
          s << "</tr>"
          s << "<tr>"
          s << "<td>#{ l(:label_issue_list_default) } </td>"
          s << "<td>"
          s << '<select onchange="if (this.value != \'\') { window.location = this.value; }">' +
                '<option value="">---</option>' +
                "<option value='#{url_for(:controller => 'issues', :action => 'index', :set_filter => 1)}'>#{ link_to(l(:label_issue_list)) }</option>" +
                "<option value='#{url_for(:controller => 'issues', :action => 'gantt', :set_filter => 1)}'>#{ link_to(l(:label_gantt)) }</option>" +
                "<option value='#{url_for(:controller => 'issues', :action => 'calendar', :set_filter => 1)}'>#{ link_to(l(:label_calendar)) }</option>" 
          s << '</select>'
          s << "</td>"
          s << "</tr>"
          s << "<tr>"
          s << "<td>#{ l(:label_issue_list_assign) } </td>"
          s << "<td>"
          s << '<select onchange="if (this.value != \'\') { window.location = this.value; }">' +
                '<option value="">---</option>' +
                "<option value='#{url_for(:controller => 'issues', :action => 'index', :set_filter => 1)}'>#{ link_to(l(:label_issue_list)) }</option>" +
                "<option value='#{url_for(:controller => 'issues', :action => 'gantt', :set_filter => 1)}'>#{ link_to(l(:label_gantt)) }</option>" +
                "<option value='#{url_for(:controller => 'issues', :action => 'calendar', :set_filter => 1)}'>#{ link_to(l(:label_calendar)) }</option>" 
          s << '</select>'
          s << "</td>"
          s << "</tr>"
          s << "</table>"
      else
          s =  "<h4 class='issue'>#{ l(:label_issue_sc)} </h4>"
          s << "<table border='0' style='border:1px solid #BBBBBB'>"
          s << "<tr>"
          s << "<td>#{ link_to(l(:label_issue_new), :controller => 'issues', :action => 'new', :project_id => project_id)} </td>"
          s << "<td>-"
          s << "</td>"
          s << "</tr>"
          s << "<tr>"
          s << "<td>#{ link_to(l(:label_issue_activity), :controller => 'projects', :action => 'activity', :id => project_id, :show_issues => '1', :user_id => User.current.id) }</td>"
          s << "<td>-"
          s << "</td>"
          s << "</tr>"
          s << "<tr>"
          s << "<td>#{ l(:label_issue_list_default) } </td>"
          s << "<td>"
          s << '<select onchange="if (this.value != \'\') { window.location = this.value; }">' +
                '<option value="">---</option>' +
                "<option value='#{url_for(:controller => 'issues', :action => 'index', :project_id => project_id, :set_filter => 1)}'>#{ link_to(l(:label_issue_list)) }</option>" +
                "<option value='#{url_for(:controller => 'issues', :action => 'gantt', :project_id => project_id, :set_filter => 1)}'>#{ link_to(l(:label_gantt)) }</option>" +
                "<option value='#{url_for(:controller => 'issues', :action => 'calendar', :project_id => project_id, :set_filter => 1)}'>#{ link_to(l(:label_calendar)) }</option>" 
          s << '</select>'
          s << "</td>"
          s << "</tr>"
          s << "<tr>"
          s << "<td>#{ l(:label_issue_list_assign) } </td>"
          s << "<td>"
          s << '<select onchange="if (this.value != \'\') { window.location = this.value; }">' +
                '<option value="">---</option>' +
                "<option value='#{url_for(:controller => 'issues', :action => 'index', :project_id => project_id, :set_filter => 1)}'>#{ link_to(l(:label_issue_list)) }</option>" +
                "<option value='#{url_for(:controller => 'issues', :action => 'gantt', :project_id => project_id, :set_filter => 1)}'>#{ link_to(l(:label_gantt)) }</option>" +
                "<option value='#{url_for(:controller => 'issues', :action => 'calendar', :project_id => project_id, :set_filter => 1)}'>#{ link_to(l(:label_calendar)) }</option>" 
          s << '</select>'
          s << "</td>"
          s << "</tr>"
          s << "</table>"
      end
      s
  end

end