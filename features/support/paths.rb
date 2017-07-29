
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the (CommunityGrows )?home page$/ then
      '/'
    when /the (CommunityGrows )?dashboard page$/ then
      '/dashboard'
    when /the (CommunityGrows )?admin_dashboard page$/ then
      '/admin'
    when /the (CommunityGrows )?log_in page$/ then
      '/users/sign_in'
    when /the (CommunityGrows )?document repository page$/ then
      '/documents'
    when /the (CommunityGrows )?internal affairs committee page$/ then
      subcommittee_index_path("internal")
    when /the (CommunityGrows )?executive committee page$/ then
      subcommittee_index_path("executive")
    when /the (CommunityGrows )?external affairs committee page$/ then
      subcommittee_index_path("external")
    when /the (CommunityGrows )?category management page$/ then
      category_index_path
    when /the (CommunityGrows )?User Profiles page$/ then
      user_profiles_page_path
    when /the (CommunityGrows )?committee management page$/ then
      committee_index_path
    when /the (CommunityGrows )?user info page for "([^"]*)"$/ then
      # puts User.find_by_name($1).id
      user_profile_path(User.find_by_name($1).id)
 
    when /the edit user page for "([^"]*)"$/ then
      edit_user_path(User.find_by_email($1).id)
    
    when /^the comment page for "([^"]+)"$/
      comment_path(Announcement.find_by_title($1).id)
  
    when /^the account details page for "([^"]+)"$/ then
      user_credentials_path
    
    when /the new announcement page for "([^"]+)"$/ then
      new_committee_announcement_path($1)
      
    when /^the edit announcement page for "([^"]+)"$/ then
      edit_committee_announcement_path(:committee_type => Announcement.find_by_title($1).committee_type, :announcement_id => Announcement.find_by_title($1).id)

    when /^the new comment page for "([^"]+)"$/ then
      new_comment_path(:announcement_id => Announcement.find_by_title($1).id)
    
    when /^the doc info page for "([^"]*)"$/ then
      info_file_path(Document.find_by_title($1).id)
    
    #not sure if in use due to legacy code
    when /^subcommittee "([^"]*)"$/ then
      info_file_path(Document.find_by_title($1).id)
      
    when /^subcommittee "([^"]*)" page$/ then
      subcommittee_index_path(committee_type: $1)

    when /the (CommunityGrows )?meeting management page$/ then
      meeting_index_path

    when /the (CommunityGrows )?meetings page$/ then
      meeting_list_path
      
      
      
      
    # "Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
