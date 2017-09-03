module TeamsHelper
  def member_status(status)
    case status
    when 'team_owner'
      'Captain'
    when 'invited'
      'Pending'
    when 'accepted'
      'Member'
    end
  end

  def status_tag(status)
    case status
  when 'team_owner'
    'is-danger'
  when 'invited'
    'is-warning'
  when 'accepted'
    'is-primary'
  end
  end
end
