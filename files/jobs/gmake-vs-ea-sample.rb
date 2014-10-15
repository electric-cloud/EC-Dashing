# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
gmake_start = 1
ea_start = 1
SCHEDULER.every '2s', :first_in => 0 do |job|
  send_event('gmake_build_count', { current: gmake_start += rand(10) })
  send_event('ea_build_count', { current: ea_start += rand(50) })
  send_event('gmake_build_rate', { value: rand(20) })
  send_event('ea_build_rate', { value: rand(50) })
  send_event('gmake_last_builds', {
              points: [
                {"x" => 0, "y" => 100},
                {"x" => 1, "y" => 200 },
                {"x" => 2, "y" => 300 },
                {"x" => 3, "y" => 10 },
                {"x" => 4, "y" => 50 },
                {"x" => 5, "y" => 120 },
                {"x" => 6, "y" => 590 },
                {"x" => 7, "y" => 330 },
                {"x" => 8, "y" => 220 },
                {"x" => 9, "y" => 50 }
               ]})
  send_event('ea_last_builds', {
              points: [
                {"x" => 0, "y" => 10},
                {"x" => 1, "y" => 20 },
                {"x" => 2, "y" => 30 },
                {"x" => 3, "y" => 10 },
                {"x" => 4, "y" => 50 },
                {"x" => 5, "y" => 12 },
                {"x" => 6, "y" => 59 },
                {"x" => 7, "y" => 33 },
                {"x" => 8, "y" => 22 },
                {"x" => 9, "y" => 5 }
               ]})
end