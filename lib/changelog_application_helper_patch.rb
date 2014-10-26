module ChangelogApplicationHelperPatch
  def self.included(base)
    unloadable
    
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      def changelog_version(v, link_to_issues) 
        html = ""
        html << "<h3>"
          if link_to_issues
            html << link_to(v.to_s, :controller => 'versions', :action => 'show', :id => v)
          else
            html << v.to_s
          end
          if v.effective_date
            html << " (#{format_date(v.effective_date)})"
          end
        html << "</h3>"
        html << "<ul>"
          v.fixed_issues.visible.each do |i|
            if link_to_issues
              html << "<li>#{link_to_issue(i)}</li>"
            else
              html << "<li><#{i.subject}</li>"
            end
          end
        html << "</ul>"
        html.html_safe
      end
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
  end

  private  
end

ApplicationHelper.send(:include, ChangelogApplicationHelperPatch)