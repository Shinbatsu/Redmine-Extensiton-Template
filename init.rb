require 'redmine'
require 'wiki_vote_macro'
require 'last_votes_hooks'

Redmine::Plugin.register :redmine_votes do
  name 'Votes'
  author 'Shinbatsu'
  description 'Create Votes'
  version '1.0.0'

  menu :project_menu, :votes, { :controller => 'votes', :action => 'index' }, :caption => :votes, :after => :wiki, :param => :project_id

   project_module :votes do
     permission :edit_votes, {:votes => [:index, :new, :edit, :new_choice, :edit_choice, :delete, :remove_choice]}
     permission :vote_votes, {:votes => [:reset_vote,:vote]}
   end
end
