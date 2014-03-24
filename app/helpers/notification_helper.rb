# Creates the messages for each notification
module NotificationHelper
  def link_to_author(author)
    link_to author.username, users_show_path(username: author.username), class: 'no-link'
  end

  def link_to_curriculum(curriculum, author)
    link_to "#{author.username}/#{curriculum.cur_name}", curricula_path(id: curriculum.id), class: 'no-link'
  end

  def link_to_commit(commit, curriculum)
    link_to commit, compare_path(id: curriculum.id, commit: commit), class: 'no-link'
  end

  def construct_notification_message_for(n)
    case n.notification_type
    when 0
      content_tag(:p,
                  "#{link_to_author(n.author)} has saved to stream #{n.stream} on #{link_to_curriculum(n.curricula, n.author)}<br>#{link_to_commit(n.commit_id, n.curricula)} #{n.message}".html_safe,
                  class: 'bg-info text-primary')
    when 3
      content_tag(:p, "#{link_to_author(n.author)} has forked #{link_to_curriculum(n.curricula, n.author)}".html_safe, class: 'bg-info text-info')
    when 7
      content_tag(:p, "#{link_to_author(n.author)} has deleted a save on #{link_to_curriculum(n.curricula, n.author)}".html_safe, class: 'bg-danger text-danger')
    end
  end
end
