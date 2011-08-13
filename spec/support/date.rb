def random_date(year, year_range = 0)
  year += rand(year_range) if year_range
  month = rand(12) + 1
  day = rand(31) + 1

  Time.local(year,month,day)
end
