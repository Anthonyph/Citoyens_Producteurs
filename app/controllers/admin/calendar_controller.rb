class Admin::CalendarController < ApplicationController
  def index
  end

  def show
    events = Event.all
    render json: events.map { |event| {
      id: event.id,
      start_date: event.start_date.to_formatted_s(:db),
      end_date: event.end_date.to_formatted_s(:db),
      text: event.title,
      description: event.description,
      address: event.address,
      creator: event.creator,
      event_type: event.event_type
      } }
  end

  def update
    mode = params['!nativeeditor_status']
    id = params['id']
    start_date = params['start_date']
    end_date = params['end_date']
    title = params['text']
    description = params['description']
    place = params['place']
    zip_code = params['zip_code']
    city = params['city']
    sector = params['sector']
    creator = params['creator']
    event_type = params['type'] || params['event_type.id']
  
    case mode
    when 'inserted'
      event = Event.create start_date: start_date, end_date: end_date, title: title, description: description,
        address: address, creator: creator, event_type: event_type
      tid = event.id
    when 'deleted'
      Event.find(id).destroy
      tid = id
    when 'updated'
      event = Event.find(id)
      # address = event.address
      # address.update!(place: place, zip_code: zip_code, city: city, sector: sector)
      type = EventType.find(event_type)
      event.event_type_id = type.id
      event.start_date = start_date
      event.end_date = end_date
      event.title = title
      event.description = description
      event.save
      id = id
    end
    
    render json: {
      type: mode,
      sid: id,
      tid: tid,
    }
  end

end