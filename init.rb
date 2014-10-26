require 'changelog_application_helper_patch'

Redmine::Plugin.register :redmine_changelog do
  
Redmine::WikiFormatting::Macros.macro :changelog_version, :desc => 'Wiki macro to generate a changelog from a single version

  {{changelog_version(version_name)}}: generates a changeset showing issues closed on a given target revision.
  {{changelog_version(version_name, false)}}: do not include the issue number/link in the listing' do |obj, args|
    version_name = args[0]
    link_to_issues = true
    if args.size >= 2 and (args[1].casecmp('false') == 0)
      link_to_issues = false
    end
    
    version = Version.where(:name => version_name).first
    render :partial => 'changelog/changelog_version', :locals => { :version => version, :project => @project, :link_to_issues => link_to_issues }
  end

  Redmine::WikiFormatting::Macros.macro :changelog, :desc => 'Wiki macro to generate a changelog

  {{changelog()}}: generates a changeset showing issues closed on a given target revision.
  {{changelog(false)}}: do not include the issue number/link in the listing' do |obj, args|
    link_to_issues = true
    if args and !args.empty? and (args[0].casecmp('false') == 0)
      link_to_issues = false
    end
    
    render :partial => 'changelog/changelog', :locals => { :project => @project, :link_to_issues => link_to_issues }
  end
  
  name 'Redmine Changelog plugin'
  author 'David S Anderson'
  description 'A wiki macro for generate a changeset history.'
  version '0.0.1'
  url 'https://github.com/ande3577/redmine_changeset'
  author_url 'https://github.com/ande3577/redmine_process_workflow'
end
