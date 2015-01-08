class EventsController < ApplicationController

  def index
    @events = Event.where( datetime_tba: false, state: ['accepted']).sort_by { |e| e.created_at }.reverse!
    @tba_events = Event.where( datetime_tba: true, state: ['accepted']).sort_by { |e| e.created_at }
    @filled_events = Event.where( datetime_tba: false, state: ['filled']).sort_by { |e| e.begins_at }.reverse!
    @closed_events = Event.where( datetime_tba: false, state: ['completed']).sort_by { |e| e.begins_at }.reverse!

    t = Event.arel_table
    @houston_events = Event.where(t[:location_city].matches("%Houston").and(t[:state].matches('accepted'))).sort_by { |e| e.created_at }.reverse!
    @filled_houston_events = Event.where(t[:location_city].matches("%Houston").and(t[:state].matches('filled'))).sort_by { |e| e.begins_at }.reverse!
    @closed_houston_events = Event.where(t[:location_city].matches("%Houston").and(t[:state].matches('completed'))).sort_by { |e| e.begins_at }.reverse!
  end

end