#will need to be scheduled using the Heroku Scheduler tool when we deploy (schedule for each evening)
#Henry said try separating out the ones that need to run in order into separate tasks (ie. create a task that runs Workshop.complete_workshop THEN runs Workshop.cancel_workshop), then call that task in the task that gets scheduled.

#1st, based on end date, complete apprenticeships that were confirmed, and workshops that were accepted w/ minimum # signups
desc "Complete events"
task :complete_events => :environment do
  Apprenticeship.complete_apprenticeship
  Workshop.complete_workshop
end


#2nd, based on close registrations date, cancel workshops that don't have minimum # signups
desc "Cancel empty workshops"
task :cancel_events => :environment do
  Workshop.cancel_workshop
end


#3rd, based on start date, send reminders if they haven't been sent yet
desc "Send event reminders"
task :send_reminders => :environment do
  Workshop.maker_reminder
  AppSignup.reminder
  WorkSignup.first_reminder
  WorkSignup.second_reminder
end


#4th, based on end date, send follow up emails if they haven't been sent yet
desc "Send followups after events"
task :send_followups => :environment do
  Workshop.maker_followup
  AppSignup.followup
  AppSignup.followup_maker
  WorkSignup.followup
end


