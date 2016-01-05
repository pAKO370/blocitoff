module ItemsHelper
  def time_remaining(item)
    time_dif = Time.now - item.created_at
    from_time = Time.now
    distance_of_time_in_words(time_dif, 7.days - time_dif)
  end

end
