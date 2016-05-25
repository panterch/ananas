class AttendancesController < CrudController
  def attend
    resource.state = 'attending'
    resource.save
  end

  def decline
    resource.state = 'declined'
    resource.save
  end
end
