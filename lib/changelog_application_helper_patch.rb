module ChangelogApplicationHelperPatch
  def self.included(base)
    unloadable
    
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      def changelog(project, link_to_issues, start_version_name, end_version_name)
        html = ""
        versions = project.versions

        start_version = start_version_name.nil? ? nil : versions.where(:name => start_version_name).first
        start_date = start_version ? start_version.effective_date : nil
        versions.select! { |v| v.effective_date and v.effective_date >= start_date } if start_date

        end_version = end_version_name.nil? ? nil : versions.where(:name => end_version_name).first
        end_date = end_version ? end_version.effective_date : nil
        versions.select! { |v| v.effective_date and v.effective_date <= end_date } if end_date

        versions.sort { |x, y|
          # force versions without effective date to end of list
          if !x.effective_date and y.effective_date
            1
          elsif !y.effective_date and x.effective_date
            -1
          else
            # otherwise reverse to show newest revision first
            y <=> x 
          end 
        }.each do |v|
          html << changelog_version(v, link_to_issues)
        end
        html.html_safe
      end

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
              html << "<li>#{i.subject}</li>"
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