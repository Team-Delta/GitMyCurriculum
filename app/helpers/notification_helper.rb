# Creates the messages for each notification
module NotificationHelper
  # creates link to an author
  #
  # +author+:: user object to link to
  def link_to_author(author)
    link_to author.username, profile_load_path(username: author.username), class: 'no-link'
  end

  # create link to a curriculum
  #
  # +curriculum+:: curriculum object being linked to
  # +author+:: user object that owns repo
  def link_to_curriculum(curriculum, author)
    link_to "#{author.username}/#{curriculum.cur_name}", curricula_path(id: curriculum.id), class: 'no-link'
  end

  # creates a link to a commit message
  #
  # +commit+:: id of commit to link to
  # +curriculum+:: curriculum object that commit is on
  def link_to_commit(commit, curriculum)
    link_to commit, compare_path(id: curriculum.id, commit: commit), class: 'no-link'
  end

  # creates a message for a given type of notification
  #
  # +n+:: notification object
  # +types of notification object+
  # * 0 user has saved to stream
  # * 3 user has forked
  # * 7 user has deleted a commit
  def construct_notification_message_for(n)
    case n.notification_type
    when 0
      content_tag(:p,
                  "#{link_to_author(n.author)} has saved to stream #{n.stream} on #{link_to_curriculum(n.curricula, n.author)}<br>#{link_to_commit(n.commit_id, n.curricula)} #{n.message}".html_safe,
                  class: 'bg-info text-primary')
    when 3
      content_tag(:p,
                  "#{link_to_author(n.author)} has forked #{link_to_curriculum(n.curricula, n.curricula.creator)}".html_safe,
                  class: 'bg-info text-primary')
    when 7
      content_tag(:p,
                  "#{link_to_author(n.author)} has deleted a save on #{link_to_curriculum(n.curricula, n.author)}".html_safe,
                  class: 'bg-danger text-danger')
    when 8
      content_tag(:p,
                  "#{link_to_author(n.author)} has been added as a contributor to #{link_to_curriculum(n.curricula, n.author)}".html_safe,
                  class: 'bg-danger text-danger')
    end
  end
end
