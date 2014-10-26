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
    render :partial => 'changelog/changelog_version', :locals => { :version => version, :link_to_issues => link_to_issues }
  end

  Redmine::WikiFormatting::Macros.macro :changelog, :desc => 'Wiki macro to generate a changelog

  {{changelog()}}: generates a changeset showing issues closed on a given target revision.
  {{changelog(false)}}: do not include the issue number/link in the listing
  {{changelog(true, start_version_name, end_version_name)}}: limit the changlog to
    versions with a target date between the start and end version.  If the start/end
    version name is invalid or the version does not have an effective date, the 
    limit check will be ignored. Versions without a specified target date will not be 
    shown in the changelog.
' do |obj, args|
    link_to_issues = true
    start_version_name = nil
    end_version_name = nil
    if args 
      link_to_issues = false if args.size >= 1 and (args[0].strip.casecmp('false') == 0)
      start_version_name = args[1] if args.size >= 2
      end_version_name = args[2] if args.size >= 3
    end
    versions = @project.versions.sort
    render :partial => 'changelog/changelog', :locals => { :project => @project, 
      :versions => versions, 
      :link_to_issues => link_to_issues, 
      :start_version_name => start_version_name, 
      :end_version_name => end_version_name }
  end
  
  name 'Redmine Changelog plugin'
  author 'David S Anderson'
  description 'A wiki macro for generate a changeset history.'
  version '0.0.1'
  url 'https://github.com/ande3577/redmine_changeset'
  author_url 'https://github.com/ande3577/redmine_process_workflow'
end
