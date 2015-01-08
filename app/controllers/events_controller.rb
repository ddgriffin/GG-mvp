class EventsController < ApplicationController

  def index
    t = Event.arel_table

    @austin_events = Event.where(t[:location_city].matches("%Austin").and(t[:datetime_tba].eq(false)).and(t[:state].matches('accepted'))).sort_by { |e| e.created_at }.reverse!
    @tba_austin_events = Event.where(t[:location_city].matches("%Austin").and(t[:datetime_tba].eq(true)).and(t[:state].matches('accepted'))).sort_by { |e| e.created_at }
    @filled_austin_events = Event.where(t[:location_city].matches("%Austin").and(t[:datetime_tba].eq(false)).and(t[:state].matches('filled'))).sort_by { |e| e.begins_at }.reverse!
    @closed_austin_events = Event.where(t[:location_city].matches("%Austin").and(t[:datetime_tba].eq(false)).and(t[:state].matches('completed'))).sort_by { |e| e.begins_at }.reverse!

    @houston_events = Event.where(t[:location_city].matches("%Houston").and(t[:state].matches('accepted'))).sort_by { |e| e.created_at }.reverse!
    @filled_houston_events = Event.where(t[:location_city].matches("%Houston").and(t[:state].matches('filled'))).sort_by { |e| e.begins_at }.reverse!
    @closed_houston_events = Event.where(t[:location_city].matches("%Houston").and(t[:state].matches('completed'))).sort_by { |e| e.begins_at }.reverse!
  end

end