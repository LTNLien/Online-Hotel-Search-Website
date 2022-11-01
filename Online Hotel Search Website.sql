create or alter view ABC as
(
select	
	*,
	clicks_A + clicks_B + clicks_C as clicks_ABC,
	cost_A + cost_B + cost_C as cost_ABC,
	bookings_A + bookings_B + bookings_C as bookings_ABC,
	booking_rev_A + booking_rev_B + booking_rev_C as booking_rev_ABC,
	bookings_A*1.0/clicks_A as conversion_A,
	bookings_B*1.0/clicks_B as conversion_B,
	bookings_C*1.0/clicks_C as conversion_C,
	(bookings_A + bookings_B + bookings_C)*1.0/(clicks_A + clicks_B + clicks_C) as conversion_ABC,
	booking_rev_A*0.15 as profit_A,
	booking_rev_B*0.15 as profit_B,
	booking_rev_C*0.15 as profit_C,
	(booking_rev_A + booking_rev_B + booking_rev_C)*0.15 as profit_ABC,
	cost_A*1.0/clicks_A as costPerClick_A,
	cost_B*1.0/clicks_B as costPerClick_B,
	cost_C*1.0/clicks_C as costPerClick_C,
	(cost_A + cost_B + cost_C)*1.0/(clicks_A + clicks_B + clicks_C) as costPerClick_ABC,
	cost_A*1.0/booking_rev_A as efficiency_A,
	cost_B*1.0/booking_rev_B as efficiency_B,
	cost_C*1.0/booking_rev_C as efficiency_C,
	(cost_A + cost_B + cost_C)*1.0/(booking_rev_A + booking_rev_B + booking_rev_C) as efficiency_ABC,
Case
	when day([date]) <= 15 then 'firstHalf'
	when day([date]) > 15 then 'latterHalf'
end as 'timeOfTheMonth',
Case	
	when ttt_group = 'short' then case	
									when day([date]) <= 23 then month([date])
									when day([date]) > 23 then month([date]) + 1
									end
	when ttt_group = 'medium' then case	
									when day([date]) <= 2 then month([date])
									when day([date]) > 2 and day([date]) < 20 then month([date]) + 1
									when day([date]) >= 20 then month([date]) + 2
									end 
	when ttt_group = 'long' then case
									when day([date]) <= 8 then month([date]) + 2
									when day([date]) > 8 and day([date]) < 24 then month([date]) + 3
									when day([date]) >= 24 then month([date]) + 4
									end
end as checkinMonth
from [data]
)

