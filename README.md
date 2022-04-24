# Votes

This plugin adds vote_block management features to Redmine, including a "Votes" tab at the project level.

You can embed votes and view vote_block results using Wiki macros. The available macros are:

* `{{vote(id)}}` - display the vote_block
* `{{vote_result(id)}}` - display detailed results for the vote_block

## Additional permissions:
- Edit votes
- Create votes
- Do votes

Votes that the current user has not yet voted on will be displayed on the Home page (for all projects) and in the project's Overview, within a box similar to the Latest News section.

If a vote_block option that has been voted on by users is deleted, their votes will also be removed.
