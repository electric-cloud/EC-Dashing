# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
gmake_start = 1
ea_start = 1
gmake_progress = 0
ea_progress = 0

st = Time.now.to_i
send_event('build_elapsed', {start_time: st})

SCHEDULER.every '2s', :first_in => 0 do |job|
=begin
  send_event('gmake_build_count', { current: gmake_start += rand(10) })
  send_event('gmake_build_cost', { current: rand(100) })
  send_event('ea_build_count', { current: ea_start += rand(50) })
  send_event('ea_build_cost', { current: rand(50) })
  send_event('gmake_build_rate', { value: rand(20) })
  send_event('ea_build_rate', { value: rand(50) })
  send_event('gmake_progress', {progress_items: [
    {name: "Current GMake build", progress: gmake_progress}
    ]})
  send_event('ea_progress', {progress_items: [
        {name: "Current EA build", progress: ea_progress}
                                              ]})
  gmake_progress += 1
  ea_progress += 2
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
=end
end