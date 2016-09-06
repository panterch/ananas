class NotificationsMailer < ApplicationMailer
  helper :events

  def booking_request(mentor, member, expert_session)
    @mentor = mentor
    @member = member
    @expert_session = expert_session

    mail subject: '[KS Ananas]: Expert Session Request',
      to: mentor.email,
      from: 'no-reply@ananas-project.com',
      reply_to: member.email
      #bcc: 'katka@kickstart-accelerator.com'
  end

  def booking_accepted_mentor(mentor, member, expert_session)
    @mentor = mentor
    @member = member
    @expert_session = expert_session

    mail subject: '[KS Ananas]: Expert Session Confirmed',
      to: mentor.email,
      from: 'no-reply@ananas-project.com',
      reply_to: member.email
      #bcc: 'katka@kickstart-accelerator.com'
  end

  def booking_accepted_member(mentor, member, expert_session)
    @mentor = mentor
    @member = member
    @expert_session = expert_session

    mail subject: '[KS Ananas]: Expert Session Confirmed',
      to: member.email,
      from: 'no-reply@ananas-project.com',
      reply_to: mentor.email
      #bcc: 'katka@kickstart-accelerator.com'
  end
end
